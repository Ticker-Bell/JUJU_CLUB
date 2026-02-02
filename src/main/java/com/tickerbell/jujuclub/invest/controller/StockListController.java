package com.tickerbell.jujuclub.invest.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.invest.dto.*;
import com.tickerbell.jujuclub.invest.service.*;
import com.tickerbell.jujuclub.utils.ColorUtil;
import com.tickerbell.jujuclub.utils.GetValidAccessToken;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/invest")
public class StockListController {

  private final StockService stockService;
  private final StockRankingService stockRankingService;
  private final KISApiService kisApiService;
  private final GetValidAccessToken getValidAccessToken;

  private final UserAssetService userAssetService;
  private final PortfolioService portfolioService;

  //자산 상세 내용
  private final AssetDetailService assetDetailService;

  /**
   * 모의투자 메인 페이지 연결 마이 탭) 사용자 자산 연결, 사용자 보유 종목 리스트, 보유 종목 도넛 차트, 관심 종목 리스트 조회 투자 탭) 모의투자 페이지 필요 정보
   * 조회 유저 관심종목, 보유주식, 모의 체결 내역
   *
   * @return invest/investMain
   */
  @GetMapping("main.do")
  public String investMain(Model model, HttpSession session) {

    return "invest/investMain";
  }

  /**
   * 마이 TAB
   */
  @GetMapping("/tab/my")
  public String getMyTabFragment(Model model, HttpSession session) {
    Integer userSeq = (Integer) session.getAttribute("userSeq");

    if (userSeq != null) {

      // 2. 보유주식 리스트
      List<PortfolioDTO> holdings = portfolioService.getPortfolioAllocationItems(userSeq);
      model.addAttribute("holdings", holdings);

      // 3. 차트 데이터 생성 (도넛 차트용)
      List<Map<String, Object>> chartData = new ArrayList<>();
      for (PortfolioDTO item : holdings) {
        Map<String, Object> data = new HashMap<>();
        data.put("stockName", item.getStockName());
        data.put("stockCode", item.getStockCode());
        data.put("weightPct", item.getWeightPct());
        data.put("color", ColorUtil.colorByStockCode(item.getStockCode()));
        chartData.add(data);
      }
      model.addAttribute("chartData", chartData);

      // 4. 차트 데이터 JSON 변환 (Chart.js용)
      ObjectMapper objectMapper = new ObjectMapper();
      try {
        model.addAttribute("chartDataJson", objectMapper.writeValueAsString(chartData));
      } catch (Exception e) {
        model.addAttribute("chartDataJson", "[]");
      }

      // 5. 사용자 자산 요약
      UserInvestSummeryDTO userAssetSummary = userAssetService.getUserInvestSummary(userSeq);
      model.addAttribute("userAsset", userAssetSummary);
    }
    return "invest/investMy";
  }

  /**
   * 투자 TAB
   */
  @GetMapping("/tab/invest")
  public String getInvestTabFragment(Model model, HttpSession session) {
    Integer userSeq = (Integer) session.getAttribute("userSeq");

    // 해당하는 유저의 관심종목들의 종목정보 리스트 반환
    List<StockDTO> stockDTOList = stockService.findStockListFromUserWatchList(userSeq);

    Map<String, KISDataDTO> codeKISDataMap = new HashMap<>();

    // 리스트를 처음 띄울때의 현재가와 등락률은 restAPI로 호출해서 출력한다.
    for(StockDTO stockDTO : stockDTOList) {
      KISDataDTO kisDataDTO = kisApiService.getPriceData(stockDTO.getStockCode());
      // KISDataDTO의 changePct 값은 음수일때만 - 붙어 있고 그 외엔 부호가 없기때문에 붙여준다.
      if (!kisDataDTO.getChangePct().startsWith("-") && !kisDataDTO.getChangePct().equals("0.00")) {
        kisDataDTO.setChangePct("+" + kisDataDTO.getChangePct());
      }
      codeKISDataMap.put(stockDTO.getStockCode(), kisDataDTO);
    }

    model.addAttribute("codeKISDataMap", codeKISDataMap);
    model.addAttribute("stockDTOList", stockDTOList);

    return "invest/investTab";
  }

  /**
   * 거래내역 TAB
   *
   */
  @GetMapping("/tab/history")
  public String getHistoryTabFragment(Model model, HttpSession session) {
    Integer userSeq = (Integer) session.getAttribute("userSeq");

    if(userSeq != null){
      List<AssetDetailDTO> assetDetailDTOList = new ArrayList<>();
      List<MockTradeDTO> mockTradeDTOList = assetDetailService.findUserTrades(userSeq);

      String typeDetail = null;
      String price = null;

      // 받아온 MockTradeDTO를 화면에 표시할 형식인 assetDetailDTO로 변경
      for(MockTradeDTO mockTradeDTO : mockTradeDTOList){
        if(mockTradeDTO.getTradeType() == 'Y'){
          typeDetail = "매수";
        }else{
          typeDetail = "매도";
        }

        LocalDate localDate = mockTradeDTO.getTradedAt().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        AssetDetailDTO assetDetailDTO =  AssetDetailDTO.builder()
                .type("주식")
                .typeDetail(typeDetail)
                .detail(mockTradeDTO.getStockName())
                .price("" + mockTradeDTO.getTradePrice())
                .quantity(mockTradeDTO.getTradeQuantity())
                .date(localDate.format(formatter))
                .build();
        assetDetailDTOList.add(assetDetailDTO);
      }
      model.addAttribute("assetDetailDTOList", assetDetailDTOList);
    }
    return "invest/assetDetail";
  }


  /**
   * 모의투자 종목 리스트에서 탭 클릭시 해당 순위대로(30개) 종목 정보 반환 paging으로 10개씩 3번 반환(page = 0,1,2)
   *
   * @param sortType string, page int
   * @return List&lt;RankingDTO&gt;
   * @throws Exception
   */
  @GetMapping("/main/stock/list")
  @ResponseBody
  public List<StockRankingDTO> getStockList(@RequestParam("sortType") String sortType,
      @RequestParam(value = "page", defaultValue = "0") int page, HttpSession session)
      throws Exception {

    List<StockRankingDTO> stockRankingDTOList = new ArrayList<>(); // 전체 리스트

    String accessToken = getValidAccessToken.getValidToken();

    switch (sortType) {
      case "interest":  //관심종목
        Integer userSeq = (Integer) session.getAttribute("userSeq");
        List<StockDTO> stockDTOList = stockService.findStockListFromUserWatchList(userSeq);

        // List<RankingDTO>를 반환해야하기에 stockDTO에 있는 Name과 Code를 넣어서 RankingDTO로 전환한다.
        // Name과 Code는 양쪽에 존재하기 때문에 상관없지만, rank는 없기 때문에 null로 넣는다.
        for (StockDTO stockDTO : stockDTOList) {
          StockRankingDTO stockRankingDTO = StockRankingDTO.builder()
              .stockName(stockDTO.getStockName())
              .stockCode(stockDTO.getStockCode())
              .build();
          stockRankingDTOList.add(stockRankingDTO);
        }
        break;

      case "volume":  //거래량순
        stockRankingDTOList = stockRankingService.getTradingVolumeRanking(accessToken);
        break;
      case "rising":  //상승률순 (전날 종가 대비)
        stockRankingDTOList = stockRankingService.getTopGainersRanking(accessToken);
        break;
      case "falling":  //하락률순 (전날 종가 대비)
        stockRankingDTOList = stockRankingService.getTopLosersRanking(accessToken);
        break;
      case "marketCap":  //시가총액순
        stockRankingDTOList = stockRankingService.getMarketCapRanking(accessToken);
        break;
    }

    // [Slicing] 요청된 페이지에 맞게 리스트를 10개만 자른다.
    int pageSize = 10;
    int startIdx = page * pageSize;
    int endIdx = Math.min(startIdx + pageSize, stockRankingDTOList.size());

    // 범위를 벗어나면 빈 리스트 반환
    if (startIdx >= stockRankingDTOList.size()) {
      return new ArrayList<>();
    }

    // 30개 중 10개만 추출
    List<StockRankingDTO> slicedList = stockRankingDTOList.subList(startIdx, endIdx);

    // 추출한 10개에 대해서만 외부 API 호출
    if ("interest".equals(sortType)) {
      for (StockRankingDTO stockRankingDTO : slicedList) {
        KISDataDTO kisDataDTO = kisApiService.getPriceData(stockRankingDTO.getStockCode());
        // KISDataDTO의 changePct 값은 음수일때만 - 붙어 있고 그 외엔 부혹 없기때문에 붙여준다.
        if (!kisDataDTO.getChangePct().startsWith("-") && !kisDataDTO.getChangePct()
            .equals("0.00")) {
          kisDataDTO.setChangePct("+" + kisDataDTO.getChangePct());
        }
        stockRankingDTO.setCurrentPrice(kisDataDTO.getCurrentPrice());
        stockRankingDTO.setChangePct(kisDataDTO.getChangePct());
      }
    } else {
      slicedList = stockRankingService.addKisDataDtoToRankingDto(slicedList);
    }

    return slicedList;
  }

  /**
   * 모의투자에서 검색시 입력한 내용을 포함하는 종목들에 대한 정보 반환
   *
   * @param keyword string
   * @return List&lt;StockDTO&gt;
   */
  @PostMapping("/search/autocomplete")
  @ResponseBody
  public List<StockDTO> autocomplete(@RequestParam("keyword") String keyword) {
    // 검색어가 없으면 빈 리스트 리턴
    if (keyword == null || keyword.isEmpty()) {
      return new ArrayList<>();
    }

    // DB 조회 결과 리턴 (Jackson 라이브러리가 자동으로 JSON 배열로 변환해줌)
    return stockService.getSearchList(keyword);
  }

  /**
   * 모의투자에서 검색한 종목에 대한 정보 반환
   *
   * @param stockCode string, stockName string
   * @return RankingDTO
   */
  @PostMapping("/stock/selected")
  @ResponseBody
  public StockRankingDTO getSelectedStock(@RequestParam("stockCode") String stockCode,
      @RequestParam("stockName") String stockName) {
    KISDataDTO kisDataDTO = kisApiService.getPriceData(stockCode);
    // KISDataDTO의 changePct 값은 음수일때만 - 붙어 있고 그 외엔 부호 없기때문에 붙여준다.
    if (!kisDataDTO.getChangePct().startsWith("-") && !kisDataDTO.getChangePct().equals("0.00")) {
      kisDataDTO.setChangePct("+" + kisDataDTO.getChangePct());
    }

    return StockRankingDTO.builder()
        .stockCode(stockCode)
        .stockName(stockName)
        .currentPrice(kisDataDTO.getCurrentPrice())
        .changePct(kisDataDTO.getChangePct())
        .build();
  }
}

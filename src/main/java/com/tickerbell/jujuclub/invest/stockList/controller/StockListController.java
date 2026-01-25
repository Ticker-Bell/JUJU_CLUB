package com.tickerbell.jujuclub.invest.stockList.controller;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.service.KISApiService;
import com.tickerbell.jujuclub.invest.stockList.dto.RankingDTO;
import com.tickerbell.jujuclub.invest.stockList.dto.StockDTO;
import com.tickerbell.jujuclub.invest.stockList.service.RankingApiService;
import com.tickerbell.jujuclub.invest.stockList.service.StockService;
import com.tickerbell.jujuclub.utils.GetValidAccessToken;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/invest")
public class StockListController {

    private final StockService stockService;
    private final RankingApiService rankingApiService;
    private final KISApiService kisApiService;
    private final GetValidAccessToken getValidAccessToken;

    @GetMapping("main.do")
    public String investMain(Model model, HttpSession session){

        Integer userSeq = (Integer)session.getAttribute("userSeq");

        // 해당하는 유저의 관심종목들의 종목정보 리스트 반환
        List<StockDTO> stockDTOList = stockService.findStockListFromUserWatchList(userSeq);

        Map<String, KISDataDTO> codeKISDataMap = new HashMap<String, KISDataDTO>();

        // 리스트를 처음 띄울때의 현재가와 등락률은 restAPI로 호출해서 출력한다.
        for(StockDTO stockDTO : stockDTOList) {
            KISDataDTO kisDataDTO = kisApiService.getPriceData(stockDTO.getStockCode());
            // KISDataDTO의 changePct 값은 음수일때만 - 붙어 있고 그 외엔 부혹 없기때문에 붙여준다.
            if (!kisDataDTO.getChangePct().startsWith("-") && !kisDataDTO.getChangePct().equals("0.00")) {
                kisDataDTO.setChangePct("+" + kisDataDTO.getChangePct());
            }

            codeKISDataMap.put(stockDTO.getStockCode(), kisDataDTO);
        }

        System.out.println("codeKISDataMap: " + codeKISDataMap);

        model.addAttribute("codeKISDataMap", codeKISDataMap);
        model.addAttribute("stockDTOList", stockDTOList);

        return "invest/investMain";
    }

    @GetMapping("/main/stock/list")
    @ResponseBody
    public List<RankingDTO> getStockList(@RequestParam("sortType") String sortType, @RequestParam(value = "page", defaultValue = "0") int page, HttpSession session, HttpServletRequest request) throws Exception {

        List<RankingDTO> rankingDTOList = new ArrayList<>(); // 전체 리스트

        String accessToken = getValidAccessToken.getValidToken(request);

        switch (sortType) {
            case "interest":  //관심종목
                Integer userSeq = (Integer)session.getAttribute("userSeq");
                List<StockDTO> stockDTOList = stockService.findStockListFromUserWatchList(userSeq);

                // List<RankingDTO>를 반환해야하기에 stockDTO에 있는 Name과 Code를 넣어서 RankingDTO로 전환한다.
                // Name과 Code는 양쪽에 존재하기 때문에 상관없지만, rank는 없기 때문에 null로 넣는다.
                for (StockDTO stockDTO : stockDTOList) {
                    RankingDTO rankingDTO = RankingDTO.builder()
                            .stockName(stockDTO.getStockName())
                            .stockCode(stockDTO.getStockCode())
                            .build();
                    rankingDTOList.add(rankingDTO);
                }
                break;

            case "volume":  //거래량순
                rankingDTOList = rankingApiService.getTradingVolumeRanking(accessToken);
                break;
            case "rising":  //상승률순 (전날 종가 대비)
                rankingDTOList = rankingApiService.getTopGainersRanking(accessToken);
                break;
            case "falling":  //하락률순 (전날 종가 대비)
                rankingDTOList = rankingApiService.getTopLosersRanking(accessToken);
                break;
            case "marketCap":  //시가총액순
                rankingDTOList = rankingApiService.getMarketCapRanking(accessToken);
                break;
        }

        // [Slicing] 요청된 페이지에 맞게 리스트를 10개만 자른다.
        int pageSize = 10;
        int startIdx = page * pageSize;
        int endIdx = Math.min(startIdx + pageSize, rankingDTOList.size());

        // 범위를 벗어나면 빈 리스트 반환
        if (startIdx >= rankingDTOList.size()) {
            return new ArrayList<>();
        }

        // 30개 중 10개만 추출
        List<RankingDTO> slicedList = rankingDTOList.subList(startIdx, endIdx);

        // 추출한 10개에 대해서만 외부 API 호출
        if("interest".equals(sortType)) {
            for(RankingDTO rankingDTO : slicedList) {
                KISDataDTO kisDataDTO = kisApiService.getPriceData(rankingDTO.getStockCode());
                // KISDataDTO의 changePct 값은 음수일때만 - 붙어 있고 그 외엔 부혹 없기때문에 붙여준다.
                if (!kisDataDTO.getChangePct().startsWith("-") && !kisDataDTO.getChangePct().equals("0.00")) {
                    kisDataDTO.setChangePct("+" + kisDataDTO.getChangePct());
                }
                rankingDTO.setCurrentPrice(kisDataDTO.getCurrentPrice());
                rankingDTO.setChangePct(kisDataDTO.getChangePct());
            }
        }else{
            slicedList = rankingApiService.addKisDataDtoToRankingDto(slicedList);
        }

        return slicedList;
    }


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

    @PostMapping("/stock/selected")
    @ResponseBody
    public RankingDTO getSelectedStock(@RequestParam("stockCode") String stockCode, @RequestParam("stockName") String stockName) {
        KISDataDTO kisDataDTO = kisApiService.getPriceData(stockCode);
        // KISDataDTO의 changePct 값은 음수일때만 - 붙어 있고 그 외엔 부혹 없기때문에 붙여준다.
        if (!kisDataDTO.getChangePct().startsWith("-") && !kisDataDTO.getChangePct().equals("0.00")) {
            kisDataDTO.setChangePct("+" + kisDataDTO.getChangePct());
        }

        return RankingDTO.builder()
                .stockCode(stockCode)
                .stockName(stockName)
                .currentPrice(kisDataDTO.getCurrentPrice())
                .changePct(kisDataDTO.getChangePct())
                .build();
    }
}

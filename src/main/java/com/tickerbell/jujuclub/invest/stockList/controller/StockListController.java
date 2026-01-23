package com.tickerbell.jujuclub.invest.stockList.controller;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.service.KISApiService;
import com.tickerbell.jujuclub.invest.stockList.dto.RankingDTO;
import com.tickerbell.jujuclub.invest.stockList.dto.StockDTO;
import com.tickerbell.jujuclub.invest.stockList.service.RankingApiService;
import com.tickerbell.jujuclub.invest.stockList.service.StockService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("main.do")
    public String investMain(Model model, HttpSession session) {

        // 세션에서 user_seq 가져오기
        session.setAttribute("userSeq", 1); // 일단 구현안되어있으므로 임시 값

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
    public List<RankingDTO> getStockList(@RequestParam("sortType") String sortType, HttpSession session) {

        List<RankingDTO> rankingDTOList = new ArrayList<>();

        switch (sortType) {
            case "interest":  //관심종목
                Integer userSeq = (Integer)session.getAttribute("userSeq");
                List<StockDTO> stockDTOList = stockService.findStockListFromUserWatchList(userSeq);

                // List<RankingDTO>를 반환해야하기에 stockDTO에 있는 Name과 Code를 넣어서 RankingDTO로 전환한다.
                // Name과 Code는 양쪽에 존재하기 때문에 상관없지만, rank는 없기 때문에 null로 넣는다.
                for (StockDTO stockDTO : stockDTOList) {
                    KISDataDTO kisDataDTO = kisApiService.getPriceData(stockDTO.getStockCode());
                    // KISDataDTO의 changePct 값은 음수일때만 - 붙어 있고 그 외엔 부혹 없기때문에 붙여준다.
                    if (!kisDataDTO.getChangePct().startsWith("-") && !kisDataDTO.getChangePct().equals("0.00")) {
                        kisDataDTO.setChangePct("+" + kisDataDTO.getChangePct());
                    }
                    RankingDTO rankingDTO = RankingDTO.builder()
                            .stockName(stockDTO.getStockName())
                            .stockCode(stockDTO.getStockCode())
                            .currentPrice(kisDataDTO.getCurrentPrice())
                            .changePct(kisDataDTO.getChangePct())
                            .build();
                    rankingDTOList.add(rankingDTO);
                }
                return rankingDTOList;

            case "volume":  //거래량순
                rankingDTOList = rankingApiService.getTradingVolumeRanking();
                rankingDTOList = rankingApiService.addKisDataDtoToRankingDto(rankingDTOList);
                return rankingDTOList;
            case "rising":  //상승률순 (전날 종가 대비)
                rankingDTOList = rankingApiService.getTopGainersRanking();
                rankingDTOList = rankingApiService.addKisDataDtoToRankingDto(rankingDTOList);
                return rankingDTOList;
            case "falling":  //하락률순 (전날 종가 대비)
                rankingDTOList = rankingApiService.getTopLosersRanking();
                rankingDTOList = rankingApiService.addKisDataDtoToRankingDto(rankingDTOList);
                return rankingDTOList;
            case "marketCap":  //시가총액순
                rankingDTOList = rankingApiService.getMarketCapRanking();
                rankingDTOList = rankingApiService.addKisDataDtoToRankingDto(rankingDTOList);
                return rankingDTOList;
            default: return new ArrayList<>();
        }
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

package com.tickerbell.jujuclub.invest.stockList.controller;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.invest.stockList.dto.RankingDTO;
import com.tickerbell.jujuclub.invest.stockList.dto.StockDTO;
import com.tickerbell.jujuclub.invest.stockList.service.RankingApiService;
import com.tickerbell.jujuclub.invest.stockList.service.StockService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/invest")
public class StockListController {

    private final StockService stockService;
    private final RankingApiService rankingApiService;

    @GetMapping("main.do")
    public String investMain(Model model, HttpSession session) {

        // 세션에서 user_seq 가져오기
        session.setAttribute("userSeq", 1); // 일단 구현안되어있으므로 임시 값

        Integer userSeq = (Integer)session.getAttribute("userSeq");

        // 해당하는 유저의 관심종목들의 종목정보 리스트 반환
        List<StockDTO> stockDTOList = stockService.findStockListFromUserWatchList(userSeq);
        model.addAttribute("stockDTOList", stockDTOList);

        return "invest/investMain";
    }

    @GetMapping("/main/stock/list")
    @ResponseBody
    public List<RankingDTO> getStockList(@RequestParam("sortType") String sortType, HttpSession session) {

        switch (sortType) {
            case "interest":  //관심종목
                Integer userSeq = (Integer)session.getAttribute("userSeq");
                List<StockDTO> stockDTOList = stockService.findStockListFromUserWatchList(userSeq);
                List<RankingDTO> rankingDTOList = new ArrayList<>();

                // List<RankingDTO>를 반환해야하기에 stockDTO에 있는 Name과 Code를 넣어서 RankingDTO로 전환한다.
                // Name과 Code는 양쪽에 존재하기 때문에 상관없지만, rank는 없기 때문에 null로 넣는다.
                for (StockDTO stockDTO : stockDTOList) {
                    RankingDTO rankingDTO = RankingDTO.builder()
                            .stockName(stockDTO.getStockName())
                            .stockCode(stockDTO.getStockCode())
                            .build();
                    rankingDTOList.add(rankingDTO);
                }
                return rankingDTOList;

            case "volume":  //거래량순
                return rankingApiService.getTradingVolumeRanking();
            case "rising":  //상승률순 (전날 종가 대비)
                return rankingApiService.getTopGainersRanking();
            case "falling":  //하락률순 (전날 종가 대비)
                return rankingApiService.getTopLosersRanking();
            case "marketCap":  //시가총액순
                return rankingApiService.getMarketCapRanking();
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

    // 테스트용  나중에 제거하기
//    @GetMapping("/chart/selectedStockInfo")
//    @ResponseBody
//    public StockDTO paramTest(@RequestParam String stockCode, @RequestParam String stockName) {
//
//        return StockDTO.builder()
//                .stockCode(stockCode)
//                .stockName(stockName)
//                .build();
//    }

    // 테스트용  나중에 제거하기
    @GetMapping("/corpoInfo/selectedStockInfo")
    @ResponseBody
    public StockDTO paramTest2(Model model, @RequestParam String stockCode) {

        return StockDTO.builder()
                .stockCode(stockCode)
                .build();
    }

}

package com.tickerbell.jujuclub.invest.controller;

import com.tickerbell.jujuclub.invest.dto.*;
import com.tickerbell.jujuclub.invest.service.KISApiService;
import com.tickerbell.jujuclub.invest.service.PortfolioService;
import com.tickerbell.jujuclub.invest.service.UserAssetService;
import com.tickerbell.jujuclub.invest.service.WatchlistService;
import com.tickerbell.jujuclub.utils.ColorUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/stock/api")
public class StockMyRestController {

    private final UserAssetService userAssetService;
    private final PortfolioService portfolioService;
    private final WatchlistService watchlistService;
    private final KISApiService kisApiService;


    /**
     * 모의투자 마이페이지 자동 갱신용 REST API
     *
     * @param userSeq int
     * @return Map(String, Object)
     */
    @GetMapping("/invest/selectedData")
    public Map<String, Object> updateMyData(@RequestParam("userSeq") int userSeq) {

        //페이지에 뿌릴 DTO데이터 묶어서 보내기
        long start = System.currentTimeMillis(); //전체 시작시간

        long step1Start = System.currentTimeMillis(); // 투자요약데이터 시간 조회
        UserInvestSummeryDTO userInvestSummeryData = userAssetService.getUserInvestSummary(userSeq);
        System.out.println("1. UserInvestSummary 소요시간: " + (System.currentTimeMillis() - step1Start) + "ms");

        long step2Start = System.currentTimeMillis(); // 포트폴리오
        List<PortfolioAllocationItemDTO> portfolioAllocationItemList = portfolioService.getPortfolioAllocationItems(userSeq);
        System.out.println("2. PortfolioAllocationItems 소요시간: " + (System.currentTimeMillis() - step2Start) + "ms");

        long step3Start = System.currentTimeMillis(); // 관심종목
        List<WatchlistItemDTO> watchlistItemList = watchlistService.getWatchlistItems(userSeq);
        System.out.println("3. WatchlistItems 소요시간: " + (System.currentTimeMillis() - step3Start) + "ms");

        //map생성 및 데이터
        Map<String, Object> myData = new HashMap<>();
        myData.put("userInvestSummeryData", userInvestSummeryData);

        //목록이니까 List로
        myData.put("portfolioAllocationItemList", portfolioAllocationItemList);
        myData.put("watchlistItemList", watchlistItemList);

        //장시간이후테스트용도
        myData.put("test", java.time.LocalDateTime.now().toString());

        //차트 데이터 (DonutChart.js가 기대하는 포맷에 맞추기)
        long step4Start = System.currentTimeMillis();
        List<Map<String, Object>> chartDataList = new ArrayList<>();

        for (PortfolioAllocationItemDTO data : portfolioAllocationItemList) {
            Map<String, Object> chartData = new HashMap<>();
            chartData.put("stockName", data.getStockName());
            chartData.put("stockCode", data.getStockCode());
            chartData.put("weightPct", data.getWeightPct());
            chartData.put("color", ColorUtil.colorByStockCode(data.getStockCode()));
            chartDataList.add(chartData);
        }

        System.out.println("4. ChartData 반복문 소요시간: " + (System.currentTimeMillis() - step4Start) + "ms");
        System.out.println("전체 API 실행 시간: " + (System.currentTimeMillis() - start) + "ms");

        //응답에 추가
        myData.put("chartData", chartDataList);

        //test
        System.out.println("체크용 " + chartDataList);

        //map반환(자동으로 json변환)
        return myData;
    }

    /**
     * (테스트) KIS 현재가 데이터 조회
     *
     * @param stockCode String
     * @return KISDataDTO
     */
    @GetMapping("/kisapitest")
    public KISDataDTO test(@RequestParam("stockCode") String stockCode) {
        return kisApiService.getPriceData(stockCode); //json반환
    }

    /**
     * (테스트) KIS 기업지표 데이터 조회
     *
     * @param stockCode String
     * @return KISCorpInfoDTO
     */
    @GetMapping("/kisapitest2")
    public KISCorpInfoDTO test2(@RequestParam("stockCode") String stockCode) {
        return kisApiService.getCorpInfoData(stockCode);
    }

    /**
     * 관심종목 목록 조회
     *
     * @param userSeq int
     * @return List(WatchlistItemDTO)
     */
    @GetMapping("/watchlist")
    public List<WatchlistItemDTO> watchlist(@RequestParam int userSeq) {
        return watchlistService.getWatchlistItems(userSeq);
    }

    /**
     * 포트폴리오 비중 목록 조회
     *
     * @param userSeq int
     * @return List(PortfolioAllocationItemDTO)
     */
    @GetMapping("/holdinglisttest")
    public List<PortfolioAllocationItemDTO> portfolioAllocationItems(@RequestParam int userSeq) {
        return portfolioService.getPortfolioAllocationItems(userSeq);
    }

}

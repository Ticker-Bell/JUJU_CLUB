package com.tickerbell.jujuclub.invest.controller;

import com.tickerbell.jujuclub.invest.dto.PortfolioDTO;
import com.tickerbell.jujuclub.invest.dto.UserInvestSummeryDTO;
import com.tickerbell.jujuclub.invest.service.UserAssetService;
import com.tickerbell.jujuclub.utils.ColorUtil;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/stock/api")
public class StockMyRestController {

    private final UserAssetService userAssetService;


    /**
     * 모의투자 마이페이지 자동 갱신용 REST API
     *
     * @param userSeq int
     * @return Map(String, Object)
     */
    @GetMapping("/invest/selectedData")
    public Map<String, Object> updateMyData(@RequestParam("userSeq") int userSeq) {

        //페이지에 뿌릴 DTO데이터 묶어서 보내기

        UserInvestSummeryDTO userInvestSummeryData = userAssetService.getUserInvestSummary(userSeq);

        List<PortfolioDTO> portfolioAllocationItemList = userInvestSummeryData.getItemDTOList();

        //map생성 및 데이터
        Map<String, Object> myData = new HashMap<>();
        myData.put("userInvestSummeryData", userInvestSummeryData);

        //목록이니까 List로
        myData.put("portfolioAllocationItemList", portfolioAllocationItemList);

        //장시간이후테스트용도
        myData.put("test", java.time.LocalDateTime.now().toString());

        //차트 데이터 (DonutChart.js가 기대하는 포맷에 맞추기)
        List<Map<String, Object>> chartDataList = new ArrayList<>();

        for (PortfolioDTO data : portfolioAllocationItemList) {
            Map<String, Object> chartData = new HashMap<>();
            chartData.put("stockName", data.getStockName());
            chartData.put("stockCode", data.getStockCode());
            chartData.put("weightPct", data.getWeightPct());
            chartData.put("color", ColorUtil.colorByStockCode(data.getStockCode()));
            chartDataList.add(chartData);
        }


        //응답에 추가
        myData.put("chartData", chartDataList);

        //test
        System.out.println("체크용 " + chartDataList);

        //map반환(자동으로 json변환)
        return myData;
    }
}

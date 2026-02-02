package com.tickerbell.jujuclub.invest.controller;

import com.tickerbell.jujuclub.invest.dto.StockChartRestDTO;
import com.tickerbell.jujuclub.invest.service.StockChartDataService;
import com.tickerbell.jujuclub.invest.service.StockChartRestService;
import com.tickerbell.jujuclub.invest.service.StockChartService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequiredArgsConstructor
@Slf4j
public class StockChartController {
    private final SimpMessagingTemplate messagingTemplate;
    private final StockChartService stockChartService;
    private final StockChartRestService stockChartRestService;
    private final StockChartDataService stockChartDataService;

    /**
     * 주식 차트 REST API 연결
     *
     * @param periodCode String
     * @param stockCode String
     * @return List&ltStockChartRestDTO&gt;
     */
    @GetMapping("api/invest/chartData")
    @ResponseBody
    public List<StockChartRestDTO> getRestChartData(@RequestParam(value = "periodCode", defaultValue = "D") String periodCode, @RequestParam(value = "stockCode") String stockCode) throws Exception {
        return stockChartRestService.getStockRestData(periodCode, stockCode);
    }

    /**
     * 주식 장 타입(market Type) 조회
     *
     * @param stockCode String
     * @return String
     */
    @GetMapping("/invest/chart/marketType")
    @ResponseBody
    public String getMarketType(@RequestParam String stockCode) {
        return stockChartDataService.selectMarketType(stockCode);
    }

    /**
     * 주식 웹소켓 데이터 요청 메시지 처리
     *
     *<p>
     *    페이로드 예시
     *</p>
     * <pre>
     *  {
     *      "tr_type": "1",
     *      "stockCodes": ["005930", "000660"]
     *  }
     * </pre>
     *
     * @param message Map<String, Object>
     */
    @MessageMapping("/invest/request/chartData")
    public void handleStockRequest(@Payload Map<String, Object> message){
        try {
            String trType = (String) message.get("tr_type");

            List<String> stockCodes = new ArrayList<>();
            Object codes = message.get("stockCodes");

            if (codes instanceof List<?>) {
                for (Object code : (List<?>) codes) {
                    stockCodes.add((String.valueOf(code)));
                }
            } else if (codes instanceof String) {
                stockCodes.add(String.valueOf(codes));

            }
            if (!stockCodes.isEmpty()) {
                stockChartService.connectToStockChartApi(trType, stockCodes);

            }
        } catch (Exception e) {
            log.error("주식 웹소켓 데이터 요청 메시지 처리 중 오류 발생");
            throw new RuntimeException(e);
        }

    }
}

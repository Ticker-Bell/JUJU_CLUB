package com.tickerbell.jujuclub.invest.stockChart.controller;

import com.tickerbell.jujuclub.invest.stockChart.dto.StockChartRestDTO;
import com.tickerbell.jujuclub.invest.stockChart.service.StockChartRestService;
import com.tickerbell.jujuclub.invest.stockChart.service.StockChartService;
import lombok.RequiredArgsConstructor;
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
public class StockChartController {
    private final SimpMessagingTemplate messagingTemplate;
    private final StockChartService stockChartService;
    private final StockChartRestService stockChartRestService;

    @GetMapping("invest/investChart.do")
    public String stockChartPage() {
        return "invest/investChart";
    }

    @GetMapping("api/invest/chartData")
    @ResponseBody
    public List<StockChartRestDTO> getRestChartData(
            @RequestParam(value = "periodCode", defaultValue = "D") String periodCode,
            @RequestParam(value = "stockCode") String stockCode) {
        return stockChartRestService.getStockRestData(periodCode, stockCode);
    }

    @MessageMapping("/invest/request/chartData")
    public void handleStockRequest(@Payload Map<String, Object> message) {
        //messagingTemplate을 사용하여 주소를 동적으로 바꾸고, 서버 부하를 줄임
        Object codes = message.get("stockCodes");
        if (codes instanceof List) {
            List<String> stockCodes = (List<String>) codes;
            for (String code : stockCodes) {
                System.out.println("다중 요청 종목: " + code);
                stockChartService.connectToStockChartApi(code);
                messagingTemplate.convertAndSend("/topic/stock/" + code, "데이터 로드 시작: " + code); //
            }
        } else {
            String stockCode = (String) message.get("stockCode");
            System.out.println("단일 요청 종목: " + stockCode);
            stockChartService.connectToStockChartApi(stockCode);
            messagingTemplate.convertAndSend("/topic/stock/" + stockCode, "단일 데이터 로드 시작: " + stockCode);
        }

    }
}

package com.tickerbell.jujuclub.invest.stockChart.controller;

import com.tickerbell.jujuclub.invest.stockChart.dto.StockChartDTO;
import com.tickerbell.jujuclub.invest.stockChart.dto.StockChartRestDTO;
import com.tickerbell.jujuclub.invest.stockChart.service.StockChartRestService;
import com.tickerbell.jujuclub.invest.stockChart.service.StockChartService;
import com.tickerbell.jujuclub.utils.StockChartParser;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequiredArgsConstructor
public class StockChartController {

    private final StockChartService stockChartService;
    private final StockChartRestService stockChartRestService;

    @GetMapping("invest/investChart.do")
    public String stockChartPage() {
        return "invest/investChart";
    }

    @GetMapping("api/invest/chartData")
    @ResponseBody
    public List<StockChartRestDTO> getRestChartData(@RequestParam(value = "periodCode", defaultValue = "D") String periodCode){
        return stockChartRestService.getStockRestData(periodCode);
    }

    @MessageMapping("/invest/request/chartData")
    @SendTo("/topic/stock")
    public void handleStockRequest(@Payload Map<String, Object> message) {
        Object codes = message.get("stockCodes");
        if (codes instanceof List) {
            List<String> stockCodes = (List<String>) codes;
            for (String code : stockCodes) {
                System.out.println("다중 요청 종목: " + code);
                stockChartService.connectToStockChartApi(code);
            }
        } else {
            String stockCode = (String) message.get("stockCode");
            System.out.println("단일 요청 종목: " + stockCode);
            stockChartService.connectToStockChartApi(stockCode);
        }

    }
}

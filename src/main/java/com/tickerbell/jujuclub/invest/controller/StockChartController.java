package com.tickerbell.jujuclub.invest.controller;

import com.tickerbell.jujuclub.invest.dto.StockChartRestDTO;
import com.tickerbell.jujuclub.invest.service.StockChartDataService;
import com.tickerbell.jujuclub.invest.service.StockChartRestService;
import com.tickerbell.jujuclub.invest.service.StockChartService;
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
    private final StockChartDataService stockChartDataService;

    @GetMapping("invest/investChart.do")
    public String stockChartPage() {
        return "invest/investChart";
    }

    @GetMapping("api/invest/chartData")
    @ResponseBody
    public List<StockChartRestDTO> getRestChartData(@RequestParam(value = "periodCode", defaultValue = "D") String periodCode, @RequestParam(value = "stockCode") String stockCode) throws Exception {
        return stockChartRestService.getStockRestData(periodCode, stockCode);
    }

    @GetMapping("/invest/chart/marketType")
    @ResponseBody
    public String getMarketType(@RequestParam String stockCode) {
        return stockChartDataService.selectMarketType(stockCode);
    }


    @MessageMapping("/invest/request/chartData")
    public void handleStockRequest(@Payload Map<String, Object> message) throws Exception {
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

    }
}

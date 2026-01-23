package com.tickerbell.jujuclub.invest.stockChart.controller;

import com.tickerbell.jujuclub.invest.stockChart.dto.SelectedStockDTO;
import com.tickerbell.jujuclub.invest.stockChart.dto.StockChartRestDTO;
import com.tickerbell.jujuclub.invest.stockChart.service.StockChartDataService;
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

import javax.servlet.http.HttpServletRequest;
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
    public List<StockChartRestDTO> getRestChartData(@RequestParam(value = "periodCode", defaultValue = "D") String periodCode, @RequestParam(value = "stockCode") String stockCode, HttpServletRequest request) throws Exception {
        return stockChartRestService.getStockRestData(periodCode, stockCode, request);
    }

    @GetMapping("/invest/chart/marketType")
    @ResponseBody
    public String getMarketType(@RequestParam String stockCode) {
        return stockChartDataService.selectMarketType(stockCode);
    }


    @MessageMapping("/invest/request/chartData")
    public void handleStockRequest(@Payload Map<String, Object> message) {
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

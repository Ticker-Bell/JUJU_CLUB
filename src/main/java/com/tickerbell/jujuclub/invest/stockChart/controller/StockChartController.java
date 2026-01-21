package com.tickerbell.jujuclub.invest.stockChart.controller;

import com.tickerbell.jujuclub.invest.stockChart.dto.SelectedStockDTO;
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

    @GetMapping("/invest/chart/selectedStockInfo")
    @ResponseBody
    public SelectedStockDTO selectedStockInfo(@RequestParam String stockCode, @RequestParam String stockName){
       //선택된 주식 정보
        return new SelectedStockDTO(stockCode, stockName);
    }

    @MessageMapping("/invest/request/chartData")
    public void handleStockRequest(@Payload Map<String, Object> message) {
        //messagingTemplate을 사용하여 주소를 동적으로 바꾸고, 서버 부하를 줄임

        //모든 주식코드를 리스트 형식으로 받음
        List<String> stockCodes = new ArrayList<>();

        Object codes = message.get("stockCodes");
        if (codes instanceof List<?>) {
            for( Object code : (List<?>) codes) {
                stockCodes.add(String.valueOf(code));
            }
        } else if (codes instanceof String) {
            stockCodes.add((String) codes);
        }
        if (!stockCodes.isEmpty()) {
            stockChartService.connectToStockChartApi(stockCodes);

            for (String stockCode : stockCodes) {
                messagingTemplate.convertAndSend("/topic/stock/" + stockCode,
                        Map.of("stockCode", stockCode, "status", "Init", "message", "데이터 로드 시작"));
            }
        }
    }
}

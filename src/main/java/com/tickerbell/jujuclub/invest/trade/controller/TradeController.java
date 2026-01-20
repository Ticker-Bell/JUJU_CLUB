package com.tickerbell.jujuclub.invest.trade.controller;

import com.tickerbell.jujuclub.invest.trade.dto.TradeDTO;
import com.tickerbell.jujuclub.invest.trade.service.TradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/trade")

public class TradeController {
    @Autowired
    TradeService tradeService;

    @PostMapping("/BuySell")
    public ResponseEntity<Map<String, Object>> buySellTrade(@RequestBody TradeDTO tradeDTO) {
        Map<String, Object> response = new HashMap<>();

        try {
            tradeService.processTrade(tradeDTO);

            response.put("success", true);
            response.put("message", "거래가 성공적으로 완료되었습니다.");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
}

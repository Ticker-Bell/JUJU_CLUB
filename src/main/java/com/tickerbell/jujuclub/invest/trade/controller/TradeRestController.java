package com.tickerbell.jujuclub.invest.trade.controller;

import com.tickerbell.jujuclub.invest.trade.dto.TradeDTO;
import com.tickerbell.jujuclub.invest.trade.service.TradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/trade")
public class TradeRestController {
        @Autowired
        TradeService tradeService;

        @PostMapping("/BuySell")
        public ResponseEntity<Map<String, Object>> buySellTrade(@RequestBody TradeDTO tradeDTO, HttpSession session) {
            Map<String, Object> response = new HashMap<>();
            Integer userSeq = (Integer) session.getAttribute("userSeq") == null ? 4 : (Integer) session.getAttribute("userSeq");

            try {
                tradeDTO.setUserSeq(userSeq);

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



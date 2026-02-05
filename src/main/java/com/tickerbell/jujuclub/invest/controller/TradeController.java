package com.tickerbell.jujuclub.invest.controller;

import com.tickerbell.jujuclub.invest.dto.TradeDTO;
import com.tickerbell.jujuclub.invest.service.TradeService;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/invest")
@Slf4j
@RequiredArgsConstructor
public class TradeController {

    private final TradeService tradeService;

    /**
     * 보유 수량 조회
     *
     * @param stockCode String
     * @return Integer
     */
    @GetMapping("/hasStockQuantity")
    @ResponseBody
    public Integer TradePage(@RequestParam String stockCode, HttpSession session) {
        Object userSeqObj = session.getAttribute("userSeq");

        int userSeq = (userSeqObj == null)
                ? 4
                : Integer.parseInt(userSeqObj.toString());
        TradeDTO tradeDTO = new TradeDTO();
        tradeDTO.setUserSeq(userSeq);
        tradeDTO.setStockCode(stockCode);

        Integer quantity = tradeService.getStockQuantity(tradeDTO);
        return (quantity == null) ? 0 : quantity;
    }

    /**
     * 주식 거래
     *
     * @param tradeDTO TradeDTO
     * @return ResponseEntity<Map<String, Object>>
     */
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

        } catch (RuntimeException e) {
            log.error("거래 실패: {}", e.getMessage());
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(response);

        } catch (Exception e) {
            log.error("시스템 오류: {}", e.getMessage());
            response.put("success", false);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

}

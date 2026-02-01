package com.tickerbell.jujuclub.invest.controller;

import com.tickerbell.jujuclub.invest.dto.TradeDTO;
import com.tickerbell.jujuclub.invest.service.TradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/invest")

public class TradeController {
    @Autowired
    TradeService tradeService;


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
}

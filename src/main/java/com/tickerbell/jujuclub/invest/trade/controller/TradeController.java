package com.tickerbell.jujuclub.invest.trade.controller;

import com.tickerbell.jujuclub.invest.trade.dto.TradeDTO;
import com.tickerbell.jujuclub.invest.trade.service.TradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/invest")

public class TradeController {
    @Autowired
    TradeService tradeService;

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

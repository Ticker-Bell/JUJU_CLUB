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

    @GetMapping("/investBuySell.do")
    public String TradePage(HttpSession session, Model model){
        Integer userSeq = (Integer) session.getAttribute("userSeq") == null ? 4 : (Integer)session.getAttribute("userSeq");
        TradeDTO tradeDTO = new TradeDTO();
        tradeDTO.setUserSeq(userSeq);
        tradeDTO.setStockSeq(1);
        int hasStockQuantity = tradeService.getStockQuantity(tradeDTO);
        model.addAttribute("hasStockQuantity", hasStockQuantity);

        return "invest/investBuySell";

    }
}

package com.tickerbell.jujuclub.invest.buysell.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BuySellController {
    @GetMapping("invest/investBuySell.do")
    public String BuySellPage(){
        return "invest/investBuySell";
    }
}

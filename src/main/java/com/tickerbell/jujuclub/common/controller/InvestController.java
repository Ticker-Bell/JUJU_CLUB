package com.tickerbell.jujuclub.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/invest")
public class InvestController {

    @GetMapping("/main.do")
    public String invest() {
        return "invest/investMain";
    }
}

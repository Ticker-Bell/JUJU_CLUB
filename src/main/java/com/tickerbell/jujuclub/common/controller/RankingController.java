package com.tickerbell.jujuclub.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ranking")
public class RankingController {

    @GetMapping("/main.do")
    public String ranking(Model model) {
        return "ranking/rankingMain";
    }

}

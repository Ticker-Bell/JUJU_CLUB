package com.tickerbell.jujuclub.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/main")
@Controller
public class SidebarController {

    @GetMapping()
    public String main() {
        return "common/main";
    }

    @GetMapping("/roadMapMain.do")
    public String roadMap() {
        return "roadMap/roadMapMain";
    }

    @GetMapping("/investMain.do")
    public String invest() {
        return "invest/investMain";
    }

    @GetMapping("/myPageMain.do")
    public String myPage() {
        return "myPage/myPageMain";
    }

    @GetMapping("/rankingMain.do")
    public String ranking() {
        return "ranking/rankingMain";
    }

}

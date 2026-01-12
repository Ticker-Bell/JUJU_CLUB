package com.tickerbell.jujuclub.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/main")
@Controller
public class SidebarController {

    @GetMapping("/roadMapMain.do")
    public String roadMap() {
        return "/main/roadMapMain";
    }

    @GetMapping("/investMain.do")
    public String invest() {
        return "/main/investMain";
    }

    @GetMapping("/myPageMain.do")
    public String myPage() {
        return "/main/myPageMain";
    }

    @GetMapping("/rankingMain.do")
    public String ranking() {
        return "/main/rankingMain";
    }

}

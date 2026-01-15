package com.tickerbell.jujuclub.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/myPage")
public class MyPageController {

    @GetMapping("/main.do")
    public String myPage() {
        return "myPage/myPageMain";
    }

}

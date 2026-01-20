package com.tickerbell.jujuclub.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/myPage")
public class MyPageProfile {

    @GetMapping("/profile")
    public String profile(Model model) {
        return "myPage/myPageProfile";
    }
}

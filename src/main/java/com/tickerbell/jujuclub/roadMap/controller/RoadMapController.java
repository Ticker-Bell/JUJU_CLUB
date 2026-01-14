package com.tickerbell.jujuclub.roadMap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/roadMap")
public class RoadMapController {
    @GetMapping("/main.do")
    public String roadMap(Model model, @RequestHeader(value="HX-Request", required = false) boolean isHtmx) {
        if (isHtmx) {
            // 사이드바 클릭 시 처리
            return "roadMap/roadMapMain";
        } else {
            // 주소창 입력 및 새로고침 처리
            model.addAttribute("targetPage", "/WEB-INF/views/roadMap/roadMapMain.jsp");
            return "common/main";
        }
    }
}

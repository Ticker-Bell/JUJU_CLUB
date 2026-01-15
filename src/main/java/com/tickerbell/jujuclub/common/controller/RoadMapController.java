package com.tickerbell.jujuclub.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/roadMap")
public class RoadMapController {

    @GetMapping("/main.do")
    public String roadMap(Model model) {

        model.addAttribute("test","테스트");
        return "roadMap/roadMapMain";
    }

}

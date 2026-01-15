package com.tickerbell.jujuclub.roadMap.controller;


import com.tickerbell.jujuclub.roadMap.dto.ChapterDTO;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/roadMapApi")
public class RoadMapApiController {
    @Autowired
    private RoadMapService roadMapService;

    @GetMapping("/chapters")
    public List<ChapterDTO> getChapter(@RequestParam("levelId") Integer levelId) {
        System.out.println("요청 받은 levelId: " + levelId); // 로그 확인용
        return roadMapService.chapterList(levelId);
    }
}

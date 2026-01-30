package com.tickerbell.jujuclub.roadMap.controller;


import com.tickerbell.jujuclub.roadMap.dto.ChapterDTO;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/roadMapApi")
public class RoadMapApiController {

    private final RoadMapService roadMapService;

    /**
     * 레벨에 맞는 챕터 전체 반환
     *
     * @param levelId Integer
     * @return roadMapService.chapterList(levelId)
     */
    @GetMapping("/chapters")
    public List<ChapterDTO> getChapter(@RequestParam("levelId") Integer levelId) {

        return roadMapService.chapterList(levelId);
    }
}

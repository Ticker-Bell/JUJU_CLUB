package com.tickerbell.jujuclub.roadMap.controller;

import com.tickerbell.jujuclub.roadMap.dto.*;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/roadMap")
public class RoadMapController {
    private final RoadMapService roadMapService;

    public RoadMapController(RoadMapService roadMapService) {
        this.roadMapService = roadMapService;
    }

    @GetMapping("/main.do")
    public String getRoadMap(Model model) {

        List<LevelDTO> levelList = roadMapService.levelList();
        List<ChapterDTO> chptList = roadMapService.chapterList(1);
        List<RoadMapLessonDTO> lessonList = roadMapService.lessonList("CHAPTER_STOCK_02");
        List<UserLessonDTO> userLessonList = roadMapService.userLessonList(11);

        levelList.forEach(System.out::println);
        chptList.forEach(System.out::println);
        lessonList.forEach(System.out::println);
        userLessonList.forEach(System.out::println);

        model.addAttribute("levelList",levelList);
        model.addAttribute("chptList",chptList);
        model.addAttribute("lessonList",lessonList);
        model.addAttribute("userLessonList",userLessonList.stream().findFirst());

        return "roadMap/roadMapMain";
    }

    @PostMapping("/main.do")
    public String postRoadMap(Model model,
                              @RequestParam("levelId") Integer levelId,
                              @RequestParam("chapterId") String chapterId) {

        List<LevelChapterLessonDTO> selectLearningList = roadMapService.selectLearningList(levelId, chapterId);
        return null;
    }

}

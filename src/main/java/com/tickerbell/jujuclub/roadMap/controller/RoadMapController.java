package com.tickerbell.jujuclub.roadMap.controller;

import com.tickerbell.jujuclub.roadMap.dto.ChapterDTO;
import com.tickerbell.jujuclub.roadMap.dto.LevelDTO;
import com.tickerbell.jujuclub.roadMap.dto.RoadMapLessonDTO;
import com.tickerbell.jujuclub.roadMap.dto.UserLessonDTO;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/roadMap")
public class RoadMapController {
    private final RoadMapService roadMapService;

    public RoadMapController(RoadMapService roadMapService) {
        this.roadMapService = roadMapService;
    }

    @GetMapping("/main.do")
    public String roadMap(Model model, @RequestHeader(value="HX-Request", required = false) boolean isHtmx, HttpSession httpSession) {

        List<LevelDTO> levelList = roadMapService.levelList();
        List<ChapterDTO> chptList = roadMapService.chapterList(1);
        List<RoadMapLessonDTO> lessonList = roadMapService.lessonList("CHAPTER_STOCK_02");
        List<UserLessonDTO> userLessonList = roadMapService.userLessonList(11);

        levelList.forEach(System.out::println);
        chptList.forEach(System.out::println);
        lessonList.forEach(System.out::println);
        userLessonList.forEach(System.out::println);

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

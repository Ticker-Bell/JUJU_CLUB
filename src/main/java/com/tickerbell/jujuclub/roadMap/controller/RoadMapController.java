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
        List<LevelChapterLessonDTO> selectLearningList = roadMapService.selectLearningList(1, "CHAPTER_STOCK_02");
//        RoadMapLessonDTO currentLssn = roadMapService.currentLssn("lesson_stock_05");
        // 미션 확인용
        List<MissionDTO> missionList = roadMapService.missionList();
        int successCount = (int) missionList.stream().filter(mission -> mission.getCount() <= mission.getProgress()).count();

        levelList.forEach(System.out::println);
        chptList.forEach(System.out::println);
        lessonList.forEach(System.out::println);
        System.out.println(userLessonList.stream().findFirst());

        model.addAttribute("levelList",levelList);
        model.addAttribute("chptList",chptList); // 레벨 선택하면 챕터리스트 조회
        model.addAttribute("lessonList",lessonList);
        model.addAttribute("selectLearningList", selectLearningList); // 레벨/챕터에 맞는 레슨 전체 조회
        model.addAttribute("userLesson",userLessonList); // 현재 유저 레슨
        model.addAttribute("isMissionClear", 4 > successCount); // 미션 클리어 확인
//        model.addAttribute("currentLssn", currentLssn);

        return "roadMap/roadMapMain";
    }


    @PostMapping("/main.do")
    public String postRoadMap(Model model,
                              @RequestParam("levelId") Integer levelId,
                              @RequestParam("chapterId") String chapterId) {

        List<LevelChapterLessonDTO> selectLearningList = roadMapService.selectLearningList(levelId, chapterId);
        return null;
    }

    @GetMapping("/mission.do")
    public String getMission(Model model) {
        List<MissionDTO> missionList = roadMapService.missionList();
        int successCount = (int) missionList.stream().filter(mission -> mission.getCount() <= mission.getProgress()).count();

        model.addAttribute("mission", missionList);
        model.addAttribute("successCount", successCount);
        return "roadMap/missionModal";
    }
}

package com.tickerbell.jujuclub.roadMap.controller;

import com.tickerbell.jujuclub.roadMap.dto.*;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
@RequestMapping("/roadMap")
public class RoadMapController {
    private final RoadMapService roadMapService;

    public RoadMapController(RoadMapService roadMapService) {
        this.roadMapService = roadMapService;
    }

    @GetMapping("/main.do")
    public String getRoadMap(Model model) {
        Integer levelSeq = 1;
        Integer userSeq = 11;
        String chapterId = "LV2_CH001";

        List<LevelDTO> levelList = roadMapService.levelList();
        List<ChapterDTO> chptList = roadMapService.chapterList(levelSeq);
        List<RoadMapLessonDTO> lessonList = roadMapService.lessonList(chapterId);
        List<UserLessonDTO> userLessonList = roadMapService.userLessonList(userSeq);
        List<LevelChapterLessonDTO> selectLearningList = roadMapService.selectLearningList(levelSeq, chapterId);
        List<LevelChapterLessonDTO> allLearningList = roadMapService.allLearningList();
        List<ChapterResultDTO> chapterResultList = roadMapService.chapterTestResult(userSeq);

        // 미션 확인용
        List<MissionDTO> missionList = roadMapService.missionList();
        int successCount = (int) missionList.stream().filter(mission -> mission.getCount() <= mission.getProgress()).count();

        // 전체 레슨 및 유저 진행 상황 저장
        int count = userLessonList.size() - 1;

        for (int i = 0; i < allLearningList.size(); i++) {
            LevelChapterLessonDTO lesson = allLearningList.get(i);
            if (count >= 0) {
                UserLessonDTO user = userLessonList.get(count--);

                if (lesson.getLessonId().equals(user.getLessonId())) {
                    if (!user.getLessonId().isEmpty() && user.getEndDate() != null && !user.getEndDate().toString().isEmpty()) {
                        lesson.setLessonStatus("completed");
                    } else if (user.getLessonId() != null && !user.getLessonId().isEmpty() &&
                            (user.getEndDate() == null || (user.getEndDate().toString()).isEmpty())) {
                        lesson.setLessonStatus("current");
                    }
                }
            } else {
                lesson.setLessonStatus("locked");
            }
        }
        int idx = 0;
        for (int i = 0; i < allLearningList.size(); i++) {
            LevelChapterLessonDTO lesson = allLearningList.get(i);
            ChapterResultDTO testResult = chapterResultList.get(idx);
            // chpaterId가 같으면
            if (lesson.getChapterId().equals(testResult.getChapterId())) {
                lesson.setChapterPass(Objects.equals(testResult.getIsPass(), "Y"));
            }
        }

        levelList.forEach(System.out::println);
        chptList.forEach(System.out::println);
        lessonList.forEach(System.out::println);
        System.out.println(userLessonList.stream().findFirst());

        model.addAttribute("levelList", levelList);
        model.addAttribute("chptList", chptList); // 레벨 선택하면 챕터리스트 조회
        model.addAttribute("lessonList", lessonList);
        model.addAttribute("selectLearningList", selectLearningList); // 레벨/챕터에 맞는 레슨 전체 조회
        model.addAttribute("userLesson", userLessonList); // 현재 유저 레슨 정보
        model.addAttribute("isMissionClear", 4 > successCount); // 미션 클리어 확인
        model.addAttribute("allLearningList", allLearningList); // 전체 레슨 + 유저 진행상황
        model.addAttribute("chapterResultList", chapterResultList); // 전체 레슨 + 유저 진행상황

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

package com.tickerbell.jujuclub.roadMap.controller;

import com.tickerbell.jujuclub.roadMap.dto.*;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        //List<RoadMapLessonDTO> lessonList = roadMapService.lessonList(chapterId);
        List<UserLessonDTO> userLessonList = roadMapService.userLessonList(userSeq);
        //List<LevelChapterLessonDTO> selectLearningList = roadMapService.selectLearningList(levelSeq, chapterId);
        List<LevelChapterLessonDTO> allLearningList = roadMapService.allLearningList();
        List<ChapterResultDTO> chapterResultList = roadMapService.chapterTestResult(userSeq);

        // 미션 확인용
        List<MissionDTO> missionList = roadMapService.missionList();
        int successCount = (int) missionList.stream().filter(mission -> mission.getCount() <= (mission.getProgress() == null ? 0 : mission.getProgress())).count();

        // 유저 레슨 진행 상황 저장
        Map<String, UserLessonDTO> userMap = new HashMap<>();
        for (UserLessonDTO user : userLessonList) {
            userMap.put(user.getLessonId(), user);
        }

        // 유저 챕터 테스트 진행상황 저장
        Map<String, ChapterResultDTO> resultMap = new HashMap<>();
        for (ChapterResultDTO result : chapterResultList) {
            resultMap.put(result.getChapterId(), result);
        }

        Map<String, Integer> chptClearCount = new HashMap<>();

        // 완료된 레슨 수 카운트
        for (LevelChapterLessonDTO lesson : allLearningList) {
            UserLessonDTO user = userMap.get(lesson.getLessonId());
            if (user != null && user.getEndDate() != null) {
                chptClearCount.put(lesson.getChapterId(),
                        chptClearCount.getOrDefault(lesson.getChapterId(), 0) + 1);
            }
        }

        // 유저 레슨, 테스트 진행상황 저장
        final boolean[] isUnlocked = {true};
        allLearningList.forEach(lesson -> {
            UserLessonDTO user = userMap.get(lesson.getLessonId());
            ChapterResultDTO result = resultMap.get(lesson.getChapterId());

            boolean testFinished = result != null && result.getIsPass().equals("Y");

            lesson.setLessonStatus(lessonStatus(user));
            lesson.setChapterPass(chapterStatus(result, lesson, chptClearCount));
        });

        model.addAttribute("levelList", levelList);
        //model.addAttribute("chptList", chptList); // 레벨 선택하면 챕터리스트 조회
        //model.addAttribute("lessonList", lessonList);
        //model.addAttribute("selectLearningList", selectLearningList); // 레벨/챕터에 맞는 레슨 전체 조회
        //model.addAttribute("userLesson", userLessonList); // 현재 유저 레슨 정보
        model.addAttribute("isMissionClear", 4 > successCount); // 미션 클리어 확인
        model.addAttribute("allLearningList", allLearningList); // 전체 레슨 + 유저 진행상황

        return "roadMap/roadMapMain";
    }

    private String lessonStatus(UserLessonDTO user) {
        if (user == null) {
            return "locked";
        }
        if (user.getEndDate() != null && !user.getEndDate().toString().isEmpty()) {
            return "completed";
        }
        return "current";
    }

    private String chapterStatus(ChapterResultDTO result, LevelChapterLessonDTO lesson, Map<String, Integer> chptClearCount) {
        if (result != null && "Y".equals(result.getIsPass())) {
            return "completed";
        }
        else {
            // 총 레슨 수 챕터당 5개 고정이라서 5로 비교
            int clearedCount = chptClearCount.getOrDefault(lesson.getChapterId(), 0);
            int totalLessonsInChapter = 5;

            return (clearedCount >= totalLessonsInChapter) ? "current" : "locked";
        }
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

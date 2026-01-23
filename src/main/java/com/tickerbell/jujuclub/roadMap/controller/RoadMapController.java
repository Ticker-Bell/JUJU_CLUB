package com.tickerbell.jujuclub.roadMap.controller;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.roadMap.dto.*;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/roadMap")
public class RoadMapController {
    private final RoadMapService roadMapService;

    @GetMapping("/main.do")
    public String getRoadMap(Model model, HttpServletRequest request) {
        // 테스트용
//        Integer levelSeq = 1;
//        Integer userSeq = 11;
//        String chapterId = "LV2_CH001";

        // TODO: 개발 완료 후 세션 연결
        HttpSession session = request.getSession();
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        Integer userSeq = loginUser.getUserSeq();

        List<LevelDTO> levelList = roadMapService.levelList();
        List<UserLessonDTO> userLessonList = roadMapService.userLessonList(userSeq);
        List<LevelChapterLessonDTO> allLearningList = roadMapService.allLearningList();
        List<ChapterResultDTO> chapterResultList = roadMapService.chapterTestResult(userSeq);

        // 미션 확인용
        List<MissionDTO> missionList = roadMapService.missionList();
        int successCount = (int) missionList.stream()
                .filter(mission -> mission.getCount() <= (mission.getProgress() == null ? 0 : mission.getProgress()))
                .count();

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


        // 유저 레슨, 테스트 진행상황 저장
        boolean isUnlocked = true;
        for(LevelChapterLessonDTO lesson: allLearningList) {
            UserLessonDTO user = userMap.get(lesson.getLessonId());
            ChapterResultDTO result = resultMap.get(lesson.getChapterId());

            boolean isLssnFinished = user != null && user.getEndDate() != null
                    && !user.getEndDate().toString().isEmpty();

            boolean isChptFinished = result != null && "Y".equals(result.getIsPass());

            if (!"6".equals(lesson.getLessonId().substring(lesson.getLessonId().length()-1))) {
                if (isLssnFinished) {
                    lesson.setStatus("completed");
                    isUnlocked = true;
                } else {
                    if (isUnlocked) {
                        lesson.setStatus("current");
                        isUnlocked = false;
                    } else {
                        lesson.setStatus("locked");
                    }
                }
            } else {
                if (isChptFinished) {
                    lesson.setStatus("completed");
                    isUnlocked = true;
                } else {
                    if (isUnlocked) {
                        lesson.setStatus("current");
                        isUnlocked = false;
                    } else {
                        lesson.setStatus("locked");
                    }

                }
            }
        }

        // 현재 진행하고 있는 유저 레슨/챕터 정보 전달
        LevelChapterLessonDTO userLesson = allLearningList.stream()
                .filter(lesson -> "current".equals(lesson.getStatus()))
                .findFirst()
                .orElse(allLearningList.get(0));

        model.addAttribute("levelList", levelList); // 레벨 전체 조회
        model.addAttribute("userLesson", userLesson); // 현재 유저 레슨 정보
        model.addAttribute("isMissionClear", 4 > successCount); // 미션 클리어 확인
        model.addAttribute("allLearningList", allLearningList); // 전체 레슨 + 유저 진행상황

        return "roadMap/roadMapMain";
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

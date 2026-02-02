package com.tickerbell.jujuclub.roadMap.controller;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.common.service.UserInfoService;
import com.tickerbell.jujuclub.roadMap.dto.*;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/roadMap")
public class RoadMapController {
    private final RoadMapService roadMapService;
    private final UserInfoService userInfoService;

    /**
     * 로드맵 메인화면 정보 조희
     *
     * @return /roadMap/roadMapMain
     */
    @GetMapping("/main.do")
    public String getRoadMap(Model model, HttpSession session) {
        
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        Integer userSeq = loginUser.getUserSeq();

        List<LevelDTO> levelList = roadMapService.levelList();
        List<UserLessonDTO> userLessonList = roadMapService.userLessonList(userSeq);
        List<LevelChapterLessonDTO> allLearningList = roadMapService.allLearningList(userSeq);
        List<MissionDTO> missionList = roadMapService.missionList(userSeq);

        int successCount = (int) missionList.stream().filter(mission -> mission.getIsSuccess().equals("Y")).count();

        // 현재 진행하고 있는 유저 레슨/챕터 정보 전달
        LevelChapterLessonDTO userLesson = allLearningList.stream()
                .filter(lesson -> !"TEST".equals(lesson.getLessonType()) && "current".equals(lesson.getStatus()))
                .findFirst()
                .orElse(allLearningList.get(0));

        // users 테이블 레벨 정보 업데이트
        userInfoService.userLevelUpdate(userSeq, userLesson.getLessonId());

        model.addAttribute("levelList", levelList); // 레벨 전체 조회
        model.addAttribute("userLesson", userLesson); // 현재 유저 레슨 정보
        model.addAttribute("isMissionClear", 4 > successCount); // 미션 클리어 확인
        model.addAttribute("allLearningList", allLearningList); // 전체 레슨 + 유저 진행상황

        return "roadMap/roadMapMain";
    }


    /**
     * 미션 정보 조회
     *
     * @return roadMap/missionModal
     */
    @GetMapping("/mission.do")
    public String getMission(Model model, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        Integer userSeq = loginUser.getUserSeq();

        List<MissionDTO> missionList = roadMapService.missionList(userSeq);
        int successCount = (int) missionList.stream().filter(mission -> mission.getIsSuccess().equals("Y")).count();

        model.addAttribute("mission", missionList);
        model.addAttribute("successCount", successCount);

        return "roadMap/missionModal";
    }


    /**
     * 레벨에 맞는 챕터 전체 반환
     *
     * @param levelId Integer
     * @return roadMapService.chapterList(levelId)
     */
    @ResponseBody
    @GetMapping("/api/chapters")
    public List<ChapterDTO> getChapter(@RequestParam("levelId") Integer levelId) {

        return roadMapService.chapterList(levelId);
    }
}

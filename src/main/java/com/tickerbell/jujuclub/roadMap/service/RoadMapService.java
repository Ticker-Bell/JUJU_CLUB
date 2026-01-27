package com.tickerbell.jujuclub.roadMap.service;

import com.tickerbell.jujuclub.roadMap.dto.*;
import com.tickerbell.jujuclub.roadMap.mapper.RoadMapMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RoadMapService {

    private final RoadMapMapper roadMapMapper;

    // level 모두 조회
    public List<LevelDTO> levelList() {
        return roadMapMapper.levelList();
    }

    // level id 기준 chapter 모두 조회
    public List<ChapterDTO> chapterList(Integer levelSeq) {
        return roadMapMapper.chapterList(levelSeq);
    }

    // user seq에 따라 현재까지 진행한 레슨 전부 조회
    public List<UserLessonDTO> userLessonList(Integer userSeq) {
        return roadMapMapper.userLessonList(userSeq);
    }

    // 전체 level, chapter, lesson 조회
    public List<LevelChapterLessonDTO> allLearningList() {
        return roadMapMapper.allLearningList();
    }

    // 유저 미션 삽입
    public void insertInitUserMission(Integer userSeq) {
        roadMapMapper.insertInitUserMission(userSeq);
    }
    // 유저 미션 모두 조회
    public List<MissionDTO> missionList(Integer userSeq) {
        List<MissionDTO> list = roadMapMapper.missionList(userSeq);
        MissionCheckDTO check = roadMapMapper.missionCheck(userSeq);

        for(MissionDTO mission: list) {
            // 미션타입에 따라 진행횟수 저장
            switch (mission.getType()) {
                case "lesson":
                    mission.setProgress(check.getLesson());
                    break;
                case "chapterTest":
                    mission.setProgress(check.getChapterTest());
                    break;
                case "buyStocks":
                    mission.setProgress(check.getBuyStocks());
                    break;
                case "watchList":
                    mission.setProgress(check.getWatchList());
                    break;
                default:
                    mission.setProgress(0);
                    break;
            }

            // 미션성공여부, 보상금 지급여부 저장
            if(mission.getProgress() >= mission.getCount()) {
                if("N".equals(mission.getIsSuccess())) {
                    mission.setIsSuccess("Y");
                    boolean rewardSuccess = roadMapMapper.missionReward(userSeq, mission.getMissionId());
                    if(rewardSuccess) {
                        System.out.println("미션 보상금 지급 완료");
                        mission.setIsRewarded("Y");
                    } else {
                        System.out.println("미션 보상금 지급 실패");
                    }
                }
            }
        }

        return list;
    }

    // 챕터테스트 모두 조회
    public List<ChapterResultDTO> chapterTestResult(Integer userSeq) {
        return roadMapMapper.chapterTestResult(userSeq);
    }

}
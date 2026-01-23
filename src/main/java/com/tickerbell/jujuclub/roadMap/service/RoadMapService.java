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

    // 미션 모두 조회
    public List<MissionDTO> missionList(Integer userSeq) {
        List<MissionDTO> list = roadMapMapper.missionList();
        MissionCheckDTO check = roadMapMapper.missionCheck(userSeq);

        for(MissionDTO mission: list) {
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

        }
        return list;
    }

    // 챕터테스트 모두 조회
    public List<ChapterResultDTO> chapterTestResult(Integer userSeq) {
        return roadMapMapper.chapterTestResult(userSeq);
    }

}
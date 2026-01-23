package com.tickerbell.jujuclub.roadMap.service;

import com.tickerbell.jujuclub.roadMap.dto.*;
import com.tickerbell.jujuclub.roadMap.mapper.RoadMapMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoadMapService {
    private final RoadMapMapper roadMapMapper;

    public RoadMapService(RoadMapMapper roadMapMapper) {
        this.roadMapMapper = roadMapMapper;
    }

    // level 모두 조회
    public List<LevelDTO> levelList() {
        return roadMapMapper.levelList();
    }

    // level id 기준 chapter 모두 조회
    public List<ChapterDTO> chapterList(Integer levelSeq) {
        return roadMapMapper.chapterList(levelSeq);
    }

    // chapter id에 따라 lesson 전부 조회
    public List<RoadMapLessonDTO> lessonList(String chapterId) {
        return roadMapMapper.lessonList(chapterId);
    }

    // user seq에 따라 현재까지 진행한 레슨 전부 조회
    public List<UserLessonDTO> userLessonList(Integer userSeq) {
        return roadMapMapper.userLessonList(userSeq);
    }

    // 레벨/챕터에 해당하는 레슨 데이터 모두 조회
    public List<LevelChapterLessonDTO> levelChptSelectAllList(Integer levelSeq, String chapterId) {
        return roadMapMapper.levelChptSelectAllList(levelSeq, chapterId);
    }

    // 현재 레슨 id 넘기기
    public RoadMapLessonDTO currentLssn(String lessonId) {
        return roadMapMapper.currentLssn(lessonId);
    }

    // level id or chapter id로 조회시, 레벨/챕터에 해당하는 레슨 데이터 보여줘야함
    public List<LevelChapterLessonDTO> selectLearningList(Integer levelSeq, String chapterId) {
        return roadMapMapper.selectLearningList(levelSeq, chapterId);
    }

    // 전체 level, chapter, lesson 조회
    public List<LevelChapterLessonDTO> allLearningList() {
        return roadMapMapper.allLearningList();
    }

    // 미션 모두 조회
    public List<MissionDTO> missionList() {
        List<MissionDTO> list = roadMapMapper.missionList();
        MissionCheckDTO check = roadMapMapper.missionCheck();

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
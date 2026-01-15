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
    public List<ChapterDTO> chapterList(Integer levelId) {
        return roadMapMapper.chapterList(levelId);
    }

    // chapter id에 따라 lesson 전부 조회
    public List<RoadMapLessonDTO> lessonList(String chapterId) {
        return roadMapMapper.lessonList(chapterId);
    }

    // userid에 따라 현재까지 진행한 레슨 전부 조회
    public List<UserLessonDTO> userLessonList(Integer userId) {
        return roadMapMapper.userLessonList(userId);
    }

    // 레벨/챕터에 해당하는 레슨 데이터 모두 조회
    public List<LevelChapterLessonDTO> levelChptSelectAllList(Integer levelId, String chapterId) {
        return roadMapMapper.levelChptSelectAllList(levelId, chapterId);
    }

    // level id or chapter id로 조회시, 레벨/챕터에 해당하는 레슨 데이터 보여줘야함
    public List<LevelChapterLessonDTO> selectLearningList(Integer levelId, String chapterId) {
        return roadMapMapper.selectLearningList(levelId, chapterId);
    }


}
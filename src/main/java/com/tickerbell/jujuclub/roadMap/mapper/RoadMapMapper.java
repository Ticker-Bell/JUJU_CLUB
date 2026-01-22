package com.tickerbell.jujuclub.roadMap.mapper;

import com.tickerbell.jujuclub.roadMap.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RoadMapMapper {
    // level 전부 조회
    List<LevelDTO> levelList();

    // level id에 따라 chapter id 전부 조회
    List<ChapterDTO> chapterList(@Param("level_seq") Integer levelId);

    // chapter id에 따라 lesson id 전부 조회
//    List<RoadMapLessonDTO> lessonList(@Param("chapter_id") String chapterId);

    // user id로 user의 현재 레슨 진행도 조회
    List<UserLessonDTO> userLessonList(@Param("user_seq") Integer userSeq);

    // 현재 레슨 조회
    //RoadMapLessonDTO currentLssn(@Param("lesson_id") String lessonId);

    // level chapter id로 조회
//    List<LevelChapterLessonDTO> levelChptSelectAllList(@Param("level_seq") Integer levelId, @Param("chapter_id") String chapterId);

    // level id or chapter id로 조회
//    List<LevelChapterLessonDTO> selectLearningList(@Param("level_seq") Integer levelSeq, @Param("chapter_id") String chapterId);

    // 전체 level, chapter, lesson 조회
    List<LevelChapterLessonDTO> allLearningList();

    // mission 조회
    List<MissionDTO> missionList();

    // mission 진행 횟수 조회
    MissionCheckDTO missionCheck();

    // chapter test 전부 조회
    List<ChapterResultDTO> chapterTestResult(@Param("user_seq") Integer userSeq);
}

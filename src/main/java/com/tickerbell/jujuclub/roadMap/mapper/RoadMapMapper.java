package com.tickerbell.jujuclub.roadMap.mapper;

import com.tickerbell.jujuclub.roadMap.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RoadMapMapper {
    /**
     * 레벨 전체 조회
     *
     * @return List&ltLevelDTO&gt
     */
    List<LevelDTO> levelList();

    /**
     * level id에 맞는 chapter 정보 전체 조회
     *
     * @param levelId Integer
     * @return List&ltChapterDTO&gt
     */
    List<ChapterDTO> chapterList(@Param("level_seq") Integer levelId);

    /**
     * user의 현재 레슨 진행 정보 조회
     *
     * @param userSeq Integer
     * @return List&ltUserLessonDTO&gt
     */
    List<UserLessonDTO> userLessonList(@Param("user_seq") Integer userSeq);

    /**
     * level, chapter, lesson 전체 조회
     *
     * @return List&ltLevelChapterLessonDTO&gt
     */
    List<LevelChapterLessonDTO> allLearningList();

    /**
     * user의 chatper test 결과 전체 조회
     *
     * @param userSeq Integer
     * @return List&ltChapterResultDTO&gt
     */
    List<ChapterResultDTO> chapterTestResult(@Param("user_seq") Integer userSeq);

    /**
     * user의 미션 데이터 조회
     *
     * @param userSeq Integer
     * @return List&ltMissionDTO&gt
     */
    List<MissionDTO> missionList(@Param("user_seq") Integer userSeq);

    /**
     * 유저 미션 정보 등록
     *
     * @param userSeq Integer
     */
    void insertInitUserMission(@Param("user_seq") Integer userSeq);

    /**
     * 유저 미션 진행 횟수 조회
     *
     * @param userSeq Integer
     * @return MissionCheckDTO
     */
    MissionCheckDTO missionCheck(@Param("user_seq") Integer userSeq);

    /**
     * 유저 미션 보상금 지급
     *
     * @param userSeq Integer, reward Integer
     * @return boolean
     */
    boolean missionReward(@Param("user_seq") Integer userSeq, @Param("mission_seq") Integer reward);

    /**
     * 온보딩 후 레벨에 맞는 레슨 정보 삽입
     * - 설정된 레벨의 이전 레슨을 완료 처리
     *
     * @param userSeq Integer, userLevel Integer
     */
    void insertInitUserLesson(@Param("user_seq")Integer userSeq, @Param("user_level") Integer userLevel);

    /**
     * 온보딩 후 레벨에 맞는 레슨 정보 삽입
     * - 설정된 레벨의 1챕터 1레슨 삽입
     *
     * @param userSeq Integer, userLevel Integer
     */
    void insertInitCurrentUserLesson(@Param("user_seq")Integer userSeq, @Param("user_level") Integer userLevel);

}

package com.tickerbell.jujuclub.roadMap.service;

import com.tickerbell.jujuclub.roadMap.dto.*;
import com.tickerbell.jujuclub.roadMap.mapper.RoadMapMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class RoadMapService {

    private final RoadMapMapper roadMapMapper;

    /**
     * 레벨 전체 조회
     *
     * @return List&ltLevelDTO&gt
     */
    public List<LevelDTO> levelList() {
        return roadMapMapper.levelList();
    }

    /**
     * level id에 맞는 chapter 정보 전체 조회
     *
     * @param levelId Integer
     * @return List&ltChapterDTO&gt
     */
    public List<ChapterDTO> chapterList(Integer levelId) {
        return roadMapMapper.chapterList(levelId);
    }

    /**
     * user의 현재 레슨 진행 정보 조회
     *
     * @param userSeq Integer
     * @return List&ltUserLessonDTO&gt
     */
    public List<UserLessonDTO> userLessonList(Integer userSeq) {
        return roadMapMapper.userLessonList(userSeq);
    }

    /**
     * level, chapter, lesson 전체 조회
     *
     * @return List&ltLevelChapterLessonDTO&gt
     */
    public List<LevelChapterLessonDTO> allLearningList() {
        return roadMapMapper.allLearningList();
    }

    /**
     * user의 chatper test 결과 전체 조회
     *
     * @param userSeq Integer
     * @return List&ltChapterResultDTO&gt
     */
    public List<ChapterResultDTO> chapterTestResult(Integer userSeq) {
        return roadMapMapper.chapterTestResult(userSeq);
    }

    /**
     * 유저 미션 정보 등록
     *
     * @param userSeq Integer
     */
    public void insertInitUserMission(Integer userSeq) {
        roadMapMapper.insertInitUserMission(userSeq);
    }

    /**
     * user의 미션 데이터 조회
     *
     * @param userSeq Integer
     * @return List&ltMissionDTO&gt
     */
    public List<MissionDTO> missionList(Integer userSeq) {
        try {
            log.info("[{}] 유저 미션 데이터 조회 - 유저 미션 DB 조회 시작", userSeq);
            List<MissionDTO> list = roadMapMapper.missionList(userSeq);
            log.info("[{}] 유저 미션 데이터 조회 - 유저 미션 DB 조회 완료", userSeq);

            log.info("[{}] 유저 미션 완료 조회 - 유저 미션 완료 DB 조회 시작", userSeq);
            MissionCheckDTO check = roadMapMapper.missionCheck(userSeq);
            log.info("[{}] 유저 미션 완료 조회 - 유저 미션 완료 DB 조회 완료", userSeq);

            for (MissionDTO mission : list) {
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
                if (mission.getProgress() >= mission.getCount()) {
                    if ("N".equals(mission.getIsSuccess())) {
                        mission.setIsSuccess("Y");
                        boolean rewardSuccess = roadMapMapper.missionReward(userSeq, mission.getMissionId());
                        if (rewardSuccess) {
                            System.out.println("미션 보상금 지급 완료");
                            mission.setIsRewarded("Y");
                        } else {
                            System.out.println("미션 보상금 지급 실패");
                        }
                    }
                }
            }

            return list;
        }catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 온보딩 후 레벨에 맞는 레슨 정보 삽입
     * - 설정된 레벨의 이전 레슨 완료 처리
     * - 설정된 레벨의 1챕터 1레슨 삽입
     *
     * @param userSeq Integer, userLevel Integer
     */
    @Transactional
    public void insertInitUserLesson(Integer userSeq, Integer userLevel) {
        roadMapMapper.insertInitUserLesson(userSeq, userLevel);
        roadMapMapper.insertInitCurrentUserLesson(userSeq, userLevel);
    };
}
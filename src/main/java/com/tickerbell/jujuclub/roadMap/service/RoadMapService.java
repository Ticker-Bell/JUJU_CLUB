package com.tickerbell.jujuclub.roadMap.service;

import com.tickerbell.jujuclub.roadMap.dto.*;
import com.tickerbell.jujuclub.roadMap.mapper.RoadMapMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

        try {
            log.info("로드맵 레벨 정보 조회 - 레벨 정보 조회 시작");
            List<LevelDTO> list = roadMapMapper.levelList();
            log.info("로드맵 레벨 정보 조회 - 레벨 정보 조회 완료");
            return list;
        } catch (Exception e) {
            log.info("로드맵 레벨 정보 조회 - 레벨 정보 조회 실패");
            throw new RuntimeException(e);
        }
    }

    /**
     * level id에 맞는 chapter 정보 전체 조회
     *
     * @param levelId Integer
     * @return List&ltChapterDTO&gt
     */
    public List<ChapterDTO> chapterList(Integer levelId) {

        try {
            log.info("[{}] 로드맵 챕터 정보 조회 -  챕터 정보 조회 시작", levelId);
            List<ChapterDTO> list = roadMapMapper.chapterList(levelId);
            log.info("[{}] 로드맵 챕터 정보 조회 -  챕터 정보 조회 완료", levelId);
            return list;
        } catch (Exception e) {
            log.info("[{}] 로드맵 챕터 정보 조회 -  챕터 정보 조회 실패", levelId);
            throw new RuntimeException(e);
        }
    }

    /**
     * user의 현재 레슨 진행 정보 조회
     *
     * @param userSeq Integer
     * @return List&ltUserLessonDTO&gt
     */
    public List<UserLessonDTO> userLessonList(Integer userSeq) {

        try {
            log.info("[{}] user 현재 레슨 진행 정보 조회 - 레슨 진행 정보 조회 시작", userSeq);
            List<UserLessonDTO> list = roadMapMapper.userLessonList(userSeq);
            log.info("[{}] 로드맵 챕터 정보 조회 -  레슨 진행 정보 조회 완료", userSeq);
            return list;
        } catch (Exception e) {
            log.info("[{}] 로드맵 챕터 정보 조회 -  레슨 진행 정보 조회 실패", userSeq);
            throw new RuntimeException(e);
        }
    }

    /**
     * user의 level, chapter, lesson 전체 진행 정보 조회
     *
     * @return List&ltLevelChapterLessonDTO&gt
     */
    public List<LevelChapterLessonDTO> allLearningList(Integer userSeq) {

        List<UserLessonDTO> userLessonList = userLessonList(userSeq);
        List<ChapterResultDTO> chapterResultList = chapterTestResult(userSeq);

        log.info("로드맵 레벨/챕터/레슨 정보 조회 - 레벨/챕터/레슨 정보 조회 시작");
        List<LevelChapterLessonDTO> allLearningList = roadMapMapper.allLearningList();
        log.info("로드맵 레벨/챕터/레슨 정보 조회 - 레벨/챕터/레슨 정보 조회 완료");

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
        for (LevelChapterLessonDTO lesson : allLearningList) {
            try {
                log.info("[{}] 유저 레슨/테스트 진행 상황 저장", userSeq);
                UserLessonDTO user = userMap.get(lesson.getLessonId());
                ChapterResultDTO result = resultMap.get(lesson.getChapterId());

                boolean isLssnFinished = user != null && user.getEndDate() != null && !user.getEndDate().toString().isEmpty();
                boolean isLssnCurrent = user != null && user.getStartDate() != null && user.getEndDate() == null;

                boolean isChptFinished = result != null && "Y".equals(result.getIsPass());

                if (!"6".equals(lesson.getLessonId().substring(lesson.getLessonId().length() - 1))) {
                    if (isLssnFinished) {
                        lesson.setStatus("completed");
                        isUnlocked = true;
                    } else {
                        if (isUnlocked || isLssnCurrent) {
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
                log.info("[{}] 유저 레슨/테스트 진행 상황 저장 완료", userSeq);
            }
        catch(Exception e){
            log.info("[{}] 유저 레슨/테스트 진행 상황 저장 실패", userSeq);
            throw new RuntimeException(e);
        }
    }
        return allLearningList;
}

/**
 * user의 chatper test 결과 전체 조회
 *
 * @param userSeq Integer
 * @return List&ltChapterResultDTO&gt
 */
public List<ChapterResultDTO> chapterTestResult(Integer userSeq) {

    try {
        log.info("[{}] user chapter test 결과 조회 - chapter test 결과 조회 시작", userSeq);
        List<ChapterResultDTO> list = roadMapMapper.chapterTestResult(userSeq);
        log.info("[{}] user chapter test 결과 조회 - chapter test 결과 조회 완료", userSeq);
        return list;
    } catch (Exception e) {
        log.info("[{}] user chapter test 결과 조회 - chapter test 결과 조회 실패", userSeq);
        throw new RuntimeException(e);
    }
}

/**
 * 유저 미션 정보 등록
 *
 * @param userSeq Integer
 */
public void insertInitUserMission(Integer userSeq) {

    try {
        log.info("[{}] user 미션 정보 등록 - user 미션 정보 DB 등록 시작", userSeq);
        roadMapMapper.insertInitUserMission(userSeq);
        log.info("[{}] user 미션 정보 등록 - user 미션 정보 DB 등록 완료", userSeq);
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
}

/**
 * user의 미션 데이터 조회
 *
 * @param userSeq Integer
 * @return List&ltMissionDTO&gt
 */
public List<MissionDTO> missionList(Integer userSeq) {
    log.info("[{}] user 미션 데이터 조회 - user 미션 DB 조회 시작", userSeq);
    List<MissionDTO> list = roadMapMapper.missionList(userSeq);
    log.info("[{}] user 미션 데이터 조회 - user 미션 DB 조회 완료", userSeq);

    log.info("[{}] user 미션 완료 조회 - user 미션 완료 DB 조회 시작", userSeq);
    MissionCheckDTO check = roadMapMapper.missionCheck(userSeq);
    log.info("[{}] user 미션 완료 조회 - user 미션 완료 DB 조회 완료", userSeq);


    for (MissionDTO mission : list) {
        try {
            log.info("[{}] user 미션 타입에 따른 진행횟수 저장 시작", userSeq);
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
            log.info("[{}] user 미션 타입에 따른 진행횟수 저장 완료", userSeq);
        } catch (Exception e) {
            log.info("[{}] user 미션 타입에 따른 진행횟수 저장 실패", userSeq);
            throw new RuntimeException(e);
        }
    }
    return list;
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

    try {
        log.info("[{}] 온보딩 후 레벨에 맞는 레슨 정보 등록 - 레슨 정보 DB 등록 시작: [{}]", userLevel, userSeq);
        roadMapMapper.insertInitUserLesson(userSeq, userLevel);
        log.info("[{}] 온보딩 후 레벨에 맞는 레슨 정보 등록 - 레슨 정보 DB 등록 완료: [{}]", userLevel, userSeq);

        log.info("[{}] 온보딩 후 최초 시작 레슨 정보 등록 - 최초 레슨 정보 DB 등록 시작: [{}]", userLevel, userSeq);
        roadMapMapper.insertInitCurrentUserLesson(userSeq, userLevel);
        log.info("[{}] 온보딩 후 최초 시작 레슨 정보 등록 - 최초 레슨 정보 DB 등록 완료: [{}]", userLevel, userSeq);
    } catch (Exception e) {
        log.info("[{}] 온보딩 후 레벨에 맞는 레슨 정보 등록 - 레슨 정보 DB 등록 실패: [{}]", userLevel, userSeq);
        throw new RuntimeException(e);
    }
}

;
}
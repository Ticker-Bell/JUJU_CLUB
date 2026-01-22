package com.tickerbell.jujuclub.roadMap.dto;

import lombok.Data;

@Data
public class LevelChapterLessonDTO {
    // 전체 다 가져오는 거 비효율적인가?
    // 일단해봐;;;
    private String levelId; // level_seq
    private String levelName; // level_name

    private String chapterId; // chapter_id
    private String chapterName; // chapter_name
    private String testReward; // test_reward
    private String testPay; // test_pay

    private String lessonId; // lesson_id
    private String lessonName; // lesson_name
    private String lessonDesc; // description
    private String lessonType; // lesson_type
    private String status; // 유저가 레슨을 완료했는지 확인
}

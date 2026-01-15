package com.tickerbell.jujuclub.roadMap.dto;

import lombok.Data;

import java.util.Date;

@Data
public class UserLessonDTO {
    private Integer resultId; // result_seq
    private Integer levelId; // level_seq
    private String chapterId; // chapter_id
    private String lessonId; // lesson_id
    private Integer userId; // user_seq
    private Date startDate; // started_at
    private Date endDate; // finished_at
}

package com.tickerbell.jujuclub.roadMap.dto;

import lombok.Data;

import java.util.Date;

@Data
public class UserLessonDTO {
    private Integer resultId; // result_seq
    private Integer levelId; // level_seq
    private String levelName; // level_name
    private String chapterId; // chapter_id
    private String chapterName; // chapter_name
    private String lessonId; // lesson_id\
    private Date startDate; // started_at
    private Date endDate; // finished_at
}

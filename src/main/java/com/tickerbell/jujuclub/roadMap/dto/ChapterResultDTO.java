package com.tickerbell.jujuclub.roadMap.dto;

import lombok.Data;

import java.util.Date;

@Data
public class ChapterResultDTO {
    private Integer resultSeq; // test_result_seq
    private Integer userSeq; // user_seq
    private String chapterId; // chapter_id
    private Integer score;
    private Integer tryCount; // attempt_no
    private String isPass; // is_pass
    private Date testDate; // tested_at
}

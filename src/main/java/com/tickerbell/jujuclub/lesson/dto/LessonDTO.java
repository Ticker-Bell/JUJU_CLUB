package com.tickerbell.jujuclub.lesson.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

public class LessonDTO {

  @Alias("QstChat")
  @Builder
  @Data
  @AllArgsConstructor
  @NoArgsConstructor
  public static class QstChat{

    private String lessonId;
    private String questionId;
    private String questionType;
    private String question_text;
    private String options;
    private String answer;
    private String image;
  }

}

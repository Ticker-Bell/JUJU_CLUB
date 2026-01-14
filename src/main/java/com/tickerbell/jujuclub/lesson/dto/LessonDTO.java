package com.tickerbell.jujuclub.lesson.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

public class LessonDTO {

  @Alias("LessonTitle")
  @Builder
  @Data
  @AllArgsConstructor
  @NoArgsConstructor
  public static class LessonTitle{

    private String chapterName;
    private String lessonName;
    private String questionId;
  }

}

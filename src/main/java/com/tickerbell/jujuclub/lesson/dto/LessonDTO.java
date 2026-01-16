package com.tickerbell.jujuclub.lesson.dto;

import java.util.List;
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
  @Alias("LessonQst")
  @Builder
  @Data
  @AllArgsConstructor
  @NoArgsConstructor
  public static class LessonQst{

    private String questionType;
    private String questionText;
    private String options;
    private String answer;
    private String explanation;

    private List<Integer> answerList;
    private List<String> optionList;
  }

}

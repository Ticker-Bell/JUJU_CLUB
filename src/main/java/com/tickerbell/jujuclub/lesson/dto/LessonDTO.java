package com.tickerbell.jujuclub.lesson.dto;

import java.util.List;
import java.util.Map;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

public class LessonDTO {


  @Alias("LessonRequest")
  @Builder
  @Data
  @AllArgsConstructor
  @NoArgsConstructor
  public static class LessonRequest{

    private int userSeq;
    private String lessonId;
    private String chapterId;
    private int score;
    private String isPass;

  }

  @Alias("LessonResponse")
  @Builder
  @Data
  @AllArgsConstructor
  @NoArgsConstructor
  public static class LessonResponse{

    private int resultSeq;
    private String userSeq;
    private String lessonId;
    private String startedAt;
    private String finishedAt;

  }
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

    private Map<String, String> matchAnswer;
    private List<Map<String, String>> leftOptions;
    private List<Map<String, String>> rightOptions;

    private List<Integer> answerList;
    private List<String> optionList;
  }

}

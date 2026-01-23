package com.tickerbell.jujuclub.lesson.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class QstChatMsgDTO {
  private String options;

  @Alias("QstChatMsgRequest")
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public static class QstChatMsgRequest{
    private String lessonId;
    private String questionId;
  }

  @Alias("QstChatMsgJsonDTO")
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public static class QstChatMsgJsonDTO{
    private String text;
    private String sender;
  }

  @Alias("QstSelectJsonDTO")
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public static class QstSelectJsonDTO{
    private String choices;
    private String correct;
  }

}

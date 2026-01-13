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


  @Alias("QstChatMsgJsonDTO")
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public static class QstChatMsgJsonDTO{
    private String text;
    private String sender;
  }

}

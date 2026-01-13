package com.tickerbell.jujuclub.lesson.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import com.tickerbell.jujuclub.lesson.mapper.LessonMapper;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LessonService {

  private final LessonMapper lessonMapper;
  private final ObjectMapper objectMapper = new ObjectMapper();

  /**
   * 레슨 채팅 목록 조회
   */
  public Map<String, List<QstChatMsgDTO.QstChatMsgJsonDTO>> getLessonChat(String lessonId) throws Exception {
    List<QstChatMsgDTO> jsonList = lessonMapper.selectQstChat(lessonId);

    Map<String, List<QstChatMsgDTO.QstChatMsgJsonDTO>> chatMap = new HashMap<>();

    int idx = 1;
    for (QstChatMsgDTO jsonDto : jsonList) {
      List<QstChatMsgDTO.QstChatMsgJsonDTO> messages = objectMapper.readValue(
          jsonDto.getOptions(),
          new TypeReference<List<QstChatMsgDTO.QstChatMsgJsonDTO>>() {}
      );
      chatMap.put("options" + idx, messages);
      idx++;
    }

    return chatMap;
  }


}

package com.tickerbell.jujuclub.lesson.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO.LessonQst;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO.LessonTitle;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import com.tickerbell.jujuclub.lesson.mapper.LessonMapper;
import java.io.IOException;
import java.util.ArrayList;
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
   * 레슨 화면  개념형 문제 채팅 조회
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

  /**
   * 레슨 화면 타이틀 조회
   */
  public List<LessonTitle> getLessonTitle(String lessonId){
    return lessonMapper.selectLssnTitle(lessonId);
  }


  /**
   * 레슨 문항 조회
   */
  public List<LessonDTO.LessonQst> getLssnQst(String lessonId) throws IOException {

    List<LessonQst> lessonQsts = lessonMapper.selectQSt(lessonId);
    List<LessonDTO.LessonQst> result = new ArrayList<>();

    for (LessonQst lessonQst : lessonQsts) {

      // options 파싱
      JsonNode optionsNode = objectMapper.readTree(lessonQst.getOptions());
      JsonNode choicesNode = optionsNode.get("choices");

      List<String> options =
          objectMapper.readValue(
              choicesNode.traverse(),
              new TypeReference<List<String>>() {}
          );

      // answer 파싱
      JsonNode answerNode = objectMapper.readTree(lessonQst.getAnswer());
      JsonNode correctNode = answerNode.get("correct");
      String explanation = answerNode.get("explanation").asText();

      LessonDTO.LessonQst qst = new LessonDTO.LessonQst();
      qst.setQuestionText(lessonQst.getQuestionText());
      qst.setOptionList(options);
      qst.setExplanation(explanation);

      // questionType 분기
      if ("드래그형".equals(lessonQst.getQuestionType())) {

        List<Integer> answerList =
            objectMapper.readValue(
                correctNode.traverse(),
                new TypeReference<List<Integer>>() {}
            );

        qst.setAnswerList(answerList);


      } else {

        // 기존 객관식 로직
        String answer = correctNode.get(0).asText();
        qst.setAnswer(answer);
      }

      result.add(qst);
    }

    return result;

  }



}

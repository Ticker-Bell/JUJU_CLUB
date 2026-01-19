package com.tickerbell.jujuclub.lesson.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO.LessonQst;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO.LessonRequest;
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
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
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
  public List<LessonQst> getLssnQst(String lessonId) throws IOException {

    List<LessonQst> lessonQsts = lessonMapper.selectQSt(lessonId);
    List<LessonQst> result = new ArrayList<>();

    for (LessonQst lessonQst : lessonQsts) {

      LessonQst qst = new LessonQst();
      qst.setQuestionText(lessonQst.getQuestionText());
      qst.setExplanation(LessonJsonParse.parseExplanation(lessonQst.getAnswer()));

      switch (lessonQst.getQuestionType()) {
        case "DRAG":
          qst.setOptionList(LessonJsonParse.parseChoices(lessonQst.getOptions()));
          qst.setAnswerList(LessonJsonParse.parseDragAnswer(lessonQst.getAnswer()));
          break;

        case "LINK":
          Map<String, List<Map<String, String>>> matchOptions = LessonJsonParse.parseMatchOptions(lessonQst.getOptions());
          qst.setLeftOptions(matchOptions.get("left"));
          qst.setRightOptions(matchOptions.get("right"));
          qst.setMatchAnswer(LessonJsonParse.parseMatchAnswer(lessonQst.getAnswer()));
          break;

        default: // 나머지 선택형
          qst.setOptionList(LessonJsonParse.parseChoices(lessonQst.getOptions()));
          qst.setAnswer(LessonJsonParse.parseSingleAnswer(lessonQst.getAnswer()));
      }

      result.add(qst);
    }

    return result;

  }

  /**
   * 레슨 시작 정보 등록
   */
  public void insertLssnInfo(int userSeq,String lessonId) throws IOException {
    LessonDTO.LessonRequest lessonRequest = new LessonRequest();
    lessonRequest.setUserSeq(String.valueOf(userSeq));
    lessonRequest.setLessonId(lessonId);
    lessonMapper.insertLssnInfo(lessonRequest);
  }
}

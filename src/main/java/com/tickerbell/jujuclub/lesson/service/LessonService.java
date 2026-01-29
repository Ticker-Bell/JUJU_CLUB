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
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class LessonService {

  private final LessonMapper lessonMapper;
  private final ObjectMapper objectMapper = new ObjectMapper();

  /**
   * 레슨 CONCEPT형 문제 조회
   *
   * @param qstChatMsgRequest QstChatMsgDTO.QstChatMsgRequest
   * @return Map<String, List < QstChatMsgDTO.QstChatMsgJsonDTO>>
   */
  public Map<String, List<QstChatMsgDTO.QstChatMsgJsonDTO>> getLessonChat(
      QstChatMsgDTO.QstChatMsgRequest qstChatMsgRequest) throws Exception {

    Map<String, List<QstChatMsgDTO.QstChatMsgJsonDTO>> chatMap = new HashMap<>();

    try {
      log.info("[{}] 레슨 CONCEPT형 문제 조회  - 문제 DB 조회 시작 :[{}]",
          qstChatMsgRequest.getLessonId(), qstChatMsgRequest.getQuestionId());

      List<QstChatMsgDTO> jsonList = lessonMapper.selectQstChat(qstChatMsgRequest);

      log.info("[{}] 레슨 CONCEPT형 문제 조회  - 문제 DB 조회 완료 :[{}]",
          qstChatMsgRequest.getLessonId(), qstChatMsgRequest.getQuestionId());

      int idx = 1;

      for (QstChatMsgDTO jsonDto : jsonList) {

        log.info(
            "[{}] 레슨 CONCEPT형 문제 조회 - JSON 파싱 시작 : [{}]",
            qstChatMsgRequest.getLessonId(), idx
        );

        List<QstChatMsgDTO.QstChatMsgJsonDTO> messages = objectMapper.readValue(
            jsonDto.getOptions(),
            new TypeReference<List<QstChatMsgDTO.QstChatMsgJsonDTO>>() {
            }
        );
        log.info(
            "[{}] 레슨 CONCEPT형 문제 조회 - JSON 파싱 종료 : [{}]",
            qstChatMsgRequest.getLessonId(), idx
        );

        chatMap.put("options" + idx, messages);
        idx++;
      }
    } catch (Exception e) {
      log.error("[{}] 레슨 CONCEPT 문항 조회 실패", qstChatMsgRequest.getLessonId());
      throw new RuntimeException(e);
    }
    return chatMap;
  }

  /**
   * 레슨 화면 타이틀 조회
   *
   * @param lessonId String
   * @return List<LessonTitle>
   */
  public List<LessonTitle> getLessonTitle(String lessonId) {
    try {
      log.info("[{}] 레슨 CONCEPT형 문제 조회 - 레슨 타이틀 DB 조회 시작", lessonId);

      List<LessonTitle> titles = lessonMapper.selectLssnTitle(lessonId);

      log.info("[{}] 레슨 CONCEPT형 문제 조회 - 레슨 타이틀 DB 조회 종료", lessonId);

      if (titles.isEmpty()) {
        log.info("[{}] 레슨 타이틀 없음", lessonId);
      }

      return titles;

    } catch (Exception e) {
      log.error("[{}] 레슨 타이틀 조회 실패", lessonId, e);
      throw new RuntimeException(e);
    }
  }


  /**
   * 레슨 문항 조회
   *
   * @param lessonId String
   * @return List<LessonQst>
   */
  public List<LessonQst> getLssnQst(String lessonId) throws IOException {

    List<LessonQst> result = new ArrayList<>();

    log.info("[{}] 레슨 레슨 문항 조회 - 문항 DB 조회 시작", lessonId);

    List<LessonQst> lessonQsts = lessonMapper.selectQSt(lessonId);

    log.info("[{}] 레슨 레슨 문항 조회 - 문항 DB 조회 종료", lessonId);

    for (LessonQst lessonQst : lessonQsts) {

      try {

        log.info("[{}] 문항 파싱 시작 - type={}", lessonId, lessonQst.getQuestionType());

        LessonQst qst = new LessonQst();
        qst.setQuestionText(lessonQst.getQuestionText());
        qst.setExplanation(LessonJsonParse.parseExplanation(lessonQst.getAnswer()));

        switch (lessonQst.getQuestionType()) {
          case "DRAG":
            qst.setOptionList(LessonJsonParse.parseChoices(lessonQst.getOptions()));
            qst.setAnswerList(LessonJsonParse.parseDragAnswer(lessonQst.getAnswer()));
            break;

          case "LINK":
            Map<String, List<Map<String, String>>> matchOptions = LessonJsonParse.parseMatchOptions(
                lessonQst.getOptions());
            qst.setLeftOptions(matchOptions.get("left"));
            qst.setRightOptions(matchOptions.get("right"));
            qst.setMatchAnswer(LessonJsonParse.parseMatchAnswer(lessonQst.getAnswer()));
            break;

          default: // 나머지 선택형
            qst.setOptionList(LessonJsonParse.parseChoices(lessonQst.getOptions()));
            qst.setAnswer(LessonJsonParse.parseSingleAnswer(lessonQst.getAnswer()));
        }

        log.info("[{}] 문항 파싱 종료 - type={}", lessonId, lessonQst.getQuestionType());

        result.add(qst);

      }catch (Exception e) {
        log.error("[{}] 레슨 레슨 문항 조회 실패 [{}]", lessonId,lessonQst.getQuestionType());
      }
    }
      return result;
  }

    /**
     * 레슨 시작 정보 등록
     *
     * @param userSeq int, lessonId String
     */
    public void insertLssnInfo ( int userSeq, String lessonId) throws IOException {

      try {

        LessonDTO.LessonRequest lessonRequest = new LessonRequest();

        lessonRequest.setUserSeq(userSeq);
        lessonRequest.setLessonId(lessonId);

        log.info("[{}] 레슨 시작 정보 등록 - 유저 레슨 결과 DB 조회 시작[{}]", lessonRequest.getLessonId(),
            lessonRequest.getUserSeq());

        int usrLssnRslt = lessonMapper.countUsrLssnRslt(lessonRequest);

        log.info("[{}] 레슨 시작 정보 등록 - 유저 레슨 결과 DB 조회 종료[{}]", lessonRequest.getLessonId(),
            lessonRequest.getUserSeq());

        //진행 중인 레슨 존재 여부 확인
        if (usrLssnRslt == 0) {

          log.info("[{}] 레슨 정보 신규 등록 시작 - userSeq={}", lessonRequest.getLessonId(),
              lessonRequest.getUserSeq());

          lessonMapper.insertLssnInfo(lessonRequest);

          log.info("[{}] 레슨 정보 신규 등록 종료 - userSeq={}", lessonRequest.getLessonId(),
              lessonRequest.getUserSeq());
        } else {
          log.info("[{}] 레슨 정보 이미 존재 - userSeq={}", lessonRequest.getLessonId(),
              lessonRequest.getUserSeq());
        }

      } catch (Exception e) {
        log.error("[{}] 레슨 시작 정보 등록 실패 - [{}]]", lessonId, userSeq);
        throw new RuntimeException(e);
      }
    }

    /**
     * 레슨 완료 정보 등록
     *
     * @param userSeq int, lessonId String
     */
    public void updateLssnInfo ( int userSeq, String lessonId) throws IOException {
      try {

        LessonDTO.LessonRequest lessonRequest = new LessonRequest();

        lessonRequest.setUserSeq(userSeq);
        lessonRequest.setLessonId(lessonId);

        log.info("[{}] 레슨 완료 정보 등록 - 완료 정보 DB 조회 시작 - [{}]]", lessonId, userSeq);

        lessonMapper.updateLssnInfo(lessonRequest);

        log.info("[{}] 레슨 완료 정보 등록 - 완료 정보 DB 조회 종료 - [{}]]", lessonId, userSeq);
      } catch (Exception e) {
        log.error("[{}] 레슨 완료 정보 등록 실패 - [{}]]", lessonId, userSeq);
        throw new RuntimeException(e);
      }
    }

    /**
     * 챕터테스트 문항 조회
     *
     * @param lessonRequest LessonDTO.LessonRequest
     * @return List<LessonQst>
     */
    public List<LessonQst> getChapterTest (LessonDTO.LessonRequest lessonRequest) throws IOException {

      List<LessonQst> result = new ArrayList<>();

      log.info("[{}] 챕터 테스트 문항 조회 - 챕터 테스트 문항 DB 조회 시작 - [{}]]", lessonRequest.getLessonId(),
          lessonRequest.getUserSeq());

      List<LessonQst> chapterQsts = lessonMapper.getChapterTestQst(lessonRequest);

      log.info("[{}] 레슨 완료 정보 등록 - 챕터 테스트 문항 DB 조회 종료 - [{}]]", lessonRequest.getLessonId(),
          lessonRequest.getUserSeq());


      for (LessonQst chapterQst : chapterQsts) {

        try {

          log.info("[{}] 챕터 테스트 문항 파싱 시작 - type={}", lessonRequest.getLessonId(),chapterQst.getQuestionType());

          LessonQst qst = new LessonQst();
          qst.setQuestionType(chapterQst.getQuestionType());
          qst.setQuestionText(chapterQst.getQuestionText());
          qst.setExplanation(LessonJsonParse.parseExplanation(chapterQst.getAnswer()));

          switch (chapterQst.getQuestionType()) {
            case "DRAG":
              qst.setOptionList(LessonJsonParse.parseChoices(chapterQst.getOptions()));
              qst.setAnswerList(LessonJsonParse.parseDragAnswer(chapterQst.getAnswer()));
              break;

            case "LINK":
              Map<String, List<Map<String, String>>> matchOptions = LessonJsonParse.parseMatchOptions(
                  chapterQst.getOptions());
              qst.setLeftOptions(matchOptions.get("left"));
              qst.setRightOptions(matchOptions.get("right"));
              qst.setMatchAnswer(LessonJsonParse.parseMatchAnswer(chapterQst.getAnswer()));
              break;

            default: // 나머지 선택형
              qst.setOptionList(LessonJsonParse.parseChoices(chapterQst.getOptions()));
              qst.setAnswer(LessonJsonParse.parseSingleAnswer(chapterQst.getAnswer()));
          }

          log.info("[{}] 챕터 테스트 문항 파싱 종료 - type={}", lessonRequest.getLessonId(),chapterQst.getQuestionType());

          result.add(qst);

        }catch (Exception e) {
          log.error("[{}] 챕터 테스트 문항 조회 실패 [{}]", lessonRequest.getLessonId(),chapterQst.getQuestionType());
        }
      }
      return result;
    }

    /**
     * 챕터테스트 시작 정보 등록
     *
     * @param userSeq int, chapterId String
     */
    public void insertChapterRslt ( int userSeq, String chapterId){

      LessonDTO.LessonRequest lessonRequest = new LessonRequest();

      try {

        lessonRequest.setUserSeq(userSeq);
        lessonRequest.setChapterId(chapterId);

        log.info("[{}] 챕터 테스트 시작 정보 등록 - 유저 챕터 테스트 결과 DB 조회 시작[{}]", lessonRequest.getUserSeq(),
            lessonRequest.getChapterId());

        int countResult = lessonMapper.countUserChapterRslt(lessonRequest);

        log.info("[{}] 챕터 테스트 시작 정보 등록 - 유저 챕터 테스트 결과 DB 조회 종료[{}]", lessonRequest.getUserSeq(),
            lessonRequest.getChapterId());
        // 챕터 결과 테이블에 존재하는지 체크
        if (countResult == 0) {

          log.info("[{}] 챕터 테스트 정보 신규 등록 시작 - userSeq={}", lessonRequest.getUserSeq(),
              lessonRequest.getChapterId());

          lessonMapper.insertChapterRslt(lessonRequest);

          log.info("[{}] 챕터 테스트 정보 신규 등록 종료 - userSeq={}", lessonRequest.getUserSeq(),
              lessonRequest.getChapterId());
        }
        // 챕터 테스트시 소모비용
        log.info("[{}] 챕터 테스트 정보 업뎃 시작 - userSeq={}", lessonRequest.getUserSeq(),
            lessonRequest.getChapterId());

        lessonMapper.updateChapterPay(lessonRequest);

        log.info("[{}] 챕터 테스트 정보 업뎃 등록 종료 - userSeq={}", lessonRequest.getUserSeq(),
            lessonRequest.getChapterId());
      } catch (Exception e) {
        log.error("[{}] 챕터 테스트 시작 정보 등록 실패 - [{}]]", lessonRequest.getUserSeq(),
            lessonRequest.getChapterId());
        throw new RuntimeException(e);
      }
    }

    /**
     * 챕터테스트 테스트 결과 업데이트
     *
     * @param lessonRequest LessonDTO.LessonRequest
     */
    public void updateChapterInfo (LessonDTO.LessonRequest lessonRequest){
      //유저 테스트 결과 저장
      try {

        log.info("[{}] 챕터 테스트 결과 업데이트 시작 - [chapterId={}]", lessonRequest.getUserSeq(),
            lessonRequest.getChapterId());
        // 유저 테스트 결과 저장
        lessonMapper.updateChapterRslt(lessonRequest);

        log.info("[{}] 챕터 테스트 결과 업데이트 종료 - [chapterId={}]", lessonRequest.getUserSeq(),
            lessonRequest.getChapterId());
        // 테스트 통과 시 보상 저장
        if ("Y".equals(lessonRequest.getIsPass())) {

          log.info("[{}] 챕터 테스트 보상 업데이트 시작 - [chapterId={}]", lessonRequest.getUserSeq(),
              lessonRequest.getChapterId());

          lessonMapper.updateChapterRwd(lessonRequest);

          log.info("[{}] 챕터 테스트 보상 업데이트 종료 - [chapterId={}]", lessonRequest.getUserSeq(),
              lessonRequest.getChapterId());
        }

      } catch (Exception e) {
        log.error("[{}] 챕터 테스트 결과 업데이트 실패 - [chapterId={}]", lessonRequest.getUserSeq(),
            lessonRequest.getChapterId());
        throw new RuntimeException(e);
      }
    }
  }

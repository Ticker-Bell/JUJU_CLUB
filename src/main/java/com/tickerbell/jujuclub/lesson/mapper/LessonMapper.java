package com.tickerbell.jujuclub.lesson.mapper;

import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO.LessonRequest;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LessonMapper {

  /**
   * 개념형 문제 조회
   *
   * @param qstChatMsgRequest QstChatMsgDTO.QstChatMsgRequest
   * @return List<QstChatMsgDTO>
   */
  List<QstChatMsgDTO> selectQstChat(QstChatMsgDTO.QstChatMsgRequest qstChatMsgRequest);
  /**
   * 레슨 타이틀 조회
   *
   * @param lessonId String
   * @return List<LessonDTO.LessonTitle>
   */
  List<LessonDTO.LessonTitle> selectLssnTitle(String lessonId);

  /**
   * 레슨 문항 조회
   *
   * @param lessonId String
   * @return List<LessonDTO.LessonQst>
   */
  List<LessonDTO.LessonQst> selectQSt(String lessonId);

  /**
   * 레슨 시작 정보 등록
   *
   * @param lessonRequest LessonDTO.LessonRequest
   * @return int
   */
  int insertLssnInfo(LessonDTO.LessonRequest lessonRequest);
  /**
   * 레슨 완료 정보 등록
   *
   * @param lessonRequest LessonRequest
   * @return int
   */
  int updateLssnInfo(LessonRequest lessonRequest);
  /**
   * 유저 레슨 총 완료 개수
   *
   * @param lessonRequest LessonRequest
   * @return int
   */
  int countUsrLssnRslt(LessonRequest lessonRequest);
  /**
   * 유저 레슨 결과 조회
   *
   * @param lessonRequest LessonRequest
   * @return List<LessonDTO.LessonResponse>
   */
  List<LessonDTO.LessonResponse> selectUsrLssnRslt(LessonRequest lessonRequest);
  /**
   * 챕터 테스트 문항 조회
   *
   * @param lessonRequest LessonDTO.LessonRequest
   * @return List<LessonDTO.LessonQst>
   */
  List<LessonDTO.LessonQst> getChapterTestQst(LessonDTO.LessonRequest lessonRequest);
  /**
   * 챕터 테스트 시작 정보 등록
   *
   * @param lessonRequest LessonDTO.LessonRequest
   * @return int
   */
  int insertChapterRslt(LessonDTO.LessonRequest lessonRequest);
  /**
   * 유저 챕터 테스트 결과 조회
   *
   * @param lessonRequest LessonDTO.LessonRequest
   * @return int
   */
  int countUserChapterRslt(LessonRequest lessonRequest);
  /**
   * 챕터 테스트 완료 정보 등록
   *
   * @param lessonRequest LessonDTO.LessonRequest
   * @return int
   */
  int updateChapterRslt(LessonRequest lessonRequest);
  /**
   * 챕터 테스트 보상 정보 등록
   *
   * @param lessonRequest LessonDTO.LessonRequest
   * @return int
   */
  int updateChapterRwd(LessonRequest lessonRequest);
  /**
   * 챕터 테스트 소모 정보 등록
   *
   * @param lessonRequest LessonDTO.LessonRequest
   * @return int
   */
  int updateChapterPay(LessonRequest lessonRequest);
}

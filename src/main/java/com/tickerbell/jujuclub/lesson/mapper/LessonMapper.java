package com.tickerbell.jujuclub.lesson.mapper;

import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO.LessonRequest;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LessonMapper {

  List<QstChatMsgDTO> selectQstChat(QstChatMsgDTO.QstChatMsgRequest qstChatMsgRequest);
  List<LessonDTO.LessonTitle> selectLssnTitle(String lessonId);

  List<LessonDTO.LessonQst> selectQSt(String lessonId);

  int insertLssnInfo(LessonDTO.LessonRequest lessonRequest);

  int updateLssnInfo(LessonRequest lessonRequest);

  int countUsrLssnRslt(LessonRequest lessonRequest);

  List<LessonDTO.LessonResponse> selectUsrLssnRslt(LessonRequest lessonRequest);

  List<LessonDTO.LessonQst> getChapterTestQst(LessonDTO.LessonRequest lessonRequest);

  int insertChapterRslt(LessonDTO.LessonRequest lessonRequest);

  int countUserChapterRslt(LessonRequest lessonRequest);
  int updateChapterRslt(LessonRequest lessonRequest);
}

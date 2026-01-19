package com.tickerbell.jujuclub.lesson.mapper;

import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LessonMapper {

  List<QstChatMsgDTO> selectQstChat(String lessonId);
  List<LessonDTO.LessonTitle> selectLssnTitle(String lessonId);

  List<LessonDTO.LessonQst> selectQSt(String lessonId);

  int insertLssnInfo(LessonDTO.LessonRequest lessonRequest);
}

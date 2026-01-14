package com.tickerbell.jujuclub.lesson.controller;

import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import com.tickerbell.jujuclub.lesson.service.LessonService;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/lesson")
@Controller
@RequiredArgsConstructor
public class LessonController {

  private final LessonService lessonService;

  @GetMapping("/lessonInfo")
  public String lessonInfo(@RequestParam String lessonId, Model model) throws Exception {
    Map<String, List<QstChatMsgDTO.QstChatMsgJsonDTO>> chatMap = lessonService.getLessonChat(lessonId);
    LessonDTO.LessonTitle title = lessonService.getLessonTitle(lessonId);

    model.addAttribute("chat", chatMap);
    model.addAttribute("colNames", chatMap.keySet());
    model.addAttribute("titles",title);


    return "/lesson/lessonMain";
  }


}

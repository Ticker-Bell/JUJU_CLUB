package com.tickerbell.jujuclub.lesson.controller;

import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import com.tickerbell.jujuclub.lesson.service.LessonService;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/lesson")
@Controller
@RequiredArgsConstructor
public class LessonController {

  private final LessonService lessonService;

  @PostMapping("/lessonInfo")
  public String getLessonInfo(
      @RequestHeader(value = "HX-Request", defaultValue = "false") boolean isHtmx,
      @RequestParam String lessonId,
      Model model) throws Exception {

    Map<String, List<QstChatMsgDTO.QstChatMsgJsonDTO>> chatMap = lessonService.getLessonChat(lessonId);

    List<LessonDTO.LessonTitle> title = lessonService.getLessonTitle(lessonId);

    List<LessonDTO.LessonQst> lessonQst = lessonService.getLssnQst(lessonId);

    model.addAttribute("chat", chatMap);
    model.addAttribute("colNames", chatMap.keySet());
    model.addAttribute("titles", title);
    model.addAttribute("qst", lessonQst);

    if (isHtmx) {
      return "/lesson/lessonInfo";
    } else {
      // 주소창에 직접 쳐서 들어오는 경우(GET)를 대비
      // Redirect를 하거나 에러 페이지를 띄움
      return "redirect:/main";
    }

  }
}

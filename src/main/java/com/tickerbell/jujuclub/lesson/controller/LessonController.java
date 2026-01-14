package com.tickerbell.jujuclub.lesson.controller;

import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import com.tickerbell.jujuclub.lesson.service.LessonService;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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

    @PostMapping("/lessonInfo")
    public String test(Model model,
                       @RequestHeader(value="HX-Request", defaultValue="false") boolean isHtmx,
                       @RequestParam("lessonId") String lessonId,   // 보낸 데이터 받기
                       @RequestParam("category") String category) {

        model.addAttribute("lessonId", lessonId);
        model.addAttribute("category", category);

        // 응답 처리 (HTMX 패턴 유지)
        if (isHtmx) {
            // test.jsp 내 <div> 태그 내용 반환
            return "lesson/test";
        } else {
            // 주소창에 직접 쳐서 들어오는 경우(GET)를 대비
            // Redirect를 하거나 에러 페이지를 띄움
            return "redirect:/main";
        }

    }

}

package com.tickerbell.jujuclub.lesson.controller;

import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO.LessonRequest;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import com.tickerbell.jujuclub.lesson.service.LessonService;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@RequestMapping("/lesson")
@Controller
@RequiredArgsConstructor
public class LessonController {

  private final LessonService lessonService;

  @PostMapping("/lessonInfo")
  public String getLessonInfo(
      @RequestHeader(value = "HX-Request", defaultValue = "false") boolean isHtmx,
      @RequestParam String lessonId,
      HttpSession session,
      Model model) throws Exception {
// 세션 연결예쩡
    int userSeq = (int) session.getAttribute("userSeq");

//    if (userSeq == null) {
//      // 로그인 안된 상태면 처리
//      return "redirect:/login";
//    }

    // 레슨 시작 정보 등록
    if(! lessonId.equals("LV1_CH001_LSN006")){

      lessonService.insertLssnInfo(userSeq,lessonId);
    }

    Map<String, List<QstChatMsgDTO.QstChatMsgJsonDTO>> chatMap = lessonService.getLessonChat(lessonId);

    List<LessonDTO.LessonTitle> title = lessonService.getLessonTitle(lessonId);

    List<LessonDTO.LessonQst> lessonQst = lessonService.getLssnQst(lessonId);

    model.addAttribute("chat", chatMap);
    model.addAttribute("colNames", chatMap.keySet());
    model.addAttribute("titles", title);
    model.addAttribute("qst", lessonQst);
    model.addAttribute("userSeq",userSeq);

    if (isHtmx) {
      return "lesson/lessonInfo";
    } else {
      // 주소창에 직접 쳐서 들어오는 경우(GET)를 대비
      // Redirect를 하거나 에러 페이지를 띄움
      return "redirect:/main";
    }

  }

  @PostMapping("/qst")
  public String getQstInfo(
      @RequestHeader(value = "HX-Request", defaultValue = "false") boolean isHtmx,
      @RequestParam String lessonId,
      @RequestParam String questionId,
      HttpSession session,
      Model model) throws Exception {

    int userSeq = (int) session.getAttribute("userSeq");

    Map<String, List<QstChatMsgDTO.QstChatMsgJsonDTO>> chatMap = lessonService.getLessonChat(lessonId);

    List<LessonDTO.LessonTitle> title = lessonService.getLessonTitle(lessonId);

    List<LessonDTO.LessonQst> lessonQst = lessonService.getLssnQst(lessonId);

    model.addAttribute("lessonId",lessonId);
    model.addAttribute("userSeq",userSeq);
    model.addAttribute("chat", chatMap);
    model.addAttribute("colNames", chatMap.keySet());
    model.addAttribute("titles", title);
    model.addAttribute("qst", lessonQst);

    if (!isHtmx) {
      // 주소창 직접 접근 방지
      return "redirect:/main";
    }

    switch (questionId) {
      case "LV1_CH001_LS001_Q002":
        return "/lesson/qst2";
      case "LV1_CH001_LS001_Q003":
        return "/lesson/qst3";
      case "LV1_CH001_LS001_Q004":
        return "/lesson/qst4";
      case "LV1_CH001_LS001_Q005":
        return "/lesson/qst5";
      default:
        // 잘못된 questionId
        return "/lesson/error";
    }

  }

  @PostMapping("/updateLssnInfo")
  public String getLessonInfo(
      @RequestHeader(value = "HX-Request", defaultValue = "false") boolean isHtmx,
      @RequestParam String lessonId,
      HttpSession session) throws Exception {

    int userSeq = (int) session.getAttribute("userSeq");

    lessonService.updateLssnInfo(userSeq,lessonId);


    if (isHtmx) {
      return "redirect:/roadMap/main.do";
    } else {
      // 주소창에 직접 쳐서 들어오는 경우(GET)를 대비
      // Redirect를 하거나 에러 페이지를 띄움
      return "redirect:/main";
    }

  }

  @PostMapping("/chapter-test")
  public String getChapterTest(
      @RequestHeader(value = "HX-Request", defaultValue = "false") boolean isHtmx,
      @RequestParam String chapterId,
      @RequestParam String lessonId,
      HttpSession session,
      Model model) throws Exception {

    int userSeq = (int) session.getAttribute("userSeq");

    LessonDTO.LessonRequest lessonRequest = new LessonRequest();
    lessonRequest.setChapterId(chapterId);
    lessonRequest.setLessonId(lessonId);

    lessonService.insertChapterRslt(userSeq,chapterId);

    List<LessonDTO.LessonQst> chapterQst = lessonService.getChapterTest(lessonRequest);


    model.addAttribute("qst", chapterQst);
    model.addAttribute("userSeq",userSeq);
    //챕터 update시 필요한 chapterId값, html body dom에 저장해둠
    model.addAttribute("chapterId",chapterId);

    if (isHtmx) {
      return "lesson/chapterTest";
    } else {
      // 주소창에 직접 쳐서 들어오는 경우(GET)를 대비
      // Redirect를 하거나 에러 페이지를 띄움
      return "redirect:/main";
    }

  }

  @PostMapping("/update-chapter")
  public void updateChapterRslt(
      @RequestHeader(value = "HX-Request", defaultValue = "false") boolean isHtmx,
      @RequestParam String chapterId,
      @RequestParam int score,
      @RequestParam String isPass,
      HttpSession session,
      Model model) throws Exception {

    int userSeq = (int) session.getAttribute("userSeq");

    LessonDTO.LessonRequest lessonRequest = new LessonRequest();

    lessonRequest.setUserSeq(userSeq);
    lessonRequest.setChapterId(chapterId);
    lessonRequest.setScore(score);
    lessonRequest.setIsPass(isPass);

    lessonService.updateChapterInfo(lessonRequest);

    model.addAttribute("userSeq",userSeq);

  }
}

package com.tickerbell.jujuclub.lesson.controller;

import com.tickerbell.jujuclub.lesson.dto.LessonDTO;
import com.tickerbell.jujuclub.lesson.dto.LessonDTO.LessonRequest;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO;
import com.tickerbell.jujuclub.lesson.dto.QstChatMsgDTO.QstChatMsgRequest;
import com.tickerbell.jujuclub.lesson.service.LessonService;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/lesson")
@Controller
@RequiredArgsConstructor
public class LessonController {

  private final LessonService lessonService;


  /**
   * 레슨 CONCEPT 문항 조회 및 레슨 시작 정보 등록
   *
   * @param lessonId String
   * @return lesson/lessonInfo
   */
  @PostMapping("/lessonInfo")
  public String getLessonInfo(
      @RequestParam String lessonId,
      HttpSession session,
      Model model) throws Exception {

    int userSeq = (int) session.getAttribute("userSeq");
    String questionId = lessonId + "_Q001";

    // 레슨 시작 정보 등록
    if(! lessonId.equals("LV1_CH001_LS006")){

      lessonService.insertLssnInfo(userSeq,lessonId);
    }

    QstChatMsgDTO.QstChatMsgRequest qstChatMsgRequest = new QstChatMsgRequest();
    qstChatMsgRequest.setLessonId(lessonId);
    qstChatMsgRequest.setQuestionId(questionId);

    Map<String, List<QstChatMsgDTO.QstChatMsgJsonDTO>> chatMap = lessonService.getLessonChat(qstChatMsgRequest);

    List<LessonDTO.LessonTitle> title = lessonService.getLessonTitle(lessonId);

    List<LessonDTO.LessonQst> lessonQst = lessonService.getLssnQst(lessonId);

    model.addAttribute("lessonId",lessonId);
    model.addAttribute("chat", chatMap);
    model.addAttribute("colNames", chatMap.keySet());
    model.addAttribute("titles", title);
    model.addAttribute("qst", lessonQst);
    model.addAttribute("userSeq",userSeq);

    return "lesson/lessonInfo";
  }



  /**
   * 레슨 SELECT,MATCH,DRAG,LINK 문항 조회
   *
   * @param lessonId String, questionId String
   * @return /lesson/qst2,/lesson/qst3,/lesson/qst4,/lesson/qst5,/lesson/error
   */
  @PostMapping("/qst")
  public String getQstInfo(
      @RequestParam String lessonId,
      @RequestParam String questionId,
      HttpSession session,
      Model model) throws Exception {

    int userSeq = (int) session.getAttribute("userSeq");


    List<LessonDTO.LessonTitle> title = lessonService.getLessonTitle(lessonId);
    List<LessonDTO.LessonQst> lessonQst = lessonService.getLssnQst(lessonId);

    model.addAttribute("lessonId",lessonId);
    model.addAttribute("userSeq",userSeq);
    model.addAttribute("titles", title);
    model.addAttribute("qst", lessonQst);


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



  /**
   * 레슨 완료 정보 등록
   *
   * @param lessonId String
   * @return redirect:/roadMap/main.do
   */
  @PostMapping("/updateLssnInfo")
  public String getLessonInfo(
      @RequestParam String lessonId,
      HttpSession session) throws Exception {

    int userSeq = (int) session.getAttribute("userSeq");

    lessonService.updateLssnInfo(userSeq,lessonId);

    return "redirect:/roadMap/main.do";
  }




  /**
   * 챕터 테스트 시작 정보 등록
   *
   * @param lessonId String
   * @return lesson/chapterTest
   */
  @PostMapping("/chapter-test")
  public String getChapterTest(
      @RequestParam String chapterId,
      @RequestParam String lessonId,
      HttpSession session,
      Model model) throws Exception {

    int userSeq = (int) session.getAttribute("userSeq");

    LessonDTO.LessonRequest lessonRequest = new LessonRequest();
    lessonRequest.setUserSeq(userSeq);
    lessonRequest.setChapterId(chapterId);
    lessonRequest.setLessonId(lessonId);

    lessonService.insertChapterRslt(userSeq,chapterId);

    List<LessonDTO.LessonTitle> title = lessonService.getLessonTitle(lessonId);
    List<LessonDTO.LessonQst> chapterQst = lessonService.getChapterTest(lessonRequest);


    model.addAttribute("title",title);
    model.addAttribute("qst", chapterQst);
    model.addAttribute("userSeq",userSeq);
    //챕터 update시 필요한 chapterId값, html body dom에 저장해둠
    model.addAttribute("chapterId",chapterId);


    return "lesson/chapterTest";
  }




  /**
   * 챕터 테스트 완료 정보 등록
   *
   * @param chapterId String, score Int, isPass, session, model
   *
   */
  @PostMapping("/update-chapter")
  public void updateChapterRslt(
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

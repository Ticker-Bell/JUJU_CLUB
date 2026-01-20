package com.tickerbell.jujuclub.ranking.controller;

import com.tickerbell.jujuclub.ranking.dto.RankingDTO;
import com.tickerbell.jujuclub.ranking.service.RankingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/ranking")
@RequiredArgsConstructor
public class RankingController {

  private final RankingService rankingService;
  @GetMapping("/main.do")
  public String ranking(
      @RequestParam Integer userSeq
      ,Model model) {

//    Integer userSeq = (Integer) session.getAttribute("userSeq");
       userSeq = 1;

//    if (userSeq == null) {
//      // 로그인 안 된 경우 처리
//      return "redirect:/login.do";
//    }

    RankingDTO.RankingResponse response =rankingService.getRankingInfo(userSeq);

    model.addAttribute("rankingInfo",response);

    return "ranking/rankingMain";
  }

}

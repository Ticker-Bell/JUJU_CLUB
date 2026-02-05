package com.tickerbell.jujuclub.ranking.controller;

import com.tickerbell.jujuclub.ranking.dto.RankingDTO;
import com.tickerbell.jujuclub.ranking.service.RankingService;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ranking")
@RequiredArgsConstructor
public class RankingController {

  private final RankingService rankingService;

  /**
   * 랭킹 리스트 조회
   *
   * @return ranking/rankingMain
   */
  @GetMapping("/main.do")
  public String ranking(
       HttpSession session
      ,Model model) {

    Integer userSeq = (Integer) session.getAttribute("userSeq");

    RankingDTO.RankingResponse response =rankingService.getRankingInfo(userSeq);

    model.addAttribute("rankingInfo",response);

    return "ranking/rankingMain";
  }

}

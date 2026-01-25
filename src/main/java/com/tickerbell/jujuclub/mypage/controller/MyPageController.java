package com.tickerbell.jujuclub.mypage.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.auth.dto.AccountDTO;
import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.service.AccountService;
import com.tickerbell.jujuclub.invest.dto.PortfolioAllocationItemDTO;
import com.tickerbell.jujuclub.invest.dto.UserInvestSummeryDTO;
import com.tickerbell.jujuclub.invest.service.PortfolioService;
import com.tickerbell.jujuclub.invest.service.UserAssetService;
import com.tickerbell.jujuclub.invest.util.ColorUtil;
import com.tickerbell.jujuclub.roadMap.dto.MissionDTO;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/myPage")
public class MyPageController {

    private final RoadMapService roadMapService;
    private final PortfolioService portfolioService;
    private final UserAssetService userAssetService;
    private final AccountService accountService;

    @GetMapping("/main.do")
    public String myPage(HttpSession session, Model model) {

        // 1. 유저 정보 확인
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        Integer userSeq = (Integer) session.getAttribute("userSeq");

        if (userSeq == null) {
            //userSeq = 2; // 테스트용 계정
            session.setAttribute("userSeq", userSeq);
            if (loginUser == null) {
                loginUser = new MemberDTO();
                loginUser.setUserName("테스트유저(2번)");
                loginUser.setUserId("testUser1");
                session.setAttribute("loginUser", loginUser);
            }
        }

        // ---------------------------------------------------------
        // [1] 차트 데이터 조회 (보유 주식)
        // ---------------------------------------------------------
        try {
            List<PortfolioAllocationItemDTO> holdings = portfolioService.getPortfolioAllocationItems(userSeq);
            List<Map<String, Object>> chartData = new ArrayList<>();

            if (holdings != null) {
                for (PortfolioAllocationItemDTO item : holdings) {
                    if (item.getWeightPct() > 0) {
                        Map<String, Object> data = new HashMap<>();
                        data.put("stockName", item.getStockName());
                        data.put("weightPct", item.getWeightPct());
                        data.put("color", ColorUtil.colorByStockCode(item.getStockCode()));
                        chartData.add(data);
                    }
                }
            }
            // JSON 문자열로 변환하여 전달 (JSP 스크립트에서 사용)
            model.addAttribute("chartDataJson", new ObjectMapper().writeValueAsString(chartData));
        } catch (Exception e) {
            log.error("차트 데이터 조회 실패", e);
            model.addAttribute("chartDataJson", "[]");
        }

        // ---------------------------------------------------------
        // [2] 자산 정보 조회 (총 자산, 예수금)
        // ---------------------------------------------------------
        try {
            UserInvestSummeryDTO userAsset = userAssetService.getUserInvestSummary(userSeq);
            if(userAsset == null) userAsset = new UserInvestSummeryDTO();

            AccountDTO myAccount = accountService.getMyAccount(userSeq);
            long cash = (myAccount != null) ? myAccount.getCashBalance() : 0L;

            userAsset.setCashBalance(cash);
            userAsset.setTotalAsset(userAsset.getTotalStockValue() + cash);

            model.addAttribute("userAsset", userAsset);
        } catch (Exception e) {
            log.error("자산 정보 조회 실패", e);
            model.addAttribute("userAsset", new UserInvestSummeryDTO());
        }

        // ---------------------------------------------------------
        // [3] 미션 정보 조회 (일일 미션)
        // ---------------------------------------------------------
        try {
            List<MissionDTO> missionList = roadMapService.missionList(userSeq);
            int successCount = (int) missionList.stream()
                    .filter(m -> m.getCount() <= m.getProgress())
                    .count();

            model.addAttribute("missionList", missionList);
            model.addAttribute("missionSuccessCount", successCount);
        } catch (Exception e) {
            log.error("미션 정보 조회 실패", e);
            model.addAttribute("missionList", new ArrayList<>());
            model.addAttribute("missionSuccessCount", 0);
        }

        return "myPage/myPageMain";
    }
}
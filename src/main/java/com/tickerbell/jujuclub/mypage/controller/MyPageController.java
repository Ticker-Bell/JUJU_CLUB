package com.tickerbell.jujuclub.mypage.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.auth.dto.AccountDTO;
import com.tickerbell.jujuclub.auth.service.AccountService;
import com.tickerbell.jujuclub.invest.dto.PortfolioDTO;
import com.tickerbell.jujuclub.invest.dto.UserInvestSummeryDTO;
import com.tickerbell.jujuclub.invest.service.PortfolioService;
import com.tickerbell.jujuclub.invest.service.UserAssetService;
import com.tickerbell.jujuclub.utils.ColorUtil;
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
@RequestMapping("/myPage") // 다시 /myPage로 원복
public class MyPageController {

    private final RoadMapService roadMapService;
    private final PortfolioService portfolioService;
    private final UserAssetService userAssetService;
    private final AccountService accountService;

    /**
     * [1] 마이페이지 메인 화면 반환 (데이터 로딩 없이 껍데기만)
     * URL: /myPage/main.do
     */
    @GetMapping("/main.do")
    public String myPage(Model model, HttpSession session) {

        Integer userSeq = (Integer) session.getAttribute("userSeq");
        AccountDTO accountDTO = accountService.getMyAccount(userSeq);

        Long cashBalance = accountDTO.getCashBalance();

        model.addAttribute("userCashBalance",cashBalance);

        return "myPage/myPageMain";
    }

    /**
     * [2] 자산 정보 및 차트 데이터 조회 (비동기)
     * URL: /myPage/asset
     */
    @GetMapping("/asset")
    public String getUserAsset(HttpSession session, Model model) {
        Integer userSeq = (Integer) session.getAttribute("userSeq");

        // --- 차트 데이터 로직 ---
        try {
            List<PortfolioDTO> holdings = portfolioService.getPortfolioAllocationItems(userSeq);
            List<Map<String, Object>> chartData = new ArrayList<>();
            if (holdings != null) {
                for (PortfolioDTO item : holdings) {
                    if (item.getWeightPct() > 0) {
                        Map<String, Object> data = new HashMap<>();
                        data.put("stockName", item.getStockName());
                        data.put("weightPct", item.getWeightPct());
                        data.put("color", ColorUtil.colorByStockCode(item.getStockCode()));
                        chartData.add(data);
                    }
                }
            }
            model.addAttribute("chartDataJson", new ObjectMapper().writeValueAsString(chartData));
        } catch (Exception e) {
            log.error("차트 데이터 조회 실패", e);
            model.addAttribute("chartDataJson", "[]");
        }

        // --- 자산 정보 로직 ---
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

        return "myPage/myPageAsset";
    }

    /**
     * [3] 미션 정보 조회 (비동기)
     * URL: /myPage/mission
     */
    @GetMapping("/mission")
    public String getUserMission(HttpSession session, Model model) {
        Integer userSeq = (Integer) session.getAttribute("userSeq");

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

        return "myPage/missionSection";
    }
}
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
public class MyPageChartController {

    private final PortfolioService portfolioService;
    private final UserAssetService userAssetService;
    private final AccountService accountService;

    @GetMapping("/main")
    public String stockMyPage(HttpSession session, Model model) {

        // 1. 로그인 유저 정보 및 userSeq 가져오기
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        Integer userSeq = (Integer) session.getAttribute("userSeq");

        // [핵심 수정] 테스트 유저를 1번으로 변경
        if (userSeq == null) {
            userSeq = 1; // <--- 여기를 1로 변경했습니다!
            session.setAttribute("userSeq", userSeq);

            if (loginUser == null) {
                loginUser = new MemberDTO();
                loginUser.setUserName("테스트유저(1번)");
                loginUser.setUserId("testUser1");
                loginUser.setUserLevel(1); // userLevel은 int 혹은 String 확인 필요 (MemberDTO 기준)
                // 만약 MemberDTO의 userLevel이 String이라면 "Beginner" 등으로 변경
                session.setAttribute("loginUser", loginUser);
            }
        }

        log.info("현재 접속 중인 userSeq: {}", userSeq); // 로그로 확인

        // 2. 보유 주식 가져오기
        List<PortfolioAllocationItemDTO> holdings = portfolioService.getPortfolioAllocationItems(userSeq);
        log.info("가져온 보유 주식 개수: {}", (holdings != null ? holdings.size() : 0));

        // 3. 차트 데이터 생성
        List<Map<String, Object>> chartData = new ArrayList<>();
        if (holdings != null) {
            for (PortfolioAllocationItemDTO item : holdings) {
                // 비중이 0보다 큰 경우에만 차트에 표시
                if (item.getWeightPct() > 0) {
                    Map<String, Object> data = new HashMap<>();
                    data.put("stockName", item.getStockName());
                    data.put("weightPct", item.getWeightPct());
                    data.put("color", ColorUtil.colorByStockCode(item.getStockCode()));
                    chartData.add(data);
                }
            }
        }

        // 4. JSON 변환
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            String jsonString = objectMapper.writeValueAsString(chartData);
            model.addAttribute("chartDataJson", jsonString);
            log.info("Chart JSON: {}", jsonString); // 데이터 확인용 로그
        } catch (Exception e) {
            log.error("JSON 변환 에러", e);
            model.addAttribute("chartDataJson", "[]");
        }

        // 5. 자산 정보 조회
        try {
            // (1) 기존 자산 요약 정보 가져오기 (총 주식 평가금액 등)
            UserInvestSummeryDTO userAsset = userAssetService.getUserInvestSummary(userSeq);
            if(userAsset == null) userAsset = new UserInvestSummeryDTO();

            // (2) [추가] DB에서 실제 예수금(cash_balance) 조회
            AccountDTO myAccount = accountService.getMyAccount(Long.valueOf(userSeq));

            if (myAccount != null) {
                // DB에 계좌가 있으면 그 잔액을 사용
                userAsset.setCashBalance(myAccount.getCashBalance());
            } else {
                // 계좌가 없으면 0원
                userAsset.setCashBalance(0L);
            }

            // (3) [재계산] 총 자산 = 주식 평가금액 + 예수금
            // (userAssetService에서 이미 계산했을 수도 있지만, 확실하게 다시 합산)
            long totalStockValue = userAsset.getTotalStockValue(); // 기존 주식 평가액
            long cashBalance = userAsset.getCashBalance();         // 방금 가져온 예수금
            userAsset.setTotalAsset(totalStockValue + cashBalance);

            model.addAttribute("userAsset", userAsset);

        } catch (Exception e) {
            log.error("자산 정보 조회 에러", e);
            model.addAttribute("userAsset", new UserInvestSummeryDTO());
        }

        return "myPage/myPageMain";
    }
}
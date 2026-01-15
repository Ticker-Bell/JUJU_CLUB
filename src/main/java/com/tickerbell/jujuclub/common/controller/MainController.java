package com.tickerbell.jujuclub.common.controller;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.common.service.UserInfoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@RequestMapping("/main")
@Controller
public class MainController {
    private final UserInfoService userInfoService;

    public MainController(UserInfoService userInfoService) {
        this.userInfoService = userInfoService;
    }

    // main화면으로 이동
    @GetMapping()
    public String showMain(Model model, HttpSession session) {
        String testId = "hi";
        System.out.println("=== 조회 시작 ID: " + testId + " ===");

        // TODO: session에서 userId 확인로직으로 수정 필요
        UserInfoDTO userInfo = userInfoService.getUserInfo(testId);

        if(userInfo != null) {
            System.out.println("조회 성공: " + userInfo.toString()); // @Data가 있으면 상세값이 출력됨
        } else {
            System.out.println("조회 실패: DB에 해당 ID가 없거나 JOIN 결과가 없음");
        }

        session.setAttribute("user", userInfo);
//        UserInfoDTO users = (UserInfoDTO) session.getAttribute("userSeq");
//
//        model.addAttribute("user", users);

        model.addAttribute("targetPage", "/WEB-INF/views/roadMap/roadMapMain.jsp");
        return "common/main";
    }

    // 사이드바 이동
    @GetMapping("/roadMapMain.do")
    public String roadMap(Model model, @RequestHeader(value="HX-Request", required = false) boolean isHtmx) {
        if (isHtmx) {
            // 사이드바 클릭 시 처리
            return "roadMap/roadMapMain";
        } else {
            // 주소창 입력 및 새로고침 처리
            model.addAttribute("targetPage", "/WEB-INF/views/roadMap/roadMapMain.jsp");
            return "common/main";
        }
    }

    @GetMapping("/investMain.do")
    public String invest(Model model, @RequestHeader(value="HX-Request", required = false) boolean isHtmx) {
        if (isHtmx) {
            // 사이드바 클릭 시 처리
            return "invest/investMain";
        } else {
            // 주소창 입력 및 새로고침 처리
            model.addAttribute("targetPage", "/WEB-INF/views/invest/investMain.jsp");
            return "common/main";
        }
    }

    @GetMapping("/myPageMain.do")
    public String myPage(Model model, @RequestHeader(value="HX-Request", required = false) boolean isHtmx) {
        if (isHtmx) {
            // 사이드바 클릭 시 처리
            return "myPage/myPageMain";
        } else {
            // 주소창 입력 및 새로고침 처리
            model.addAttribute("targetPage", "/WEB-INF/views/myPage/myPageMain.jsp");
            return "common/main";
        }
    }

    @GetMapping("/rankingMain.do")
    public String ranking(Model model, @RequestHeader(value="HX-Request", required = false) boolean isHtmx) {
        System.out.println(">>> 요청 들어옴: /rankingMain.do");
        System.out.println(">>> HTMX 헤더 감지됨? " + isHtmx);

        if (isHtmx) {
            System.out.println(">>> [HTMX 요청] 조각(Fragment) 리턴");
            return "ranking/rankingMain";
        } else {
            System.out.println(">>> [일반 요청] 전체 페이지 리턴");
            model.addAttribute("targetPage", "../ranking/rankingMain.jsp");
            return "common/main";
        }
    }

}

package com.tickerbell.jujuclub.common.controller;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.common.service.UserInfoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/main")
@Controller
public class MainController {
    private final UserInfoService userInfoService;

    public MainController(UserInfoService userInfoService) {
        this.userInfoService = userInfoService;
    }

    // main화면으로 이동
    @GetMapping()
    public String showMain(Model model) {
        String testId = "hi";
        System.out.println("=== 조회 시작 ID: " + testId + " ===");

        // TODO: session에서 userId 확인로직으로 수정 필요
        UserInfoDTO userInfo = userInfoService.getUserInfo(testId);

        if(userInfo != null) {
            System.out.println("조회 성공: " + userInfo.toString()); // @Data가 있으면 상세값이 출력됨
        } else {
            System.out.println("조회 실패: DB에 해당 ID가 없거나 JOIN 결과가 없음");
        }

        model.addAttribute("user", userInfo);
        return "common/main";
    }

    // 사이드바 이동
    @GetMapping("/roadMapMain.do")
    public String roadMap() {
        return "roadMap/roadMapMain";
    }

    @GetMapping("/investMain.do")
    public String invest() {
        return "invest/investMain";
    }

    @GetMapping("/myPageMain.do")
    public String myPage() {
        return "myPage/myPageMain";
    }

    @GetMapping("/rankingMain.do")
    public String ranking() {
        return "ranking/rankingMain";
    }

}

package com.tickerbell.jujuclub.auth.controller;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.service.AccountService;
import com.tickerbell.jujuclub.roadMap.service.RoadMapService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/account")
@RequiredArgsConstructor
@Slf4j
public class AccountController {

    private final AccountService accountService;
    private final RoadMapService roadMapService;

    /**
     * 유저 계좌 생성
     *
     * @return response Map<String, Object>
     */
    @PostMapping("/create.ajax")
    @ResponseBody
    public Map<String, Object> createAccount(HttpSession session) {

        // 세션에 저장된 LoginUser을 가져와서 변수에 저장
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        Map<String, Object> response = new HashMap<>();

        // 세션 정보 null값 확인
        if (loginUser == null) {
            response.put("ok", false);
            response.put("message", "로그인 정보가 없습니다.");
            return response;
        }

        try {
            log.info("[{}] 유저 계좌 생성 시작", loginUser.getUserSeq());
            // 서비스에서 생성된 계좌번호를 받음
            log.info("[{}] 유저 계좌 생성  - 등록된 유저 계좌에서 계좌번호 받기 시작", loginUser.getUserSeq());
            String createdAccountNo = accountService.createAccount(loginUser.getUserSeq());
            log.info("[{}] 유저 계좌 생성  - 등록된 유저 계좌에서 계좌번호 받기 종료", loginUser.getUserSeq());

            if (createdAccountNo != null) {

                response.put("ok", true);
                response.put("message", "계좌가 생성되었습니다.");
                response.put("accountNo", createdAccountNo);

                try {
                    log.info("[{}] 유저 계좌 생성 - 유저 일일 미션 등록 시작", loginUser.getUserSeq());
                    roadMapService.insertInitUserMission(loginUser.getUserSeq());
                    log.info("[{}] 유저 계좌 생성 - 유저 일일 미션 등록 종료", loginUser.getUserSeq());

                    log.info("[{}] 유저 계좌 생성 - 유저 레슨 등록 시작 [{}]", loginUser.getUserSeq(), loginUser.getUserLevel());
                    if (loginUser.getUserLevel() > 1)
                        roadMapService.insertInitUserLesson(loginUser.getUserSeq(), loginUser.getUserLevel());
                    log.info("[{}] 유저 계좌 생성 - 유저 레슨 등록 종료 [{}]", loginUser.getUserSeq(), loginUser.getUserLevel());
                } catch(Exception e) {
                    log.error("유저 계좌 생성 실패 (미션, 레슨)");
                    throw new RuntimeException(e);
                }
            } else {
                response.put("ok", false);
                response.put("message", "이미 계좌가 존재합니다.");
            }

        } catch (Exception e) {
            response.put("ok", false);
            response.put("message", "계좌 생성 중 오류 발생: " + e.getMessage());

            log.info("[{}] 유저 계좌 생성 실패", loginUser.getUserSeq());
        }

        return response;
    }
}
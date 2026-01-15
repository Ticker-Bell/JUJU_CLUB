package com.tickerbell.jujuclub.auth.controller;

import com.tickerbell.jujuclub.auth.dto.SigninDTO;
import com.tickerbell.jujuclub.auth.service.AccountService;
import lombok.RequiredArgsConstructor;
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
public class AccountController {

    private final AccountService accountService;

    @PostMapping("/create.ajax")
    @ResponseBody
    public Map<String, Object> createAccount(HttpSession session) {
        Map<String, Object> res = new HashMap<>();

        SigninDTO loginUser = (SigninDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            res.put("ok", false);
            res.put("message", "로그인 정보가 없습니다.");
            return res;
        }

        try {
            // [수정] 서비스에서 생성된 계좌번호를 받음
            Long createdAccountNo = accountService.createAccount(loginUser.getUserId());

            if (createdAccountNo != null) {
                res.put("ok", true);
                res.put("message", "계좌가 생성되었습니다.");
                res.put("accountNo", createdAccountNo); // [추가] 클라이언트로 전달
            } else {
                res.put("ok", false);
                res.put("message", "이미 계좌가 존재합니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", "계좌 생성 중 오류 발생: " + e.getMessage());
        }

        return res;
    }
}
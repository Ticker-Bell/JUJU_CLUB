package com.tickerbell.jujuclub.auth.controller;

import com.tickerbell.jujuclub.auth.dto.SigninDTO;
import com.tickerbell.jujuclub.auth.service.SigninService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class SigninController {

    private final SigninService signinService;

    @PostMapping(
            value = "/login.ajax",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE
    )
    @ResponseBody
    public Map<String, Object> SinginAjax(@RequestBody SigninAjaxRequest req,
                                         HttpSession session,
                                         HttpServletRequest request) {

        Map<String, Object> res = new HashMap<>();

        try {
            // ✅ 서비스에서 검증 + 사용자정보 반환(성공 시)
            SigninDTO user = signinService.signin(req.getEmail(), req.getPassword());

            // ✅ 비밀번호는 세션에 들고가지 않기 (필드명이 user_pw 임)
            user.setUserPw(null);

            session.setAttribute("signinUser", user);

            res.put("ok", true);
            res.put("message", "로그인 성공");
            res.put("redirectUrl", request.getContextPath() + "/main");

        } catch (IllegalArgumentException e) {
            res.put("ok", false);
            res.put("message", e.getMessage());

        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", "처리 중 오류가 발생했습니다.");
        }

        return res;
    }

    public static class SigninAjaxRequest {
        private String email;
        private String password;

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }
}
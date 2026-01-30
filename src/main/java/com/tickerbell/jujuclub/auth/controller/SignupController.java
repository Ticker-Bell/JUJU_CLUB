package com.tickerbell.jujuclub.auth.controller;

import java.util.HashMap;
import java.util.Map;

import com.tickerbell.jujuclub.auth.dto.SignupDTO;
import com.tickerbell.jujuclub.auth.service.SignupService;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/auth")
public class SignupController {

    private final SignupService signupService;

    public SignupController(SignupService signupService) {
        this.signupService = signupService;
    }

    /**
     * 회원가입
     *
     * @return map {@code Map<String, Object>}
     */
    @PostMapping(
            value = "/signin.ajax",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE
    )
    @ResponseBody
    public Map<String, Object> signupAjax(@RequestBody SignupAjaxRequest request) {

        Map<String, Object> map = new HashMap<>();

        try {
            SignupDTO dto = new SignupDTO();

            dto.setUserId(request.getEmail());
            dto.setUserName(request.getUsername());
            dto.setUserPw(request.getPassword());

            signupService.signup(dto);

            map.put("ok", true);
            map.put("message", "회원가입이 완료되었습니다.");
            return map;

        } catch (IllegalArgumentException e) {
            map.put("ok", false);
            map.put("message", e.getMessage());
            return map;

        } catch (Exception e) {
            e.printStackTrace();
            map.put("ok", false);
            map.put("message", "처리 중 오류가 발생했습니다.");
            return map;
        }
    }

    // 1. 이메일 중복 확인 API
    /**
     * 유저 정보 수정 (이미지) - 기본 이미지 처리, 파일 형식 확인, 캐시 방지 처리
     *
     * @param img byte[]
     * @return new ResponseEntity&lt;&gt;(out, headers, HttpStatus.OK) Map&lt;String, Object&gt;
     */
    @GetMapping("/check-email")
    @ResponseBody
    public Map<String, Object> checkEmail(@RequestParam String email) {
        Map<String, Object> map = new HashMap<>();

        if (signupService.isEmailDuplicate(email)) {
            map.put("ok", false);
            map.put("message", "이미 사용중인 이메일 입니다."); // 백엔드에서 메시지 결정
        } else {
            map.put("ok", true);
            map.put("message", "사용 가능한 이메일입니다.");
        }
        return map;
    }

    // 2. 닉네임 중복 확인 API
    /**
     * 유저 정보 수정 (이미지) - 기본 이미지 처리, 파일 형식 확인, 캐시 방지 처리
     *
     * @param img byte[]
     * @return new ResponseEntity&lt;&gt;(out, headers, HttpStatus.OK) Map&lt;String, Object&gt;
     */
    @GetMapping("/check-nickname")
    @ResponseBody
    public Map<String, Object> checkNickname(@RequestParam String nickname) {
        Map<String, Object> map = new HashMap<>();

        if (signupService.isNicknameDuplicate(nickname)) {
            map.put("ok", false);
            map.put("message", "이미 사용중인 닉네임 입니다."); // 백엔드에서 메시지 결정
        } else {
            map.put("ok", true);
            map.put("message", "사용 가능한 닉네임입니다.");
        }
        return map;
    }

    public static class SignupAjaxRequest {
        private String email;
        private String username;
        private String password;

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }

        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }
}
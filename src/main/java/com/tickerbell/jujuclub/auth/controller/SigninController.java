package com.tickerbell.jujuclub.auth.controller;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
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

    // 1. 로그인 요청 처리
    /**
     * 닉네임 중복 확인
     *
     * @param req SigninAjaxRequest
     * @return res {@code Map<String, Object>}
     */
    @PostMapping(value = "/login.ajax", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> SinginAjax(@RequestBody SigninAjaxRequest req,
                                          HttpSession session,
                                          HttpServletRequest request) {
        Map<String, Object> res = new HashMap<>();
        try {
            // 로그인 서비스 호출
            MemberDTO user = signinService.signin(req.getEmail(), req.getPassword());
            user.setUserPw(null); // 비밀번호 제거

            // 세션 생성 (키: loginUser)
            session.setAttribute("loginUser", user);
            session.setAttribute("userLevel", user.getUserLevel());
            session.setAttribute("userSeq", user.getUserSeq());

            // 응답 데이터 구성
            res.put("ok", true);
            res.put("message", "로그인 성공");
            res.put("userName", user.getUserName()); // [유지] 상단바 이름 표시용

            // 레벨 유무에 따른 다음 동작 결정
            if (user.getUserLevel() != null) {
                res.put("nextAction", "main");
                res.put("redirectUrl", request.getContextPath() + "/roadMap/main.do");
            } else {
                res.put("nextAction", "survey");
            }
        } catch (Exception e) {
            res.put("ok", false);
            res.put("message", e.getMessage());
        }
        return res;
    }

    // 2. [추가] 로그아웃 기능
    /**
     * 로그아웃
     *
     * @return redirect:/
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 세션 무효화 (로그인 정보 삭제)
        session.invalidate();

        // 메인(시작) 페이지로 리다이렉트
        return "redirect:/";
    }

    // 3. 레벨 업데이트 기능 (계좌 생성은 AccountController에서 담당)
    /**
     * 닉네임 중복 확인
     *
     * @param req {@code Map<String, Integer}
     * @return res {@code Map<String, Object>}
     */
    @PostMapping(value = "/updateLevel.ajax", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> updateLevelAjax(@RequestBody Map<String, Integer> req, HttpSession session) {
        Map<String, Object> res = new HashMap<>();

        try {
            MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
            if (loginUser == null) {
                res.put("ok", false);
                res.put("message", "로그인이 필요합니다.");
                return res;
            }

            Integer level = req.get("level");
            if (level == null || level < 1 || level > 3) throw new IllegalArgumentException("유효하지 않은 레벨입니다.");

            // 회원가입 후 유저 레벨 등록
            signinService.updateUserLevel(loginUser.getUserSeq(), level);

            // 세션 정보 갱신
            loginUser.setUserLevel(level);
            session.setAttribute("loginUser", loginUser);

            res.put("ok", true);
            res.put("message", "레벨 설정 완료");

        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", "레벨 업데이트 오류: " + e.getMessage());
        }
        return res;
    }

    /**
     * 로그인 요청 DTO
     */
    public static class SigninAjaxRequest {
        private String email; private String password;
        public String getEmail() { return email; } public void setEmail(String email) { this.email = email; }
        public String getPassword() { return password; } public void setPassword(String password) { this.password = password; }
    }
}
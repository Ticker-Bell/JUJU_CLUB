package com.tickerbell.jujuclub.auth.controller;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @PostMapping("/updateProfile.ajax")
    @ResponseBody
    public Map<String, Object> updateProfile(@RequestBody Map<String, String> req, HttpSession session) {
        Map<String, Object> res2 = new HashMap<>();

        // 세션 확인
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            res2.put("ok", false);
            res2.put("message", "로그인 정보가 없습니다.");
            return res2;
        }

        try {
            // 요청 데이터 추출
            String userName = req.get("userName");
            String userPw = req.get("userPw");

            // 서비스 호출 (닉네임만, 비밀번호만, 닉네임&비밀번호 -> 3가지 경우의수 모두 처리)
            memberService.updateProfile(loginUser.getUserId(), userName, userPw);

            // 세션 데이터 갱신 (중요: 화면 동기화)
            // 닉네임이 변경되었다면 세션 객체도 수정해야 화면에 바로 반영됨
            if (StringUtils.hasText(userName)) {
                loginUser.setUserName(userName);
            }
            // 비밀번호는 세션에 저장된 값을 굳이 바꿀 필요 없음 (보안상 평문 저장 금지, 해시값은 DB에서 다시 불러오지 않는 한 유지)

            session.setAttribute("loginUser", loginUser); // 변경된 객체 다시 저장

            res2.put("ok", true);
            res2.put("message", "회원 정보가 성공적으로 수정되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            res2.put("ok", false);
            res2.put("message", "수정 중 오류가 발생했습니다.");
        }

        return res2;
    }

    // [기존] 회원탈퇴 요청 (AJAX)
    @PostMapping("/withdraw.ajax")
    @ResponseBody
    public Map<String, Object> withdraw(@RequestBody Map<String, String> req, HttpSession session) {
        Map<String, Object> res = new HashMap<>();

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser"); // 타입 맞춤
        if (loginUser == null) {
            res.put("ok", false);
            res.put("message", "로그인 정보가 없습니다.");
            return res;
        }

        try {
            String password = req.get("password");

            // 서비스 호출 (비밀번호 체크 및 삭제)
            memberService.withdraw(loginUser.getUserId(), password);

            // 세션 만료 (로그아웃)
            session.invalidate();

            res.put("ok", true);
            res.put("message", "회원 탈퇴가 완료되었습니다.");

        } catch (IllegalArgumentException e) {
            res.put("ok", false);
            res.put("message", e.getMessage()); // "비밀번호가 일치하지 않습니다." 등
        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", "탈퇴 처리 중 오류가 발생했습니다.");
        }

        return res;
    }
}
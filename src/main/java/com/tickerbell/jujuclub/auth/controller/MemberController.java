package com.tickerbell.jujuclub.auth.controller;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            res2.put("ok", false);
            res2.put("message", "로그인 정보가 없습니다.");
            return res2;
        }

        try {
            String userName = req.get("userName");
            String userPw = req.get("userPw");

            memberService.updateProfile(loginUser.getUserId(), userName, userPw);

            if (StringUtils.hasText(userName)) {
                loginUser.setUserName(userName);
            }
            session.setAttribute("loginUser", loginUser);

            res2.put("ok", true);
            res2.put("message", "회원 정보가 성공적으로 수정되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            res2.put("ok", false);
            res2.put("message", "수정 중 오류가 발생했습니다.");
        }

        return res2;
    }

    /** ✅ user_image(MEDIUMBLOB) 업로드/저장 */
    @PostMapping(value = "/updateProfileImage.ajax", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @ResponseBody
    public Map<String, Object> updateProfileImage(@RequestParam("userImage") MultipartFile userImage,
                                                  HttpSession session) {
        Map<String, Object> res = new HashMap<>();

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            res.put("ok", false);
            res.put("message", "로그인 정보가 없습니다.");
            return res;
        }

        try {
            if (userImage == null || userImage.isEmpty()) {
                res.put("ok", false);
                res.put("message", "업로드된 파일이 없습니다.");
                return res;
            }

            // (선택) 이미지 크기 제한 예: 2MB
            long maxBytes = 2L * 1024 * 1024;
            if (userImage.getSize() > maxBytes) {
                res.put("ok", false);
                res.put("message", "이미지 용량이 너무 큽니다. (최대 2MB)");
                return res;
            }

            // ✅ DB에 넣을 byte[]
            byte[] bytes = userImage.getBytes();

            // ✅ 서비스 호출 -> MyBatis updateUser -> USERS.user_image 저장
            memberService.updateProfileImage(loginUser.getUserId(), bytes);

            // ⚠️ 세션에 이미지 바이트를 넣는 건 비추(세션 커짐).
            // loginUser.setUserImage(bytes); // 필요하면 넣을 수는 있으나 권장 X

            res.put("ok", true);
            res.put("message", "프로필 이미지가 저장되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", "이미지 저장 중 오류가 발생했습니다.");
        }

        return res;
    }

    @PostMapping("/withdraw.ajax")
    @ResponseBody
    public Map<String, Object> withdraw(@RequestBody Map<String, String> req, HttpSession session) {
        Map<String, Object> res = new HashMap<>();

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            res.put("ok", false);
            res.put("message", "로그인 정보가 없습니다.");
            return res;
        }

        try {
            String password = req.get("password");
            memberService.withdraw(loginUser.getUserId(), password);
            session.invalidate();

            res.put("ok", true);
            res.put("message", "회원 탈퇴가 완료되었습니다.");

        } catch (IllegalArgumentException e) {
            res.put("ok", false);
            res.put("message", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", "탈퇴 처리 중 오류가 발생했습니다.");
        }

        return res;
    }
}
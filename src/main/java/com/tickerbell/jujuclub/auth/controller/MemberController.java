package com.tickerbell.jujuclub.auth.controller;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.InputStream;
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

            if (StringUtils.hasText(userName)) loginUser.setUserName(userName);
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

            // ✅ 2MB 제한
            long maxBytes = 2L * 1024 * 1024;
            if (userImage.getSize() > maxBytes) {
                res.put("ok", false);
                res.put("message", "이미지 용량이 너무 큽니다. (최대 2MB)");
                return res;
            }

            // ✅ 간단 타입 체크(권장)
            String ct = userImage.getContentType();
            if (ct == null || !ct.startsWith("image/")) {
                res.put("ok", false);
                res.put("message", "이미지 파일만 업로드할 수 있습니다.");
                return res;
            }

            memberService.updateProfileImage(loginUser.getUserId(), userImage.getBytes());

            res.put("ok", true);
            res.put("message", "프로필 이미지가 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", "이미지 저장 중 오류가 발생했습니다.");
        }
        return res;
    }

    /** ✅ DB에 저장된 user_image를 그대로 내려줌 (없으면 404 -> onerror로 기본이미지) */
    @GetMapping("/profile-image")
    public ResponseEntity<byte[]> profileImage(HttpSession session, HttpServletRequest request) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        byte[] img = null;

        // 1) DB 이미지 조회
        MemberDTO dbUser = memberService.selectUserById(loginUser.getUserId());
        if (dbUser != null && dbUser.getUserImage() != null && dbUser.getUserImage().length > 0) {
            img = dbUser.getUserImage();
        }

        // 2) 없으면 default 이미지 로드
        MediaType mediaType = MediaType.IMAGE_PNG; // 기본이미지는 png라 가정
        if (img == null) {
            try (InputStream is = request.getServletContext()
                    .getResourceAsStream("/resources/images/default-profile.png")) {

                if (is == null) return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
                img = is.readAllBytes();
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
            }
        } else {
            // (선택) DB 이미지면 JPEG/PNG 시그니처로 타입 추정
            if (img.length >= 4
                    && (img[0] & 0xFF) == 0x89
                    && (img[1] & 0xFF) == 0x50
                    && (img[2] & 0xFF) == 0x4E
                    && (img[3] & 0xFF) == 0x47) {
                mediaType = MediaType.IMAGE_PNG;
            } else if (img.length >= 2
                    && (img[0] & 0xFF) == 0xFF
                    && (img[1] & 0xFF) == 0xD8) {
                mediaType = MediaType.IMAGE_JPEG;
            } else {
                mediaType = MediaType.APPLICATION_OCTET_STREAM;
            }
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(mediaType);
        headers.setCacheControl(CacheControl.noStore()); // 캐시 꼬임 방지

        return new ResponseEntity<>(img, headers, HttpStatus.OK);
    }
}
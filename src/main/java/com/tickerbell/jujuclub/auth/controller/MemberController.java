package com.tickerbell.jujuclub.auth.controller;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
public class MemberController {

    private final MemberService memberService;

    /**
     * 유저 정보 수정
     *
     * @param request Map<String, String>
     * @return response Map<String, Object>
     */
    @PostMapping("/updateProfile.ajax")
    @ResponseBody
    public Map<String, Object> updateProfile(@RequestBody Map<String, String> request, HttpSession session) {

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        Map<String, Object> response = new HashMap<>();

        if (loginUser == null) {
            response.put("ok", false);
            response.put("message", "로그인 정보가 없습니다.");
            return response;
        }

        try {
            String userName = request.get("userName");
            String userPw = request.get("userPw");

            memberService.updateProfile(loginUser.getUserId(), userName, userPw);

            if (StringUtils.hasText(userName))
                loginUser.setUserName(userName);

            session.setAttribute("loginUser", loginUser);

            response.put("ok", true);
            response.put("message", "회원 정보가 성공적으로 수정되었습니다.");

        } catch (Exception e) {
            response.put("ok", false);
            response.put("message", "수정 중 오류가 발생했습니다.");
        }
        return response;
    }

    /**
     * 유저 정보 수정 (이미지)
     *
     * @param userImage MultipartFile
     * @return response Map<String, Object>
     */
    @PostMapping(value = "/updateProfileImage.ajax", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @ResponseBody
    public Map<String, Object> updateProfileImage(@RequestParam("userImage") MultipartFile userImage, HttpSession session) {

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        Map<String, Object> response = new HashMap<>();

        if (loginUser == null) {
            response.put("ok", false);
            response.put("message", "로그인 정보가 없습니다.");
            return response;
        }

        try {

            if (userImage == null || userImage.isEmpty()) {
                response.put("ok", false);
                response.put("message", "업로드된 파일이 없습니다.");
                return response;
            }

            long maxBytes = 2L * 1024 * 1024;
            if (userImage.getSize() > maxBytes) {
                response.put("ok", false);
                response.put("message", "이미지 용량이 너무 큽니다. (최대 2MB)");
                return response;
            }

            String ct = userImage.getContentType();
            if (ct == null || !ct.startsWith("image/")) {
                response.put("ok", false);
                response.put("message", "이미지 파일만 업로드할 수 있습니다.");
                return response;
            }

            memberService.updateProfileImage(loginUser.getUserId(), userImage.getBytes());

            response.put("ok", true);
            response.put("message", "프로필 이미지가 저장되었습니다.");

        } catch (Exception e) {

            response.put("ok", false);
            response.put("message", "이미지 저장 중 오류가 발생했습니다.");
        }
        return response;
    }

    /**
     * 유저 정보 (이미지) 가져오기
     *
     * @return buildImageResponse(img, request) ResponseEntity&lt;byte[]&gt;
     */
    @GetMapping("/profile-image")
    public ResponseEntity<byte[]> profileImageMine(HttpSession session, HttpServletRequest request) {

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        MemberDTO dbUser = memberService.selectUserById(loginUser.getUserId());
        byte[] img = (dbUser != null) ? dbUser.getUserImage() : null;

        return buildImageResponse(img, request);
    }

    /**
     * 유저 정보 수정 (이미지)
     *
     * @param userSeq int
     * @return buildImageResponse(img, request) {@code ResponseEntity<byte[]>}
     */
    @GetMapping(value = "/profile-image", params = "userSeq")
    public ResponseEntity<byte[]> profileImageBySeq(@RequestParam("userSeq") int userSeq,
        HttpSession session,
        HttpServletRequest request) {

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        MemberDTO dbUser = memberService.selectUserBySeq(userSeq);
        byte[] img = (dbUser != null) ? dbUser.getUserImage() : null;

        return buildImageResponse(img, request);
    }

    /**
     * 유저 정보 수정 (이미지) - 기본 이미지 처리, 파일 형식 확인, 캐시 방지 처리
     *
     * @param img byte[]
     * @return new ResponseEntity&lt;&gt;(out, headers, HttpStatus.OK) Map&lt;String, Object&gt;
     */
    private ResponseEntity<byte[]> buildImageResponse(byte[] img, HttpServletRequest request) {
        byte[] out = img;

        MediaType mediaType = MediaType.IMAGE_PNG;
        if (out == null || out.length == 0) {
            try (InputStream is = request.getServletContext()
                .getResourceAsStream("/resources/images/default-profile.png")) {
                if (is == null) return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
                out = is.readAllBytes();
                mediaType = MediaType.IMAGE_PNG;
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
            }
        } else {
            if (out.length >= 4
                && (out[0] & 0xFF) == 0x89
                && (out[1] & 0xFF) == 0x50
                && (out[2] & 0xFF) == 0x4E
                && (out[3] & 0xFF) == 0x47) {
                mediaType = MediaType.IMAGE_PNG;
            } else if (out.length >= 2
                && (out[0] & 0xFF) == 0xFF
                && (out[1] & 0xFF) == 0xD8) {
                mediaType = MediaType.IMAGE_JPEG;
            } else {
                mediaType = MediaType.APPLICATION_OCTET_STREAM;
            }
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(mediaType);

        // ✅ 캐시로 인해 첫 번째 이미지가 다른 이미지에 “복붙”되는 현상 방지
        headers.setCacheControl("no-store, no-cache, must-revalidate, max-age=0");
        headers.add("Pragma", "no-cache");
        headers.add("Expires", "0");

        return new ResponseEntity<>(out, headers, HttpStatus.OK);
    }
}

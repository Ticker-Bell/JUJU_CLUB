package com.tickerbell.jujuclub.auth.service;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.dto.SigninDTO;
import com.tickerbell.jujuclub.auth.mapper.SigninMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SigninService {

    private final SigninMapper signinMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    // 기존 로그인 메서드 (생략하지 말고 유지)
    public MemberDTO signin(String email, String rawPw) {
        // ... (기존 코드와 동일) ...
        if (email == null || email.trim().isEmpty()) throw new IllegalArgumentException("이메일을 입력해주세요.");
        if (rawPw == null || rawPw.trim().isEmpty()) throw new IllegalArgumentException("비밀번호를 입력해주세요.");
        MemberDTO user = signinMapper.selectUserById(email);
        if (user == null) throw new IllegalArgumentException("존재하지 않는 아이디 입니다.");
        if (!passwordEncoder.matches(rawPw, user.getUserPw())) throw new IllegalArgumentException("아이디 또는 비밀번호가 틀립니다.");
        return user;
    }

    // [추가] 레벨 업데이트 서비스
    public void updateUserLevel(Long userSeq, int level) {
        signinMapper.updateUserLevel(userSeq, level);
    }
}
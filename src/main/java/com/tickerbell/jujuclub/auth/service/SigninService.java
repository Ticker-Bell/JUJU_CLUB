package com.tickerbell.jujuclub.auth.service;

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

  public SigninDTO signin(String email, String rawPw) {

    if (email == null || email.trim().isEmpty()) {
      throw new IllegalArgumentException("이메일을 입력해주세요.");
    }
    if (rawPw == null || rawPw.trim().isEmpty()) {
      throw new IllegalArgumentException("비밀번호를 입력해주세요.");
    }

    // ✅ 아이디로만 조회 (DB의 해시 비번 가져오기)
    SigninDTO user = signinMapper.selectUserById(email);

    // 보안상 동일 메시지 권장
    if (user == null) {
      throw new IllegalArgumentException("존재하지 않는 아이디 입니다.");
    }

    // ✅ BCrypt 비교
    boolean ok = passwordEncoder.matches(rawPw, user.getUserPw());
    if (!ok) {
      throw new IllegalArgumentException("아이디 또는 비밀번호가 틀립니다.");
    }
    return user;
  }
}
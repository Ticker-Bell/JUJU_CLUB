package com.tickerbell.jujuclub.auth.service;

import com.tickerbell.jujuclub.auth.dto.SignupDTO;
import com.tickerbell.jujuclub.auth.mapper.SignupMapper;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@NoArgsConstructor
@Service
public class SignupService {

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private SignupMapper signupMapper;

    @Transactional
    public void signup(SignupDTO dto) {

        // 1) 기본 검증
        if (dto.getUserId() == null || dto.getUserId().trim().isEmpty())
            throw new IllegalArgumentException("이메일을 입력해주세요.");
        if (dto.getUserName() == null || dto.getUserName().trim().isEmpty())
            throw new IllegalArgumentException("닉네임을 입력해주세요.");
        if (dto.getUserPw() == null || dto.getUserPw().trim().isEmpty())
            throw new IllegalArgumentException("비밀번호를 입력해주세요.");

        // 2) 중복 체크
        // (새로 만든 메서드를 재사용하면 코드가 더 깔끔해집니다)
        if (isEmailDuplicate(dto.getUserId()))
            throw new IllegalArgumentException("이미 사용중인 이메일 입니다.");
        if (isNicknameDuplicate(dto.getUserName()))
            throw new IllegalArgumentException("이미 사용중인 닉네임입니다.");

        // 3) BCrypt 해싱 (핵심)
        dto.setUserPw(bCryptPasswordEncoder.encode(dto.getUserPw()));

        // 4) 저장
        signupMapper.insertUser(dto);
    }

    // ============================================================
    // [수정된 부분] 중복 확인 메서드는 signup() 메서드 밖으로 빼야 합니다.
    // ============================================================

    public boolean isEmailDuplicate(String email) {
        return signupMapper.existsByUserId(email) > 0;
    }

    public boolean isNicknameDuplicate(String nickname) {
        return signupMapper.existsByUserName(nickname) > 0;
    }
}
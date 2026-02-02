package com.tickerbell.jujuclub.auth.service;

import com.tickerbell.jujuclub.auth.dto.SignupDTO;
import com.tickerbell.jujuclub.auth.mapper.SignupMapper;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import lombok.extern.slf4j.XSlf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@NoArgsConstructor
@Service
@Slf4j
public class SignupService {

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private SignupMapper signupMapper;

    /**
     * 회원가입
     *
     * @param signupDTO SignupDTO
     */
    @Transactional
    public void signup(SignupDTO signupDTO) {

        // 빈칸 검증
        if (signupDTO.getUserId() == null || signupDTO.getUserId().trim().isEmpty())
            throw new IllegalArgumentException("이메일을 입력해주세요.");
        if (signupDTO.getUserName() == null || signupDTO.getUserName().trim().isEmpty())
            throw new IllegalArgumentException("닉네임을 입력해주세요.");
        if (signupDTO.getUserPw() == null || signupDTO.getUserPw().trim().isEmpty())
            throw new IllegalArgumentException("비밀번호를 입력해주세요.");

        // 중복 체크
        if (isEmailDuplicate(signupDTO.getUserId()))
            throw new IllegalArgumentException("이미 사용중인 이메일 입니다.");
        if (isNicknameDuplicate(signupDTO.getUserName()))
            throw new IllegalArgumentException("이미 사용중인 닉네임입니다.");

        // 비밀번호 BCrypt 해싱
        signupDTO.setUserPw(bCryptPasswordEncoder.encode(signupDTO.getUserPw()));

        // 저장
        log.info("[{}] 회원가입 - 유저 정보 등록 시작", signupDTO);
        signupMapper.insertUser(signupDTO);
        log.info("[{}] 회원가입 - 유저 정보 등록 종료", signupDTO);
    }

    /**
     * 이메일 중복 확인
     *
     * @param email String
     * return result boolean
     */
    public boolean isEmailDuplicate(String email) {
        log.info("[{}] 이메일 중복 확인 시작", email);
        boolean result = signupMapper.existsByUserId(email) > 0;
        log.info("[{}] 이메일 중복 확인 종료", email);
        return result;
    }

    /**
     * 닉네임 중복 확인
     *
     * @param nickname String
     * return result boolean
     */
    public boolean isNicknameDuplicate(String nickname) {
        log.info("[{}] 닉네임 중복 확인 시작", nickname);
        boolean result = signupMapper.existsByUserName(nickname) > 0;
        log.info("[{}] 닉네임 중복 확인 종료", nickname);
        return result;
    }
}
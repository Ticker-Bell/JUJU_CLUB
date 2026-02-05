package com.tickerbell.jujuclub.auth.service;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.dto.SigninDTO;
import com.tickerbell.jujuclub.auth.mapper.SigninMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class SigninService {

    private final SigninMapper signinMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    /**
     * 로그인
     *
     * @param email String, rawPw String
     * return user MemberDTO
     */
    public MemberDTO signin(String email, String rawPw) {

        // 로그인창에서 빈칸 검사
        if (email == null || email.trim().isEmpty())
            throw new IllegalArgumentException("이메일을 입력해주세요.");
        if (rawPw == null || rawPw.trim().isEmpty())
            throw new IllegalArgumentException("비밀번호를 입력해주세요.");

        log.info("[{}] 로그인 - 유저 정보 조회 시작", email);
        MemberDTO user = signinMapper.selectUserById(email);
        log.info("[{}] 로그인 - 유저 정보 조회 종료", email);

        if (user == null) throw new IllegalArgumentException("존재하지 않는 아이디 입니다.");
        if (!passwordEncoder.matches(rawPw, user.getUserPw())) throw new IllegalArgumentException("아이디 또는 비밀번호가 틀립니다.");

        return user;
    }

    /**
     * 회원설문 완료 후 유저 레벨 등록
     *
     * @param userSeq Integer, level Integer
     */
    public void updateUserLevel(Integer userSeq, Integer level) {

        // userSeq로 유저를 찾은 후 level 등록
        log.info("[{}],[{}] 유저 레벨 등록 시작", userSeq, level);
        signinMapper.updateUserLevel(userSeq, level);
        log.info("[{}],[{}] 유저 레벨 등록 종료", userSeq, level);
    }
}
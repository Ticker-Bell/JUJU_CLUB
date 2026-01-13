package com.tickerbell.jujuclub.auth.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tickerbell.jujuclub.auth.dto.SignupDTO;
import com.tickerbell.jujuclub.auth.mapper.SignupMapper;

@Service
public class SignupServiceImpl implements SignupService {

    private final SignupMapper signupMapper;

    public SignupServiceImpl(SignupMapper signupMapper) {
        this.signupMapper = signupMapper;
    }

    @Override
    @Transactional
    public void signup(SignupDTO dto) {
        if (dto.getUserId() == null || dto.getUserId().trim().isEmpty())
            throw new IllegalArgumentException("이메일을 입력해주세요.");
        if (dto.getUserName() == null || dto.getUserName().trim().isEmpty())
            throw new IllegalArgumentException("닉네임을 입력해주세요.");
        if (dto.getUserPw() == null || dto.getUserPw().trim().isEmpty())
            throw new IllegalArgumentException("비밀번호를 입력해주세요.");

        if (signupMapper.existsByUserId(dto.getUserId()) > 0)
            throw new IllegalArgumentException("이미 사용중인 이메일 입니다.");
        if (signupMapper.existsByUserName(dto.getUserName()) > 0)
            throw new IllegalArgumentException("이미 사용중인 닉네임입니다.");

        signupMapper.insertUser(dto);
    }
}
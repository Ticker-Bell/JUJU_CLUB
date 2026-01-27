package com.tickerbell.jujuclub.auth.service;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberMapper memberMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    @Transactional(readOnly = true)
    public MemberDTO selectUserById(String userId) {
        return memberMapper.selectUserById(userId);
    }

    @Transactional
    public void updateProfile(String userId, String newName, String newPw) {
        MemberDTO updateDto = new MemberDTO();
        updateDto.setUserId(userId);

        if (StringUtils.hasText(newName)) updateDto.setUserName(newName);
        if (StringUtils.hasText(newPw)) updateDto.setUserPw(passwordEncoder.encode(newPw));

        if (StringUtils.hasText(newName) || StringUtils.hasText(newPw)) {
            memberMapper.updateUser(updateDto);
        }
    }

    @Transactional
    public void updateProfileImage(String userId, byte[] imageBytes) {
        MemberDTO updateDto = new MemberDTO();
        updateDto.setUserId(userId);
        updateDto.setUserImage(imageBytes);
        memberMapper.updateUser(updateDto);
    }

    public void withdraw(String userId, String inputPassword) {
        MemberDTO user = memberMapper.selectUserById(userId);
        if (user == null || !passwordEncoder.matches(inputPassword, user.getUserPw())) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }
        memberMapper.deleteUser(userId);
    }
}
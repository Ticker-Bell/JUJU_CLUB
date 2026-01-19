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
    private final BCryptPasswordEncoder passwordEncoder; //

    @Transactional
    public void updateProfile(String userId, String newName, String newPw) {
        MemberDTO updateDto = new MemberDTO();
        updateDto.setUserId(userId); // WHERE 절 기준

        // 닉네임 변경 로직 (값이 있을 때만 DTO에 세팅)
        if (StringUtils.hasText(newName)) {
            updateDto.setUserName(newName);
        }

        // 비밀번호 변경 로직 (값이 있을 때만 암호화 후 DTO에 세팅)
        if (StringUtils.hasText(newPw)) {
            String encodedPwd = passwordEncoder.encode(newPw);
            updateDto.setUserPw(encodedPwd);
        }

        // 3. 실제 DB 업데이트 수행
        // Mapper XML의 <if> 태그 덕분에:
        // - 닉네임만 있으면 -> 닉네임만 UPDATE
        // - 비번만 있으면 -> 비번만 UPDATE
        // - 둘 다 있으면 -> 둘 다 UPDATE
        // - 둘 다 없으면 -> 아무것도 안 함 (에러 방지 필요 시 체크 로직 추가 가능)
        if (StringUtils.hasText(newName) || StringUtils.hasText(newPw)) {
            memberMapper.updateUser(updateDto);
        }
    }

    // 기존 탈퇴 로직 유지
    public void withdraw(String userId, String inputPassword) {
        MemberDTO user = memberMapper.selectUserById(userId);
        if (user == null || !passwordEncoder.matches(inputPassword, user.getUserPw())) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }
        memberMapper.deleteUser(userId);
    }
}
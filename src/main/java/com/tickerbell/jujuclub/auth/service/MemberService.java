package com.tickerbell.jujuclub.auth.service;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberService {

    // BCrypt 해시 함수 기반 비밀번호 인코더
    private final BCryptPasswordEncoder passwordEncoder;
    private final MemberMapper memberMapper;

    /**
     * 유저 정보 조회 (userId)
     *
     * @param userId String
     * @return memberMapper.selectUserById(userId) MemberDTO
     */
    @Transactional
    public MemberDTO selectUserById(String userId) {
        return memberMapper.selectUserById(userId);
    }

    /**
     * 유저 정보 조회 (userSeq)
     *
     * @param userSeq int
     * @return memberMapper.selectUserBySeq(userSeq) MemberDTO
     */
    @Transactional
    public MemberDTO selectUserBySeq(int userSeq) {
        return memberMapper.selectUserBySeq(userSeq);
    }

    /**
     * 유저 정보 수정 (닉네임, 비밀번호)
     *
     * @param userId String
     * @return memberMapper.selectUserById(userId) MemberDTO
     */
    @Transactional
    public void updateProfile(String userId, String newName, String newPw) {
        MemberDTO updateDto = new MemberDTO();
        updateDto.setUserId(userId);

        if (StringUtils.hasText(newName)) updateDto.setUserName(newName);
        if (StringUtils.hasText(newPw)) updateDto.setUserPw(passwordEncoder.encode(newPw));

        if (StringUtils.hasText(newName) || StringUtils.hasText(newPw)) {
            log.info("[{}],[{}] 유저 정보 수정 - 유저 닉네임, 비밀번호 수정 시작", userId, newName);
            memberMapper.updateUser(updateDto);
            log.info("[{}],[{}] 유저 정보 수정 - 유저 닉네임, 비밀번호 수정 종료", userId, newName);
        }
    }

    /**
     * 유저 정보 수정 (이미지)
     *
     * @param userId String
     * @return memberMapper.selectUserById(userId) MemberDTO
     */
    @Transactional
    public void updateProfileImage(String userId, byte[] imageBytes) {
        MemberDTO updateDto = new MemberDTO();
        updateDto.setUserId(userId);
        updateDto.setUserImage(imageBytes);
        memberMapper.updateUser(updateDto);
    }

    /**
     * 유저 정보 삭제
     *
     * @param userId String
     * @return memberMapper.selectUserById(userId) MemberDTO
     */
    public void withdraw(String userId, String inputPassword) {
        MemberDTO user = memberMapper.selectUserById(userId);
        if (user == null || !passwordEncoder.matches(inputPassword, user.getUserPw())) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }
        memberMapper.deleteUser(userId);
    }
}
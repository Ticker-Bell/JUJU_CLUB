package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {

    /**
     * 레슨 CONCEPT 문항 조회 및 레슨 시작 정보 등록
     *
     * @param account AccountDTO
     * @return int
     */
    MemberDTO selectUserById(String userId);

    /**
     * 레슨 CONCEPT 문항 조회 및 레슨 시작 정보 등록
     *
     * @param account AccountDTO
     * @return int
     */
    MemberDTO selectUserBySeq(@Param("userSeq") int userSeq);

    /**
     * 레슨 CONCEPT 문항 조회 및 레슨 시작 정보 등록
     *
     * @param account AccountDTO
     * @return int
     */
    void deleteUser(String userId);

    /**
     * 유저 정보 수정(닉네임, 비밀번호, 프로필 이미지)
     *
     * @param memberDTO MemberDTO
     */
    void updateUser(MemberDTO memberDTO);

}

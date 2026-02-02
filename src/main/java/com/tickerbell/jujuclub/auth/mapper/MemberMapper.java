package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {

    /**
     * 유저 정보 조회 (userId)
     *
     * @param userId String
     * @return MemberDTO
     */
    MemberDTO selectUserById(String userId);

    /**
     * 유저 정보 조회 (userSeq)
     *
     * @param userSeq int
     * @return MemberDTO
     */
    MemberDTO selectUserBySeq(@Param("userSeq") int userSeq);

    /**
     * 유저 정보 삭제
     *
     * @param userId String
     */
    void deleteUser(String userId);

    /**
     * 유저 정보 수정
     *
     * @param memberDTO MemberDTO
     */
    void updateUser(MemberDTO memberDTO);

}

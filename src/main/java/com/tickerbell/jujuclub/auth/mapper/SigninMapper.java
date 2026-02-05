package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import com.tickerbell.jujuclub.auth.dto.SigninDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SigninMapper {

  /**
   * 닉네임 중복 확인
   *
   * @param userId String
   * @return MemberDTO
   */
  MemberDTO selectUserById(String userId);

  /**
   * 유저 레벨 등록
   *
   * @param userSeq Integer, level Integer
   */
  void updateUserLevel(@Param("userSeq") Integer userSeq, @Param("level") Integer level);
}
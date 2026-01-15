package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.SigninDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SigninMapper {
  SigninDTO selectUserById(String userId);

  void updateUserLevel(@Param("userSeq") int userSeq, @Param("level") int level);
}
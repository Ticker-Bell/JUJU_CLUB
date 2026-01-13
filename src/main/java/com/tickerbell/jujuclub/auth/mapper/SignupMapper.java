package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.SignupDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SignupMapper {
    int existsByUserName(String userName);
    int existsByUserId(String userId);
    int insertUser(SignupDTO dto);
}
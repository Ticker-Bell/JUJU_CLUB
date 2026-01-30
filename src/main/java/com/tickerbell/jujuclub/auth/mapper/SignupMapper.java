package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.SignupDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SignupMapper {

    /**
     * 닉네임 중복 확인
     *
     * @param userName String
     * @return int
     */
    int existsByUserName(String userName);

    /**
     * 이메일 중복 확인
     *
     * @param userId String
     * @return int
     */
    int existsByUserId(String userId);

    /**
     * 레슨 문항 조회
     *
     * @param signupDTO SignupDTO
     * @return int
     */
    int insertUser(SignupDTO signupDTO);
}
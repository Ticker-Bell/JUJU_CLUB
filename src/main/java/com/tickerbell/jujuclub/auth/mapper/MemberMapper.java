package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

    MemberDTO selectUserById(String userId);

    void deleteUser(String userId);
    void updateUser(MemberDTO memberDTO);

}

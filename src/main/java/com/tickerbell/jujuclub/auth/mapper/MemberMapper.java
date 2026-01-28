package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {

    MemberDTO selectUserById(String userId);
    MemberDTO selectUserBySeq(@Param("userSeq") int userSeq);
    void deleteUser(String userId);
    void updateUser(MemberDTO memberDTO);

}

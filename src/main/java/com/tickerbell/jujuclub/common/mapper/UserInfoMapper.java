package com.tickerbell.jujuclub.common.mapper;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserInfoMapper {
    UserInfoDTO userInfo(@Param("userSeq") int userSeq);
}

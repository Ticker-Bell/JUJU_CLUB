package com.tickerbell.jujuclub.common.service;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.common.mapper.UserInfoMapper;
import org.springframework.stereotype.Service;


@Service
public class UserInfoService {
 private final UserInfoMapper userInfoMapper;

    public UserInfoService(UserInfoMapper userInfoMapper) {
        this.userInfoMapper = userInfoMapper;
    }

    public UserInfoDTO getUserInfo(int userSeq){
     return userInfoMapper.userInfo(userSeq);
    }
}

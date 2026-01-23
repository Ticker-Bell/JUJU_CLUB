package com.tickerbell.jujuclub.common.service;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.common.mapper.UserInfoMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class UserInfoService {
 private final UserInfoMapper userInfoMapper;

    public UserInfoDTO getUserInfo(Integer userSeq){
     return userInfoMapper.userInfo(userSeq);
    }

    public void userLevelUpdate(Integer userSeq, String lessonId) {
        userInfoMapper.userLevelUpdate(userSeq,lessonId);
    }
}

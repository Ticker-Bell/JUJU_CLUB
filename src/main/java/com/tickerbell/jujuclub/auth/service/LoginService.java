package com.tickerbell.jujuclub.auth.service;

import com.tickerbell.jujuclub.auth.dto.LoginDTO;
import com.tickerbell.jujuclub.auth.mapper.LoginMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LoginService {

  private final LoginMapper loginMapper;

  public String login(LoginDTO loginDTO) {
    boolean success = loginMapper.checkUser(loginDTO) > 0;
    return success ? "로그인 성공" : "아이디 또는 비밀번호가 틀립니다.";
  }
}

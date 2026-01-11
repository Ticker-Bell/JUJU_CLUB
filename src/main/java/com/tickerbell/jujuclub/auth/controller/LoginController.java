package com.tickerbell.jujuclub.auth.controller;

import com.tickerbell.jujuclub.auth.dto.LoginDTO;
import com.tickerbell.jujuclub.auth.mapper.LoginMapper;
import com.tickerbell.jujuclub.auth.service.LoginService;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class LoginController {

  private final LoginService loginService;

  @GetMapping("/login")
  public String loginForm() {
    return "/auth/login";
  }

  @PostMapping("/login")
  public String login(@ModelAttribute LoginDTO loginDTO, Model model) {
    String message = loginService.login(loginDTO);
    model.addAttribute("msg", message);

    if ("로그인 성공".equals(message)) {
      return "home";
    } else {
      return "/auth/login";
    }
  }
}

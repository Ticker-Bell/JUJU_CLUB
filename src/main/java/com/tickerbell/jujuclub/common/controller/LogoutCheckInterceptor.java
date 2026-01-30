package com.tickerbell.jujuclub.common.controller;

import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();

        // 정반대 로직: 세션에 로그인 정보가 '있으면' 차단
        if (session.getAttribute("loginUser") != null && session.getAttribute("userLevel") != null) {
            // 이미 로그인한 사람이니 메인 페이지(또는 대시보드)로 쫓아냄
            // [주의] 로그인 후 이동하는 실제 메인 페이지 주소를 적으세요.
            // 예: /roadMap/main.do 또는 /main
            response.sendRedirect(request.getContextPath() + "/roadMap/main.do");
            return false; // 더 이상 컨트롤러로 가지 마라
        }

        // 로그인 안 했으면 통과 (로그인 페이지 볼 수 있음)
        return true;
    }
}
package com.tickerbell.jujuclub.common.controller;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.common.service.UserInfoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@RequiredArgsConstructor
public class HtmxLayoutInterceptor implements HandlerInterceptor {
    private final UserInfoService userInfoService;

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView mv) throws Exception {
        // 유효성 체크 (뷰가 없거나 리다이렉트인 경우 넘김)
        if (mv == null || mv.getViewName() == null) return;
        String viewName = mv.getViewName();
        if (viewName.startsWith("redirect:")) return;

        // Htmx 요청 확인 (header 체크)
        boolean isHtmx = request.getHeader("HX-Request") != null;

        // session 확인
        HttpSession session = request.getSession();
        Integer userSeq = (Integer) session.getAttribute("userSeq");
        UserInfoDTO userInfo = userInfoService.getUserInfo(userSeq);

        if (userInfo != null) {
            System.out.println("=== [Interceptor] userInfo 세션 저장 성공: " + userInfo.getUserSeq());
            session.setAttribute("user", userInfo);
        } else {
            System.out.println("=== [Interceptor] userInfo 조회 실패");
        }


        // Htxm 요청이 아닌 경우
        if (!isHtmx) {
            mv.addObject("targetPage", viewName);
            mv.setViewName("common/main");
        }
    }
}

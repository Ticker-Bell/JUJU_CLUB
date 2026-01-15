package com.tickerbell.jujuclub.common.controller;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HtmxLayoutInterceptor implements HandlerInterceptor {

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView mv) {
        // 유효성 체크 (뷰가 없거나 리다이렉트인 경우 넘김)
        if(mv == null || mv.getViewName() == null) return;
        String viewName = mv.getViewName();
        if(viewName.startsWith("redirect:")) return;

        // Htmx 요청 확인 (header 체크)
        boolean isHtmx = request.getHeader("HX-Request") != null;

        // Htxm 요청이 아닌 경우
        if(!isHtmx) {
            mv.addObject("targetPage", viewName);
            mv.setViewName("common/main");
        }
    }
}

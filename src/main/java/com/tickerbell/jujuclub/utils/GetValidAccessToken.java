package com.tickerbell.jujuclub.utils;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
public class GetValidAccessToken {
    private final RequestNewAccessToken requestNewToken;

    public String getValidToken(HttpServletRequest request) throws Exception {
        ServletContext application;
        application = request.getServletContext();

        String token = (String) application.getAttribute("API_TOKEN");
        LocalDateTime expireAt =
                (LocalDateTime) application.getAttribute("API_TOKEN_EXPIRE_AT");

        // 토큰이 없거나 만료된 경우
        if (token == null || expireAt == null || expireAt.isBefore(LocalDateTime.now())) {
            token = requestNewToken.getAccessToken();

            application.setAttribute("API_TOKEN", token);
            application.setAttribute(
                    "API_TOKEN_EXPIRE_AT",
                    LocalDateTime.now().plusHours(24)
            );
        }

        return token;
    }

}

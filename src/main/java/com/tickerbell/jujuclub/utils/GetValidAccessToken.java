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
    private final ServletContext servletContext;

    public String getValidToken() throws Exception {

        String token = (String) servletContext.getAttribute("API_TOKEN");
        LocalDateTime expireAt =
                (LocalDateTime) servletContext.getAttribute("API_TOKEN_EXPIRE_AT");

        // 토큰이 없거나 만료된 경우
        if (token == null || expireAt == null || expireAt.isBefore(LocalDateTime.now())) {
            token = requestNewToken.getAccessToken();

            servletContext.setAttribute("API_TOKEN", token);
            servletContext.setAttribute(
                    "API_TOKEN_EXPIRE_AT",
                    LocalDateTime.now().plusHours(6)
            );
        }

        return token;
    }

}

package com.tickerbell.jujuclub.utils;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
public class GetValidApprovalKey {
    private final RequestNewApprovalKey requestNewApprovalKey;
    private final ServletContext servletContext;

    public synchronized String getValidApprovalKey() throws Exception {

        String key = (String)servletContext.getAttribute("APPROVAL_KEY");
        LocalDateTime expireAt = (LocalDateTime)servletContext.getAttribute("APPROVAL_KEY_EXPIRE_AT");

        // 키가 없거나 만료된 경우
        if (key == null || expireAt == null || expireAt.isBefore(LocalDateTime.now())) {
            key = requestNewApprovalKey.getApprovalKey();

            servletContext.setAttribute("APPROVAL_KEY", key);
            servletContext.setAttribute("APPROVAL_KEY_EXPIRE_AT", LocalDateTime.now().plusHours(24));
        }

        return key;
    }
}

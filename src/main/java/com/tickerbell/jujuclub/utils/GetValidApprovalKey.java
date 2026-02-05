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

    /**
     * Application scope에 저장된 approval key (Web socket 연결에 사용) 가져오기
     * 없거만 만료되면 새로 발급
     *
     * @return String
     * @throws Exception
     */
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

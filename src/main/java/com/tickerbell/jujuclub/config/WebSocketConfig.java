package com.tickerbell.jujuclub.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.*;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    public void configureMessageBroker(MessageBrokerRegistry config) {
        //특정 채널 구독 & 메시지 행선지 결정
        config.enableSimpleBroker("/topic"); //서버->클라이언트
        config.setApplicationDestinationPrefixes("/app"); //클라이언트->서버
    }

    public void registerStompEndpoints(StompEndpointRegistry registry) {
        //클라이언트 접속을 위한 엔드포인트 설정
        registry.addEndpoint("/ws-jujuclub").withSockJS();
    }
}

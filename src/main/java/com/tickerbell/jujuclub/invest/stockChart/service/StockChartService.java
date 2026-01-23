package com.tickerbell.jujuclub.invest.stockChart.service;

import com.tickerbell.jujuclub.invest.stockChart.dto.StockChartDTO;
import com.tickerbell.jujuclub.utils.StockChartFormatter;
import com.tickerbell.jujuclub.utils.StockChartParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.client.WebSocketClient;
import org.springframework.web.socket.client.standard.StandardWebSocketClient;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class StockChartService {
    private WebSocketSession externalSession = null; //
    private final Set<String> subscribedCodes = Collections.synchronizedSet(new HashSet<>());

    private final SimpMessagingTemplate messagingTemplate;
    private final StockChartParser stockChartParser;
    private final String APPROVAL_KEY = "5622cc60-8a75-4bbb-845a-9f70babcc1bd";

    public synchronized void connectToStockChartApi(String trType, List<String> stockCodeList) {
        //세션이 없거나 닫혀있으면 연결
        if (externalSession == null || !externalSession.isOpen()) {
            initConnection(stockCodeList);
        } else if (trType.equals("1")) {
            //구독 요청
            for (String stockCode : stockCodeList) {
                if (!subscribedCodes.contains(stockCode)) {
                    sendSubscribeMessage(externalSession, stockCode);
                }
            }
        } else if (trType.equals("2")) {
            //구독 해제
            for (String stockCode : stockCodeList) {
                sendUnsubscribeMessage(externalSession, stockCode);
            }
        }
    }

    private void initConnection(List<String> stockCodeList) {
        WebSocketClient client = new StandardWebSocketClient();
        String externalUrl = "ws://ops.koreainvestment.com:21000/tryitout/H0STCNT0";

        client.doHandshake(new TextWebSocketHandler() {
            @Override
            public void afterConnectionEstablished(WebSocketSession session) throws Exception {
                externalSession = session;
                for (String stockCode : stockCodeList) {
                    sendSubscribeMessage(session, stockCode);
                }
            }

            @Override
            protected void handleTextMessage(WebSocketSession session, TextMessage message) {
                String chartData = message.getPayload();

                // [추가] JSON 응답(성공 메시지 등)이면 파싱하지 않고 로그만 남긴 뒤 종료
                if (chartData.startsWith("{") || chartData.startsWith("[")) {
                    log.info("수신된 설정 메시지: {}", chartData);
                    return;
                }

                log.info("실시간 데이터 수신: {}", chartData);
                try {
                    List<StockChartDTO> chartDTOList = stockChartParser.parseStockChart(chartData);

                    if (chartDTOList != null) {
                        for (StockChartDTO stockChartDTO : chartDTOList) {
                            messagingTemplate.convertAndSend("/topic/stock/" + stockChartDTO.getStockCode(), stockChartDTO);
                        }
                    }
                } catch (Exception e) {
                    log.error("데이터 파싱 중 예상치 못한 에러 발생: {}", e.getMessage());
                    log.debug("에러 발생 데이터: {}", chartData);
                }
            }

            public void handleTransportError(WebSocketSession session, Throwable exception) {
                log.error("외부 API 통신 에러: " + exception.getMessage());
            }

            public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
                log.warn("외부 API 연결 종료. 재연결 로직이 필요합니다.");
            }
        }, externalUrl);

    }

    private void sendSubscribeMessage(WebSocketSession session, String stockCode) {
        try {
            String subscribeMessage = String.format(
                    "{\"header\":{\"approval_key\":\"%s\",\"custtype\":\"P\",\"tr_type\":\"1\",\"content-type\":\"utf-8\"}," +
                            "\"body\":{\"input\":{\"tr_id\":\"H0STCNT0\",\"tr_key\":\"%s\"}}}", APPROVAL_KEY, stockCode);


            session.sendMessage(new TextMessage(subscribeMessage));
            subscribedCodes.add(stockCode);
            log.info("종목 구독: {}", stockCode);

            messagingTemplate.convertAndSend("/topic/stock/" + stockCode,
                    Map.of("stockCode", stockCode, "status", "Init", "message", "데이터 로드 시작"));
        } catch (Exception e) {
            log.error("구독 전송 에러 ({}) : {}", stockCode, e.getMessage());
        }
    }

    private void sendUnsubscribeMessage(WebSocketSession session, String stockCode) {
        try {
            String subscribeMessage = String.format(
                    "{\"header\":{\"approval_key\":\"%s\",\"custtype\":\"P\",\"tr_type\":\"2\",\"content-type\":\"utf-8\"}," +
                            "\"body\":{\"input\":{\"tr_id\":\"H0STCNT0\",\"tr_key\":\"%s\"}}}", APPROVAL_KEY, stockCode);


            session.sendMessage(new TextMessage(subscribeMessage));
            subscribedCodes.remove(stockCode);
            log.info("종목 구독 취소: {}", stockCode);

            messagingTemplate.convertAndSend("/topic/stock/" + stockCode,
                    Map.of("stockCode", stockCode, "status", "UnSubscribe", "message", "구독 해제 완료"));
        } catch (Exception e) {
            log.error("구독 취소 전송 에러 ({}) : {}", stockCode, e.getMessage());
        }
    }

}

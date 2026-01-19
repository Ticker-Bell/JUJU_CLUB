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

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class StockChartService {
    private final SimpMessagingTemplate messagingTemplate;
    private final StockChartParser stockChartParser;
    private final String APPROVAL_KEY = "062fab1b-3a3c-48da-b666-d3a57042db77             ";

    public void connectToStockChartApi(String stockCode) {
        WebSocketClient client = new StandardWebSocketClient();
        String externalUrl = "ws://ops.koreainvestment.com:21000/tryitout/H0STCNT0";

        client.doHandshake(new TextWebSocketHandler() {
            @Override
            public void afterConnectionEstablished(WebSocketSession session) throws Exception {
                String subscribeMessage = String.format(
                        "{\"header\":{\"approval_key\":\"%s\",\"custtype\":\"P\",\"tr_type\":\"1\",\"content-type\":\"utf-8\"}," +
                                "\"body\":{\"input\":{\"tr_id\":\"H0STCNT0\",\"tr_key\":\"%s\"}}}", APPROVAL_KEY, stockCode);


                session.sendMessage(new TextMessage(subscribeMessage));
                log.info("외부 API에 종목 구독 요청전송: {}", stockCode);
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
}

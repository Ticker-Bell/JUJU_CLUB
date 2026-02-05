package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.StockChartDTO;
import com.tickerbell.jujuclub.utils.GetValidApprovalKey;
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
    private final GetValidApprovalKey getValidApprovalKey;

    private String approvalKey = null;

    /**
     * 주식 차트 웹소켓 API 연결 및 구독 관리 서비스
     *
     * @param trType String
     * @param stockCodeList List<String>
     */
    public synchronized void connectToStockChartApi(String trType, List<String> stockCodeList) throws Exception {
        //세션이 없거나 닫혀있으면 연결
        if (externalSession == null || !externalSession.isOpen()) {
            initConnection(stockCodeList);
        } else if (trType.equals("1")) {
            //구독 요청
            for (String stockCode : stockCodeList) {
                //구독하지 않았을 때
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

    /**
     * 주식 차트 웹소켓 API 최초 연결 서비스
     *
     * @param stockCodeList List<String>
     */
    private void initConnection(List<String> stockCodeList) {
        WebSocketClient client = new StandardWebSocketClient();
        String externalUrl = "ws://ops.koreainvestment.com:21000/tryitout/H0STCNT0";

        client.doHandshake(new TextWebSocketHandler() {
            /**
             * 웹소켓 연결 후 구독 메시지 전송 서비스
             *
             * @param session WebSocketSession
             */
            @Override
            public void afterConnectionEstablished(WebSocketSession session){
                externalSession = session;
                for (String stockCode : stockCodeList) {
                    try {
                        sendSubscribeMessage(session, stockCode);
                    } catch (Exception e) {
                        log.error("웹소켓 연결 후 구독 메시지 전송 서비스 중 오류 발생");
                        throw new RuntimeException(e);
                    }
                }
            }

            /**
             * 받은 웹소켓 메시지 처리, 파싱 및 구독 중인 클라이언트에게 전송 서비스
             *
             * @param session WebSocketSession
             * @param message TextMessage
             */
            @Override
            protected void handleTextMessage(WebSocketSession session, TextMessage message) {
                String chartData = message.getPayload();

                //JSON 응답(성공 메시지 등)이면 파싱하지 않고 로그만 남긴 뒤 종료
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
                    log.error("웹소켓 데이터 파싱 중 오류 발생: {}", e.getMessage());
                    log.debug("에러 발생 데이터: {}", chartData);
                }
            }

            /**
             * 웹소켓 API 통신 에러 처리
             *
             * @param session WebSocketSession
             * @param exception Throwable
             */
            public void handleTransportError(WebSocketSession session, Throwable exception) {
                log.error("외부 API 통신 에러: " + exception.getMessage());
            }

            /**
             * 웹소켓 API 연결 해제 후 메시지 출력
             *
             * @param session WebSocketSession
             * @param status CloseStatus
             */
            public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
                log.warn("외부 API 연결 종료. 재연결 로직이 필요합니다.");
            }
        }, externalUrl);

    }

    /**
     * 웹소켓 구독 메시지 생성 서비스
     *
     * @param session WebSocketSession
     * @param stockCode String
     */
    private void sendSubscribeMessage(WebSocketSession session, String stockCode){
        try {
            approvalKey = getValidApprovalKey.getValidApprovalKey();
            String subscribeMessage = String.format(
                    "{\"header\":{\"approval_key\":\"%s\",\"custtype\":\"P\",\"tr_type\":\"1\",\"content-type\":\"utf-8\"}," +
                            "\"body\":{\"input\":{\"tr_id\":\"H0STCNT0\",\"tr_key\":\"%s\"}}}", approvalKey, stockCode);


            session.sendMessage(new TextMessage(subscribeMessage));
            subscribedCodes.add(stockCode);
            log.info("종목 구독: {}", stockCode);

            messagingTemplate.convertAndSend("/topic/stock/" + stockCode,
                    Map.of("stockCode", stockCode, "status", "Init", "message", "데이터 로드 시작"));
        } catch (Exception e) {
            log.error("구독 전송 에러 ({}) : {}", stockCode, e.getMessage());
            throw new RuntimeException(e);
        }
    }

    /**
     * 웹소켓 구독 해제 메시지 생성 서비스
     *
     * @param session WebSocketSession
     * @param stockCode String
     */
    private void sendUnsubscribeMessage(WebSocketSession session, String stockCode) {

        try {
            approvalKey = getValidApprovalKey.getValidApprovalKey();
            String subscribeMessage = String.format(
                    "{\"header\":{\"approval_key\":\"%s\",\"custtype\":\"P\",\"tr_type\":\"2\",\"content-type\":\"utf-8\"}," +
                            "\"body\":{\"input\":{\"tr_id\":\"H0STCNT0\",\"tr_key\":\"%s\"}}}", approvalKey, stockCode);


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

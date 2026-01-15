package com.tickerbell.jujuclub.invest.stockList.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.invest.stockList.dto.RankingDTO;
import com.tickerbell.jujuclub.invest.stockList.dto.StockDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class RankingApiService {

    private static final String APP_KEY = "PSEwye9EwwaHCT6TlEJBejuGmtuDmsZRLsTP";
    private static final String APP_SECRET = "1Zxqr/7cOzLRg7nEsU2BJM8rSekIxQPnvCcUcxoPVGexTHQyDSiMXaYlGmGAkJYi/s7bWUdWI9H4gETBWiNyl4j5gfuiz7NuVEKi6vTTNL3ptWfBXQFe5cesH35tmEnPuSKWZ8U8++HM0LF+GQxQ9nZtRWZX0MR1CDQuUStqIHd4ase/mhQ=";
    private static final String URL_BASE = "https://openapi.koreainvestment.com:9443";

    private String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6IjllOGFkMTk1LTM3NWUtNDhhYS1iNDBhLTk0YWQ2NjgyYjhkZiIsInByZHRfY2QiOiIiLCJpc3MiOiJ1bm9ndyIsImV4cCI6MTc2ODU1NDI4MCwiaWF0IjoxNzY4NDY3ODgwLCJqdGkiOiJQU0V3eWU5RXd3YUhDVDZUbEVKQmVqdUdtdHVEbXNaUkxzVFAifQ.4-D8h1xZJMMVCBOQLA5crEh0CT7ovrUSmEmxWmFstD3pAcawzWx-gTuk787Ry1rQkewhykiLVAteLhP_QI7iQg";

    @Autowired
    private RestTemplate restTemplate;

    private final ObjectMapper mapper = new ObjectMapper();

//    // accessToken 발급
//    public void getAccessToken() {
//        try{
//            String url = URL_BASE + "/oauth2/tokenP";
//
//            // 헤더 설정
//            HttpHeaders headers = new HttpHeaders();
//
//            // 바디 설정 (Map을 쓰면 JSON으로 자동 변환됨)
//            Map<String, String> body = new HashMap<>();
//            body.put("grant_type", "client_credentials");
//            body.put("appkey", APP_KEY);
//            body.put("appsecret", APP_SECRET);
//
//            // 요청 보내기(POST)
//            HttpEntity<Map<String, String>> request = new HttpEntity<>(body, headers);
//            ResponseEntity<JsonNode> response = restTemplate.postForEntity(url, request, JsonNode.class);
//
//            // 응답 파싱 및 토큰 저장
//            JsonNode root = response.getBody();
//            this.accessToken = root.path("access_token").asText();
//
//        } catch (Exception e){
//            e.printStackTrace();
//            log.info("토큰 발급 실패");
//        }
//    }

    public List<RankingDTO> getTradingVolumeRanking(){

        // 토큰이 없으면 발급 시도
//        if (this.accessToken == null || this.accessToken.isEmpty()) {
//            getAccessToken();
//        }

        try{
            // URL 및 쿼리 파라미터 설정
            URI uri = UriComponentsBuilder.fromHttpUrl(URL_BASE)
                    .path("/uapi/domestic-stock/v1/quotations/volume-rank")
                    .queryParam("FID_COND_MRKT_DIV_CODE", "J")
                    .queryParam("FID_COND_SCR_DIV_CODE", "20171")
                    .queryParam("FID_INPUT_ISCD", "0000")
                    .queryParam("FID_DIV_CLS_CODE", "0")
                    .queryParam("FID_BLNG_CLS_CODE", "0")
                    .queryParam("FID_TRGT_CLS_CODE", "111111111")
                    .queryParam("FID_TRGT_EXLS_CLS_CODE", "1111101111")
                    .queryParam("FID_INPUT_PRICE_1", "")
                    .queryParam("FID_INPUT_PRICE_2", "")
                    .queryParam("FID_VOL_CNT", "")
                    .queryParam("FID_INPUT_DATE_1", "")
                    .build()
                    .toUri();

            // 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.set("content-type", "application/json; charset=utf-8");
            headers.set("authorization", "Bearer " + this.accessToken);
            headers.set("appkey", APP_KEY);
            headers.set("appsecret", APP_SECRET);
            headers.set("tr_id", "FHPST01710000");
            headers.set("custtype", "P");

            // 요청 엔티티 생성 (GET이라 Body는 null)
            HttpEntity<Void> request = new HttpEntity<>(headers);

            // 호출 (GET)
            ResponseEntity<JsonNode> response = restTemplate.exchange(uri, HttpMethod.GET, request, JsonNode.class);

            // 결과 확인 및 로직 처리
            JsonNode root = response.getBody();

            String rtCd = root.path("rt_cd").asText();  //성공 여부 코드
            String msgCd = root.path("msg_cd").asText();  //메세지 코드

            if(response.getStatusCode() == HttpStatus.OK && "0".equals(rtCd)){
                // 정상 성공
                // output에는 순위별로 JSON데이터가 여러개 존재
                return JsonToDto(root.path("output"));
            }
//            else if ("EGW00123".equals(msgCd)){
//                System.out.println("토큰 만료됨. 재발급 후 다시 시도");
//                getAccessToken();
//                return getTradingVolumeRanking();
//            }
            else{
                System.out.println("Error Code: " + response.getStatusCode());
                return null;
            }

        } catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    private List<RankingDTO> JsonToDto(JsonNode node){
        //JsonNode 안에 Json 배열이 랭킹 순으로 들어가 있음
        //각 Json을 DTO로 변환

        List<RankingDTO> rankingDTOList = new ArrayList<>();

        for(JsonNode item : node){
            RankingDTO rankingDTO = RankingDTO.builder()
                    .stockName(item.path("hts_kor_isnm").asText())
                    .stockCode(item.path("mksc_shrn_iscd").asText())
                    .rank(item.path("data_rank").asInt())
                    .build();
            rankingDTOList.add(rankingDTO);
        }

        return rankingDTOList;
    }

}

package com.tickerbell.jujuclub.invest.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.invest.dto.KISCorpInfoDTO;
import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.utils.RequestNewAccessToken;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;


@RequiredArgsConstructor
@Service
public class KISApiService {

    //토큰 재사용 로직
    private final RequestNewAccessToken requestNewAccessToken;

    //RestTemplate
    private final RestTemplate restTemplate;

    @Value("${kis.appkey}")
    private String APP_KEY;

    @Value("${kis.appsecret}")
    private String APP_SECRET;

    @Value("${kis.baseurl}")
    private String BASE_URL;

    public KISDataDTO getPriceData(String stockCode){
        try{
            //토큰 재사용하기
            String token = requestNewAccessToken.getAccessToken();
            //RestTemlplate으로 변경
            //주소 : (REST 주식현재가 시세[v1_국내주식-008] 사용)
            String url = BASE_URL
                    + "/uapi/domestic-stock/v1/quotations/inquire-price"
                    + "?FID_COND_MRKT_DIV_CODE=J"
                    + "&FID_INPUT_ISCD="
                    + stockCode;
            //Uri : 주소에 특수문자가 들어가도 안전하게 변환
            URI uri = new URI(url);
            //헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.set("authorization", "Bearer " + token); //Bearer 공백필수
            headers.set("appkey", APP_KEY);
            headers.set("appsecret", APP_SECRET);
            headers.set("tr_id", "FHKST01010100");
            headers.setContentType(MediaType.APPLICATION_JSON); //Json형식을 보내라고 하는것

            //요청보내기
            HttpEntity<String> request = new HttpEntity<>(headers);
            //exchange : 주소, 방식, 요청데이터, 받을 타입(KIS가 Json객체를 보낸다.)
            //RestTemplate.exchange() 메소드 실행 시 connect() ~ disconnect() 전부 처리
            ResponseEntity<JsonNode> response = restTemplate.exchange(uri, HttpMethod.GET, request, JsonNode.class);

            //파싱
//            {  <-- 여기가 "root"
//                "rt_cd": "0", "msg1": "정상처리",
//                    "output": {  <-- 여기가 "output"
//                        "stck_prpr": "6010",  <-- (현재가)
//                        "per": "13.43"
//                    }
//            }
            JsonNode root = response.getBody(); //json으로 받아와서 readTree안하고 바로 꺼내기
            //path는 없으면 null 을 주는게 아니라 비어있는 노드를 줘서 에러 검증이 필요 없다.
            JsonNode output = root.path("output");
            if(output.isMissingNode() || output.isNull()){
                System.out.println("[KISApiService] 현제가 데이터 없음. " + stockCode);
            }
            //output 안에서 원하는 부분만 저장
            String currentPriceStr = output.path("stck_prpr").asText("0"); //주식현재가:stck-prpr
            int currentPrice = Integer.parseInt(currentPriceStr.replace(",","")); //값이 없다면 0 반환, 혹시 모를 ,제거
            String priceRate = output.path("prdy_ctrt").asText(); //등락률:prdy_ctrt
            String priceSign = output.path("prdy_vrss_sign").asText(); //등락 부호:prdy_vrss_sign

            System.out.println("현재가 데이터 : " + currentPrice + " 등락률 : " + priceRate + " 부호 : " + priceSign);
            //
            return new KISDataDTO(currentPrice, priceRate, priceSign);

        } catch (Exception e) {
            System.out.println("API 호출 에러: " + e.getMessage());
            return new KISDataDTO(0, "0", "3"); //안전한 기본값 반환
        }
    }

    //현재가 조회 : 토큰 준비, KIS API 호출(토큰 + 종목코드), 응답에서 추출
    //등락률
    //등락부호
    public KISDataDTO getPriceData2(String stockCode) {

        HttpURLConnection conn = null;

        try {
            //토큰가져오기
            String token = requestNewAccessToken.getAccessToken();

            //URL만들기(REST 주식현재가 시세[v1_국내주식-008] 사용)
            String urlStr = BASE_URL
                    + "/uapi/domestic-stock/v1/quotations/inquire-price"
                    + "?FID_COND_MRKT_DIV_CODE=J"
                    + "&FID_INPUT_ISCD="
                    + stockCode;
            URL url = new URL(urlStr);

            //연결설정
            conn = (HttpURLConnection) url.openConnection();

            //데이터받는방식
            conn.setRequestMethod("GET");

            //헤더
            conn.setRequestProperty("authorization", "Bearer " + token); //Bearer 공백필수
            conn.setRequestProperty("appkey", APP_KEY);
            conn.setRequestProperty("appsecret", APP_SECRET);
            conn.setRequestProperty("tr_id", "FHKST01010100"); //현재가

            //응답받기
            StringBuilder response = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null) response.append(line);
            }
            //데이터 추출, 파싱
            String json = response.toString();

            int priceStart = json.indexOf("\"stck_prpr\":\"") + 13; //주식현재가:stck-prpr
            int priceEnd = json.indexOf("\"", priceStart);
            String priceStr = json.substring(priceStart, priceEnd);
            int currentPrice = Integer.parseInt(priceStr);
            System.out.println("현재가 데이터 : " + currentPrice);

            int rateStart = json.indexOf("\"prdy_ctrt\":\"") + 13; //등락률:prdy_ctrt
            int rateEnd = json.indexOf("\"", rateStart);
            String priceRate = json.substring(rateStart, rateEnd);

            int signStart = json.indexOf("\"prdy_vrss_sign\":\"") + 18; //등락 부호:prdy_vrss_sign
            int signEnd = json.indexOf("\"", signStart);
            String priceSign = json.substring(signStart, signEnd);

            //DTO리턴
            return new KISDataDTO(currentPrice, priceRate, priceSign);
        } catch (Exception e) {
            System.out.println("API 호출 에러 " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }

    }

    private static final ObjectMapper objectMapper = new ObjectMapper();

    //시가총액 hts_avls
    //52주 최고/최저 w_52_hgpr / w_52_lwpr
    //상장 주식 수 lstn_stcn
    //PER per, PBR pbr
    //EPS eps, BPS bps
    public KISCorpInfoDTO getCorpInfoData(String stockCode) {
        HttpURLConnection conn = null;
        try {
            //토큰얻기
            String token = requestNewAccessToken.getAccessToken();
            //주소 설정
            String urlStr = BASE_URL
                    + "/uapi/domestic-stock/v1/quotations/inquire-price"
                    + "?FID_COND_MRKT_DIV_CODE=J"
                    + "&FID_INPUT_ISCD="
                    + stockCode;

            URL url = new URL(urlStr);
            //API 발급 접근 HTTP프로토콜,
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            //헤더설정
            conn.setRequestProperty("authorization", "Bearer " + token);
            conn.setRequestProperty("appkey", APP_KEY);
            conn.setRequestProperty("appsecret", APP_SECRET);
            conn.setRequestProperty("tr_id", "FHKST01010100");

            //응답받기
            StringBuilder response = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
            }
            //JSON -> 자바객체
            String json = response.toString();
            System.out.println("KIS api 기업정보 응답" + json);

            //Jackson 사용
            //JSON 전체를 JsonNode로
            JsonNode root = objectMapper.readTree(json);
            //output만 추출
            JsonNode outputData = root.path("output");
            if (outputData.isMissingNode() || outputData.isNull()) {
                System.out.println("KIS응답에 output이 없습니다. stockCode = " + stockCode);
                return null;
            }

            //DTO에 담기
            String outputDataJson = outputData.toString();
            //매칭
            KISCorpInfoDTO kisCorpInfoDTO = objectMapper.readValue(outputDataJson, KISCorpInfoDTO.class);

            return kisCorpInfoDTO;

        } catch (Exception e) {
            System.out.println("기업정보 API 호출 에러: " + e.getMessage());
            e.printStackTrace();
            //에러시 빈 DTO 보내주기 - NullPointerException 방지
            return new KISCorpInfoDTO();

        } finally {
            if (conn != null) {
                conn.disconnect(); //끊어주기
            }
        }
    }

}

package com.tickerbell.jujuclub.invest.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.invest.dto.KISCorpInfoDTO;
import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.utils.RequestNewAccessToken;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@RequiredArgsConstructor
@Service
public class KISApiService {

    private final RequestNewAccessToken requestNewAccessToken;

    @Value("${kis.appkey}")
    private String APP_KEY;

    @Value("${kis.appsecret}")
    private String APP_SECRET;

    @Value("${kis.baseurl}")
    private String BASE_URL;

    //현재가 조회 : 토큰 준비, KIS API 호출(토큰 + 종목코드), 응답에서 추출
    //등락률
    //등락부호
    public KISDataDTO getPriceData(String stockCode) {

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
    public KISCorpInfoDTO getCorpInfoData(String stockCode) {
        HttpURLConnection conn = null;
        try {
            //토큰얻기
            String token = requestNewAccessToken.getAccessToken();

            String urlStr = BASE_URL
                    + "/uapi/domestic-stock/v1/quotations/inquire-price"
                    + "?FID_COND_MRKT_DIV_CODE=J"
                    + "&FID_INPUT_ISCD="
                    + stockCode;

            URL url = new URL(urlStr);
            //API 발급 접근 HTTP프로토콜
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

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

            //JSON -> DTO
            String outputDataJson = outputData.toString();
            KISCorpInfoDTO kisCorpInfoDTO = objectMapper.readValue(outputDataJson, KISCorpInfoDTO.class);

            return kisCorpInfoDTO;

        } catch (Exception e) {
            System.out.println("기업정보 API 호출 에러: " + e.getMessage());
            e.printStackTrace();
            return null;

        } finally {
            if (conn != null) {
                conn.disconnect(); //끊어주기
            }
        }
    }

}

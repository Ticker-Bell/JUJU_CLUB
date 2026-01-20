package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class KISApiService {

    @Value("${kis.appkey}")
    private String APP_KEY;

    @Value("${kis.appsecret}")
    private String APP_SECRET;

    @Value("${kis.baseurl}")
    private String BASE_URL;

    //토큰은 재사용하기
    private String accessToken = null;
    private long tokenExpireTime = 0; //만료시간(토큰 발급시 같이 들어옴)

    public String getAccessToken() throws Exception {

        //토근이 발급됐다면 다시 사용
        if (accessToken != null && System.currentTimeMillis() < tokenExpireTime - 60000) {
            return accessToken;
        }

        HttpURLConnection conn = null;

        try{
            //토큰 발급 요청 보낼 주소
            URL url = new URL(BASE_URL + "/oauth2/tokenP");

            //연결
            conn = (HttpURLConnection) url.openConnection();

            //데이터보내는방식
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            //보낼 데이터
            String requestBody = "{"
                    + "\"grant_type\": \"client_credentials\","
                    + "\"appkey\": \"" + APP_KEY + "\","
                    + "\"appsecret\": \"" + APP_SECRET + "\""
                    + "}";

            //데이터 전송
            try(OutputStream os = conn.getOutputStream()){
                os.write(requestBody.getBytes("UTF-8"));
            }

            //응답 받기
            StringBuilder response = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null){
                    response.append(line);
                }
            }

            //토큰 추출
            String jsonResponse = response.toString();
            int startIndex = jsonResponse.indexOf("\"access_token\":\"") + 16;
            int endIndex = jsonResponse.indexOf("\"", startIndex);
            accessToken = jsonResponse.substring(startIndex, endIndex);
            //토큰 만료시간 가져오기
            int expiresKey = jsonResponse.indexOf("\"expires_in\":");
            if (expiresKey != -1) {
                int startExpires = expiresKey + 13; //expires_in:길이13칸
                int endExpires = jsonResponse.indexOf(",", startExpires);
                if (endExpires == -1) {
                    endExpires = jsonResponse.indexOf("}", startExpires);
                }
                //시간 추출
                String expiresTimeStr = jsonResponse.substring(startExpires, endExpires).trim();
                long expiresTime = Long.parseLong(expiresTimeStr);//사용가능시간
                tokenExpireTime = System.currentTimeMillis() + (expiresTime * 1000); //만료시간

                System.out.println("토큰발급완료");
            } else {
                tokenExpireTime = System.currentTimeMillis() + (86400 * 1000); //못찾을경우 기본값 처리
            }
            return accessToken;
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    //현재가 조회 : 토큰 준비, KIS API 호출(토큰 + 종목코드), 응답에서 추출
    //등락률
    //등락부호
    public KISDataDTO getPriceData(String stockCode) {

        HttpURLConnection conn = null;

        try {
            //토큰가져오기
            String token = getAccessToken();

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
            if(conn != null){
                conn.disconnect();
            }
        }

    }

}

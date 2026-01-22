package com.tickerbell.jujuclub.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class RequestNewAccessToken {
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

}

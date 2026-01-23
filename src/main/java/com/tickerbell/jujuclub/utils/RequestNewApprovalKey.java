package com.tickerbell.jujuclub.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class RequestNewApprovalKey {
    @Value("${kis.appkey}")
    private String APP_KEY;

    @Value("${kis.appsecret}")
    private String APP_SECRET;

    @Value("${kis.baseurl}")
    private String BASE_URL;

    private String approvalKey = null;

    public String getApprovalKey() throws Exception {

        HttpURLConnection conn = null;

        try{
            URL url = new URL(BASE_URL + "/oauth2/Approval");

            // 연결
            conn = (HttpURLConnection) url.openConnection();

            // 데이터 보내는 방식
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // 보낼 데이터
            String requestBody = "{"
                    + "\"grant_type\": \"client_credentials\","
                    + "\"appkey\": \"" + APP_KEY + "\","
                    + "\"secretkey\": \"" + APP_SECRET + "\""
                    + "}";

            // 데이터 전송
            try(OutputStream os = conn.getOutputStream()) {
                os.write(requestBody.getBytes("UTF-8"));
            }

            // 응답 받기
            StringBuilder response = new StringBuilder();
            try(BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
            }

            // 토큰 추출
            String jsonResponse = response.toString();
            int startIndex = jsonResponse.indexOf("\"approval_key\":\"") + 16;
            int endIndex = jsonResponse.indexOf("\"", startIndex);
            approvalKey = jsonResponse.substring(startIndex, endIndex);

            return approvalKey;
        }finally {
            if(conn != null){
                conn.disconnect();
            }
        }

    }
}

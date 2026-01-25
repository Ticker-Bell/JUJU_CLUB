package com.tickerbell.jujuclub.invest.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.mapper.CodeMappingMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;

@RequiredArgsConstructor
@Service
public class DARTApiService {

    private static final ObjectMapper objectMapper = new ObjectMapper();
    private final CodeMappingMapper mapping;

    private final KISApiService kisApiService;

    //https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS002&apiId=2019005
    //GET : https://opendart.fss.or.kr/api/alotMatter.json

    @Value("${dart.appkey}")
    private String APP_KEY;
    //배당
    private String BASE_URL = "https://opendart.fss.or.kr/api/alotMatter.json";
    //재무제표


    //사업보고서 년도 계산
    public String getBsnsYear(){
        //사업보고서는 매년 3월 말까지 제출
        //3월 말을 기준으로 1~3월은 현재년도 -2, 4~12월 -1
        LocalDateTime now = LocalDateTime.now();
        int currentYear = now.getYear();
        int currentMonth = now.getMonthValue();

        if(currentMonth < 4){
            return String.valueOf(currentYear-2);
        } else {
            return String.valueOf(currentYear-1);
        }
    }

    public double getDividendPerShare(String stockCode){

        long dividend = 0L; //배당금
        double dividendPerShare = 0L; //배당 수익률 - 1주당 배당금 / 주가

        //KIS의 현재 주가
        String corpCode = mapping.selectCorpCode(stockCode);
        KISDataDTO kisDataDTO = kisApiService.getPriceData(stockCode);
        int currentPrice = (kisDataDTO != null) ? kisDataDTO.getCurrentPrice() : 0;

        //사업보고서 년도
        String bsns_year = getBsnsYear();

        HttpURLConnection conn = null;

        try{
            String urlStr = BASE_URL
                    + "?crtfc_key=" + APP_KEY
                    + "&corp_code=" + corpCode
                    + "&bsns_year=" + bsns_year
                    + "&reprt_code=11011";

            URL url = new URL(urlStr);

            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //응답받기
            StringBuilder response = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
            }

            String res = response.toString();
            System.out.println("Dart 정기보고서 배당에 관한 응답" + res);

            //Jackson 사용
            //JSON 전체를 JsonNode로
            JsonNode root = objectMapper.readTree(res);

            //dart는 list 배열을 반환함 -> for 돌리기
            JsonNode outputData = root.path("output");

            //output 대신 list(배열)를 꺼내서 돌려야 함
            JsonNode listNode = root.path("list");
            if (listNode.isMissingNode() || !listNode.isArray()) {
                return 0L;
            }

            //리스트 순회하며 '보통주 현금배당금'찾기
            for (JsonNode node : listNode) {
                String se = node.path("se").asText(); //구분
                //stock_knd null일 경우 빈 문자열로 바꿔주기(ex)한국쉘석유 같이 다트에 필드가 누락된 경우가 있음)
                String stockKnd = node.has("stock_knd") ? node.path("stock_knd").asText() : ""; //주식 종류

                //보통주이거나 종류가 명시되지 않은 경우
                if ("주당 현금배당금(원)".equals(se) && ("보통주".equals(stockKnd) || stockKnd.isEmpty())) {
                    String amountStr = node.path("thstrm").asText(); //당기금액
                    System.out.println("찾은 배당금 문자열: [" + amountStr + "]");

                    //쉼표(,) 제거 및 공백 처리, Long변환
                    if (amountStr != null && !amountStr.isEmpty() && !"-".equals(amountStr)) {
                        dividend =  Long.parseLong(amountStr.replace(",", "").trim());

                        if(currentPrice > 0 ){
                            dividendPerShare =  ((double)dividend/currentPrice)*100;
                            System.out.println("계산성공 : " + dividendPerShare);
                        } else{
                            System.out.println("계산 불가: 현재가가 0입니다. (배당금: " + dividend + ")");
                            dividendPerShare = 0.0;
                        }
                        break;
                    }
                }
            }

            System.out.println("[DART] corpCode=" + corpCode + ", stockCode=" + stockCode);


            return dividendPerShare;

        } catch (Exception e){
            System.out.println("기업정보 API 호출 에러: " + e.getMessage());
            return 0.0; //못 찾았으면 0원

        } finally {
            if (conn != null) {
                conn.disconnect(); //끊어주기
            }

        }
    }

}

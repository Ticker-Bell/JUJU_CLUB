package com.tickerbell.jujuclub.invest.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.invest.dto.DARTCorpInfoDTO;
import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.mapper.CodeMappingMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.time.LocalDateTime;

@RequiredArgsConstructor
@Service
public class DARTApiService {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    private final CodeMappingMapper mapping;

    private final KISApiService kisApiService;

    private final RestTemplate restTemplate;

    //(배당)
    //https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS002&apiId=2019005
    //GET : https://opendart.fss.or.kr/api/alotMatter.json

    //(재무제표)
    //https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS003&apiId=2019016
    //GET : https://opendart.fss.or.kr/api/fnlttSinglAcnt.json

    @Value("${dart.appkey}")
    private String APP_KEY;
    //dart -> 배당
    private String BASE_URL = "https://opendart.fss.or.kr/api/alotMatter.json";
    //dart -> 재무제표
    private String BASE_URL2 = "https://opendart.fss.or.kr/api/fnlttSinglAcnt.json";


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

    public DARTCorpInfoDTO getDartCorpInfo(String stockCode){
        //ROE : 순이익(당기순이익 : netIncome, account_nm:당기순이익/당기순이익(손실)) / 자본(자본총계 : equity, account_nm:자본총계) * 100
        //부채비율 : 부채(부채총계 : liabilities, account_nn:부채총계) / 자본(자본총계) * 100

        DARTCorpInfoDTO dartCorpInfoDTO = new DARTCorpInfoDTO();

        //stockCode로 해당하는 corpCode 구해주기
        String corpCode = mapping.selectCorpCode(stockCode);

        //매출액
        long sales = 0;
        //영업이익
        long operatingProfit = 0;
        //자본 총계
        long totalEquity = 0;
        //부채 총계
        long totalLiabilities = 0;
        //당기순이익
        long netIncome = 0;

        //ROE
        double roe = 0.0;
        //부채비율
        double debtRatio = 0.0;

        HttpURLConnection conn = null;

        try {
            //요청인자
            //URL만들기
            URI uri = UriComponentsBuilder.fromHttpUrl(BASE_URL2)
                    .queryParam("crtfc_key", APP_KEY)
                    .queryParam("corp_code", corpCode)
                    .queryParam("bsns_year", getBsnsYear())
                    .queryParam("reprt_code", "11011")
                    .build()
                    .toUri();

            //            {  <-- 여기가 "root" (JsonNode)
//                    "status": "000",
//                    "message": "정상",
//                    "list": [  <-- 여기가 "root.path('list')"
//                { "account_nm": "자본", "amount": "100" },
//                { "account_nm": "부채", "amount": "50" },
//                                  ...
//                ]
//            }

            //연결 + 요청 + 파싱
            JsonNode root = restTemplate.getForObject(uri, JsonNode.class);
            JsonNode listNode = root.path("list");

            if(listNode.isMissingNode() || !listNode.isArray()){
                System.out.println("재무제표 데이터 없음 : " + stockCode);
                return dartCorpInfoDTO; //빈 객체 리턴
            }

            //값 찾기
            for(JsonNode data : listNode){
                //연결재무제표인지 확인하기
                String fsDiv = data.path("fs_div").asText();
                if(!"CFS".equals(fsDiv)){
                    continue; //OFS값이면 넘어가기
                }
                String accountName = data.path("account_nm").asText();
                String amountStr = data.path("thstrm_amount").asText(); //thstrm : 현재년도 데이터

                if(amountStr == null || amountStr.isEmpty() || amountStr.equals("-")) {
                    continue;
                }

                //숫자로 변환
                long amount = 0;
                try {
                    amount = Long.parseLong(amountStr.replace(",","").trim());
                } catch (NumberFormatException e) {
                    continue;
                }

                //자본 총계
                if("자본총계".equals(accountName) || "자본".equals(accountName)){
                    totalEquity = amount;
                }
                //부채 총계
                else if ("부채총계".equals(accountName) || "부채".equals(accountName)) {
                    totalLiabilities = amount;
                }
                //당기순이익
                else if ("당기순이익".equals(accountName) || "당기순이익(손실)".equals(accountName)) {
                    netIncome = amount;
                }
                //매출액
                else if ("매출액".equals(accountName) || "수익(매출액)".equals(accountName)) {
                    sales = amount;
                }
                //영업이익
                else if ("영업이익".equals(accountName) || "영업이익(손실)".equals(accountName)) {
                    operatingProfit = amount;
                }
            }
            //비율계산
            if(totalEquity > 0){
                //부채비율 : 부채 / 자본 * 100
                debtRatio = ((double)totalLiabilities/totalEquity)*100;
                //roe : 순이익 / 자본 * 100
                roe = ((double) netIncome/totalEquity)*100;
            }
            System.out.println("계산결과 [" + stockCode + "] 자본:" + totalEquity + ", 부채:" + totalLiabilities + ", 순이익:" + netIncome);
            System.out.println("-> ROE: " + roe + "%, 부채비율: " + debtRatio + "%");

            //DTO에 담기
            dartCorpInfoDTO.setSales(sales);
            dartCorpInfoDTO.setOperatingProfit(operatingProfit);
            dartCorpInfoDTO.setNetIncome(netIncome);
            dartCorpInfoDTO.setRoe(roe);
            dartCorpInfoDTO.setDebtRatio(debtRatio);

        } catch (Exception e) {
            System.out.println("재무제표 조회 실패 : " + e.getMessage());
        }
        return dartCorpInfoDTO;
    }

}

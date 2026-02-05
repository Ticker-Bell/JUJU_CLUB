package com.tickerbell.jujuclub.invest.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.invest.dto.DARTCorpInfoDTO;
import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.mapper.CodeMappingMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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

@Slf4j
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


    /**
     * DART 사업보고서 년도 계산
     *
     * @return String
     */
    public String getBsnsYear() {
        //사업보고서 년도 계산
        //사업보고서는 매년 3월 말까지 제출
        //3월 말을 기준으로 1~3월은 현재년도 -2, 4~12월 -1
        LocalDateTime now = LocalDateTime.now();
        int currentYear = now.getYear();
        int currentMonth = now.getMonthValue();

        if (currentMonth < 4) {
            return String.valueOf(currentYear - 2);
        } else {
            return String.valueOf(currentYear - 1);
        }
    }

    /**
     * 배당수익률 계산
     *
     * @param stockCode String
     * @return double
     */
    public double getDividendPerShare(String stockCode) {

        long dividend = 0L; //배당금
        double dividendPerShare = 0.0; //배당 수익률(%) = 1주당 배당금 / 현재가 * 100

        //1) 시작로그
        log.info("[{}]: 배당수익률 조회 시작", stockCode);

        //DART 종목코드
        String corpCode = mapping.selectCorpCode(stockCode);

        //KIS의 현재 주가
        KISDataDTO kisDataDTO = kisApiService.getPriceData(stockCode);
        int currentPrice = (kisDataDTO != null) ? kisDataDTO.getCurrentPrice() : 0;

        //사업보고서 년도
        String bsns_year = getBsnsYear();

        //2) 파라미터 준비 완료 로그
        log.info("[{}]: 배당수익률 조회 파라미터 준비 완료 - corpCode={}, bsnsYear={}, currentPrice={}", stockCode, corpCode, bsns_year, currentPrice);

        HttpURLConnection conn = null;

        try {
            //3) 요청 시작 로그
            log.info("[{}]: 배당 조회 요청 시작 - corpCode={}, bsnsYear={}, reprtCode=11011", stockCode, corpCode, bsns_year);

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
            //4) 응답 수신 완료 로그
            log.info("[{}]: DART 정기보고서 배당에 관한 응답 - response={}", stockCode, res);

            //Jackson 사용 : JSON 전체를 JsonNode로
            JsonNode root = objectMapper.readTree(res);

            //DART는 list 배열을 반환함 -> for 돌리기
            JsonNode outputData = root.path("output");

            //output 대신 list(배열)를 꺼내서 돌려야 함
            JsonNode listNode = root.path("list");
            if (listNode.isMissingNode() || !listNode.isArray()) {
                //5) 응답 형식 이상 경고
                log.warn("[{}]: DART 응답 형식 이상 경고 - list 누락 또는 배열 아님 corpCode={}, bsnsYear={}", stockCode, corpCode, bsns_year);
                return 0.0;
            }

            //리스트 순회하며 주당 현금배당금(원) 찾기
            int index = 0; //log용

            for (JsonNode node : listNode) {
                index++;
                String se = node.path("se").asText(); //구분
                //stock_knd null일 경우 빈 문자열로 바꿔주기(ex)한국쉘석유 같이 다트에 필드가 누락된 경우가 있음)
                String stockKnd = node.has("stock_knd") ? node.path("stock_knd").asText() : ""; //주식 종류

                //보통주이거나 종류가 명시되지 않은 경우
                if ("주당 현금배당금(원)".equals(se) && ("보통주".equals(stockKnd) || stockKnd.isEmpty())) {
                    String amountStr = node.path("thstrm").asText(); //당기금액

                    //6) 배당 항목 로그
                    log.info("[{}]: DART 배당금 항목 - idx={}, se={}, stockKnd={}, thstrm={}", stockCode, index, se, stockKnd, amountStr);

                    //쉼표(,) 제거 및 공백 처리, Long변환
                    if (amountStr != null && !amountStr.isEmpty() && !"-".equals(amountStr)) {
                        dividend = Long.parseLong(amountStr.replace(",", "").trim());

                        if (currentPrice > 0) {
                            dividendPerShare = ((double) dividend / currentPrice) * 100;

                            //7) 배당수익률 계산 성공 로그
                            log.info("[{}]: 배당수익률 계산 성공 - dividend={}, currentPrice={}, dividendPerShare={}", stockCode, dividend, currentPrice, dividendPerShare);
                        } else {
                            //8) 배당수익률 계산 불가 경고
                            log.warn("[{}] 계산 불가 - 현재가가 0 dividend={}, corpCode={}, bsnsYear={}", stockCode, dividend, corpCode, bsns_year);
                            dividendPerShare = 0.0;
                        }
                        break;
                    } else {
                        //9) 배당금 값 X 경고
                        log.warn("[{}] 배당금 값이 비어있음/무효 - thstrm={}", stockCode, amountStr);
                    }
                }
            }
            //10) 배당수익률 조회 끝
            log.info("[{}] 배당수익률 조회 종료 - corpCode={}, result={}", stockCode, corpCode, dividendPerShare);

            return dividendPerShare;

        } catch (Exception e) {
            //11) 실패 로그
            log.error("[{}] 배당수익률 조회 실패 - corpCode={}, bsnsYear={}, currentPrice={}", stockCode, corpCode, bsns_year, currentPrice, e);
            return 0.0; //못 찾았으면 0원

        } finally {
            if (conn != null) {
                conn.disconnect(); //연결 해제
            }
        }
    }

    /**
     * 기업 정보 카드 - 재무 스냅샷 데이터 조회 및 계산
     *
     * @param stockCode String
     * @return DARTCorpInfoDTO
     */
    public DARTCorpInfoDTO getDartCorpInfo(String stockCode) {
        //ROE : 순이익(당기순이익 : netIncome, account_nm:당기순이익/당기순이익(손실)) / 자본(자본총계 : equity, account_nm:자본총계) * 100
        //부채비율 : 부채(부채총계 : liabilities, account_nn:부채총계) / 자본(자본총계) * 100

        //1) 시작로그
        log.info("[{}] 재무 스냅샷 데이터 조회 시작", stockCode);

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

        String bsnsYear = getBsnsYear();

        //2)파라미터 준비 완료 로그
        log.info("[{}] 요청 파라미터 준비 완료 - corpCode={}, bsnsYear={}, reprtCode=11011", stockCode, corpCode, bsnsYear);

        //HttpURLConnection conn = null;

        try {
            //요청인자
            //URL만들기
            URI uri = UriComponentsBuilder.fromHttpUrl(BASE_URL2)
                    .queryParam("crtfc_key", APP_KEY)
                    .queryParam("corp_code", corpCode)
                    .queryParam("bsns_year", bsnsYear)
                    .queryParam("reprt_code", "11011")
                    .build()
                    .toUri();

            //3)데이터 조회 요청 시작 로그
            log.info("[{}] DART 데이터 조회 요청 시작", stockCode);


//            {  <-- 여기가 "root" (JsonNode)
//                    "status": "000",
//                    "message": "정상",
//                    "list": [  <-- 여기가 "root.path('list')"
//                               { "account_nm": "자본", "amount": "100" },
//                               { "account_nm": "부채", "amount": "50" },
//                                                 ...
//                            ]
//            }

            //연결 + 요청 + 파싱
            JsonNode root = restTemplate.getForObject(uri, JsonNode.class);

            if (root != null) {
                //4)응답 수신 로그
                log.info("[{}] DART 응답 수신 - status={}, message={}", stockCode, root.path("status").asText(), root.path("message").asText());
            } else {
                //5)응답 수신 오류
                log.warn("[{}] DART 응답이 null 입니다 - corpCode={}, bsnsYear={}", stockCode, corpCode, bsnsYear);
                return dartCorpInfoDTO;
            }

            JsonNode listNode = root.path("list");

            if (listNode.isMissingNode() || !listNode.isArray()) {
                //6)응답 형식 이상 오류
                log.warn("[{}] 재무제표 데이터 없음 - list 누락 또는 배열 아님 (corpCode={}, bsnsYear={})", stockCode, corpCode, bsnsYear);
                return dartCorpInfoDTO; //빈 객체 리턴
            }

            //7)재무제표 list 파싱 시작 로그
            log.info("[{}] 재무제표 list 파싱 시작 - listSize={}", stockCode, listNode.size());

            //값 찾기
            for (JsonNode data : listNode) {
                //연결재무제표인지 확인하기
                String fsDiv = data.path("fs_div").asText();
                if (!"CFS".equals(fsDiv)) {
                    continue; //OFS값이면 넘어가기
                }
                String accountName = data.path("account_nm").asText();
                String amountStr = data.path("thstrm_amount").asText(); //thstrm : 현재년도 데이터

                if (amountStr == null || amountStr.isEmpty() || amountStr.equals("-")) {
                    continue;
                }

                //숫자로 변환
                long amount = 0;
                try {
                    amount = Long.parseLong(amountStr.replace(",", "").trim());
                } catch (NumberFormatException e) {
                    continue;
                }

                //자본 총계
                if ("자본총계".equals(accountName) || "자본".equals(accountName)) {
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
            //8)DART 재무제표 데이터 파싱 완료
            log.info("[{}] 재무제표 파싱 완료 - totalEquity={}, totalLiabilities={}, netIncome={}, sales={}, operatingProfit={}", stockCode, totalEquity, totalLiabilities, netIncome, sales, operatingProfit);

            //비율계산
            if (totalEquity > 0) {
                //부채비율 : 부채 / 자본 * 100
                debtRatio = ((double) totalLiabilities / totalEquity) * 100;
                //roe : 순이익 / 자본 * 100
                roe = ((double) netIncome / totalEquity) * 100;
            } else {
                //9) 비율 계산 불가 경고
                log.warn("[{}] 비율 계산 불가 - totalEquity=0, totalLiabilities={}, netIncome={}", stockCode, totalLiabilities, netIncome);
            }
            //10) 부채비율, ROE 계산 완료 로그
            log.info("[{}] 재무제표 계산 완료 - 부채비율={}%, ROE={}%, corpCode={}, bsnsYear={}", stockCode, debtRatio, roe, corpCode, bsnsYear);

            //DTO에 담기
            dartCorpInfoDTO.setSales(sales);
            dartCorpInfoDTO.setOperatingProfit(operatingProfit);
            dartCorpInfoDTO.setNetIncome(netIncome);
            dartCorpInfoDTO.setRoe(roe);
            dartCorpInfoDTO.setDebtRatio(debtRatio);

        } catch (Exception e) {
            //11) 재무제표 조회 실패 에러
            log.error("[{}] 재무제표 조회 실패 - corpCode={}, bsnsYear={}", stockCode, corpCode, bsnsYear, e);
        }

        //12) DART 재무 스냅샷 조회 끝 로그
        log.info("[{}] DART 재무 스냅샷 조회 종료 - corpCode={}, sales={}, operatingProfit={}, netIncome={}, 부채비율={}%, ROE={}%", stockCode, corpCode, sales, operatingProfit, netIncome, debtRatio, roe);

        return dartCorpInfoDTO;
    }
}

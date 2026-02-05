package com.tickerbell.jujuclub.invest.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.dto.StockRankingDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class StockRankingService {

    @Value("${kis.appkey}")
    private String appkey;

    @Value("${kis.appsecret}")
    private String appsecret;

    @Value("${kis.baseurl}")
    private String baseurl;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private KISApiService kisApiService;


    /**
     * 한국투자 Open API 호출
     * 국내주식 거래량 순위 REST API 요청 및 응답 return
     *
     * @param accessToken string
     * @return List&lt;RankingDTO&gt;
     * @throws Exception
     */
    public List<StockRankingDTO> getTradingVolumeRanking(String accessToken) throws Exception {

        try{
            // URL 및 쿼리 파라미터 설정
            URI uri = UriComponentsBuilder.fromHttpUrl(baseurl)
                    .path("/uapi/domestic-stock/v1/quotations/volume-rank")
                    .queryParam("FID_COND_MRKT_DIV_CODE", "J")  //조건 시장 분류 코드 - J:KRX, NX:NXT
                    .queryParam("FID_COND_SCR_DIV_CODE", "20171")  //조건 화면 분류 코드 - 20171
                    .queryParam("FID_INPUT_ISCD", "0000")  //입력 종목코드 - 0000(전체) 기타(업종코드)
                    .queryParam("FID_DIV_CLS_CODE", "0")  //분류 구분 코드 - 0(전체) 1(보통주) 2(우선주)
                    .queryParam("FID_BLNG_CLS_CODE", "0")  //소속 구분 코드 - 0 : 평균거래량 1:거래증가율 2:평균거래회전율 3:거래금액순 4:평균거래금액회전율
                    .queryParam("FID_TRGT_CLS_CODE", "111111111")  //대상 구분 코드 - 1 or 0 9자리 (차례대로 증거금 30% 40% 50% 60% 100% 신용보증금 30% 40% 50% 60%) ex) "111111111"
                    .queryParam("FID_TRGT_EXLS_CLS_CODE", "1111101111")  //대상 제외 구분 코드 - 1 or 0 10자리 (차례대로 투자위험/경고/주의 관리종목 정리매매 불성실공시 우선주 거래정지 ETF ETN 신용주문불가 SPAC) ex) "0000000000"
                    .queryParam("FID_INPUT_PRICE_1", "")  //입력 가격1 - 가격 ~  ex) "0"  전체 가격 대상 조회 시 FID_INPUT_PRICE_1, FID_INPUT_PRICE_2 모두 ""(공란) 입력
                    .queryParam("FID_INPUT_PRICE_2", "")  //입력 가격2 - ~ 가격  ex) "1000000"  전체 가격 대상 조회 시 FID_INPUT_PRICE_1, FID_INPUT_PRICE_2 모두 ""(공란) 입력
                    .queryParam("FID_VOL_CNT", "")  //거래량 수 - 거래량 ~  ex) "100000"  전체 거래량 대상 조회 시 FID_VOL_CNT ""(공란) 입력
                    .queryParam("FID_INPUT_DATE_1", "")  //입력 날짜1 - ""(공란) 입력
                    .build()
                    .toUri();

            // 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.set("content-type", "application/json; charset=utf-8");
            headers.set("authorization", "Bearer " + accessToken);
            headers.set("appkey", appkey);  //한국투자증권 홈페이지에서 발급받은 appkey
            headers.set("appsecret", appsecret);  //한국투자증권 홈페이지에서 발급받은 appsecret
            headers.set("tr_id", "FHPST01710000");  //거래ID - FHPST01710000
            headers.set("custtype", "P");  //고객 타입 - B : 법인  P : 개인

            // 요청 엔티티 생성 (GET이라 Body는 null)
            HttpEntity<Void> request = new HttpEntity<>(headers);

            // 호출 (GET)
            ResponseEntity<JsonNode> response = restTemplate.exchange(uri, HttpMethod.GET, request, JsonNode.class);

            // 결과 확인 및 로직 처리
            JsonNode root = response.getBody();

            String rtCd = root.path("rt_cd").asText();  //성공 여부 코드
            String msgCd = root.path("msg_cd").asText();  //메세지 코드

            if(response.getStatusCode() == HttpStatus.OK && "0".equals(rtCd)) {
                // 정상 성공
                // output에는 순위별로 JSON데이터가 여러개 존재
                return JsonToDto(root.path("output"));
            } else{
                log.error("거래량 순위 api 응답 에러: {}", response.getStatusCode());
                return null;
            }

        } catch(Exception e){
            log.error("거래량 순위 api 호출 실패");
            throw new RuntimeException(e);
        }
    }

    /**
     * 한국투자 Open API 호출
     * 국내주식 시가총액 상위 REST API 요청 및 응답 return
     *
     * @param accessToken string
     * @return List&lt;RankingDTO&gt;
     * @throws Exception
     */
    public List<StockRankingDTO> getMarketCapRanking(String accessToken) throws Exception {
        try{
            // URL 및 쿼리 파라미터 설정
            URI uri = UriComponentsBuilder.fromHttpUrl(baseurl)
                    .path("/uapi/domestic-stock/v1/ranking/market-cap")
                    .queryParam("fid_input_price_2", "")  // 입력 가격2 - 입력값 없을때 전체 (~ 가격)
                    .queryParam("fid_cond_mrkt_div_code", "J")  //조건 시장 분류 코드 - 시장구분코드 (J:KRX, NX:NXT)
                    .queryParam("fid_cond_scr_div_code", "20174")  //조건 화면 분류 코드 - Unique key( 20174 )
                    .queryParam("fid_div_cls_code", "0")  //분류 구분 코드 - 0: 전체, 1:보통주, 2:우선주
                    .queryParam("fid_input_iscd", "0000")  //입력 종목코드 - 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
                    .queryParam("fid_trgt_cls_code", "0")  //대상 구분 코드 - 0 : 전체
                    .queryParam("fid_trgt_exls_cls_code", "0")  //대상 제외 구분 코드 - 0 : 전체
                    .queryParam("fid_input_price_1", "")  //입력 가격1 - 입력값 없을때 전체 (가격 ~)
                    .queryParam("fid_vol_cnt", "")  //거래량 수 - 입력값 없을때 전체 (거래량 ~)
                    .build()
                    .toUri();

            // 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.set("content-type", "application/json; charset=utf-8");
            headers.set("authorization", "Bearer " + accessToken);
            headers.set("appkey", appkey);  //한국투자증권 홈페이지에서 발급받은 appkey
            headers.set("appsecret", appsecret);  //한국투자증권 홈페이지에서 발급받은 appsecret
            headers.set("tr_id", "FHPST01740000");  //거래ID - FHPST01740000
            headers.set("custtype", "P");  //고객 타입 - B : 법인  P : 개인

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
            } else{
                log.error("시가총액 상위 api 응답 에러: {}", response.getStatusCode());
                return null;
            }
        } catch(Exception e){
            log.error("시가총액 상위 api 호출 실패");
            throw new RuntimeException(e);
        }
    }

    /**
     * 한국투자 Open API 호출
     * 국내주식 상승률 순위 REST API 요청 및 응답 return
     *
     * @param accessToken string
     * @return List&lt;RankingDTO&gt;
     * @throws Exception
     */
    public List<StockRankingDTO> getTopGainersRanking(String accessToken) throws Exception {
        try{
            // URL 및 쿼리 파라미터 설정
            URI uri = UriComponentsBuilder.fromHttpUrl(baseurl)
                    .path("/uapi/domestic-stock/v1/ranking/fluctuation")
                    .queryParam("fid_rsfl_rate2", "")  // 등락 비율2 - 공백 입력 시 전체 (~ 비율
                    .queryParam("fid_cond_mrkt_div_code", "J")  //조건 시장 분류 코드 - 시장구분코드 (J:KRX, NX:NXT)
                    .queryParam("fid_cond_scr_div_code", "20170")  //조건 화면 분류 코드 - Unique key( 20170 )
                    .queryParam("fid_input_iscd", "0000")  //입력 종목코드 - 0000(전체) 코스피(0001), 코스닥(1001), 코스피200(2001)
                    .queryParam("fid_rank_sort_cls_code", "0")  //순위 정렬 구분 코드 - 0:상승율순 1:하락율순 2:시가대비상승율 3:시가대비하락율 4:변동율
                    .queryParam("fid_input_cnt_1", "0")  //입력 수1 - 0:전체 , 누적일수 입력
                    .queryParam("fid_prc_cls_code", "1")  //가격 구분 코드 - 'fid_rank_sort_cls_code :0 상승율 순일때 (0:저가대비, 1:종가대비)   fid_rank_sort_cls_code :1 하락율 순일때 (0:고가대비, 1:종가대비)  fid_rank_sort_cls_code : 기타 (0:전체)'
                    .queryParam("fid_input_price_1", "")  //입력 가격1 - 공백 입력 시 전체 (가격 ~)
                    .queryParam("fid_input_price_2", "")  //입력 가격2 - 공백 입력 시 전체 (~ 가격)
                    .queryParam("fid_vol_cnt", "")  //거래량 수 - 공백 입력 시 전체 (거래량 ~)
                    .queryParam("fid_trgt_cls_code", "0")  //대상 구분 코드 - 0:전체
                    .queryParam("fid_trgt_exls_cls_code", "0")  //대상 제외 구분 코드 - 0:전체
                    .queryParam("fid_div_cls_code", "0")  //분류 구분 코드 - 0:전체
                    .queryParam("fid_rsfl_rate1", "")  //등락 비율1 - 공백 입력 시 전체 (비율 ~)
                    .build()
                    .toUri();

            // 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.set("content-type", "application/json; charset=utf-8");
            headers.set("authorization", "Bearer " + accessToken);
            headers.set("appkey", appkey);  //한국투자증권 홈페이지에서 발급받은 appkey
            headers.set("appsecret", appsecret);  //한국투자증권 홈페이지에서 발급받은 appsecret
            headers.set("tr_id", "FHPST01700000");  //거래ID - FHPST01700000
            headers.set("custtype", "P");  //고객 타입 - B : 법인  P : 개인

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
                return JsonToDto2(root.path("output"));
            } else{
                log.error("상승률 순위 api 응답 에러: {}", response.getStatusCode());
                return null;
            }
        } catch(Exception e){
            log.error("상승률 순위 api 호출 실패");
            throw new RuntimeException(e);
        }
    }

    /**
     * 한국투자 Open API 호출
     * 국내주식 하락률 순위 REST API 요청 및 응답 return
     *
     * @param accessToken string
     * @return List&lt;RankingDTO&gt;
     * @throws Exception
     */
    public List<StockRankingDTO> getTopLosersRanking(String accessToken) throws Exception {
        try{
            // URL 및 쿼리 파라미터 설정
            URI uri = UriComponentsBuilder.fromHttpUrl(baseurl)
                    .path("/uapi/domestic-stock/v1/ranking/fluctuation")
                    .queryParam("fid_rsfl_rate2", "")  // 등락 비율2 - 공백 입력 시 전체 (~ 비율
                    .queryParam("fid_cond_mrkt_div_code", "J")  //조건 시장 분류 코드 - 시장구분코드 (J:KRX, NX:NXT)
                    .queryParam("fid_cond_scr_div_code", "20170")  //조건 화면 분류 코드 - Unique key( 20170 )
                    .queryParam("fid_input_iscd", "0000")  //입력 종목코드 - 0000(전체) 코스피(0001), 코스닥(1001), 코스피200(2001)
                    .queryParam("fid_rank_sort_cls_code", "1")  //순위 정렬 구분 코드 - 0:상승율순 1:하락율순 2:시가대비상승율 3:시가대비하락율 4:변동율
                    .queryParam("fid_input_cnt_1", "0")  //입력 수1 - 0:전체 , 누적일수 입력
                    .queryParam("fid_prc_cls_code", "1")  //가격 구분 코드 - 'fid_rank_sort_cls_code :0 상승율 순일때 (0:저가대비, 1:종가대비)   fid_rank_sort_cls_code :1 하락율 순일때 (0:고가대비, 1:종가대비)  fid_rank_sort_cls_code : 기타 (0:전체)'
                    .queryParam("fid_input_price_1", "")  //입력 가격1 - 공백 입력 시 전체 (가격 ~)
                    .queryParam("fid_input_price_2", "")  //입력 가격2 - 공백 입력 시 전체 (~ 가격)
                    .queryParam("fid_vol_cnt", "")  //거래량 수 - 공백 입력 시 전체 (거래량 ~)
                    .queryParam("fid_trgt_cls_code", "0")  //대상 구분 코드 - 0:전체
                    .queryParam("fid_trgt_exls_cls_code", "0")  //대상 제외 구분 코드 - 0:전체
                    .queryParam("fid_div_cls_code", "0")  //분류 구분 코드 - 0:전체
                    .queryParam("fid_rsfl_rate1", "")  //등락 비율1 - 공백 입력 시 전체 (비율 ~)
                    .build()
                    .toUri();

            // 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.set("content-type", "application/json; charset=utf-8");
            headers.set("authorization", "Bearer " + accessToken);
            headers.set("appkey", appkey);  //한국투자증권 홈페이지에서 발급받은 appkey
            headers.set("appsecret", appsecret);  //한국투자증권 홈페이지에서 발급받은 appsecret
            headers.set("tr_id", "FHPST01700000");  //거래ID - FHPST01700000
            headers.set("custtype", "P");  //고객 타입 - B : 법인  P : 개인

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
                return JsonToDto2(root.path("output"));
            } else{
                log.error("하락률 순위 api 응답 에러: {}", response.getStatusCode());
                return null;
            }

        } catch(Exception e){
            log.error("하락률 순위 api 호출 실패");
            throw new RuntimeException(e);
        }
    }

    /**
     * 한국투자 Open API 요청 응답으로 받아온 데이터를 JSON에서 DTO로 변환하여 return
     *
     * @param node JsonNode
     * @return List&lt;RankingDTO&gt;
     */
    private List<StockRankingDTO> JsonToDto(JsonNode node){
        //JsonNode 안에 Json 배열이 랭킹 순으로 들어가 있음
        //각 Json을 DTO로 변환

        List<StockRankingDTO> stockRankingDTOList = new ArrayList<>();

        for(JsonNode item : node){
            StockRankingDTO stockRankingDTO = StockRankingDTO.builder()
                    .stockName(item.path("hts_kor_isnm").asText())
                    .stockCode(item.path("mksc_shrn_iscd").asText())
                    .rank(item.path("data_rank").asInt())
                    .build();
            stockRankingDTOList.add(stockRankingDTO);
        }

        return stockRankingDTOList;
    }

    /**
     * 한국투자 Open API 요청 응답으로 받아온 데이터를 JSON에서 DTO로 변환하여 return
     *
     * @param node JsonNode
     * @return List&lt;RankingDTO&gt;
     */
    private List<StockRankingDTO> JsonToDto2(JsonNode node){
        // 등락률 순위를 받아올땐 응답 BODY의 주식 종목 코드의 key값 이름이
        // 'mksc_shrn_iscd'가 아니라 'stck_shrn_iscd'로 달라서
        // JsonToDto로는 불가능하기 때문에 구현

        List<StockRankingDTO> stockRankingDTOList = new ArrayList<>();

        for(JsonNode item : node){
            StockRankingDTO stockRankingDTO = StockRankingDTO.builder()
                    .stockName(item.path("hts_kor_isnm").asText())
                    .stockCode(item.path("stck_shrn_iscd").asText())
                    .rank(item.path("data_rank").asInt())
                    .build();
            stockRankingDTOList.add(stockRankingDTO);
        }

        return stockRankingDTOList;
    }

    /**
     * 해당 순위별 리스트의 각 종목들 현재가를 가져와 DTO에 추가 후 return
     *
     * @param stockRankingDTOList List&lt;RankingDTO&gt;
     * @return List&ltRankingDTO&gt;
     */
    public List<StockRankingDTO> addKisDataDtoToRankingDto(List<StockRankingDTO> stockRankingDTOList){

        for(int i=0; i< stockRankingDTOList.size(); i++){
            try{
                StockRankingDTO stockRankingDTO = stockRankingDTOList.get(i);
                KISDataDTO kisDataDTO = kisApiService.getPriceData(stockRankingDTO.getStockCode());
                // KISDataDTO의 changePct 값은 음수일때만 - 붙어 있고 그 외엔 부혹 없기때문에 붙여준다.
                if (!kisDataDTO.getChangePct().startsWith("-") && !kisDataDTO.getChangePct().equals("0.00")) {
                    kisDataDTO.setChangePct("+" + kisDataDTO.getChangePct());
                }
                stockRankingDTO.setCurrentPrice(kisDataDTO.getCurrentPrice());
                stockRankingDTO.setChangePct(kisDataDTO.getChangePct());
            }catch (Exception e){
                log.error("RankingApiService에서 kisApiService 호출 실패");
                throw new RuntimeException(e);
            }
        }
        return stockRankingDTOList;
    }

}

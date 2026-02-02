package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.StockChartRestDTO;
import com.tickerbell.jujuclub.utils.GetValidAccessToken;
import com.tickerbell.jujuclub.utils.StockChartParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.List;


@RequiredArgsConstructor
@Service
@Slf4j
public class StockChartRestService {
    @Value("${kis.appkey}")
    private String APPKEY;

    @Value("${kis.appsecret}")
    private String APPSECRET;

    @Value("${kis.baseurl}")
    private String BASEURL;

    private final GetValidAccessToken getValidAccessToken;

    private String ACCESSTOKEN;
    private final StockChartParser stockChartParser;

    /**
     * 주식 차트 REST API 요청 서비스
     *
     * @param periodCode String
     * @param stockCode String
     * @return List<StockChartRestDTO>
     */
    public List<StockChartRestDTO> getStockRestData(String periodCode, String stockCode) {
        List<StockChartRestDTO> result = null;
        try {
            RestTemplate restTemplate = new RestTemplate();
            ACCESSTOKEN = getValidAccessToken.getValidToken();
            String url = BASEURL + "/uapi/domestic-stock/v1/quotations/inquire-daily-price";
            HttpHeaders headers = new HttpHeaders();
            headers.set("content_type", "application/json;charset=utf-8");
            headers.set("authorization", "Bearer " + ACCESSTOKEN);
            headers.set("appkey", APPKEY);
            headers.set("appsecret", APPSECRET);
            headers.set("tr_id", "FHKST01010400");
            headers.set("custtype", "P");

            UriComponentsBuilder urlBuilder = UriComponentsBuilder.fromHttpUrl(url)
                    .queryParam("FID_COND_MRKT_DIV_CODE", "J")
                    .queryParam("FID_INPUT_ISCD", stockCode)
                    .queryParam("FID_PERIOD_DIV_CODE", periodCode)
                    .queryParam("FID_ORG_ADJ_PRC", "0");

            HttpEntity<?> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(
                    urlBuilder.toUriString(),
                    HttpMethod.GET,
                    entity,
                    String.class
            );
            result = stockChartParser.parseStockRestData(response.getBody(), periodCode);
        } catch (Exception e) {
            log.error("주식 차트 REST API 요청 서비스 중 오류 발생");
            throw new RuntimeException(e);
        }
        return result;
    }
}
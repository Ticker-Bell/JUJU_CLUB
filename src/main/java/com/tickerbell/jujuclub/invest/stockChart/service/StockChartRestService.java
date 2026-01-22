package com.tickerbell.jujuclub.invest.stockChart.service;

import com.tickerbell.jujuclub.invest.stockChart.dto.StockChartRestDTO;
import com.tickerbell.jujuclub.utils.RequestNewAccessToken;
import com.tickerbell.jujuclub.utils.StockChartParser;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.List;


@RequiredArgsConstructor
@Service
public class StockChartRestService {
    @Value("${kis.appkey}")
    private String APPKEY;

    @Value("${kis.appsecret}")
    private String APPSECRET;

    @Value("${kis.baseurl}")
    private String BASEURL;

    private final RequestNewAccessToken requestNewAccessToken;

    private String ACCESSTOKEN;
    private final StockChartParser stockChartParser;


    public List<StockChartRestDTO> getStockRestData(String periodCode, String stockCode) throws Exception {
        RestTemplate restTemplate = new RestTemplate();
        ACCESSTOKEN = requestNewAccessToken.getAccessToken();
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
        return stockChartParser.parseStockRestData(response.getBody(), periodCode);
    }
}
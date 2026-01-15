package com.tickerbell.jujuclub.invest.stockChart.service;

import com.tickerbell.jujuclub.invest.stockChart.dto.StockChartRestDTO;
import com.tickerbell.jujuclub.utils.StockChartParser;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.List;


@RequiredArgsConstructor
@Service
public class StockChartRestService {
    private final String ACCESS_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6ImUwNjI3YjkwLTIyMTEtNDg4Yy04NDE0LTNkMWZiOTA0MjI4YSIsInByZHRfY2QiOiIiLCJpc3MiOiJ1bm9ndyIsImV4cCI6MTc2ODUzMDg0OCwiaWF0IjoxNzY4NDQ0NDQ4LCJqdGkiOiJQU0V3eWU5RXd3YUhDVDZUbEVKQmVqdUdtdHVEbXNaUkxzVFAifQ.fIO-eSaTv80gpqxSE1QoOaiqAeTf-KrUpn5dc2QCgvMu6jn50gPDjra3QrugKWOJTupBjJts3DImIg_wSXQA-A";
    private final String APPKEY = "PSEwye9EwwaHCT6TlEJBejuGmtuDmsZRLsTP";
    private final String APPSECRET = "1Zxqr/7cOzLRg7nEsU2BJM8rSekIxQPnvCcUcxoPVGexTHQyDSiMXaYlGmGAkJYi/s7bWUdWI9H4gETBWiNyl4j5gfuiz7NuVEKi6vTTNL3ptWfBXQFe5cesH35tmEnPuSKWZ8U8++HM0LF+GQxQ9nZtRWZX0MR1CDQuUStqIHd4ase/mhQ=";
    private final StockChartParser stockChartParser;


    public List<StockChartRestDTO> getStockRestData() {
        RestTemplate restTemplate = new RestTemplate();
        String url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/quotations/inquire-daily-price";
        HttpHeaders headers = new HttpHeaders();
        headers.set("content_type", "application/json;charset=utf-8");
        headers.set("authorization", "Bearer " + ACCESS_TOKEN);
        headers.set("appkey", APPKEY);
        headers.set("appsecret", APPSECRET);
        headers.set("tr_id", "FHKST01010400");
        headers.set("custtype", "P");

        UriComponentsBuilder urlBuilder = UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("FID_COND_MRKT_DIV_CODE", "UN")
                .queryParam("FID_INPUT_ISCD", "005930")
                .queryParam("FID_PERIOD_DIV_CODE", "D")
                .queryParam("FID_ORG_ADJ_PRC", "0");

        HttpEntity<?> entity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(
                urlBuilder.toUriString(),
                HttpMethod.GET,
                entity,
                String.class
        );
        return stockChartParser.parseStockRestData(response.getBody());
    }
}
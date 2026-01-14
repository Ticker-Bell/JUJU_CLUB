package com.tickerbell.jujuclub.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PortfolioAllocationItemDTO {

    // 응답형태 : List<PortfolioAllocationItemDTO>
    // 예) 삼성전자 32% -> 삼성전자 한 줄이 DTO 1개
    // 차트 안에 구성 될 요소 : 유저가 보유한 주식 종목 명, 현재가에 따른 % 비율, 구매한 주식 개수

    private int stockSeq;
    private String stockCode;
    private String stockName;
    private int currentPrice; //KIS 현재가
    private int quantity;
    private long currentValue; //현재평가금액 : currentPrice * quantity
    private double weightPct; //비중 : currentValue / totalValue*100

}

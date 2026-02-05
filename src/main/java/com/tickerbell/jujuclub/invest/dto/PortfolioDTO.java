package com.tickerbell.jujuclub.invest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PortfolioDTO {

    // 응답형태 : List<PortfolioAllocationItemDTO>
    // 예) 삼성전자 32% -> 삼성전자 한 줄이 DTO 1개
    // 차트 안에 구성 될 요소 : 유저가 보유한 주식 종목 명, 현재가에 따른 % 비율, 구매한 주식 개수

    //DB
    private int stockSeq;
    private String stockCode;
    private String stockName;
    private int quantity;
    private int avgPrice; //평균단가
    //KIS Api
    private int currentPrice; //현재가

    private long pnl; //평가손익(currentPrice - avgPrice)*quantity
    //차트
    private double weightPct; //비중 : currentValue / totalValue*100

}

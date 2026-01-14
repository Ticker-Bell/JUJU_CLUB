package com.tickerbell.jujuclub.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class HoldinglistItemDTO {

    //유저의 보유주식 한줄 불러오기
    private int stockSeq;
    private String stockCode;
    private String stockName;
    private int quantity; //보유 수량
    private int avgPrice; //평균 단가
    private int currentPrice; //KIS 현재가
    private long currentValue; //현재평가금액 = currentPrice * quantity
    private long unrealizedGainLoss; //평가손익 = (currentPrice - avgPrice) * quantity

}

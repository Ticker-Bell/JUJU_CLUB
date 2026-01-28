package com.tickerbell.jujuclub.invest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserInvestSummeryDTO {

    private long totalAsset; //총 평가자산
    private long cashBalance; //예수금
    private long totalStockValue; //주식평가금액 총합(총 평가금액)
    private double totalReturnPct; //총 수익률

}

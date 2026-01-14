package com.tickerbell.jujuclub.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserInvestSummeryDTO {

    private long totalAsset; //총평가자산
    private long cashBalance; //이용가능자산(보유현금)
    private long totalStockValue; //투자금
    private double totalReturnPct; //총수익률= ((totalStockValue - 초기투자금)/초기투자금)*100

}

package com.tickerbell.jujuclub.invest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RankingDTO {
    private String stockName;
    private String stockCode;
    private Integer rank;
    private int currentPrice;
    private String changePct;
}

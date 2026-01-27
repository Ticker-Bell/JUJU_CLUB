package com.tickerbell.jujuclub.invest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class StockDTO {
    private Integer stockSeq;
    private String stockCode;
    private String stockName;
    private String marketType;
    private String sector;
}

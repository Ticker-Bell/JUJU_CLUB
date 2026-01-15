package com.tickerbell.jujuclub.invest.stockList.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class StockDTO {
    Integer stockSeq;
    String stockCode;
    String stockName;
    String marketType;
    String sector;
}

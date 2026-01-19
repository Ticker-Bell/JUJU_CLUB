package com.tickerbell.jujuclub.stockdata.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class StockDataDTO {
    String stockCode;
    String stockName;
    String marketType;
    String sector;
}

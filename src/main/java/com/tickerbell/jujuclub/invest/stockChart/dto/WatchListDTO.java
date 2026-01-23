package com.tickerbell.jujuclub.invest.stockChart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WatchListDTO {
    private int userSeq;
    private String stockCode;
}

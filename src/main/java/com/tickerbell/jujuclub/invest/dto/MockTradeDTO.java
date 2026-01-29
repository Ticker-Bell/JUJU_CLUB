package com.tickerbell.jujuclub.invest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MockTradeDTO {
    private String stockName;
    private char tradeType;
    private int tradePrice;
    private int tradeQuantity;
    private Date tradedAt;
}

package com.tickerbell.jujuclub.invest.trade.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TradeDTO {
    private int userSeq;
    private int stockSeq;
    private String tradeType;
    private int tradeQuantity;
    private int tradePrice;
    private int totalAmount;
}

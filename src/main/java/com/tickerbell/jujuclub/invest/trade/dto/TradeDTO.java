package com.tickerbell.jujuclub.invest.trade.dto;

import lombok.*;
import org.apache.ibatis.type.Alias;

@Alias("TradeDTO")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TradeDTO {
    private int userSeq;
    private int stockSeq;
    private String tradeType;
    private int tradeQuantity;
    private int tradePrice;
    private int totalAmount;

    private String stockCode;
}

package com.tickerbell.jujuclub.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class WatchlistItemDTO {

    private int favoriteSeq;
    private int stockSeq;
    private String stockCode;
    private String stockName;
    private int currentPrice; //KIS 현재가
    private String changePct; //등락률

}

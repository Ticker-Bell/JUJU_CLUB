package com.tickerbell.jujuclub.invest.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class StockChartRestDTO {
    @JsonProperty("stck_bsop_date")
    private String tradeDate; //체결시간
    @JsonProperty("stck_clpr")
    private int currentPrice; //현재가


    private String displayPrice; //포맷팅한 현재가
    private String displayDate; //포맷팅한 일자

}

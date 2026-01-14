package com.tickerbell.jujuclub.invest.stockChart.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StockChartDTO {
    private String stockCode; //종목코드
    private String tradeTime; //체결시간
    private int currentPrice; //현재가
    private String dayOverDaySign; //전일 대비 부호
    private int dayOverDayChange; //전일 대비
    private double dayOverDayRate; //전일 대비율

    private String displayPrice; //포맷팅한 현재가
    private String displayTime; //포맷팅한 체결시간
    private String displayChange; //포맷팅한 전일 대비 관련 데이터
}

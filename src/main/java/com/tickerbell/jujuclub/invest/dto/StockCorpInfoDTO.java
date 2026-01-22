package com.tickerbell.jujuclub.invest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StockCorpInfoDTO {

    //페이지에 띄워질 데이터
    //KIS API : 시가총액, 52주 최고/최저, 상장 주식 수
    //배당금(배당 수익률 = (1주당 배당금/현재가)*100) - KIS로 데이터 가져오기 불가능
    private String marketCapData; //시가총액
    private String w52HgprData; //52주 최고가
    private String w52LwprData; //52주 최저가
    private String listedStockCntData; //상장주식수
    private String dividendPriceRatio; //배당수익률 - 임시

}

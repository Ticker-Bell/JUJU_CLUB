package com.tickerbell.jujuclub.invest.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class KISCorpInfoDTO {

    //KIS API : 시가총액, 52주 최고/최저, 상장 주식 수
    @JsonProperty("hts_avls")
    private String marketCap; //시가총액
    @JsonProperty("w52_hgpr")
    private String w52Hgpr; //52주 최고가
    @JsonProperty("w52_lwpr")
    private String w52Lwpr; //52주 최저가
    @JsonProperty("lstn_stcn")
    private String listedStockCnt; //상장주식수
    //배당금을 위해 결산연도가 필요하면
    //stck_dryy추가
}

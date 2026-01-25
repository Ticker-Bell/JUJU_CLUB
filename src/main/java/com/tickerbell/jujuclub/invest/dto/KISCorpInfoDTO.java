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

    //KIS API에서 받아올 값들

    @JsonProperty("hts_avls")
    private String marketCap; //시가총액
    @JsonProperty("w52_hgpr")
    private String w52Hgpr; //52주 최고가
    @JsonProperty("w52_lwpr")
    private String w52Lwpr; //52주 최저가
    @JsonProperty("lstn_stcn")
    private String listedStockCnt; //상장주식수
    //PER, PBR, EPS, BPS
    @JsonProperty("per") //주가를 주당순이익으로 나눈 값, per이 낮을수록 기업이 내는 이익에 비해 주가가 저평가 되어있다는 의미.
    private String per;
    @JsonProperty("pbr") //주가를 주당순자산으로 나눈 값으로 pbr이 낮을수록 기업의 실제 자산가치 대비 주가가 저평가 되어있다는 의미.
    private String pbr;
    @JsonProperty("eps") //1주당 회사가 벌어들인 순이익, 숫자가 클수록 회사의 기업가치가 크고 배당 줄 수 있는 여유가 있음.
    private String eps;
    @JsonProperty("bps") //회사가 경영을 멈추고 현재 시점의 순자산을 주주들에게 나눠줄 경우 한 주당 얼마씩 줄 수 있는지 의미. 클수록 기업가치가 높음.
    private String bps;

}

package com.tickerbell.jujuclub.invest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DARTCorpInfoDTO {

    //Dart 통합조회 DTO : 종목코드 당 데이터 한번에 받아오기
        //->매출액, 영업이익, 순이익, 부채비율, ROE

    //재무제표 API: 부채비율, 유보율, ROE, EPS 계산용 (자본, 부채, 순이익)
    //배당 API: 배당수익률 계산용 (주당 배당금)
    //주식총수 API: BPS, 시가총액 계산용 (발행주식수) - KIS

    //dartapi는 json구조가 kis랑 다르게 list형태고 key가 반복된다
    //account_nm, thstrm_amount값을 봐야 뭔지 알 수 있기 때문에
    //자동으로 매핑되는 @JsonProperty를 사용하지 않았음.

    // 1. 재무제표 창고에서 가져올 것들
    private long sales; //매출액
    private long operatingProfit; //영업이익
    private long netIncome; //당기순이익
    private double debtRatio; //부채비율 (계산)
    private double roe;           //ROE (계산)

    // 2. 배당 창고에서 가져올 것
    private long dividendAmt; //주당 현금배당금 (보통주 기준)

}

package com.tickerbell.jujuclub.invest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class KISDataDTO {

    //종목코드 넣어서 리스트로 가져오는게 더 좋아보인다고 하심
    private int currentPrice;
    private String changePct;
    private String changeSign; //등락부호

}

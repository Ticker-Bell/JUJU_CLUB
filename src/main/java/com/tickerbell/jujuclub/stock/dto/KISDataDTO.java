package com.tickerbell.jujuclub.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class KISDataDTO {

    private int currentPrice;
    private String changePct;
    private String changeSign; //등락부호

}

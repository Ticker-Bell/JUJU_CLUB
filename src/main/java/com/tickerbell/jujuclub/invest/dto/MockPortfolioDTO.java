package com.tickerbell.jujuclub.invest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MockPortfolioDTO {

    private int portfolioSeq;
    private int userSeq;
    private int stockSeq;
    private int quantity;
    private int avgPrice;
    private LocalDateTime updatedAt;

}

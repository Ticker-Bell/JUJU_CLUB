package com.tickerbell.jujuclub.auth.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AccountDTO {
    private String userId;
    private Long accountNo;
    private Long cashBalance;
    private Date createdAt;
    private Date updatedAt;
}

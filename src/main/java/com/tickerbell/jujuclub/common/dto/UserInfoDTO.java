package com.tickerbell.jujuclub.common.dto;

import lombok.Data;

@Data
public class UserInfoDTO {
    private Integer userSeq; // user_seq
    private String userName;    // user_name 과 매핑될 곳
    private Integer userLevel;  // user_level 과 매핑될 곳
    private String cashBalance; // cash_balance 와 매핑될 곳
}

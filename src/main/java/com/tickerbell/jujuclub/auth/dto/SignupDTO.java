package com.tickerbell.jujuclub.auth.dto;

import lombok.Data;

@Data
public class SignupDTO {
    private String userId;
    private String userPw;
    private String userName;
}

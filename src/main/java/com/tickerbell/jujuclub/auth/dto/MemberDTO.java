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
public class MemberDTO {
    private Long userSeq;
    private String userId;
    private String userPw;
    private String userName;
    private Date createdAt;
    private Integer userLevel;
}

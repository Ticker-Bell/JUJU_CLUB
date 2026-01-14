package com.tickerbell.jujuclub.auth.dto;


import lombok.*;

import java.util.Date;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SigninDTO {

  private String userId;
  private String userPw;
  private String userName;
  private Date createdAt;
  private int userLevel;
}

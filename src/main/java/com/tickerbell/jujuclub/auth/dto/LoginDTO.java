package com.tickerbell.jujuclub.auth.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LoginDTO {

  private String user_id;
  private String user_pw;
  private String user_name;
  private String created_at;
  private String level;
}

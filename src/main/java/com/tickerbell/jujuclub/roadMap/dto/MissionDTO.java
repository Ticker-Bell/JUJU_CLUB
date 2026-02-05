package com.tickerbell.jujuclub.roadMap.dto;

import lombok.Data;

@Data
public class MissionDTO {
    private Integer missionId; // mission_seq
    private String type; // mission_type
    private String content; // mission_title,varchar(50)
    private Integer reward; //mission_reward
    private Integer count; // target_value
    private Integer progress; // 현재진행 횟수 저장
    private String isSuccess; // 미션 완료여부 확인
    private String isRewarded; // 보상금 지급여부 확인
}

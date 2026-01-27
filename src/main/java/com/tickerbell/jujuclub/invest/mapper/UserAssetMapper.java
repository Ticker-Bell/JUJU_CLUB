package com.tickerbell.jujuclub.invest.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserAssetMapper {
    Long selectCashBalance(@Param("user_seq") int userSeq);
    Long selectChapTestReward(@Param("user_seq") int userSeq);
    Long selectMissionReward(@Param("user_seq") int userSeq);
    Long selectUserTotalReward(@Param("user_seq") int userSeq);
}

package com.tickerbell.jujuclub.invest.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserAssetMapper {

    /**
     * 사용자가 보유한 예수금 조회
     *
     * @param userSeq int
     * @return Long
     */
    Long selectCashBalance(@Param("user_seq") int userSeq);

    /**
     * 사용자 챕터 테스트 보상 합계 조회
     *
     * @param userSeq int
     * @return Long
     */
    Long selectChapTestReward(@Param("user_seq") int userSeq);

    /**
     * 사용자 미션 보상 합계 조회
     *
     * @param userSeq int
     * @return Long
     */
    Long selectMissionReward(@Param("user_seq") int userSeq);

    /**
     * 사용자 보상 전체(미션, 테스트) 총 합 조회
     *
     * @param userSeq int
     * @return Long
     */
    Long selectUserTotalReward(@Param("user_seq") int userSeq);
}

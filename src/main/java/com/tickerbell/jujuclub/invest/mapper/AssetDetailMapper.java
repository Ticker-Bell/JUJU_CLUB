package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.MockTradeDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AssetDetailMapper {

    /**
     * 유저 모의 체결 내역 조회
     *
     * @param userSeq int
     * @return List&lt;MockTradeDTO&gt;
     */
    List<MockTradeDTO> findUserTrades(int userSeq);
}

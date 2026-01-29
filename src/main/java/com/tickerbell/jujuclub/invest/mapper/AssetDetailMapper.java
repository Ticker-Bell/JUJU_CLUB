package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.MockTradeDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AssetDetailMapper {
    List<MockTradeDTO> findUserTrades(int userSeq);
}

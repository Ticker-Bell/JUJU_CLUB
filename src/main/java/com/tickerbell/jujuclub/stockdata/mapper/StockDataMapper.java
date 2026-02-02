package com.tickerbell.jujuclub.stockdata.mapper;

import com.tickerbell.jujuclub.stockdata.dto.StockDataDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StockDataMapper {

    /**
     * 주식 종목 정보 DB에 삽입
     *
     * @param stockDataDTO StockDataDTO
     * @return int
     */
    int insert(StockDataDTO stockDataDTO);
}

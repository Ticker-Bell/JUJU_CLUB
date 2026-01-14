package com.tickerbell.jujuclub.stockdata.mapper;

import com.tickerbell.jujuclub.stockdata.dto.StockDataDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StockDataMapper {
    int insert(StockDataDTO stockDataDTO);
}

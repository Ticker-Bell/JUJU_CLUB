package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.WatchListDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StockChartDataMapper {
    String selectMarketType(String stockCode);
    void insertWatchList(WatchListDTO watchListDTO);
    void deleteWatchList(WatchListDTO watchListDTO);
    boolean selectWatchListByUserStock(WatchListDTO watchListDTO);
}

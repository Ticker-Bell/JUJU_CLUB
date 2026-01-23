package com.tickerbell.jujuclub.invest.stockChart.mapper;

import com.tickerbell.jujuclub.invest.stockChart.dto.WatchListDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StockChartDataMapper {
    String selectMarketType(String stockCode);
    void insertWatchList(WatchListDTO watchListDTO);
    void deleteWatchList(WatchListDTO watchListDTO);
}

package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.WatchListDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StockChartDataMapper {
    /**
     * 주식 장 DB조회
     *
     * @param stockCode String
     * @return String
     */
    String selectMarketType(String stockCode);

    /**
     * 관심 종목 DB 삽입
     *
     * @param watchListDTO WatchListDTO
     */
    void insertWatchList(WatchListDTO watchListDTO);

    /**
     * 관심 종목 DB 제거
     *
     * @param watchListDTO WatchListDTO
     */
    void deleteWatchList(WatchListDTO watchListDTO);

    /**
     * 관심 종목 여부 DB 조회
     * @param watchListDTO WatchListDTO
     * @return boolean
     */
    boolean selectWatchListByUserStock(WatchListDTO watchListDTO);
}

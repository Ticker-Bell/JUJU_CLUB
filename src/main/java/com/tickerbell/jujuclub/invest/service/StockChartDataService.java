package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.WatchListDTO;
import com.tickerbell.jujuclub.invest.mapper.StockChartDataMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class StockChartDataService {
    private final StockChartDataMapper stockChartDataMapper;

    /**
     * 주식 장 DB 조회 서비스
     *
     * @param stockCode String
     * @return String
     */
    public String selectMarketType(String stockCode) {
        log.info("[{}]: 주식 장 DB 조회 서비스 시작", stockCode);
        String result = stockChartDataMapper.selectMarketType(stockCode);
        log.info("[{}]: 주식 장 DB 조회 서비스 완료", stockCode);

        return result;
    }

    /**
     * 관심 종목 DB 삽입 서비스
     *
     * @param watchListDTO WatchListDTO
     */
    public void insertWatchList(WatchListDTO watchListDTO) {
        log.info("[{}]: 관심 종목 DB 삽입 서비스 시작", watchListDTO);
        stockChartDataMapper.insertWatchList(watchListDTO);
        log.info("[{}]: 관심 종목 DB 삽입 서비스 완료", watchListDTO);

    }

    /**
     * 관심 종목 DB 제거 서비스
     *
     * @param watchListDTO WatchListDTO
     */
    public void deleteWatchList(WatchListDTO watchListDTO) {
        log.info("[{}]: 관심 종목 DB 제거 서비스 시작", watchListDTO);
        stockChartDataMapper.deleteWatchList(watchListDTO);
        log.info("[{}]: 관심 종목 DB 제거 서비스 완료", watchListDTO);

    }

    /**
     * 관심 종목 여부 DB 조회 서비스
     *
     * @param watchListDTO WatchListDTO
     * @return boolean
     */
    public boolean selectWatchlist(WatchListDTO watchListDTO) {
        log.info("[{}]: 관심 종목 여부 DB 조회 서비스 시작", watchListDTO);
        boolean isSelectedWatchlist = stockChartDataMapper.selectWatchListByUserStock(watchListDTO);
        log.info("[{}]: 관심 종목 여부 DB 조회 서비스 완료", watchListDTO);
        return isSelectedWatchlist;
    }

}

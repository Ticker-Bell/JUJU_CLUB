package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.WatchListDTO;
import com.tickerbell.jujuclub.invest.mapper.StockChartDataMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class StockChartDataService {
    private final StockChartDataMapper stockChartDataMapper;

    public String selectMarketType(String stockCode) {
        return stockChartDataMapper.selectMarketType(stockCode);
    }

    public void insertWatchList(WatchListDTO watchListDTO) {
        stockChartDataMapper.insertWatchList(watchListDTO);
    }

    public void deleteWatchList(WatchListDTO watchListDTO) {
        stockChartDataMapper.deleteWatchList(watchListDTO);
    }

    public boolean selectWatchlist(WatchListDTO watchListDTO) { return stockChartDataMapper.selectWatchListByUserStock( watchListDTO);}

}

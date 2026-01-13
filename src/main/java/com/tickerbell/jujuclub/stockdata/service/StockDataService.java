package com.tickerbell.jujuclub.stockdata.service;

import com.tickerbell.jujuclub.stockdata.dto.StockDataDTO;
import com.tickerbell.jujuclub.stockdata.mapper.StockDataMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class StockDataService {

    private final StockDataMapper stockDataMapper;

    public int insert(StockDataDTO stockDataDTO) {
        return stockDataMapper.insert(stockDataDTO);
    }
}

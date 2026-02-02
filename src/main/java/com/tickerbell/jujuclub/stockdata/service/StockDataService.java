package com.tickerbell.jujuclub.stockdata.service;

import com.tickerbell.jujuclub.stockdata.dto.StockDataDTO;
import com.tickerbell.jujuclub.stockdata.mapper.StockDataMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class StockDataService {

    private final StockDataMapper stockDataMapper;

    /**
     * 주식 종목 정보 DB에 삽입
     *
     * @param stockDataDTO StockDataDTO
     * @return int
     */
    public int insert(StockDataDTO stockDataDTO) {
        log.info("[{}] DB 삽입 시작", stockDataDTO.getStockCode() + " " + stockDataDTO.getStockName());

        int response = stockDataMapper.insert(stockDataDTO);

        log.info("[{}] DB 삽입 완료", stockDataDTO.getStockCode() + " " + stockDataDTO.getStockName());
        return response;
    }
}

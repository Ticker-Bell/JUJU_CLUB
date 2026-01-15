package com.tickerbell.jujuclub.invest.stockList.service;

import com.tickerbell.jujuclub.invest.stockList.dto.StockDTO;
import com.tickerbell.jujuclub.invest.stockList.mapper.StockMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StockService {

    private final StockMapper stockMapper;

    public StockDTO findBySeq(Integer seq) {return stockMapper.findBySeq(seq);}

    public List<StockDTO> findStockCodeListFromUserWatchList(Integer UserSeq) {return stockMapper.findStockCodeListFromUserWatchList(UserSeq);}
}

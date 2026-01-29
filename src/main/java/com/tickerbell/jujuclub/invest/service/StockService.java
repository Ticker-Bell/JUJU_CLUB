package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.StockDTO;
import com.tickerbell.jujuclub.invest.mapper.StockMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StockService {

    private final StockMapper stockMapper;

    public StockDTO findBySeq(Integer seq) {return stockMapper.findBySeq(seq);}

    public List<StockDTO> findStockListFromUserWatchList(Integer UserSeq) {return stockMapper.findStockListFromUserWatchList(UserSeq);}

    public List<StockDTO> getSearchList(String keyword) {return stockMapper.getSearchList(keyword);}
}

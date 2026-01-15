package com.tickerbell.jujuclub.invest.stockList.mapper;

import com.tickerbell.jujuclub.invest.stockList.dto.StockDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StockMapper {
    StockDTO findBySeq(Integer seq);

    List<StockDTO> findStockCodeListFromUserWatchList(Integer UserSeq);
}

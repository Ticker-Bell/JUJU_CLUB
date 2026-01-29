package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.StockDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StockMapper {
    StockDTO findBySeq(Integer seq);

    List<StockDTO> findStockListFromUserWatchList(Integer UserSeq);

    List<StockDTO> getSearchList(String keyword);
}

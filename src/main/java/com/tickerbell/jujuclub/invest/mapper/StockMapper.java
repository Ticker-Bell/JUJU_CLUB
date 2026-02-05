package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.StockDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StockMapper {

    /**
     * 유저가 즐겨찾기한 종목들 조회
     *
     * @param UserSeq Integer
     * @return List&lt;StockDTO&gt;
     */
    List<StockDTO> findStockListFromUserWatchList(Integer UserSeq);

    /**
     * 검색창에서 입력한 내용을 포함한 종목들 조회
     *
     * @param keyword string
     * @return List&lt;StockDTO&gt;
     */
    List<StockDTO> getSearchList(String keyword);
}

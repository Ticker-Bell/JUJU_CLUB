package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.TradeDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TradeMapper {
    int selectBalance(int userSeq);

    void updateBalance(@Param("userSeq") int userSeq, @Param("amount") int amount);

   Integer selectHoldings(TradeDTO tradeDTO);

    void upsertHoldings(TradeDTO tradeDTO);

    void deleteHoldings();

    void insertTradeHistory(TradeDTO tradeDTO);

    int selectStockSeq(String stockCode);
}

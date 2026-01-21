package com.tickerbell.jujuclub.invest.trade.mapper;

import com.tickerbell.jujuclub.invest.trade.dto.TradeDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TradeMapper {
    int selectBalance(int userSeq);

    void updateBalance(@Param("userSeq") int userSeq, @Param("amount") int amount);

   Integer selectHoldings(int stockSeq);

    void upsertHoldings(TradeDTO tradeDTO);

    void deleteHoldings();

    void insertTradeHistory(TradeDTO tradeDTO);
}

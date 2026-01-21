package com.tickerbell.jujuclub.invest.trade.mapper;

import com.tickerbell.jujuclub.invest.trade.dto.TradeDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TradeMapper {
    int selectBalance(@Param("userSeq") int userSeq);

    void updateBalance(@Param("userSeq") int userSeq, @Param("amount") int amount);

   int selectHoldings(@Param("stockSeq") int stockSeq);

    void upsertHoldings(@Param("9") TradeDTO tradeDTO, @Param("updateQuantity") int updateQuantity);

    void insertTradeHistory(TradeDTO tradeDTO);
}

package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.TradeDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TradeMapper {
    /**
     * 사용자 잔고 DB 조회
     *
     * @param userSeq int
     * @return int
     */
    int selectBalance(int userSeq);

    /**
     * 사용자 잔고 DB 갱신
     *
     * @param userSeq int
     * @param amount int
     */
    void updateBalance(@Param("userSeq") int userSeq, @Param("amount") int amount);

    /**
     * 보유 주식 수량 DB 조회
     *
     * @param tradeDTO TradeDTO
     * @return Integer
     */
   Integer selectHoldings(TradeDTO tradeDTO);

    /**
     * 보유 주식 DB 삽입 및 갱신
     *
     * @param tradeDTO TradeDTO
     */
    void upsertHoldings(TradeDTO tradeDTO);

    /**
     * 보유 주식 DB 삭제
     */
    void deleteHoldings();

    /**
     * 주식 거래 내역 DB 삽입
     *
     * @param tradeDTO TradeDTO
     */
    void insertTradeHistory(TradeDTO tradeDTO);

    /**
     * stockCode에서 stockSeq로 변환
     *
     * @param stockCode String
     * @return int
     */
    int selectStockSeq(String stockCode);
}

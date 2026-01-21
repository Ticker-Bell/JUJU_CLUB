package com.tickerbell.jujuclub.invest.trade.service;

import com.tickerbell.jujuclub.invest.trade.dto.TradeDTO;
import com.tickerbell.jujuclub.invest.trade.mapper.TradeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TradeService {

    @Autowired
    private TradeMapper tradeMapper;

    @Transactional
    public String processTrade(TradeDTO tradeDTO) {
        int userSeq = tradeDTO.getUserSeq();
        int tradeQuantity = tradeDTO.getTradeQuantity();

        int totalAmount = tradeDTO.getTradePrice() * tradeQuantity;
        int updateQuantity = "Y".equals(tradeDTO.getTradeType()) ? tradeQuantity : -tradeQuantity;
        int amountChange = "Y".equals(tradeDTO.getTradeType()) ? -totalAmount : totalAmount;

        tradeMapper.updateBalance(userSeq, amountChange);

        tradeMapper.upsertHoldings(tradeDTO, updateQuantity);
        tradeMapper.insertTradeHistory(tradeDTO);

        return "트랜지션이 처리되었습니다.";
    }

    public int getStockQuantity(TradeDTO tradeDTO){
        return  tradeMapper.selectHoldings(tradeDTO.getStockSeq());
    }
}
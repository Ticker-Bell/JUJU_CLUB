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

        int currentbalance = tradeMapper.selectBalance(userSeq);
        int totalAmount = tradeDTO.getTradePrice() * tradeQuantity;

        int amountChange = "Y".equals(tradeDTO.getTradeType()) ? -totalAmount : totalAmount;
        System.out.println(amountChange);
        tradeMapper.updateBalance(userSeq, amountChange);


        tradeMapper.upsertHoldings(tradeDTO);

        tradeDTO.setTradeQuantity(tradeQuantity);

        tradeMapper.insertTradeHistory(tradeDTO);

        return "트랜지션이 처리되었습니다.";
    }
}
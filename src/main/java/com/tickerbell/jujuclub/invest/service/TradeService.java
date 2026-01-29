package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.TradeDTO;
import com.tickerbell.jujuclub.invest.mapper.TradeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TradeService {

    @Autowired
    private TradeMapper tradeMapper;

    @Transactional(rollbackFor = Exception.class)
    public String processTrade(TradeDTO tradeDTO) {
        int userSeq = tradeDTO.getUserSeq();
        Integer stockSeq = tradeMapper.selectStockSeq(tradeDTO.getStockCode().trim());
        if (stockSeq == null) {
            throw new IllegalArgumentException("존재하지 않는 종목입니다.");
        }


        tradeDTO.setStockSeq(stockSeq);
        int tradeQuantity = tradeDTO.getTradeQuantity();

        int totalAmount = tradeDTO.getTradePrice() * tradeQuantity;
        int amountChange = "Y".equals(tradeDTO.getTradeType()) ? -totalAmount : totalAmount;

        int userBalance = tradeMapper.selectBalance(userSeq);
        Integer userQuantity = tradeMapper.selectHoldings(tradeDTO);

        //예외처리
        if (tradeDTO.getTradeType().equals("Y")&& totalAmount>userBalance) {
            //예상 금액>현재 보유 자금
            throw new RuntimeException("매수 금액이 현재 보유 자금을 초과하였습니다.");

        }else {
            if(tradeDTO.getTradeType().equals("N")&&userQuantity == null){
                throw new RuntimeException("현재 보유하고 있는 종목이 아닙니다.");
            } else if (tradeDTO.getTradeType().equals("N")&&tradeQuantity>userQuantity) {
                throw new RuntimeException("매도 수량이 현재 보유 수량을 초과하였습니다.");
            }
        }
        if(totalAmount<=0){
            throw new RuntimeException("수량을 확인해주세요. 양의 정수만 가능합니다.");
        }
        tradeDTO.setTotalAmount(totalAmount);
        tradeMapper.upsertHoldings(tradeDTO);
        tradeMapper.updateBalance(userSeq, amountChange);
        tradeMapper.deleteHoldings();
        tradeMapper.insertTradeHistory(tradeDTO);

        return "트랜지션이 처리되었습니다.";
    }

    public Integer getStockQuantity(TradeDTO tradeDTO){
        return  tradeMapper.selectHoldings(tradeDTO);
    }
}
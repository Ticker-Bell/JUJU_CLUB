package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.TradeDTO;
import com.tickerbell.jujuclub.invest.mapper.TradeMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
public class TradeService {

    @Autowired
    private TradeMapper tradeMapper;

    /**
     * 주식 거래 DB 서비스
     * @param tradeDTO TradeDTO
     * @return String
     */
    @Transactional(rollbackFor = Exception.class)
    public String processTrade(TradeDTO tradeDTO) {
        int userSeq = tradeDTO.getUserSeq();
        log.info("[{}]: stockCode로 stockSeq DB 조회 서비스 시작",tradeDTO.getStockCode());
        Integer stockSeq = tradeMapper.selectStockSeq(tradeDTO.getStockCode().trim());
        log.info("[{}]:  stockCode로 stockSeq DB 조회 서비스 완료", tradeDTO.getStockCode());

        if (stockSeq == null) {
            throw new IllegalArgumentException("존재하지 않는 종목입니다.");
        }


        tradeDTO.setStockSeq(stockSeq);
        int tradeQuantity = tradeDTO.getTradeQuantity();

        int totalAmount = tradeDTO.getTradePrice() * tradeQuantity;
        int amountChange = "Y".equals(tradeDTO.getTradeType()) ? -totalAmount : totalAmount;

        log.info("[{}]: 주식 거래 잔고 DB 조회 서비스 시작",userSeq);
        int userBalance = tradeMapper.selectBalance(userSeq);
        log.info("[{}]: 주식 거래 잔고 DB 조회 서비스 완료",userSeq);

        Integer userQuantity = getStockQuantity(tradeDTO);

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

        log.info("[{}]: 주식 거래 보유 주식 DB 삽입 및 갱신 서비스 시작", tradeDTO);
        tradeMapper.upsertHoldings(tradeDTO);
        log.info("[{}]:  주식 거래 보유 주식 DB 삽입 및 갱신 서비스 완료", tradeDTO);

        log.info("[{}, {}]: 주식 거래 잔고 DB 갱신 서비스 시작", userSeq, amountChange);
        tradeMapper.updateBalance(userSeq, amountChange);
        log.info("[{}, {}]: 주식 거래 잔고 DB 갱신 서비스 완료", userSeq, amountChange);

        log.info("주식 거래 보유 주식 DB 삭제 서비스 시작");
        tradeMapper.deleteHoldings();
        log.info("주식 거래 보유 주식 DB 삭제 서비스 완료");

        log.info("[{}]: 주식 거래 내역 DB 삽입 시작", tradeDTO);
        tradeMapper.insertTradeHistory(tradeDTO);
        log.info("[{}]: 주식 거래 내역 DB 삽입 완료", tradeDTO);

        return "트랜지션이 처리되었습니다.";
    }

    /**
     * 사용자 보유 주식 수량
     * @param tradeDTO TradeDTO
     * @return Integer
     */
    public Integer getStockQuantity(TradeDTO tradeDTO){
        log.info("[{}]: 주식 거래 보유 수량 DB 조회 시작", tradeDTO);
        Integer userQuantity =  tradeMapper.selectHoldings(tradeDTO);
        log.info("[{}]: 주식 거래 보유 수량 DB 조회 완료", tradeDTO);

        return userQuantity;
    }
}
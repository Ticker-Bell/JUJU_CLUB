package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.dto.PortfolioAllocationItemDTO;
import com.tickerbell.jujuclub.invest.mapper.PortfolioMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PortfolioService {

    //현재가, 평가손익(pnl), 비중 계산(pct)
    private final PortfolioMapper portfolioMapper;
    private final KISApiService kisApiService;

    public List<PortfolioAllocationItemDTO> getPortfolioAllocationItems(int userSeq){

        List<PortfolioAllocationItemDTO> items = portfolioMapper.selectPortfolioList(userSeq);

        long totalStockPrice = 0L; //전체 주식 평가금액 합(pct 계산)
        //현재가, 평가손익, 전체금액 합산 구하기
        for (PortfolioAllocationItemDTO data : items){
            KISDataDTO kisDataDTO = kisApiService.getPriceData(data.getStockCode());

            //api호출 조절하기
            try {
                Thread.sleep(100); //0.1초 멈춤
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            int currentPrice = (kisDataDTO == null) ? 0 : kisDataDTO.getCurrentPrice(); //현재가
            data.setCurrentPrice(currentPrice);
            //평균단가는 DB에 저장되어있음
            long currentValue = (long)currentPrice * data.getQuantity(); //주식 한 종목 총 투자금
            totalStockPrice += currentValue;
            //매수, 매도 체결시 update 필요
            long pnl = (long)(currentPrice - data.getAvgPrice()) * data.getQuantity(); //평가손익
            data.setPnl(pnl);
        }
        //주식 각 항목 보유 퍼센트 구하기
        if(totalStockPrice <= 0L){
            for(PortfolioAllocationItemDTO data : items){
                data.setWeightPct(0.0);
            }
            return items;
        }
        //pnl
        for(PortfolioAllocationItemDTO data : items){
            long currentValue = (long)data.getCurrentPrice() * data.getQuantity();

            double weightPct = BigDecimal.valueOf(currentValue)
                    .multiply(BigDecimal.valueOf(100))
                    .divide(BigDecimal.valueOf(totalStockPrice), 2, RoundingMode.HALF_UP)
                    .doubleValue();

            data.setWeightPct(weightPct);
        }

        return items;
    }

    public int calAvgPrice(int userSeq, int stockSeq, int quantity, int price){
        //체결시 업데이트 필요
        return 0;
    }

}

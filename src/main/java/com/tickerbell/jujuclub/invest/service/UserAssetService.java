package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.PortfolioAllocationItemDTO;
import com.tickerbell.jujuclub.invest.dto.UserInvestSummeryDTO;
import com.tickerbell.jujuclub.invest.mapper.UserAssetMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserAssetService {

    //총 평가 자산(보유 현금 + 투자금)(변함)
    //보유 현금(USER_ACCOUNT.cash_balance)
    //투자금(주식평가금액) = 현재가 * 보유수량(변함)
    //수익률 = (( 총 평가자산 - 초기자산(온보딩 후 받는 자산) ) / 초기자산) * 100(변함)

    private final UserAssetMapper userAssetMapper;
    private final PortfolioService portfolioService;
    private static final long initial_cash = 1000000L; //초기자산 100만원

    public UserInvestSummeryDTO getUserInvestSummary(int userSeq){

        //현금(DB에 값 들어있음)
        Long cashBalance = userAssetMapper.selectCashBalance(userSeq);
        if(cashBalance == null){
            cashBalance = 0L;
        }
        //포트폴리오 - currentPrice
        List<PortfolioAllocationItemDTO> items = portfolioService.getPortfolioAllocationItems(userSeq);

        long totalUserAsset = 0L; //총 평가자산 = 보유 현금 + (현재가 * 수량)
        //주식 평가금액 계산
        long totalStockValue = 0L;
        for (PortfolioAllocationItemDTO data : items) {
            totalStockValue += (long)data.getCurrentPrice() * data.getQuantity();
        }

        //총 평가자산 계산
        totalUserAsset = cashBalance + totalStockValue;

        //수익률 계산
        double totalReturnPct = 0.0;
        if (initial_cash > 0) {
            //
            totalReturnPct = ( (double)( totalUserAsset - initial_cash ) / initial_cash ) * 100;
        }

        //DTO만들어서 return
        return UserInvestSummeryDTO.builder()
                .totalAsset(totalUserAsset)
                .cashBalance(cashBalance)
                .totalStockValue(totalStockValue)
                .totalReturnPct(totalReturnPct)
                .build();

    }

}

package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.PortfolioAllocationItemDTO;
import com.tickerbell.jujuclub.invest.dto.UserInvestSummeryDTO;
import com.tickerbell.jujuclub.invest.mapper.UserAssetMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserAssetService {

    private final UserAssetMapper userAssetMapper;
    private final PortfolioService portfolioService;
    private static final long initial_cash = 1000000L; //초기자산 100만원

    @Transactional(readOnly = true)
    public UserInvestSummeryDTO getUserInvestSummary(int userSeq){

        //1.예수금(cash_balance)
        Long cashBalance = userAssetMapper.selectCashBalance(userSeq);
        if(cashBalance == null){
            cashBalance = 0L;
        }

        //2.주식평가금액
        long totalStockValue = 0L;

        List<PortfolioAllocationItemDTO> portfolioList = portfolioService.getPortfolioAllocationItems(userSeq);

        for(PortfolioAllocationItemDTO data : portfolioList){
            totalStockValue += (long)data.getQuantity() * data.getCurrentPrice();
        }

        //3.총 평가자산
        long totalAsset = cashBalance + totalStockValue;

        //4.원금(초기자금 + 보상금)
//        Long totalReward = userAssetMapper.selectChapTestReward(userSeq) + userAssetMapper.selectMissionReward(userSeq);
        Long totalReward = userAssetMapper.selectUserTotalReward(userSeq);
        if(totalReward == null){
            totalReward = 0L;
        }
        long totalPrincipal = initial_cash + totalReward;

        //5.총 수익률
        long totalProfit = totalAsset - totalPrincipal; //총 수익금
        double totalReturnProfit = 0.0;
        if(totalPrincipal > 0){
            totalReturnProfit = ((double) totalProfit / totalPrincipal) * 100;
        }

        return UserInvestSummeryDTO.builder()
                .totalAsset(totalAsset) //총 평가자산
                .cashBalance(cashBalance) //보유현금
                .totalStockValue(totalStockValue) //총 평가자산
                .totalReturnPct(totalReturnProfit) //총 수익률
                .build();

    }

}

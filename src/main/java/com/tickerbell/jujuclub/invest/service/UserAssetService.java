package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.PortfolioDTO;
import com.tickerbell.jujuclub.invest.dto.UserInvestSummeryDTO;
import com.tickerbell.jujuclub.invest.mapper.UserAssetMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserAssetService {

  private final UserAssetMapper userAssetMapper;
  private final PortfolioService portfolioService;
  private static final long initial_cash = 1000000L; //초기자산 100만원

  /**
   * 모의투자 - 마이페이지 유저 자산 정보 계산 예수금 cashBalance : user_account.cash_balance 총 주식평가금액 totalStockValue :
   * 보유 수량 * 현재가 합 원금 totalPrincipal : 초기자산(initial_cash) + 누적 보상금(totalReward) 총 수익금 totalProfit :
   * 총 평가자산 - 원금 총 수익률 totalReturnPct : (총 수익금 / 원금) * 100
   *
   * @param userSeq int
   * @return UserInvestSummeryDTO
   */
  @Transactional(readOnly = true)
  public UserInvestSummeryDTO getUserInvestSummary(int userSeq) {

    try {
      log.info("[{}] 유저 자산 정보 조회 - 예수금 DB 조회 시작", userSeq);
      //1.예수금(cash_balance)
      Long cashBalance = userAssetMapper.selectCashBalance(userSeq);
      if (cashBalance == null) {
        cashBalance = 0L;
      }
      log.info("[{}] 유저 자산 정보 조회 - 예수금 DB 조회 종료 cashBalance={}", userSeq, cashBalance);

      log.info("[{}] 유저 자산 정보 조회 - 포트폴리오 항목 조회 시작", userSeq);
      //2.총 주식평가금액
      long totalStockValue = 0L;

      List<PortfolioDTO> portfolioList = portfolioService.getPortfolioAllocationItems(
          userSeq);
      log.info("[{}] 유저 자산 정보 조회 - 포트폴리오 항목 조회 종료 items={}", userSeq, portfolioList);
      if (portfolioList != null) {
        for (PortfolioDTO data : portfolioList) {
          totalStockValue += (long) data.getQuantity() * data.getCurrentPrice();
        }
      }

      //3.총 평가자산
      long totalAsset = cashBalance + totalStockValue;

      //4.원금(초기자금 + 보상금 - 미션, 테스트 등)
//        Long totalReward = userAssetMapper.selectChapTestReward(userSeq) + userAssetMapper.selectMissionReward(userSeq);
      log.info("[{}] 유저 자산 정보 조회 - 누적 보상금 DB 조회 시작", userSeq);
      Long totalReward = userAssetMapper.selectUserTotalReward(userSeq); //보상금
      if (totalReward == null) {
        totalReward = 0L;
      }
      log.info("[{}] 유저 자산 정보 조회 - 누적 보상금 DB 조회 종료 totalReward={}", userSeq, totalReward);

      long totalPrincipal = initial_cash + totalReward;

      //5.총 수익률(총 평가자산 - 원금)
      long totalProfit = totalAsset - totalPrincipal; //총 수익금
      double totalReturnProfit = 0.0;
      if (totalPrincipal > 0) {
        totalReturnProfit = ((double) totalProfit / totalPrincipal) * 100;
      }

      log.info(
          "[{}] 유저 자산 정보 계산 완료 - totalAsset={}, cashBalance={}, totalStockValue={}, totalPrincipal={}, totalProfit={}, totalReturnPct={}",
          userSeq, totalAsset, cashBalance, totalStockValue, totalPrincipal, totalProfit,
          totalReturnProfit);

      return UserInvestSummeryDTO.builder()
          .totalAsset(totalAsset) //총 평가자산
          .cashBalance(cashBalance) //예수금
          .totalStockValue(totalStockValue) //총 평가금액
          .totalReturnPct(totalReturnProfit) //총 수익률
          .itemDTOList(portfolioList)
          .build();

    } catch (Exception e) {
      log.error("[{}] 유저 자산 정보 조회, 계산 실패", userSeq, e);
      throw new RuntimeException(e);
    }
  }
}

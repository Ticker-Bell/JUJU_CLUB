package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.dto.PortfolioAllocationItemDTO;
import com.tickerbell.jujuclub.invest.mapper.PortfolioMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class PortfolioService {

    //현재가, 평가손익(pnl), 비중 계산(pct)
    private final PortfolioMapper portfolioMapper;
    private final KISApiService kisApiService;

    /**
     * 모의투자 마이페이지 - 사용자 보유 주식 리스트 조회
     * 사용자 별 보유 포트폴리오 항목을 조회하고, 각 종목별 현재가, 평가손익(pnl), 포트폴리오 비중(%) 계산
     *
     * @param userSeq int
     * @return List &lt;PortfolioAllocationItemDTO&gt;
     */
    public List<PortfolioAllocationItemDTO> getPortfolioAllocationItems(int userSeq) {
        try {
            log.info("[{}] 포트폴리오 항목 조회 - mock_portfolio DB 조회 시작", userSeq);
            List<PortfolioAllocationItemDTO> items = portfolioMapper.selectPortfolioList(userSeq);
            log.info("[{}] 포트폴리오 항목 조회 - mock_portfolio DB 조회 종료 items={}", userSeq, (items == null ? 0 : items.size()));

            if (items == null || items.isEmpty()) {
                log.info("[{}] 포트폴리오 항목 없음", userSeq);
                return java.util.Collections.emptyList(); //빈 리스트 반환
            }

            long totalStockPrice = 0L; //전체 주식 평가금액 합(pct 계산)
            int index = 1;

            //현재가, 평가손익, 전체금액 합산 구하기
            for (PortfolioAllocationItemDTO data : items) {
                log.info("[{}] 포트폴리오 항목 처리 시작 - [{}] stockCode={}", userSeq, index, data.getStockCode());
                //KIS 현재가 조회
                KISDataDTO kisDataDTO = kisApiService.getPriceData(data.getStockCode());
                if (kisDataDTO == null) {
                    log.warn("[{}] KIS 현재가 조회 실패(null) - stockCode={}", userSeq, data.getStockCode());
                }

                //api호출 조절하기
                try {
                    Thread.sleep(100); //0.1초 멈춤. 다음 API 호출 전 지연시키기
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    log.error("[{}] 포트폴리오 항목 처리 중 sleep 인터럽트 - stockCode={}", userSeq, data.getStockCode(), e);
                    throw new RuntimeException(e);
                }

                int currentPrice = (kisDataDTO == null) ? 0 : kisDataDTO.getCurrentPrice(); //현재가
                data.setCurrentPrice(currentPrice);
                //종목 평가금액
                long currentValue = (long) currentPrice * data.getQuantity(); //주식 한 종목 총 투자금
                totalStockPrice += currentValue;
                //평가손익(현재가 - 평균단가) * 수량
                long pnl = (long) (currentPrice - data.getAvgPrice()) * data.getQuantity(); //평가손익
                data.setPnl(pnl);

                log.info("[{}] 포트폴리오 항목 처리 종료 - [{}] stockCode={}, currentPrice={}, qty={}, avgPrice={}, pnl={}, currentValue={}", userSeq, index, data.getStockCode(), currentPrice, data.getQuantity(), data.getAvgPrice(), pnl, currentValue);
                index++;
            }

            log.info("[{}] 포트폴리오 항목 별 비중 계산 시작 - totalStockPrice={}", userSeq, totalStockPrice);
            //주식 각 항목 보유 퍼센트 구하기
            //totalStockPrice가 0이하면 비중 0으로 처리
            if (totalStockPrice <= 0L) {
                log.warn("[{}] totalStockPrice <= 0 이므로 weightPct를 0으로 설정", userSeq);
                for (PortfolioAllocationItemDTO data : items) {
                    data.setWeightPct(0.0);
                }
                return items;
            }
            //pnl
            //종목별 비중계산
            for (PortfolioAllocationItemDTO data : items) {
                long currentValue = (long) data.getCurrentPrice() * data.getQuantity();

                double weightPct = BigDecimal.valueOf(currentValue)
                        .multiply(BigDecimal.valueOf(100))
                        .divide(BigDecimal.valueOf(totalStockPrice), 2, RoundingMode.HALF_UP)
                        .doubleValue();

                data.setWeightPct(weightPct);
                log.info("[{}] 포트폴리오 비중 계산 - stockCode={}, currentValue={}, weightPct={}", userSeq, data.getStockCode(), currentValue, weightPct);
            }
            log.info("[{}] 포트폴리오 비중/평가손익 계산 완료", userSeq);
            return items;

        } catch (Exception e) {
            log.error("[{}] 포트폴리오 비중/평가손익 계산 실패", userSeq, e);
            throw new RuntimeException(e);
        }
    }
}

package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.dto.WatchlistItemDTO;
import com.tickerbell.jujuclub.invest.mapper.WatchlistMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class WatchlistService {

    private final WatchlistMapper watchlistMapper;
    private final KISApiService kisApiService;

    /**
     * 관심종목리스트 조회
     * 각 종목의 현재가, 등락률을 KIS Api로 값을 가져오고 현재가 내림차순 정렬 반환
     *
     * @param userSeq int
     * @return List&lt;WatchlistItemDTO&gt;
     */
    public List<WatchlistItemDTO> getWatchlistItems(int userSeq) {

        try{

            // 관심종목 리스트 조회
            //DB + KIS(currentPrice, changePct)
            log.info("[{}] 관심종목 조회 - DB 조회 시작", userSeq);
            List<WatchlistItemDTO> items = watchlistMapper.selectWatchlistItems(userSeq); //데이터베이스에서 목록 가져오기
            log.info("[{}] 관심종목 조회 - DB 조회 종료 (items={})", userSeq, (items == null ? 0 : items.size()));

            int index = 1; //log 용도
            for (WatchlistItemDTO data : items) { //현재가 채우기
                log.info("[{}] 관심종목 현재가 조회 시작 - [{}] stockCode={}", userSeq, index, data.getStockCode());
                KISDataDTO kisDataDTO = kisApiService.getPriceData(data.getStockCode()); //api 호출
                if (kisDataDTO != null) {
                    data.setCurrentPrice(kisDataDTO.getCurrentPrice());
                    data.setChangePct(kisDataDTO.getChangePct());
                } else {
                    log.warn("[{}] 관심종목 현재가 조회 실패(null) - stockCode={}", userSeq, data.getStockCode());
                }

                //api호출 조절하기
                try {
                    Thread.sleep(100); //0.1초 멈춤
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt(); //인터럽트 플래그 복구 -> 중단 처리 가능하게 도움
                    log.error("[{}] 관심종목 조회 중 sleep 인터럽트 에러 - stockCode={}", userSeq, data.getStockCode(), e);
                    throw new RuntimeException(e);
                }
                log.info("[{}] 관심종목 현재가 조회 종료 - [{}] stockCode={}, currentPrice={}, changePct={}", userSeq, index, data.getStockCode(), data.getCurrentPrice(), data.getChangePct());
                index++;
            }

            //현재가 높은 순 정렬
            items.sort(Comparator.comparingInt(WatchlistItemDTO::getCurrentPrice).reversed());
            log.info("[{}] 관심종목 조회 완료", userSeq);

            return items;
        } catch (Exception e) {
            log.error("[{}] 관심종목 조회 실패", userSeq, e);
            throw new RuntimeException(e);
        }
    }
}

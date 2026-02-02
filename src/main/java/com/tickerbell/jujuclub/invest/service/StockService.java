package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.StockDTO;
import com.tickerbell.jujuclub.invest.mapper.StockMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class StockService {

    private final StockMapper stockMapper;

    /**
     * 유저가 즐겨찾기한 종목들 조회
     *
     * @param UserSeq Integer
     * @return List&lt;StockDTO&gt;
     */
    public List<StockDTO> findStockListFromUserWatchList(Integer userSeq) {
        log.info("[{}] 유저가 즐겨찾기한 종목 DB 조회 시작", userSeq);

        List<StockDTO> response = stockMapper.findStockListFromUserWatchList(userSeq);

        log.info("[{}] 유저가 즐겨찾기한 종목 DB 조회 완료", userSeq);
        return response;
    }

    /**
     * 검색창에서 입력한 내용을 포함한 종목들 조회
     *
     * @param keyword string
     * @return List&lt;StockDTO&gt;
     */
    public List<StockDTO> getSearchList(String keyword) {
        log.info("[{}]를 포함한 종목 DB 조회 시작", keyword);

        List<StockDTO> response = stockMapper.getSearchList(keyword);

        log.info("[{}]를 포함한 종목 DB 조회 완료", keyword);
        return response;
    }
}

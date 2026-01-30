package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.MockTradeDTO;
import com.tickerbell.jujuclub.invest.mapper.AssetDetailMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AssetDetailService {
    private final AssetDetailMapper assetDetailMapper;

    /**
     * 유저 모의 체결 내역 조회
     *
     * @param userSeq int
     * @return List&lt;MockTradeDTO&gt;
     */
    public List<MockTradeDTO> findUserTrades(int userSeq){
        log.info("[{}] 유저의 모의 체결 내역 DB 조회 시작", userSeq);

        List<MockTradeDTO> response = assetDetailMapper.findUserTrades(userSeq);

        log.info("[{}] 유저의 모의 체결 내역 DB 조회 완료", userSeq);
        return response;
    }
}

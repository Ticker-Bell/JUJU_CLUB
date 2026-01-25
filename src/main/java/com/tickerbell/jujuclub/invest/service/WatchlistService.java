package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.dto.WatchlistItemDTO;
import com.tickerbell.jujuclub.invest.mapper.WatchlistMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WatchlistService {

    private final WatchlistMapper watchlistMapper;
    private final KISApiService kisApiService;

    public List<WatchlistItemDTO> getWatchlistItems(int userSeq){

        // 관심종목 리스트 조회
        //DB + KIS(currentPrice, changePct)
        List<WatchlistItemDTO> items = watchlistMapper.selectWatchlistItems(userSeq); //데이터베이스에서 목록 가져오기

        for(WatchlistItemDTO data : items){ //현재가 채우기
            KISDataDTO kisDataDTO = kisApiService.getPriceData(data.getStockCode()); //api 호출
            if(kisDataDTO != null){
                data.setCurrentPrice(kisDataDTO.getCurrentPrice());
                data.setChangePct(kisDataDTO.getChangePct());
            }
            //api호출 조절하기
            try {
                Thread.sleep(100); //0.1초 멈춤
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        return items;
    }

}

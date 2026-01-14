package com.tickerbell.jujuclub.stock.service;

import com.tickerbell.jujuclub.stock.dto.KISDataDTO;
import com.tickerbell.jujuclub.stock.dto.WatchlistItemDTO;
import com.tickerbell.jujuclub.stock.mapper.WatchlistMapper;
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

        List<WatchlistItemDTO> items = watchlistMapper.selectWatchlistItems(userSeq);

        for(WatchlistItemDTO data : items){
            KISDataDTO kisDataDTO = kisApiService.getPriceData(data.getStockCode());
            data.setCurrentPrice(kisDataDTO.getCurrentPrice());
            data.setChangePct(kisDataDTO.getChangePct());
        }

        return items;
    }

}

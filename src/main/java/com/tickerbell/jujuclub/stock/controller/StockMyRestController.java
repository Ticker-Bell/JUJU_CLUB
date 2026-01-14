package com.tickerbell.jujuclub.stock.controller;

import com.tickerbell.jujuclub.stock.dto.KISDataDTO;
import com.tickerbell.jujuclub.stock.dto.WatchlistItemDTO;
import com.tickerbell.jujuclub.stock.service.KISApiService;
import com.tickerbell.jujuclub.stock.service.WatchlistService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/stock/api")
public class StockMyRestController {

    //json반환

    private final WatchlistService watchlistService;
    private final KISApiService kisApiService;

    @GetMapping("/kisapitest")
    @ResponseBody
    public KISDataDTO test(@RequestParam("stockCode") String stockCode){
        return kisApiService.getPriceData(stockCode);
    }

    @GetMapping("/watchlist")
    public List<WatchlistItemDTO> watchlist(@RequestParam int userSeq){
        return watchlistService.getWatchlistItems(userSeq);
    }

}

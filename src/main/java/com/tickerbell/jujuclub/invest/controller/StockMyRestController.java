package com.tickerbell.jujuclub.invest.controller;

import com.tickerbell.jujuclub.invest.dto.KISDataDTO;
import com.tickerbell.jujuclub.invest.dto.PortfolioAllocationItemDTO;
import com.tickerbell.jujuclub.invest.dto.WatchlistItemDTO;
import com.tickerbell.jujuclub.invest.service.KISApiService;
import com.tickerbell.jujuclub.invest.service.PortfolioService;
import com.tickerbell.jujuclub.invest.service.WatchlistService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/stock/api")
public class StockMyRestController {

    private final PortfolioService portfolioService;
    private final WatchlistService watchlistService;
    private final KISApiService kisApiService;

    //json반환
    @GetMapping("/kisapitest")
    public KISDataDTO test(@RequestParam("stockCode") String stockCode){
        return kisApiService.getPriceData(stockCode);
    }
    @GetMapping("/watchlist")
    public List<WatchlistItemDTO> watchlist(@RequestParam int userSeq){
        return watchlistService.getWatchlistItems(userSeq);
    }
    @GetMapping("/holdinglisttest")
    public List<PortfolioAllocationItemDTO> portfolioAllocationItems(@RequestParam int userSeq){
        return portfolioService.getPortfolioAllocationItems(userSeq);
    }

}

package com.tickerbell.jujuclub.invest.stockChart.controller;

import com.tickerbell.jujuclub.invest.stockChart.dto.WatchListDTO;
import com.tickerbell.jujuclub.invest.stockChart.service.StockChartDataService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@RequestMapping("/stock/watchlist")
public class StockWatchListController {

    private final StockChartDataService stockChartDataService;

    @PostMapping
    @ResponseBody
    public void insertWatchList(@RequestBody WatchListDTO watchListDTO, HttpSession session) {
        Integer userSeq = (Integer) session.getAttribute("userSeq") == null ? 4 : (Integer) session.getAttribute("userSeq");
        watchListDTO.setUserSeq(userSeq);
        stockChartDataService.insertWatchList(watchListDTO);
    }

    @DeleteMapping
    @ResponseBody
    public void deleteWatchList(@RequestBody WatchListDTO watchListDTO, HttpSession session) {
        Integer userSeq = (Integer) session.getAttribute("userSeq") == null ? 4 : (Integer) session.getAttribute("userSeq");
        watchListDTO.setUserSeq(userSeq);
        stockChartDataService.deleteWatchList(watchListDTO);
    }

    @GetMapping("/isLiked")
    @ResponseBody
    public boolean selectWatchList(WatchListDTO watchListDTO, HttpSession session) {
        Integer userSeq = (session.getAttribute("userSeq") == null) ? 4 : (Integer) session.getAttribute("userSeq");
        watchListDTO.setUserSeq(userSeq);
        return stockChartDataService.selectWatchlist(watchListDTO);
    }


}


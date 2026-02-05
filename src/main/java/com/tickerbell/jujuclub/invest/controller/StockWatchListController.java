package com.tickerbell.jujuclub.invest.controller;

import com.tickerbell.jujuclub.invest.dto.WatchListDTO;
import com.tickerbell.jujuclub.invest.service.StockChartDataService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@RequestMapping("/stock/watchlist")
public class StockWatchListController {

    private final StockChartDataService stockChartDataService;

    /**
     * 관심 종목 등록
     *
     * @param watchListDTO WatchListDTO
     */
    @PostMapping
    @ResponseBody
    public void insertWatchList(@RequestBody WatchListDTO watchListDTO, HttpSession session) {
        Integer userSeq = (Integer) session.getAttribute("userSeq") == null ? 4 : (Integer) session.getAttribute("userSeq");
        watchListDTO.setUserSeq(userSeq);
        stockChartDataService.insertWatchList(watchListDTO);
    }


    /**
     * 관심 종목 삭제
     *
     * @param watchListDTO WatchListDTO
     */
    @DeleteMapping
    @ResponseBody
    public void deleteWatchList(@RequestBody WatchListDTO watchListDTO, HttpSession session) {
        Integer userSeq = (Integer) session.getAttribute("userSeq") == null ? 4 : (Integer) session.getAttribute("userSeq");
        watchListDTO.setUserSeq(userSeq);
        stockChartDataService.deleteWatchList(watchListDTO);
    }


    /**
     * 관심 종목 확인
     *
     * @param watchListDTO WatchListDTO
     * @return boolean 관심 종목 DB에 존재하면 true, 그렇지 않으면 false
     */
    @GetMapping("/isLiked")
    @ResponseBody
    public boolean selectWatchList(WatchListDTO watchListDTO, HttpSession session) {
        Integer userSeq = (session.getAttribute("userSeq") == null) ? 4 : (Integer) session.getAttribute("userSeq");
        watchListDTO.setUserSeq(userSeq);
        return stockChartDataService.selectWatchlist(watchListDTO);
    }


}


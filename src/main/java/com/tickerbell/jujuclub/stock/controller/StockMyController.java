package com.tickerbell.jujuclub.stock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/stock/my")
public class StockMyController {

    //stock/my 페이지 반환

    @GetMapping
    public String stockMyPage(){
        return "stock/my"; //my.jsp
    }

//    @GetMapping("/watchlist")
//    public ResponseEntity<List<WatchlistItemDTO>> getWatchlist() {
//        int userSeq = 1; //로그인시 수정
//        List<WatchlistItemDTO> items = watchlistService.getWatchlistItems(userSeq);
//        return ResponseEntity.ok(items);
//    }

}

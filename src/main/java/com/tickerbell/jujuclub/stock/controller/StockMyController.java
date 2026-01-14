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

}

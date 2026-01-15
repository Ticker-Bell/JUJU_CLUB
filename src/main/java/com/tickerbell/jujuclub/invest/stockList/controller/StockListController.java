package com.tickerbell.jujuclub.invest.stockList.controller;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.invest.stockList.dto.StockDTO;
import com.tickerbell.jujuclub.invest.stockList.service.StockService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class StockListController {

    private final StockService stockService;

    @GetMapping("/main/investMain.do")
    public String investMain(Model model, HttpSession session) {

        // 세션에서 user_seq 가져오기
        session.setAttribute("userSeq", 1); // 일단 구현안되어있으므로 임시 값

        Integer userSeq = (Integer)session.getAttribute("userSeq");

        List<StockDTO> stockDTOList = stockService.findStockCodeListFromUserWatchList(userSeq);
        model.addAttribute("stockDTOList", stockDTOList);

        return "invest/investMain";
    }

}

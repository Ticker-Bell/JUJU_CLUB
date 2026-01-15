package com.tickerbell.jujuclub.invest.stockList.controller;

import com.tickerbell.jujuclub.common.dto.UserInfoDTO;
import com.tickerbell.jujuclub.invest.stockList.dto.RankingDTO;
import com.tickerbell.jujuclub.invest.stockList.dto.StockDTO;
import com.tickerbell.jujuclub.invest.stockList.service.RankingApiService;
import com.tickerbell.jujuclub.invest.stockList.service.StockService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class StockListController {

    private final StockService stockService;
    private final RankingApiService rankingApiService;

    @GetMapping("/main/investMain.do")
    public String investMain(Model model, HttpSession session) {

        // 세션에서 user_seq 가져오기
        session.setAttribute("userSeq", 1); // 일단 구현안되어있으므로 임시 값

        Integer userSeq = (Integer)session.getAttribute("userSeq");

        // 해당하는 유저의 관심종목들의 종목정보 리스트 반환
        List<StockDTO> stockDTOList = stockService.findStockListFromUserWatchList(userSeq);
        model.addAttribute("stockDTOList", stockDTOList);

        return "invest/investMain";
    }

    @GetMapping("/main/stock/list")
    @ResponseBody
    public List<RankingDTO> getStockList(@RequestParam("sortType") String sortType) {

        switch (sortType) {
            case "interest" :
                return rankingApiService.getTradingVolumeRanking();
            case "volume":
                return null;
            case "rising":
                return null;
            case "falling":
                return null;
            case "marketCap":
                return null;
            default: return new ArrayList<>();
        }
    }

}

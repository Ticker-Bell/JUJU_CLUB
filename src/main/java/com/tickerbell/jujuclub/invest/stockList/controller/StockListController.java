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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/invest")
public class StockListController {

    private final StockService stockService;
    private final RankingApiService rankingApiService;

    @GetMapping("main.do")
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
    public List<RankingDTO> getStockList(@RequestParam("sortType") String sortType, HttpSession session) {

        switch (sortType) {
            case "interest":
                Integer userSeq = (Integer)session.getAttribute("userSeq");
                List<StockDTO> stockDTOList = stockService.findStockListFromUserWatchList(userSeq);
                List<RankingDTO> rankingDTOList = new ArrayList<>();

                // List<RankingDTO>를 반환해야하기에 stockDTO에 있는 Name과 Code를 넣어서 RankingDTO로 전환한다.
                // Name과 Code는 양쪽에 존재하기 때문에 상관없지만, rank는 없기 때문에 null로 넣는다.
                for (StockDTO stockDTO : stockDTOList) {
                    RankingDTO rankingDTO = RankingDTO.builder()
                            .stockName(stockDTO.getStockName())
                            .stockCode(stockDTO.getStockCode())
                            .build();
                    rankingDTOList.add(rankingDTO);
                }
                return rankingDTOList;

            case "volume":
                return rankingApiService.getTradingVolumeRanking();
            case "rising":
                return new ArrayList<>();
            case "falling":
                return new ArrayList<>();
            case "marketCap":
                return new ArrayList<>();
            default: return new ArrayList<>();
        }
    }

}

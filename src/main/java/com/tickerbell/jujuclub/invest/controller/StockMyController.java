package com.tickerbell.jujuclub.invest.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.invest.dto.PortfolioAllocationItemDTO;
import com.tickerbell.jujuclub.invest.dto.UserInvestSummeryDTO;
import com.tickerbell.jujuclub.invest.service.PortfolioService;
import com.tickerbell.jujuclub.invest.service.UserAssetService;
import com.tickerbell.jujuclub.invest.service.WatchlistService;
import com.tickerbell.jujuclub.invest.util.ColorUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/invest")
public class StockMyController {

    private final WatchlistService watchlistService;
    private final PortfolioService portfolioService;
    private final UserAssetService userAssetService;

    @GetMapping("/my")
    public String stockMyPage(HttpSession session, Model model){
        //세션에서 유저 시퀀스 가져오기
        Integer userSeq = (Integer)session.getAttribute("userSeq");

        if (userSeq == null) {
            return "redirect:/auth/login";
        }

        //관심종목
        model.addAttribute("watchlist", watchlistService.getWatchlistItems(userSeq));
        //보유주식리스트
        List<PortfolioAllocationItemDTO> holdings = portfolioService.getPortfolioAllocationItems(userSeq);
        model.addAttribute("holdings", holdings);
        //도넛차트JSON(종목명, Pct, 색상)
        List<Map<String, Object>> chartData = new ArrayList<>();
        for(int i = 0; i < holdings.size(); i++){
            PortfolioAllocationItemDTO portfolioAllocationItemDTO = holdings.get(i); //보유종목DTO
            Map<String, Object> data = new HashMap<>();
            data.put("stockName", portfolioAllocationItemDTO.getStockName());
            data.put("weightPct", portfolioAllocationItemDTO.getWeightPct());
            data.put("color", ColorUtil.colorByStockCode(portfolioAllocationItemDTO.getStockCode())); //종목코드별 색상
            chartData.add(data);
        }
        model.addAttribute("chartData", chartData); //범례 데이터

        //JSON변환(chart.js는 자바객체를 읽을 수 없다)
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            model.addAttribute("chartDataJson", objectMapper.writeValueAsString(chartData));
        } catch (Exception e) {
            log.warn("JSON변환 에러");
            model.addAttribute("chartDataJson", "[]"); //차트데이터
        }

        //사용자자산요약 정보
        UserInvestSummeryDTO userAssetSummary = userAssetService.getUserInvestSummary(userSeq);
        model.addAttribute("userAsset", userAssetSummary);

        return "invest/my"; //my.jsp
    }

}

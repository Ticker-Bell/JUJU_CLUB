package com.tickerbell.jujuclub.invest.controller;

import com.tickerbell.jujuclub.invest.dto.StockCorpInfoDTO;
import com.tickerbell.jujuclub.invest.service.DARTApiService;
import com.tickerbell.jujuclub.invest.service.StockCorpInfoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@RequestMapping("/invest")
public class StockCorpInfoController {

    private final StockCorpInfoService stockCorpInfoService;
    private final DARTApiService dartApiService;

    /**
     * 모의투자 투자 페이지
     * 투자 탭 기업정보 및 재무 스냅샷 데이터 연결
     *
     * @param stockCode String
     * @return invest/stockCorpInfoCard
     */
    @GetMapping("/corpInfo")
    public String corpInfoPage(@RequestParam("stockCode") String stockCode, Model model) throws Exception {

        StockCorpInfoDTO stockCorpInfoDTO = stockCorpInfoService.getConvertStockCorpInfoData(stockCode);
        model.addAttribute("stockCorpInfo", stockCorpInfoDTO);

        return "invest/stockCorpInfoCard";
    }

}

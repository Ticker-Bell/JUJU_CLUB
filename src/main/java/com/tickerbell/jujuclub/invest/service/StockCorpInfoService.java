package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.KISCorpInfoDTO;
import com.tickerbell.jujuclub.invest.dto.StockCorpInfoDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;

@Service
@RequiredArgsConstructor
public class StockCorpInfoService {
    //JSP 화면에 보여질 JSON 데이터 포맷팅 하는 서비스

    private final KISApiService kisApiService;

    //받아온 JSON 데이터를 담은 DTO에서 화면에 띄울 데이터를 담은 DTO클래스로 변환
    public StockCorpInfoDTO getConvertStockCorpInfoData(String stockCode) throws Exception {
        KISCorpInfoDTO kisCorpInfoDTO = kisApiService.getCorpInfoData(stockCode);

        //시가총액
        String marketCap =  formatMarketCap(kisCorpInfoDTO.getMarketCap());

        //상장주식수
        String listedStockCnt = formatComma(kisCorpInfoDTO.getListedStockCnt());

        //52주 최고
        String w52HgprData = formatComma(kisCorpInfoDTO.getW52Hgpr());

        //52주 최저
        String w52LwprData = formatComma(kisCorpInfoDTO.getW52Lwpr());

        //배당수익률(Dart에서 가져오면 추가)
        String dividendPriceRatioData = (("dummy" == null ? "0.0" : "dummy") + "%"); //변경필요

        //DTO리턴
        return StockCorpInfoDTO.builder()
                .marketCapData(marketCap)
                .w52HgprData(w52HgprData)
                .w52LwprData(w52LwprData)
                .listedStockCntData(listedStockCnt)
                .dividendPriceRatio(dividendPriceRatioData)
                .build();
    }

    //시가총액 "조", "억" 단위 변환
    private String formatMarketCap(String data){
        if(data==null || data.isEmpty()){
            return "-";
        }
        try{
            long value = Long.parseLong(data); //단위가 억, 조로 넘어가는 경우
            long hundredMillion = value % 10000; //억 단위
            long trillion = value / 10000; //조 단위

            StringBuilder sb = new StringBuilder();
            if(trillion > 0){
                sb.append(trillion).append("조 ");
            }
            sb.append(new DecimalFormat("#,###").format(hundredMillion)).append("억");

            return sb.toString();
        } catch (NumberFormatException e){
            return data;
        }
    }

    //숫자 단위마다 , 찍기
    private String formatComma(String data){
        if(data==null || data.isEmpty()){
            return "-";
        }
        try{
            long value = Long.parseLong(data);
            return new DecimalFormat("#,###").format(value);
        } catch (NumberFormatException e){
            return data;
        }
    }

}

package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.DARTCorpInfoDTO;
import com.tickerbell.jujuclub.invest.dto.KISCorpInfoDTO;
import com.tickerbell.jujuclub.invest.dto.StockCorpInfoDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;

@Service
@RequiredArgsConstructor
public class StockCorpInfoService {
    //JSP 화면에 보여질 JSON 데이터 포맷팅 하는 서비스

    private final KISApiService kisApiService;
    private final DARTApiService dartApiService;

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

        //PER
        String per = (kisCorpInfoDTO.getPer() == null || kisCorpInfoDTO.getPer().isEmpty()) ? "-" : kisCorpInfoDTO.getPer();

        //PBR
        String pbr = (kisCorpInfoDTO.getPbr() == null || kisCorpInfoDTO.getPbr().isEmpty()) ? "-" : kisCorpInfoDTO.getPbr();

        //EPS
        String eps = formatComma(kisCorpInfoDTO.getEps());

        //BPS
        String bps = formatComma(kisCorpInfoDTO.getBps());

        //다트 재무제표 가져오기
        DARTCorpInfoDTO dartCorpInfoDTO = dartApiService.getDartCorpInfo(stockCode);

        //ROE 자기자본이익률(%) : (당기 순이익 / 자본 총 계) * 100
        String roe;
        if(dartCorpInfoDTO.getRoe() == 0.0){
            roe  = "roe 없음";
        } else {
            BigDecimal bd = BigDecimal.valueOf(dartCorpInfoDTO.getRoe());
            bd = bd.setScale(2, RoundingMode.HALF_UP);
            roe = bd.toPlainString() + "%";
        }

        //부채비율(%) : (부채 총 계 / 자본 총 계) * 100
        String debtRatio;
        if(dartCorpInfoDTO.getDebtRatio() == 0.0){
            debtRatio  = "debtRatio 없음";
        } else {
            BigDecimal bd = BigDecimal.valueOf(dartCorpInfoDTO.getDebtRatio());
            bd = bd.setScale(2, RoundingMode.HALF_UP);
            debtRatio = bd.toPlainString() + "%";
        }

        //배당수익률
        double data = dartApiService.getDividendPerShare(stockCode);
        String dividendPriceRatio;
        if(data == 0.0){
            dividendPriceRatio = "배당금 없음";
        } else{
            BigDecimal bd = BigDecimal.valueOf(data); //소숫점 3번째 자리에서 반올림
            bd = bd.setScale(2, RoundingMode.HALF_UP);
            dividendPriceRatio = bd.toPlainString() + "%";
        }

        //DTO리턴
        return StockCorpInfoDTO.builder()
                .marketCapData(marketCap)
                .w52HgprData(w52HgprData)
                .w52LwprData(w52LwprData)
                .listedStockCntData(listedStockCnt)
                .per(per)
                .pbr(pbr)
                .eps(eps)
                .bps(bps)
                .dividendPriceRatio(dividendPriceRatio)
                .roe(roe)
                .debtRatio(debtRatio)
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

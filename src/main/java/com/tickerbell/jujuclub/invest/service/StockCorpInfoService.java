package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.DARTCorpInfoDTO;
import com.tickerbell.jujuclub.invest.dto.KISCorpInfoDTO;
import com.tickerbell.jujuclub.invest.dto.StockCorpInfoDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;

@Slf4j
@Service
@RequiredArgsConstructor
public class StockCorpInfoService {
    //JSP 화면에 보여질 JSON 데이터 포맷팅 하는 서비스

    private final KISApiService kisApiService;
    private final DARTApiService dartApiService;

    /**
     * 모의투자 투자탭 - 기업정보 카드에 들어갈 값을 KIS, DART 응답 DTO에서 꺼내 형식에 맞게 데이터 포맷팅
     *
     * @param stockCode String
     * @return StockCorpInfoDTO
     */
    public StockCorpInfoDTO getConvertStockCorpInfoData(String stockCode) {

        //받아온 JSON 데이터를 담은 DTO에서 화면에 띄울 데이터를 담은 DTO클래스로 변환

        try {
            log.info("[{}] KIS 기업정보 데이터 조회 시작", stockCode);
            KISCorpInfoDTO kisCorpInfoDTO = kisApiService.getCorpInfoData(stockCode);
            log.info("[{}] KIS 기업정보 데이터 조회 종료", stockCode);

            //시가총액
            String marketCap = formatMarketCap(kisCorpInfoDTO.getMarketCap());

            //상장주식수
            String listedStockCnt = formatComma(kisCorpInfoDTO.getListedStockCnt());

            //52주 최고
            String w52HgprData = formatComma(kisCorpInfoDTO.getW52Hgpr());

            //52주 최저
            String w52LwprData = formatComma(kisCorpInfoDTO.getW52Lwpr());

            //PER
            String per = formatIfDataEmpty(kisCorpInfoDTO.getPer());

            //PBR
            String pbr = formatIfDataEmpty(kisCorpInfoDTO.getPbr());

            //EPS
//            String eps = formatIfDataEmpty(formatComma(kisCorpInfoDTO.getEps()));
            String eps = formatComma(formatIfDataEmpty(kisCorpInfoDTO.getEps()));


            //BPS
//            String bps = formatIfDataEmpty(formatComma(kisCorpInfoDTO.getBps()));
            String bps = formatComma(formatIfDataEmpty(kisCorpInfoDTO.getBps()));

            log.info("[{}] EPS={}, BPS={} 값 조회", stockCode, kisCorpInfoDTO.getEps(), kisCorpInfoDTO.getBps());

            log.info("[{}] DART 재무제표 조회 시작", stockCode);
            //다트 재무제표 가져오기
            DARTCorpInfoDTO dartCorpInfoDTO = dartApiService.getDartCorpInfo(stockCode);
            log.info("[{}] DART 재무제표 조회 종료", stockCode);

            //ROE 자기자본이익률(%) : (당기 순이익 / 자본 총 계) * 100
            String roe;
            if (dartCorpInfoDTO.getRoe() == 0.0) {
                roe = "ROE 없음";
            } else {
                BigDecimal bd = BigDecimal.valueOf(dartCorpInfoDTO.getRoe());
                bd = bd.setScale(2, RoundingMode.HALF_UP);
                roe = bd.toPlainString() + "%";
            }

            //부채비율(%) : (부채 총 계 / 자본 총 계) * 100
            String debtRatio;
            if (dartCorpInfoDTO.getDebtRatio() == 0.0) {
                debtRatio = "부채비율 없음";
            } else {
                BigDecimal bd = BigDecimal.valueOf(dartCorpInfoDTO.getDebtRatio());
                bd = bd.setScale(2, RoundingMode.HALF_UP);
                debtRatio = bd.toPlainString() + "%";
            }

            log.info("[{}] DART 배당정보 조회 시작", stockCode);
            //배당수익률
            double data = dartApiService.getDividendPerShare(stockCode);
            log.info("[{}] DART 배당정보 조회 종료 - raw={}", stockCode, data);

            String dividendPriceRatio;
            if (data == 0.0) {
                dividendPriceRatio = "배당금 없음";
            } else {
                BigDecimal bd = BigDecimal.valueOf(data); //소숫점 3번째 자리에서 반올림
                bd = bd.setScale(2, RoundingMode.HALF_UP);
                dividendPriceRatio = bd.toPlainString() + "%";
            }

            //DTO리턴
            StockCorpInfoDTO result = StockCorpInfoDTO.builder()
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

            log.info("[{}] 기업정보 카드 데이터 변환 완료", stockCode);

            return result;

        } catch (Exception e) {
            log.warn("[{}] 기업정보 카드 데이터 변환 실패", stockCode, e);
            throw new RuntimeException(e);
        }
    }

    /**
     * 시가총액 데이터의 단위("조", "억") 변환
     *
     * @param data String
     * @return String
     */
    private String formatMarketCap(String data) {
        if (data == null || data.isEmpty()) {
            return "-";
        }
        try {
            long value = Long.parseLong(data); //단위가 억, 조로 넘어가는 경우
            long hundredMillion = value % 10000; //억 단위
            long trillion = value / 10000; //조 단위

            StringBuilder sb = new StringBuilder();
            if (trillion > 0) {
                sb.append(trillion).append("조 ");
            }
            sb.append(new DecimalFormat("#,###").format(hundredMillion)).append("억");

            return sb.toString();
        } catch (NumberFormatException e) {
            log.warn("시가총액 데이터 포맷팅 실패 - data={}", data, e);
            return data;
        }
    }

    /**
     * 숫자 문자열을 단위마다 , 형식으로 변환
     *
     * @param data String
     * @return String
     */
    private String formatComma(String data) {
        if (data == null || data.isEmpty()) {
            return "-";
        }
        try {
            double value = Double.parseDouble(data);
            return new DecimalFormat("#,###.##").format(value);
        } catch (NumberFormatException e) {
            log.warn("콤마 포맷 실패 - data={}", data, e);
            return data;
        }
    }

    /**
     * 데이터가 없거나 0이면 "없음"으로 리턴, 숫자 파싱에 실패하면 "-" 리턴
     *
     * @param data String
     * @return String
     */
    private String formatIfDataEmpty(String data) {
        if (data == null) return "-";

        String newData = data.trim();
        if (newData.isEmpty()) return "-";

        try {
            return Double.parseDouble(newData) == 0.0 ? "없음" : newData;
        } catch (NumberFormatException e) {
            log.warn("숫자 파싱 실패 - data={}", data, e);
            return "-";
        }
    }


}

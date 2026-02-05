package com.tickerbell.jujuclub.utils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tickerbell.jujuclub.invest.dto.StockChartDTO;
import com.tickerbell.jujuclub.invest.dto.StockChartRestDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.*;

@Slf4j
@Component
public class StockChartParser {
    private static final int FIELD_COUNT = 46; //체결 데이터 한 건당 필드 수
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public List<StockChartDTO> parseStockChart(String rawData) {
        //웹소켓 데이터 가공
        List<StockChartDTO> stockChartDTOList = new ArrayList<>();

        if (rawData.startsWith("{") || rawData.startsWith("[")) {
            log.info("설정/성공 메시지 수신 (파싱 생략): {}", rawData);
        }

        String[] parts = rawData.split("\\|");
        String[] allFieldData = parts[3].split("\\^");

        for (int i = 0; i < allFieldData.length; i += FIELD_COUNT) {
            if (i + FIELD_COUNT > allFieldData.length) break;

            StockChartDTO stockdto = new StockChartDTO();
            stockdto.setStockCode(allFieldData[i + 0]);
            stockdto.setTradeTime(allFieldData[i + 1]);
            stockdto.setCurrentPrice(Integer.parseInt(allFieldData[i + 2]));
            stockdto.setDayOverDaySign(allFieldData[i + 3]);
            stockdto.setDayOverDayChange(Integer.parseInt(allFieldData[i + 4]));
            stockdto.setDayOverDayRate(Double.parseDouble(allFieldData[i + 5]));
            applyFormatting(stockdto);
            stockChartDTOList.add(stockdto);
        }
        return stockChartDTOList;
    }

    public List<StockChartRestDTO> parseStockRestData(String response, String periodCode) {
        List<StockChartRestDTO> stockChartRestList;
        try {
            String trimmedJson = response.trim();
            JsonNode jsonNode = objectMapper.readTree(trimmedJson);

            String rtCd = jsonNode.path("rt_cd").asText();
            if (!"0".equals(rtCd)) {
                return Collections.emptyList();
            }
            JsonNode outputNode = jsonNode.get("output");

            stockChartRestList = objectMapper.convertValue(
                    outputNode,
                    new TypeReference<List<StockChartRestDTO>>() { }
            );

            stockChartRestList.sort(Comparator.comparing(StockChartRestDTO::getTradeDate));

            stockChartRestList.forEach(dto -> applyRestFormatting(dto, periodCode));

        } catch (Exception e) {
            throw new RuntimeException("차트 데이터 파싱 에러", e);
        }
        return stockChartRestList;
    }


    private static void applyFormatting(StockChartDTO stockChartDTO) {
        stockChartDTO.setDisplayPrice(StockChartFormatter.formatPrice(stockChartDTO.getCurrentPrice()));
        stockChartDTO.setDisplayTime(StockChartFormatter.formatTime(stockChartDTO.getTradeTime()));
        stockChartDTO.setDisplayChange(StockChartFormatter.formatdayOverDayWithSign(stockChartDTO.getDayOverDaySign(), stockChartDTO.getDayOverDayChange(), stockChartDTO.getDayOverDayRate()));
        stockChartDTO.setDisplayRate(StockChartFormatter.formatdayOverDayRate(stockChartDTO.getDayOverDayRate()));

    }


    private static void applyRestFormatting(StockChartRestDTO stockChartRestDTO, String periodCode) {
        //rest data 포맷팅
        stockChartRestDTO.setDisplayPrice(StockChartFormatter.formatPrice(stockChartRestDTO.getCurrentPrice()));

        String rawDate = stockChartRestDTO.getTradeDate();

        if ("M".equals(periodCode)) {
            String yearMonth = rawDate.substring(0, 4) + "/" + rawDate.substring(4, 6);
            stockChartRestDTO.setDisplayDate(yearMonth);
        } else {
            String monthDay = rawDate.substring(4, 6) + "/" + rawDate.substring(6, 8);
            stockChartRestDTO.setDisplayDate(monthDay);
        }
    }


}
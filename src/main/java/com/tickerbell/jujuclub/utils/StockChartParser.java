package com.tickerbell.jujuclub.utils;

import com.tickerbell.jujuclub.stockChart.dto.StockChartDTO;

import java.util.*;

public class StockChartParser {
    private static final int FIELD_COUNT = 46; //체결 데이터 한 건당 필드 수
    private StockChartFormatter stockChartFormatter;

    //api에서 받은 데이터 가공
    public List<StockChartDTO> parseStockChart(String rawData) {
        List<StockChartDTO> stockChartDTOList = new ArrayList<>();

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


    private static void applyFormatting(StockChartDTO stockChartDTO) {
        stockChartDTO.setDisplayPrice(StockChartFormatter.formatPrice(stockChartDTO.getCurrentPrice()));
        stockChartDTO.setDisplayTime(StockChartFormatter.formatTime(stockChartDTO.getTradeTime()));
        stockChartDTO.setDisplayChange(StockChartFormatter.formatdayOverDayWithSign(stockChartDTO.getDayOverDaySign(), stockChartDTO.getDayOverDayChange(), stockChartDTO.getDayOverDayRate()));

    }
}
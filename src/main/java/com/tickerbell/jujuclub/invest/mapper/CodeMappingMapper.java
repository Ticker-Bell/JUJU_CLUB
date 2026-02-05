package com.tickerbell.jujuclub.invest.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CodeMappingMapper {

    /**
     * DARTApi의 기업코드와 KISApi 기업코드 매칭
     *
     * @param stockCode String
     * @return String
     */
    public String selectCorpCode(@Param("stockCode") String stockCode);
}

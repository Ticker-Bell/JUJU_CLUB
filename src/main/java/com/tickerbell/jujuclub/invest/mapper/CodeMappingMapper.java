package com.tickerbell.jujuclub.invest.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CodeMappingMapper {
    public String selectCorpCode(@Param("stockCode") String stockCode);
}

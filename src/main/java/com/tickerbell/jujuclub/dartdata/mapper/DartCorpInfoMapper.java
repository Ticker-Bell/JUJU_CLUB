package com.tickerbell.jujuclub.dartdata.mapper;

import com.tickerbell.jujuclub.dartdata.dto.DartCorpInfoDataDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DartCorpInfoMapper {

    List<String> selectAllStockCodes();

    int insert(List<DartCorpInfoDataDTO> list);

}

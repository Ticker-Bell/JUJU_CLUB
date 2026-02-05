package com.tickerbell.jujuclub.dartdata.mapper;

import com.tickerbell.jujuclub.dartdata.dto.DartCorpInfoDataDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DartCorpInfoMapper {

    /**
     * stockCode 비어있지 않은 값들만 조회
     *
     * @return List&lt;String&gt;
     */
    List<String> selectAllStockCodes();

    /**
     * DART Api의 corp_code 데이터 삽입
     *
     * @param list List&lt;DartCorpInfoDataDTO&gt;
     * @return int
     */
    int insert(List<DartCorpInfoDataDTO> list);

}

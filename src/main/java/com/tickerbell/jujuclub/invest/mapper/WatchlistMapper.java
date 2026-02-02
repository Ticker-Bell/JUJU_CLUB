package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.WatchlistItemDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WatchlistMapper {

    /**
     * 사용자 관심 종목 목록 조회
     *
     * @param userSeq int
     * @return List&lt;WatchlistItemDTO&gt;
     */
    List<WatchlistItemDTO> selectWatchlistItems(@Param("user_seq") int userSeq);
}

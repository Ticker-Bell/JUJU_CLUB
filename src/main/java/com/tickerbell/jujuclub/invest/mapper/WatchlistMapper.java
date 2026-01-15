package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.WatchlistItemDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WatchlistMapper {
    List<WatchlistItemDTO> selectWatchlistItems(@Param("user_seq") int userSeq);
}

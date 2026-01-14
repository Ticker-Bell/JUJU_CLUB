package com.tickerbell.jujuclub.stock.mapper;

import com.tickerbell.jujuclub.stock.dto.WatchlistItemDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WatchlistMapper {

    // 메소드 선언(SQL이름표), 파라미터(입력값)타입, 리턴(결과)타입, @Param이름
    List<WatchlistItemDTO> selectWatchlistItems(@Param("user_seq") int userSeq);

}

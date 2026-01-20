package com.tickerbell.jujuclub.ranking.mapper;

import com.tickerbell.jujuclub.ranking.dto.RankingDTO;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RankingMapper {
  RankingDTO.RankingResponse getUserRankingInfo(int userSeq);
  List<RankingDTO.RankingListOBA> getRankingBoardListOBA();
  List<RankingDTO.RankingListOBR> getRankingBoardListOBR();

}
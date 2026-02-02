package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.MockPortfolioDTO;
import com.tickerbell.jujuclub.invest.dto.PortfolioDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PortfolioMapper {

    /**
     * 사용자 보유 종목 리스트 조회
     *
     * @param userSeq int
     * @return List&ltPortfolioAllocationItemDTO&gt;
     */
    List<PortfolioDTO> selectPortfolioList(@Param("user_seq") int userSeq);

    /**
     * 사용자, 종목코드 기준 보유 종목 리스트 단건 조회
     *
     * @param userSeq  int
     * @param stockSeq int
     * @return MockPortfolioDTO
     */
    MockPortfolioDTO selectPortfolioItem(@Param("user_seq") int userSeq, @Param("stock_seq") int stockSeq);

    /**
     * 보유 종목 신규 등록
     *
     * @param mockPortfolioDTO MockPortfolioDTO
     * @return int
     */
    int insertPortfolioItem(MockPortfolioDTO mockPortfolioDTO);

    /**
     * 보유 종목 수량, 평균 단가 갱신
     *
     * @param mockPortfolioDTO MockPortfolioDTO
     * @return int
     */
    int updatePortfolioItem(MockPortfolioDTO mockPortfolioDTO);
}

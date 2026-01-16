package com.tickerbell.jujuclub.invest.mapper;

import com.tickerbell.jujuclub.invest.dto.MockPortfolioDTO;
import com.tickerbell.jujuclub.invest.dto.PortfolioAllocationItemDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PortfolioMapper {
    List<PortfolioAllocationItemDTO> selectPortfolioList(@Param("user_seq") int userSeq);

    MockPortfolioDTO selectPortfolioItem(@Param("user_seq")int userSeq, @Param("stock_seq")int stockSeq);

    int insertPortfolioItem(MockPortfolioDTO mockPortfolioDTO);

    int updatePortfolioItem(MockPortfolioDTO mockPortfolioDTO);
}

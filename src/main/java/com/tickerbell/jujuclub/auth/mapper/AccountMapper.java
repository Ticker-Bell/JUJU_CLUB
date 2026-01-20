package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.AccountDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AccountMapper {
    int checkAccountExist(Long userId);
    int insertAccount(AccountDTO account);
    AccountDTO selectAccountByUserSeq(Long userSeq);
}

package com.tickerbell.jujuclub.auth.service;

import com.tickerbell.jujuclub.auth.dto.AccountDTO;
import com.tickerbell.jujuclub.auth.mapper.AccountMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class AccountService {

    private final AccountMapper accountMapper;

    /**
     * 유저 계좌 조회
     *
     * @param userSeq Integer
     * @return accountDTO AccountDTO
     */
    public AccountDTO getMyAccount(Integer userSeq) {

        log.info("[{}] 유저 계좌 조회 시작", userSeq);
        AccountDTO accountDTO = accountMapper.selectAccountByUserSeq(userSeq);
        log.info("[{}] 유저 계좌 조회 종료", userSeq);

        return accountDTO;
    }

    /**
     * 유저 계좌 생성
     *
     * @param userSeq Integer
     * @return accountNo String
     */
    public String createAccount(Integer userSeq) {

        String accountNo = generateRandomAccountNo();

        try {
            log.info("[{}] 유저 계좌 생성 시작", userSeq);

            log.info("[{}] 이메일 중복 확인 시작", userSeq);
            boolean exist = accountMapper.checkAccountExist(userSeq) > 0;
            log.info("[{}] 이메일 중복 확인 시작", userSeq);

            if (exist) {
                // 유저 계좌가 존재하면 null 반환
                return null;
            }

            // AccountDTO 생성 및 cashBalance를 1,000,000으로 설정
            AccountDTO account = AccountDTO.builder()
                    .userSeq(userSeq)
                    .accountNo(accountNo)
                    .cashBalance(1000000L)
                    .build();

            // 만들어진 AccountDTO를 DB에 저장
            log.info("[{}] 유저 계좌 생성  -  유저 계좌 등록 시작", userSeq);
            accountMapper.insertAccount(account);
            log.info("[{}] 유저 계좌 생성  -  유저 계좌 등록 종료", userSeq);
        } catch (Exception e) {
            log.error("유저 계좌 생성 실패");
            throw new RuntimeException(e);
        }

        log.info("[{}] 유저 계좌 생성 종료", userSeq);
        // 계좌번호를 반환
        return accountNo;
    }

    /**
     * 계좌번호 랜덤 생성
     *
     * @return String.valueOf(randomNumber) String
     */
    private String generateRandomAccountNo() {
        // 계좌번호를 14자리로 랜덤 생성
        long randomNumber = (long) (Math.random() * 90000000000000L) + 10000000000000L;

        // long을 String으로 변환
        return String.valueOf(randomNumber);
    }
}
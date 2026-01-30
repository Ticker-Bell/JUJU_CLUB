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
     * @return accountMapper.selectAccountByUserSeq(userSeq) AccountDTO
     */
    public AccountDTO getMyAccount(Integer userSeq) {

        return accountMapper.selectAccountByUserSeq(userSeq);
    }

    /**
     * 유저 계좌 생성
     *
     * @param userSeq Integer
     * @return accountNo String
     */
    // [수정] void -> Long (생성된 계좌번호 반환)
    public String createAccount(Integer userSeq) {

        String accountNo = generateRandomAccountNo();

        try {
            log.info("[{}] 유저 계좌 생성  - 유저 계좌 유효성 검사 DB 조회 시작", userSeq);

            // 중복된 유저 계좌 확인
            if (accountMapper.checkAccountExist(userSeq) > 0) {

                // 유저 계좌가 존재하면 null 반환
                return null;
            }
            log.info("[{}] 유저 계좌 생성  - 유저 계좌 유효성 검사 DB 조회 종료", userSeq);

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
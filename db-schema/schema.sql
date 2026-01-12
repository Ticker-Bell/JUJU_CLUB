CREATE TABLE USERS (
    user_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '유저 시퀀스',
    user_id VARCHAR(20) NOT NULL COMMENT '유저ID',
    user_pw VARCHAR(20) NOT NULL COMMENT '유저PW',
    user_name VARCHAR(50) NOT NULL COMMENT '유저 이름',
    user_level INT UNSIGNED NOT NULL DEFAULT 1 COMMENT '유저 레벨',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '가입 일시',
    PRIMARY KEY (user_seq)
)
    comment '유저';

CREATE TABLE STOCK_MASTER (
    stock_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '종목 시퀀스',
    stock_code VARCHAR(20) COMMENT '종목 코드',
    stock_name VARCHAR(50) NOT NULL COMMENT '종목명',
    market_type VARCHAR(20) NOT NULL COMMENT '시장 구분',
    sector VARCHAR(50) NOT NULL COMMENT '업종',
    stock_type VARCHAR(20) NOT NULL COMMENT '종목 타입',
    PRIMARY KEY (stock_seq)
)
    comment '주식 종목';

CREATE TABLE USER_WATCHLIST (
    favorite_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '관심종목 시퀀스',
    user_seq INT UNSIGNED NOT NULL COMMENT '유저 시퀀스',
    stock_seq INT UNSIGNED COMMENT '종목 시퀀스',
    PRIMARY KEY (favorite_seq),
    FOREIGN KEY (user_seq) REFERENCES USERS(user_seq),
    FOREIGN KEY (stock_seq) REFERENCES STOCK_MASTER(stock_seq)
)
    comment '관심종목';

CREATE TABLE USER_ACCOUNT (
    account_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '계좌 시퀀스',
    user_id VARCHAR(20) NOT NULL COMMENT '유저 ID',
    account_no INT UNSIGNED NOT NULL COMMENT '계좌 번호',
    cash_balance INT UNSIGNED NOT NULL DEFAULT 100000 COMMENT '잔고',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '계좌 생성일',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '계좌 수정일',
    PRIMARY KEY (account_seq)
)
    comment '유저 계좌';

CREATE TABLE MOCK_TRADE (
    trade_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '거래 시퀀스',
    user_seq INT UNSIGNED NOT NULL COMMENT '유저 시퀀스',
    stock_seq INT UNSIGNED COMMENT '종목 시퀀스',
    trade_type CHAR(1) NOT NULL DEFAULT 'Y' COMMENT '매수/매도',
    trade_price INT UNSIGNED NOT NULL COMMENT '거래 가격',
    trade_quantity INT UNSIGNED NOT NULL COMMENT '거래 수량',
    traded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '거래 일시',
    PRIMARY KEY (trade_seq),
    FOREIGN KEY (user_seq) REFERENCES USERS(user_seq),
    FOREIGN KEY (stock_seq) REFERENCES STOCK_MASTER(stock_seq)
)
    comment '거래 내역';

CREATE TABLE USER_MISSION (
    user_mission_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '유저 미션 시퀀스',
    is_completed CHAR(1) NOT NULL DEFAULT 'N' COMMENT '미션 완료 여부',
    started_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '시작 일시',
    completed_at DATETIME COMMENT '완료 일시',
    progress_count INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '진행 횟수',
    PRIMARY KEY (user_mission_seq)
)
    comment '유저 미션';

CREATE TABLE LEARNING_LEVEL (
    level_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '레벨 시퀀스',
    level_name VARCHAR(10) NOT NULL COMMENT '레벨명',
    is_domestic CHAR(1) NOT NULL DEFAULT 'Y' COMMENT '국내 여부',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
    PRIMARY KEY (level_seq)
)
    comment '학습 레벨';

CREATE TABLE LEARNING_CHAPTER (
    chapter_id VARCHAR(50) NOT NULL COMMENT '챕터ID',
    level_seq INT UNSIGNED NOT NULL COMMENT '레벨 시퀀스',
    chapter_name VARCHAR(100) NOT NULL COMMENT '챕터명',
    test_reward INT UNSIGNED NOT NULL COMMENT '테스트 보상',
    test_pay INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '테스트 지불',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
    PRIMARY KEY (chapter_id),
    FOREIGN KEY (level_seq) REFERENCES LEARNING_LEVEL(level_seq)
)
    comment '학습 챕터';

CREATE TABLE LEARNING_LESSON (
    lesson_id VARCHAR(50) NOT NULL COMMENT '레슨ID',
    chapter_id VARCHAR(50) NOT NULL COMMENT '챕터ID',
    lesson_name VARCHAR(100) NOT NULL COMMENT '레슨명',
    lesson_type VARCHAR(20) NOT NULL COMMENT '레슨 타입',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
    PRIMARY KEY (lesson_id),
    FOREIGN KEY (chapter_id) REFERENCES LEARNING_CHAPTER(chapter_id)
)
    comment '학습 레슨';

CREATE TABLE LEARNING_QUESTION (
    question_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '문항 시퀀스',
    lesson_id VARCHAR(50) NOT NULL COMMENT '레슨ID',
    question_id VARCHAR(50) NOT NULL COMMENT '문항ID',
    question_type VARCHAR(20) NOT NULL COMMENT '문항 유형',
    question_text TEXT NOT NULL COMMENT '문항 내용',
    options JSON NOT NULL COMMENT '선택지 정보',
    answer JSON NOT NULL COMMENT '정답 정보',
    image VARCHAR(100) COMMENT '이미지 경로',
    PRIMARY KEY (question_seq),
    FOREIGN KEY (lesson_id) REFERENCES LEARNING_LESSON(lesson_id)
)
    comment '학습 문항';

CREATE TABLE USER_QUESTION_RESULT (
    result_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '결과 시퀀스',
    lesson_id VARCHAR(50) NOT NULL COMMENT '레슨ID',
    user_seq INT UNSIGNED NOT NULL COMMENT '유저시퀀스',
    started_at DATETIME COMMENT '시작 시간',
    finished_at DATETIME COMMENT '종료 시간',
    PRIMARY KEY (result_seq)
)
    comment '유저 레슨 결과';

CREATE TABLE USER_TEST_RESULT (
    test_result_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '테스트 결과 번호',
    user_seq INT UNSIGNED NOT NULL COMMENT '유저 시퀀스',
    chapter_id VARCHAR(50) NOT NULL COMMENT '챕터ID',
    score INT NOT NULL COMMENT '점수',
    attempt_no INT UNSIGNED NOT NULL COMMENT '시도 횟수',
    is_pass CHAR(1) NOT NULL DEFAULT 'N' COMMENT '통과 여부',
    tested_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '응시 일시',
    PRIMARY KEY (test_result_seq),
    FOREIGN KEY (user_seq) REFERENCES USERS(user_seq)
)
    comment '유저 테스트 결과';

CREATE TABLE MISSION (
    mission_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '미션 시퀀스',
    mission_type VARCHAR(50) NOT NULL COMMENT '미션 유형',
    mission_title VARCHAR(50) NOT NULL COMMENT '미션 제목',
    mission_reward INT UNSIGNED NOT NULL COMMENT '미션 보상',
    target_value INT UNSIGNED COMMENT '목표 값',
    PRIMARY KEY (mission_seq)
)
    comment '미션';

CREATE TABLE MOCK_PORTFOLIO (
    portfolio_seq INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '포트폴리오 시퀀스',
    user_seq INT UNSIGNED NOT NULL COMMENT '유저 시퀀스',
    stock_seq INT UNSIGNED COMMENT '종목 시퀀스',
    quantity INT NOT NULL COMMENT '보유 수량',
    avg_price INT NOT NULL COMMENT '평균 단가',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
    PRIMARY KEY (portfolio_seq),
    FOREIGN KEY (user_seq) REFERENCES USERS(user_seq),
    FOREIGN KEY (stock_seq) REFERENCES STOCK_MASTER(stock_seq)
)
    comment '유저 포트폴리오';

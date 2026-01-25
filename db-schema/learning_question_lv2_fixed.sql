-- Q1. CONCEPT: 본업과 일회성 수익
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS001', 'LV2_CH001_LS001_Q001', 'CONCEPT',
           '회사가 장사를 잘했는지 보려면 어떤 숫자를 가장 먼저 봐야 할까요?',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 이 회사는 이번에 땅을 팔아서 500억 원을 벌었대요! 호재 맞죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '잠깐만요! 그건 일회성 수익이에요. 내년에도 땅을 팔 수는 없잖아요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '우리가 봐야 할 건 "영업이익"입니다. 주식 시장은 이걸 회사의 진짜 실력으로 보거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 매출이 아무리 커도 본업에서 적자가 나면 위험하다는 거군요?')
           ), NULL, NULL
       );

-- Q2. SELECT: 영업이익의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS001', 'LV2_CH001_LS001_Q002', 'SELECT',
           '매출액에서 매출원가와 판관비를 뺀, 기업의 순수 본업 성과를 나타내는 지표는?',
           JSON_OBJECT('choices', JSON_ARRAY('당기순이익', '영업이익', '자본금', '매출총이익')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '영업이익은 기업의 핵심 사업 경쟁력을 보여주는 가장 중요한 지표입니다.'),
           NULL
       );

-- Q3. MATCH: 항목별 분류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS001', 'LV2_CH001_LS001_Q003', 'MATCH',
           '이자 수익이나 자산 매각 이익처럼 본업과 상관없이 발생한 수익을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('영업외수익', '매출원가', '판관비')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '영업외수익은 기업의 지속적인 이익 창출 능력과는 거리가 있습니다.'),
           NULL
       );

-- Q4. DRAG: 손익계산서 흐름
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS001', 'LV2_CH001_LS001_Q004', 'DRAG',
           '이익의 도출 순서: 매출액 → {{blank}} → 세전이익 → {{blank}}',
           JSON_OBJECT('choices', JSON_ARRAY('영업이익', '당기순이익', '자본금')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '매출에서 비용을 걷어낼수록 기업의 순수한 성적이 드러납니다.'),
           NULL
       );

-- Q5. LINK: 실전 의미 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS001', 'LV2_CH001_LS001_Q005', 'LINK',
           '손익계산서 항목과 투자자의 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','매출액 상승'),
                   JSON_OBJECT('id','L2','text','영업이익 상승'),
                   JSON_OBJECT('id','L3','text','영업외손실 발생'),
                   JSON_OBJECT('id','L4','text','판관비 급증')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','시장의 파이가 커지거나 점유율이 늘어남'),
                           JSON_OBJECT('id','R2','text','본업의 경쟁력이 강화되어 실력이 좋아짐'),
                           JSON_OBJECT('id','R3','text','이자 비용이나 투자 실패로 최종 이익 감소'),
                           JSON_OBJECT('id','R4','text','마케팅비나 인건비 등 운영비 지출이 많아짐')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '항목 간의 관계를 이해해야 실적 뉴스 이면의 진실이 보입니다.'),
           NULL
       );

-- Q1. CONCEPT: 기대치와 주가
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS002', 'LV2_CH001_LS002_Q001', 'CONCEPT',
           '주식 시장은 "예상보다 잘했나"를 가장 중요하게 여깁니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '이 회사 실적이 작년보다 30%나 늘었는데 왜 주가는 폭락하죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '시장 전문가들이 100% 성장을 예상했기 때문이에요. 30%는 실망스러운 결과죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 이미 주가는 100% 성장을 기대하고 올라와 있었던 거군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 이걸 "선반영"이라고 해요. 그래서 시장의 평균 예상치인 "컨센서스"가 중요합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 컨센서스의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS002', 'LV2_CH001_LS002_Q002', 'SELECT',
           '애널리스트들이 발표한 기업 실적 예상치의 평균값을 무엇이라 부를까요?',
           JSON_OBJECT('choices', JSON_ARRAY('컨센서스', '가이던스', '모멘텀', '벨류에이션')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '컨센서스는 시장이 해당 기업에 대해 가지는 평균적인 눈높이입니다.'),
           NULL
       );

-- Q3. MATCH: 어닝 서프라이즈
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS002', 'LV2_CH001_LS002_Q003', 'MATCH',
           '실적이 예상치를 크게 상회하여 주가가 급등하는 현상을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('어닝 서프라이즈', '어닝 쇼크', '재료 소멸')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '예상을 뛰어넘는 실적은 시장에 강력한 매수 신호를 줍니다.'),
           NULL
       );

-- Q4. DRAG: 발표 전후의 흐름
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS002', 'LV2_CH001_LS002_Q004', 'DRAG',
           '주가는 실적 발표 전에 {{blank}}으로 오르기도 하지만, 발표 후 기대에 못 미치면 {{blank}}가 발생합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('기대감', '실망 매물', '상한가')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '기대가 크면 실망도 큽니다. 발표 직전 주가의 위치가 중요한 이유입니다.'),
           NULL
       );

-- Q5. LINK: 실적 발표 상황별 대응
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS002', 'LV2_CH001_LS002_Q005', 'LINK',
           '발표 결과와 시장의 반응을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','어닝 서프라이즈'),
                   JSON_OBJECT('id','L2','text','어닝 쇼크'),
                   JSON_OBJECT('id','L3','text','컨센서스 부합'),
                   JSON_OBJECT('id','L4','text','흑자 전환')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','추가 성장에 대한 확신으로 주가 상승'),
                           JSON_OBJECT('id','R2','text','성장 둔화 우려로 강력한 매도세 출현'),
                           JSON_OBJECT('id','R3','text','재료 소멸로 인한 일시적 조정'),
                           JSON_OBJECT('id','R4','text','체질 개선 신호로 장기적 우상향 기대')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '결과 자체보다 시장의 기대치를 채웠는지가 핵심입니다.'),
           NULL
       );

-- Q1. CONCEPT: 수익성의 차이
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS003', 'LV2_CH001_LS003_Q001', 'CONCEPT',
           '많이 파는 것보다 잘 남기는 것이 진짜 실력입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', 'A카페와 B카페 모두 매출이 1억 원인데, 왜 주식 시장은 B만 좋아하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', 'A는 9천만 원을 비용으로 써서 1천만 원만 남기고, B는 5천만 원만 써서 5천만 원을 남기기 때문이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', 'B의 "영업이익률"이 훨씬 높으니 위기가 와도 더 잘 버티죠.')
           ), NULL, NULL
       );

-- Q2. SELECT: 영업이익률 계산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS003', 'LV2_CH001_LS003_Q002', 'SELECT',
           '매출 1,000억 원, 영업이익 200억 원인 기업의 영업이익률은?',
           JSON_OBJECT('choices', JSON_ARRAY('5%', '10%', '20%', '50%')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '영업이익률($\frac{영업이익}{매출액} \times 100$)은 기업의 장사 효율을 보여줍니다.'),
           NULL
       );

-- Q3. MATCH: 고마진 산업의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS003', 'LV2_CH001_LS003_Q003', 'MATCH',
           '독보적인 기술이나 강력한 브랜드를 가져 이익률이 높은 상태를 {{blank}} 구조라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('고마진', '저마진', '박리다매')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '고마진 기업은 원자재 값이 올라도 가격을 올려 대응할 힘이 있습니다.'),
           NULL
       );

-- Q4. DRAG: 이익률 변화의 원인
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS003', 'LV2_CH001_LS003_Q004', 'DRAG',
           '원자재 값이 상승하거나 경쟁이 심해져 {{blank}} 지출이 늘어나면 {{blank}}이 하락합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('마케팅비', '영업이익률', '매출액')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '비용 관리에 실패하면 매출이 늘어도 실속이 없어집니다.'),
           NULL
       );

-- Q5. LINK: 업종별 이익률 특성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS003', 'LV2_CH001_LS003_Q005', 'LINK',
           '업종과 일반적인 이익률 성격을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','소프트웨어/플랫폼'),
                   JSON_OBJECT('id','L2','text','전통 제조업'),
                   JSON_OBJECT('id','L3','text','유통/도매업'),
                   JSON_OBJECT('id','L4','text','바이오/신약')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','추가 생산 비용이 낮아 이익률이 매우 높음'),
                           JSON_OBJECT('id','R2','text','원가 비중이 높아 이익률이 보통 수준임'),
                           JSON_OBJECT('id','R3','text','박리다매 구조로 이익률이 매우 낮음'),
                           JSON_OBJECT('id','R4','text','성공 시 폭발적인 이익률을 기록함')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '업종별 평균 이익률을 알아야 상대적 우위를 알 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 흑자 전환의 가치
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS004', 'LV2_CH001_LS004_Q001', 'CONCEPT',
           '최악을 지나 희망이 보일 때 주가는 가장 뜨겁습니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '이 회사는 3년째 적자인데 갑자기 주가가 오르기 시작했어요. 왜일까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '곧 "흑자 전환"이 예상되기 때문이에요. 적자에서 0원이 되는 순간이 성장 속도는 가장 빠르죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 이제는 망할 걱정보다 돈 벌 일만 남았다는 기대감이 주가를 밀어올리는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 턴어라운드의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS004', 'LV2_CH001_LS004_Q002', 'SELECT',
           '기업 실적이 적자에서 흑자로 돌아서는 것을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('턴어라운드(흑자전환)', '어닝 쇼크', '상장폐지', '감자')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '턴어라운드 종목은 주가 상승 탄력이 매우 큰 경우가 많습니다.'),
           NULL
       );

-- Q3. MATCH: 적자 축소의 신호
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS004', 'LV2_CH001_LS004_Q003', 'MATCH',
           '아직 흑자는 아니지만 적자 폭이 눈에 띄게 줄어드는 것을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('적자 축소', '흑자 감소', '자본 잠식')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '적자 축소는 흑자 전환으로 가는 긍정적인 신호입니다.'),
           NULL
       );

-- Q4. DRAG: 턴어라운드의 원인
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS004', 'LV2_CH001_LS004_Q004', 'DRAG',
           '불필요한 사업을 정리하는 {{blank}}을 통해 비용을 줄이면 {{blank}}이 가능해집니다.',
           JSON_OBJECT('choices', JSON_ARRAY('구조조정', '흑자 전환', '유상 증자')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '체질 개선에 성공한 기업은 시장의 재평가를 받습니다.'),
           NULL
       );

-- Q5. LINK: 실적 변화 상황 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS004', 'LV2_CH001_LS004_Q005', 'LINK',
           '실적 변화 상황과 시장의 기대치를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','적자 → 흑자 전환'),
                   JSON_OBJECT('id','L2','text','흑자 → 적자 전환'),
                   JSON_OBJECT('id','L3','text','적자 폭 대폭 축소'),
                   JSON_OBJECT('id','L4','text','흑자 규모 대폭 확대')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','강력한 주가 반등 모멘텀 형성'),
                           JSON_OBJECT('id','R2','text','심각한 우려로 강력한 매도세 출현'),
                           JSON_OBJECT('id','R3','text','실적 개선에 대한 기대감 상승'),
                           JSON_OBJECT('id','R4','text','본격적인 성장에 따른 주가 우상향')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '방향성이 바뀌는 지점을 찾는 것이 실전 투자의 묘미입니다.'),
           NULL
       );

-- Q1. CONCEPT: 비용의 성격
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS005', 'LV2_CH001_LS005_Q001', 'CONCEPT',
           '회사가 장사를 안 해도 나가는 돈이 있습니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '매출이 10% 줄었는데 이익은 반토막이 났어요. 왜 이러죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 바로 "고정비" 때문이에요. 공장 월세나 직원 월급은 매출과 상관없이 매달 나가야 하거든요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '매출이 줄어도 고정비는 그대로라 이익이 더 크게 깎이는 거예요.')
           ), NULL, NULL
       );

-- Q2. SELECT: 고정비의 예시
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS005', 'LV2_CH001_LS005_Q002', 'SELECT',
           '다음 중 기업의 대표적인 "고정비" 항목은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('임대료 및 감가상각비', '원재료비', '포장비', '판매수수료')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '임대료 등은 매출 변화와 상관없이 일정하게 발생하는 비용입니다.'),
           NULL
       );

-- Q3. MATCH: 영업 레버리지
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS005', 'LV2_CH001_LS005_Q003', 'MATCH',
           '고정비를 넘어서는 매출이 발생한 후 이익이 급격히 증가하는 현상을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('영업 레버리지', '부채 레버리지', '가격 전가')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '고정비 비중이 높은 기업은 매출 증가 시 이익이 폭발적으로 늘어납니다.'),
           NULL
       );

-- Q4. DRAG: 비용의 분류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS005', 'LV2_CH001_LS005_Q004', 'DRAG',
           '판매량에 따라 변하는 {{blank}}와 상관없이 일정한 {{blank}}를 구분해야 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('변동비', '고정비', '매출액')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '비용의 성격을 알아야 불황기 기업의 생존력을 알 수 있습니다.'),
           NULL
       );

-- Q5. LINK: 비용 구조와 기업 특성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH001_LS005', 'LV2_CH001_LS005_Q005', 'LINK',
           '비용 구조에 따른 기업의 특징을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','고정비 비중이 높음'),
                   JSON_OBJECT('id','L2','text','변동비 비중이 높음'),
                   JSON_OBJECT('id','L3','text','규모의 경제 실현'),
                   JSON_OBJECT('id','L4','text','한계 비용 제로')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','매출 상승 시 이익이 기하급수적으로 증가'),
                           JSON_OBJECT('id','R2','text','매출과 이익이 비교적 일정하게 움직임'),
                           JSON_OBJECT('id','R3','text','생산량이 많아질수록 제품당 고정비 감소'),
                           JSON_OBJECT('id','R4','text','추가 생산 시 비용이 거의 들지 않음')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '비즈니스 모델마다 이익이 나는 원리가 다릅니다.'),
           NULL
       );

-- Q1. CONCEPT: 재무상태표의 기초 (FAQ: 10억짜리 빌딩이 있으면 부자 아닌가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS001', 'LV2_CH002_LS001_Q001', 'CONCEPT',
           '겉으로 보이는 규모보다 그 안의 "내 돈" 비중이 중요합니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 이 회사는 빌딩도 많고 현금도 1,000억이나 있대요. 엄청난 부자죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 1,000억이 어떻게 만들어졌는지 봐야 해요. 800억이 은행 대출(부채)이라면 진짜 내 돈(자본)은 200억뿐인 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 자산은 부채와 자본을 합친 개념이군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 투자자는 자산 규모보다 부채를 뺀 "순자산(자본)"이 어떻게 변하는지에 집중해야 합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 자산의 구성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS001', 'LV2_CH002_LS001_Q002', 'SELECT',
           '재무상태표에서 "자산"을 정의하는 올바른 수식은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('자산 = 부채 + 자본', '자산 = 부채 - 자본', '자산 = 매출 + 이익', '자산 = 자본 - 부채')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '기업이 굴리는 모든 자원은 남에게 빌린 돈과 내 돈의 합입니다.'),
           NULL
       );

-- Q3. MATCH: 순자산의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS001', 'LV2_CH002_LS001_Q003', 'MATCH',
           '전체 자산에서 부채를 빼고 남은, 주주들의 몫인 진짜 내 돈을 {{blank}}이라고 부릅니다.',
           JSON_OBJECT('choices', JSON_ARRAY('자본(순자산)', '유동부채', '영업이익')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '자본은 주주가 낸 돈과 그동안 벌어들인 이익의 합계입니다.'),
           NULL
       );

-- Q4. DRAG: 재무 구조 분석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS001', 'LV2_CH002_LS001_Q004', 'DRAG',
           '기업이 빌린 돈은 {{blank}} 항목에 기록되고, 주주들이 투자한 원금은 {{blank}} 항목에 기록됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('부채', '자본', '자산')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '자금의 출처에 따라 부채와 자본으로 나뉩니다.'),
           NULL
       );

-- Q5. LINK: 재무 항목 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS001', 'LV2_CH002_LS001_Q005', 'LINK',
           '재무상태표의 항목과 그에 해당하는 구체적인 사례를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','자산 (Asset)'),
                   JSON_OBJECT('id','L2','text','부채 (Liability)'),
                   JSON_OBJECT('id','L3','text','자본 (Equity)'),
                   JSON_OBJECT('id','L4','text','이익잉여금')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','회사가 보유한 공장, 현금, 특허권'),
                           JSON_OBJECT('id','R2','text','은행 대출금 및 갚아야 할 외상값'),
                           JSON_OBJECT('id','R3','text','주주가 투자한 원금과 쌓인 이익'),
                           JSON_OBJECT('id','R4','text','장사해서 벌어 사내에 쌓아둔 돈')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '기본 항목을 알아야 재무 건전성을 판단할 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 지불 능력 (FAQ: 흑자인데 왜 부도가 나나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS002', 'LV2_CH002_LS002_Q001', 'CONCEPT',
           '부도는 자산이 부족해서가 아니라 "현금"이 없어서 일어납니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '장부상으로는 이익인데 회사가 망할 수도 있나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, 이걸 "흑자도산"이라고 해요. 100억짜리 건물이 있어도 당장 오늘 갚아야 할 빚 1억이 없으면 부도가 나죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그래서 1년 안에 현금화할 수 있는 "유동비율"을 반드시 체크해야 합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 부채비율의 안전 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS002', 'LV2_CH002_LS002_Q002', 'SELECT',
           '일반적인 제조업 기준으로, 재무가 안정적이라고 평가받는 부채비율의 기준은?',
           JSON_OBJECT('choices', JSON_ARRAY('100% 이하', '200% 이상', '400% 이상', '부채 0% 상태')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '부채비율 100% 이하는 내 돈이 빚보다 많다는 뜻으로 매우 안전한 수치입니다.'),
           NULL
       );

-- Q3. MATCH: 유동비율의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS002', 'LV2_CH002_LS002_Q003', 'MATCH',
           '1년 안에 갚아야 할 빚 대비 1년 안에 현금화 가능한 자산의 비율을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('유동비율', '부채비율', '당좌비율')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '유동비율은 기업의 단기 지급 능력을 보여줍니다.'),
           NULL
       );

-- Q4. DRAG: 재무 지표 해석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS002', 'LV2_CH002_LS002_Q004', 'DRAG',
           '부채비율이 낮을수록 {{blank}}이 높고, 유동비율이 높을수록 {{blank}} 능력이 좋습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('재무 건전성', '현금 동원', '영업 이익')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '두 지표를 함께 봐야 기업의 생존 능력을 정확히 알 수 있습니다.'),
           NULL
       );

-- Q5. LINK: 지표별 위험 신호 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS002', 'LV2_CH002_LS002_Q005', 'LINK',
           '재무 지표의 상태와 그에 따른 투자자의 판단을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','부채비율 200% 초과'),
                   JSON_OBJECT('id','L2','text','유동비율 100% 미만'),
                   JSON_OBJECT('id','L3','text','부채비율 50% 미만'),
                   JSON_OBJECT('id','L4','text','현금성 자산 급증')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','빚이 너무 많아 이자 부담이 매우 큼'),
                           JSON_OBJECT('id','R2','text','당장 빚 갚을 현금이 부족함(부도 위험)'),
                           JSON_OBJECT('id','R3','text','매우 탄탄하고 보수적인 재무 구조'),
                           JSON_OBJECT('id','R4','text','위기 대응력 및 투자 여력 상승')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '숫자의 변화는 기업의 생존 신호입니다.'),
           NULL
       );

-- Q1. CONCEPT: 자본의 잠식 (FAQ: 자본금이 줄어든다는 게 무슨 뜻인가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS003', 'LV2_CH002_LS003_Q001', 'CONCEPT',
           '밑천이 드러나기 시작하면 상장폐지의 서막입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '자본잠식이라는 말을 들었는데, 회사가 망한다는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, 매우 위험해요. 주주들이 처음에 낸 원금(자본금)까지 적자가 파고든 상태를 말하거든요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이게 계속되면 주식은 휴지 조각이 될 수 있습니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 완전 자본잠식의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS003', 'LV2_CH002_LS003_Q002', 'SELECT',
           '자본 총계가 마이너스(-)가 되어 빚이 자산보다 더 많아진 상태를 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('완전 자본잠식', '부분 자본잠식', '유상 증자', '무상 감자')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '완전 자본잠식은 즉각적인 상장폐지 사유가 될 수 있습니다.'),
           NULL
       );

-- Q3. MATCH: 관리종목 지정 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS003', 'LV2_CH002_LS003_Q003', 'MATCH',
           '자본금의 50% 이상이 잠식되면 거래소는 해당 종목을 {{blank}}으로 지정하여 경고를 보냅니다.',
           JSON_OBJECT('choices', JSON_ARRAY('관리종목', '우량종목', '급등종목')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '관리종목 지정은 상장폐지로 가는 마지막 경고등입니다.'),
           NULL
       );

-- Q4. DRAG: 자본 잠식의 과정
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS003', 'LV2_CH002_LS003_Q004', 'DRAG',
           '지속적인 {{blank}}이 발생하면 쌓아둔 이익이 사라지고, 결국 {{blank}}을 갉아먹게 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('당기순손실', '자본금', '영업이익')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '적자가 쌓이면 결국 회사의 밑천이 바닥납니다.'),
           NULL
       );

-- Q5. LINK: 기업 상태와 경고 신호 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS003', 'LV2_CH002_LS003_Q005', 'LINK',
           '자본의 상태와 그에 따른 거래소의 조치를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','자본잠식률 50% 이상'),
                   JSON_OBJECT('id','L2','text','완전 자본잠식'),
                   JSON_OBJECT('id','L3','text','자본금 < 자본총계'),
                   JSON_OBJECT('id','L4','text','2년 연속 잠식률 50%')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','관리종목 지정 대상'),
                           JSON_OBJECT('id','R2','text','즉각적인 상장폐지 사유'),
                           JSON_OBJECT('id','R3','text','정상적인 재무 상태'),
                           JSON_OBJECT('id','R4','text','상장 적격성 실질심사 대상')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '자본 항목은 기업의 생명선과 같습니다.'),
           NULL
       );

-- Q1. CONCEPT: 증자의 목적 (FAQ: 주식 수를 늘리면 무조건 나쁜가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS004', 'LV2_CH002_LS004_Q001', 'CONCEPT',
           '돈을 빌리는 대신 주식을 더 발행하는 이유를 알아야 합니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '유상증자 공시가 떴는데 주가가 왜 떨어지죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '회사가 돈이 없어서 주주들에게 손을 벌리는 것으로 해석될 수 있기 때문이에요. 주식 수가 많아지니 1주당 가치도 희석되죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '하지만 그 돈으로 큰 공장을 짓는다면 나중에는 호재가 될 수도 있습니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 무상증자의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS004', 'LV2_CH002_LS004_Q002', 'SELECT',
           '주주들에게 돈을 받지 않고 공짜로 주식을 나눠주는 것을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('무상증자', '유상증자', '감자', '배당')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '무상증자는 보통 재무 구조가 튼튼하다는 자신감의 표현으로 호재로 인식됩니다.'),
           NULL
       );

-- Q3. MATCH: 주주 배정 유상증자
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS004', 'LV2_CH002_LS004_Q003', 'MATCH',
           '기존 주주들에게 새로 발행할 주식을 살 권리를 먼저 주는 방식을 {{blank}} 유상증자라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('주주배정', '제3자배정', '일반공모')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '주주배정은 주주들에게 추가 자금 납입을 요구하므로 단기적 악재인 경우가 많습니다.'),
           NULL
       );

-- Q4. DRAG: 증자의 영향
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS004', 'LV2_CH002_LS004_Q004', 'DRAG',
           '제3자배정 유상증자는 큰 투자자가 들어오는 것이라 {{blank}}로, 운영자금 목적의 주주배정은 {{blank}}로 인식되는 경향이 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('호재', '악재', '중립')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '누가, 어떤 목적으로 증자를 하느냐가 중요합니다.'),
           NULL
       );

-- Q5. LINK: 증자/감자 유형별 해석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS004', 'LV2_CH002_LS004_Q005', 'LINK',
           '기업의 결정과 그에 따른 일반적인 시장의 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','무상증자'),
                   JSON_OBJECT('id','L2','text','제3자배정 유상증자'),
                   JSON_OBJECT('id','L3','text','운영자금용 유상증자'),
                   JSON_OBJECT('id','L4','text','무상감자')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','재무 건전성 과시 및 주주 환원 성격'),
                           JSON_OBJECT('id','R2','text','대규모 파트너십 및 투자 자금 유입'),
                           JSON_OBJECT('id','R3','text','현금 고갈에 따른 주주 손벌리기'),
                           JSON_OBJECT('id','R4','text','상장폐지를 막기 위한 최후의 재무 조정')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '공시의 의도를 파악해야 적절히 대응할 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 메자닌 금융 (FAQ: 사채가 주식으로 바뀐다는데 좋은 건가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS005', 'LV2_CH002_LS005_Q001', 'CONCEPT',
           '빚인데 주식이 될 수도 있는 "변신 채권"을 조심하세요.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '전환사채(CB) 물량이 나온다는데 이게 뭔가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '돈을 빌려준 사람이 나중에 이자 대신 주식으로 바꿀 수 있는 권리가 있는 채권이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주식으로 바뀌면 유통 물량이 늘어나서 주가에는 큰 부담이 되죠. 마치 "잠재적 매물 폭탄"과 같습니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 전환사채(CB)의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS005', 'LV2_CH002_LS005_Q002', 'SELECT',
           '채권을 주식으로 바꿀 수 있는 권리가 부여된 사채를 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('전환사채(CB)', '신주인수권부사채(BW)', '일반사채', '국채')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'CB는 주가가 오르면 주식으로 전환해 차익을 노릴 수 있는 채권입니다.'),
           NULL
       );

-- Q3. MATCH: 리픽싱(Refixing)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS005', 'LV2_CH002_LS005_Q003', 'MATCH',
           '주가가 떨어지면 전환 가격을 함께 낮추어주는 조항을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('리픽싱', '액면분할', '배당락')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '리픽싱은 기존 주주들에게는 주식 가치가 더 희석되는 악재입니다.'),
           NULL
       );

-- Q4. DRAG: 오버행 리스크
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS005', 'LV2_CH002_LS005_Q004', 'DRAG',
           'CB나 BW 물량이 시장에 쏟아질 수 있는 위험을 {{blank}}이라고 하며, 이는 주가 상승을 {{blank}}하는 요인이 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('오버행', '억제', '급등')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '잠재적인 대량 매도 물량은 투자 심리를 크게 위축시킵니다.'),
           NULL
       );

-- Q5. LINK: 복합 금융 상품 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS005', 'LV2_CH002_LS005_Q005', 'LINK',
           '금융 상품과 그 권리의 특징을 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','전환사채 (CB)'),
                   JSON_OBJECT('id','L2','text','신주인수권부사채 (BW)'),
                   JSON_OBJECT('id','L3','text','교환사채 (EB)'),
                   JSON_OBJECT('id','L4','text','리픽싱 조항')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','채권 자체가 주식으로 변하는 권리'),
                           JSON_OBJECT('id','R2','text','채권은 유지하고 새 주식만 살 수 있는 권리'),
                           JSON_OBJECT('id','R3','text','보유한 다른 회사 주식으로 바꿀 수 있는 권리'),
                           JSON_OBJECT('id','R4','text','주가 하락 시 주식 전환 가격을 낮추는 조항')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '이런 파생 상품이 많은 기업은 투자 시 희석 위험을 고려해야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: PER의 본질 (FAQ: 수익 대비 주가가 몇 배인가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS001', 'LV2_CH003_LS001_Q001', 'CONCEPT',
           '치킨집 권리금 비유를 통해 PER의 개념을 잡아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 이 치킨집은 1년에 5천만 원을 번대요. 그런데 사장님이 권리금으로 5억을 달라고 하네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럼 투자금을 회수하는 데 딱 10년이 걸리겠네요. 이게 바로 PER 10배라는 뜻이에요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 내가 낸 돈을 연간 이익으로 나누는 거군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. PER이 낮을수록 원금을 빨리 회수할 수 있다는 뜻이니 보통 "싸다"고 평가합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: PER 계산하기
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS001', 'LV2_CH003_LS001_Q002', 'SELECT',
           '시가총액이 2,000억 원이고 당기순이익이 200억 원인 기업의 PER은 얼마일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('5배', '10배', '20배', '100배')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '시가총액을 당기순이익으로 나누면 PER 10배가 나옵니다.'),
           NULL
       );

-- Q3. MATCH: 저PER의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS001', 'LV2_CH003_LS001_Q003', 'MATCH',
           '버는 돈에 비해 주가가 낮게 거래되는 상태를 {{blank}}라고 하며 매력적인 투자 후보가 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('저평가', '고평가', '적정가')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '낮은 PER은 시장에서 저렴하게 평가받고 있음을 의미합니다.'),
           NULL
       );

-- Q4. DRAG: PER 공식 구성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS001', 'LV2_CH003_LS001_Q004', 'DRAG',
           'PER = {{blank}} / {{blank}}',
           JSON_OBJECT('choices', JSON_ARRAY('시가총액', '당기순이익', '매출액')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '가격(P)을 수익(E)으로 나눈 비율(R)입니다.'),
           NULL
       );

-- Q5. LINK: 주가와 이익의 관계 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS001', 'LV2_CH003_LS001_Q005', 'LINK',
           '주가와 실적 변화에 따른 PER의 움직임을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','이익 고정, 주가 상승'),
                   JSON_OBJECT('id','L2','text','주가 고정, 이익 증가'),
                   JSON_OBJECT('id','L3','text','이익과 주가 동반 상승'),
                   JSON_OBJECT('id','L4','text','이익 급감, 주가 고정')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','PER 상승 (비싸짐)'),
                           JSON_OBJECT('id','R2','text','PER 하락 (저렴해짐)'),
                           JSON_OBJECT('id','R3','text','PER 유지 (적정가 유지)'),
                           JSON_OBJECT('id','R4','text','PER 급상승 (고평가 위험)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '주가와 이익의 속도 차이를 이해하는 것이 핵심입니다.'),
           NULL
       );

-- Q1. CONCEPT: PBR의 의미 (FAQ: PBR이 1보다 낮으면 무조건 좋은 건가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS002', 'LV2_CH003_LS002_Q001', 'CONCEPT',
           '회사가 가진 재산보다 주식 값이 더 싼 기묘한 상황입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '이 회사는 빌딩과 현금을 합치면 1,000억 원인데, 시가총액은 500억 원뿐이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 PBR 0.5배 상태예요. 회사를 통째로 사서 다 팔아버려도 500억이 남는 장사죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '와, 그럼 완전 이득 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이론상으론 그렇죠. 다만 장사가 안되어 재산만 깎아 먹고 있다면 시장이 낮게 평가할 수도 있어요.')
           ), NULL, NULL
       );

-- Q2. SELECT: PBR 1배의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS002', 'LV2_CH003_LS002_Q002', 'SELECT',
           '주가가 기업의 1주당 순자산 가치와 정확히 일치하는 상태의 PBR은 얼마일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('0배', '1배', '1.5배', '2배')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', 'PBR 1배는 주가가 장부상 재산 가치와 같다는 기준점입니다.'),
           NULL
       );

-- Q3. MATCH: 업종별 PBR 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS002', 'LV2_CH003_LS002_Q003', 'MATCH',
           '부동산이나 현금이 많은 전통 제조업은 PBR이 {{blank}} 경향이 있고, 기술력 중심 성장주는 PBR이 {{blank}} 경향이 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('낮은', '높은', '일정한')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '자산 비중에 따라 업종별 PBR 기준이 다릅니다.'),
           NULL
       );

-- Q4. DRAG: PBR 공식
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS002', 'LV2_CH003_LS002_Q004', 'DRAG',
           'PBR = {{blank}} / {{blank}}',
           JSON_OBJECT('choices', JSON_ARRAY('시가총액', '순자산(자본)', '매출액')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '시장 가격(Price)을 장부 가치(Book-value)로 나눈 비율입니다.'),
           NULL
       );

-- Q5. LINK: PBR 수치별 해석 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS002', 'LV2_CH003_LS002_Q005', 'LINK',
           'PBR 수치에 따른 일반적인 시장의 평가를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','PBR 0.2배 수준'),
                   JSON_OBJECT('id','L2','text','PBR 1.0배 수준'),
                   JSON_OBJECT('id','L3','text','PBR 10.0배 수준'),
                   JSON_OBJECT('id','L4','text','PBR 하락 추세')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','극심한 저평가 혹은 자산 가치 불신'),
                           JSON_OBJECT('id','R2','text','자산 가치만큼 적정하게 평가됨'),
                           JSON_OBJECT('id','R3','text','성장 프리미엄이 매우 높게 반영됨'),
                           JSON_OBJECT('id','R4','text','기업의 자산 가치 훼손 우려 발생')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', 'PBR은 하락장에서 주가의 바닥을 가늠하는 지표로 쓰입니다.'),
           NULL
       );

-- Q1. CONCEPT: 업종별 멀티플 (FAQ: PER 20배면 무조건 비싼 건가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS003', 'LV2_CH003_LS003_Q001', 'CONCEPT',
           '축구선수와 야구선수의 연봉 기준이 다르듯, 주식도 업종별 기준이 다릅니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'mentor', 'text', '은행주는 PER 5배가 보통이지만, 반도체는 20배도 싸다고 할 때가 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '와, 그럼 절대적인 숫자만 보면 안 되겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 내가 사려는 주식의 PER이 "업종 평균"보다 낮은지 확인하는 게 핵심입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 올바른 비교 대상
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS003', 'LV2_CH003_LS003_Q002', 'SELECT',
           '기업의 고평가 여부를 판단할 때 가장 바람직한 비교 방법은?',
           JSON_OBJECT('choices', JSON_ARRAY('전혀 다른 업종의 1위 기업과 비교', '동일한 업종 내의 경쟁사들과 비교', '내 매수 희망 가격과 비교', '어제 주가와 비교')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '같은 사업 모델을 가진 경쟁사와 비교해야 공정합니다.'),
           NULL
       );

-- Q3. MATCH: 저평가 함정
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS003', 'LV2_CH003_LS003_Q003', 'MATCH',
           '지표는 낮지만 성장이 멈춰 주가가 오르지 않는 상태를 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('저평가 함정', '골든 크로스', '매집 구간')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '단순히 숫자만 낮다고 좋은 주식은 아닐 수 있습니다.'),
           NULL
       );

-- Q4. DRAG: 멀티플 부여 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS003', 'LV2_CH003_LS003_Q004', 'DRAG',
           '시장은 성장성이 높은 섹터에 더 높은 {{blank}}를 부여하며, 이를 통해 {{blank}} 주가가 정당화됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('멀티플(배수)', '높은', '낮은')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '미래 성장이 기대되면 현재 비싸도 시장은 인정해 줍니다.'),
           NULL
       );

-- Q5. LINK: 지표 조합 해석 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS003', 'LV2_CH003_LS003_Q005', 'LINK',
           'PER과 PBR의 조합에 따른 일반적인 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','저PER + 저PBR'),
                   JSON_OBJECT('id','L2','text','고PER + 고PBR'),
                   JSON_OBJECT('id','L3','text','고PER + 저PBR'),
                   JSON_OBJECT('id','L4','text','저PER + 고PBR')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','전형적인 가치주 (안정성 높음)'),
                           JSON_OBJECT('id','R2','text','전형적인 성장주 (변동성 큼)'),
                           JSON_OBJECT('id','R3','text','자산은 많으나 수익성이 낮은 기업'),
                           JSON_OBJECT('id','R4','text','수익성은 좋으나 자산이 적은 기술주')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '두 지표를 함께 봐야 기업의 성격이 정확히 보입니다.'),
           NULL
       );

-- Q1. CONCEPT: 성장의 프리미엄 (FAQ: 왜 적자인데도 주가는 폭등하나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS004', 'LV2_CH003_LS004_Q001', 'CONCEPT',
           '성장주는 미래의 이익을 현재로 당겨와서 가격에 반영합니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '이 기업은 PER이 100배가 넘는데 왜 계속 오르죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '투자자들이 "미래의 폭발적 성장"을 믿기 때문이에요. 나중엔 돈을 어마어마하게 벌 거라 보는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 지금의 높은 가격은 미래 가치를 미리 당겨온 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 가치주의 장점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS004', 'LV2_CH003_LS004_Q002', 'SELECT',
           '일반적으로 가치주(Value Stock)가 투자자에게 매력적인 가장 큰 이유는?',
           JSON_OBJECT('choices', JSON_ARRAY('주가가 하루에 30%씩 급등해서', '실적 대비 주가가 싸고 배당이 많아서', '신기술 소식이 매일 나와서', '거래량이 가장 많아서')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '가치주는 낮은 변동성과 안정적인 배당이 장점입니다.'),
           NULL
       );

-- Q3. MATCH: 성장주의 핵심 지표
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS004', 'LV2_CH003_LS004_Q003', 'MATCH',
           '성장주는 현재의 이익보다 미래의 {{blank}}에 더 큰 가치를 두므로 높은 PER이 정당화되기도 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('성장률', '청산가치', '부채비율')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '성장률은 미래의 이익을 결정하는 가장 중요한 변수입니다.'),
           NULL
       );

-- Q4. DRAG: 금리와의 관계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS004', 'LV2_CH003_LS004_Q004', 'DRAG',
           '금리가 낮을 때는 {{blank}}가 유리하고, 금리가 높아지면 실적이 탄탄한 {{blank}}가 주목받습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('성장주', '가치주', '테마주')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '금리는 성장주의 미래 이익 가치를 깎는 요인이 됩니다.'),
           NULL
       );

-- Q5. LINK: 업종 성격 연결 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS004', 'LV2_CH003_LS004_Q005', 'LINK',
           '종목의 유형과 그에 해당하는 산업군을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','성장주 (Growth)'),
                   JSON_OBJECT('id','L2','text','가치주 (Value)'),
                   JSON_OBJECT('id','L3','text','경기 방어주'),
                   JSON_OBJECT('id','L4','text','경기 민감주')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','AI, 로봇, 2차전지, 바이오'),
                           JSON_OBJECT('id','R2','text','은행, 보험, 지주사, 가스/전기'),
                           JSON_OBJECT('id','R3','text','음식료, 통신, 공공 서비스'),
                           JSON_OBJECT('id','R4','text','해운, 화학, 건설, 자동차')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '산업의 성격을 알면 적합한 투자 전략을 짤 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 코리아 디스카운트 (FAQ: 우리나라는 왜 미국보다 저렴한가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS005', 'LV2_CH003_LS005_Q001', 'CONCEPT',
           '실력은 좋은데 인정을 못 받는 한국 시장의 특징을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '한국 주식들은 PER 10배 아래가 많아요. 미국은 20배가 넘는데 왜 이렇죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '낮은 배당과 지배구조 리스크 등으로 인해 시장 전체가 낮게 평가받는 현상이에요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 그래서 최근 "벨류업 프로그램" 같은 정책이 나오는 거군요?')
           ), NULL, NULL
       );

-- Q2. SELECT: 기업 가치 제고의 핵심
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS005', 'LV2_CH003_LS005_Q002', 'SELECT',
           '최근 시장에서 강조하는 "기업 벨류업"의 핵심적인 수단은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('주주 환원 강화(배당, 자사주 소각)', '대출 확대', '신규 공장 증설', '회사 이름 변경')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '주주에게 이익을 돌려주는 것이 가치 제고의 지름길입니다.'),
           NULL
       );

-- Q3. MATCH: 자사주 소각의 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS005', 'LV2_CH003_LS005_Q003', 'MATCH',
           '회사가 자기 주식을 사서 없애버리는 {{blank}}은 주식 수를 줄여 주당 가치를 직접적으로 높입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('자사주 소각', '액면 분할', '증자')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '자사주 소각은 가장 강력한 주가 부양 신호 중 하나입니다.'),
           NULL
       );

-- Q4. DRAG: 가치 판단의 종합
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS005', 'LV2_CH003_LS005_Q004', 'DRAG',
           '단순히 지표가 낮은 것보다 {{blank}}이 높고 적극적으로 {{blank}}하는 기업이 재평가받을 가능성이 큽니다.',
           JSON_OBJECT('choices', JSON_ARRAY('수익성(ROE)', '주주 환원', '부채비율')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '돈을 잘 벌고 주주와 잘 나누는 기업이 시장에서 사랑받습니다.'),
           NULL
       );

-- Q5. LINK: 투자 상황별 지표 활용 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS005', 'LV2_CH003_LS005_Q005', 'LINK',
           '투자의 목적에 따라 우선적으로 확인해야 할 지표를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','망하지 않을 기업 찾기'),
                   JSON_OBJECT('id','L2','text','실적 대비 싼 종목 찾기'),
                   JSON_OBJECT('id','L3','text','재산 대비 싼 종목 찾기'),
                   JSON_OBJECT('id','L4','text','주주를 위하는 기업 찾기')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','부채비율 및 유동비율'),
                           JSON_OBJECT('id','R2','text','PER (주가수익비율)'),
                           JSON_OBJECT('id','R3','text','PBR (주가순자산비율)'),
                           JSON_OBJECT('id','R4','text','배당수익률 및 자사주 소각 이력')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '상황에 따라 적절한 지표를 선택하는 것이 중급 투자의 실력입니다.'),
           NULL
       );

-- Q1. CONCEPT: ROE의 본질 (FAQ: 수익금이 같은데 왜 실력이 다르다고 하나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS001', 'LV2_CH004_LS001_Q001', 'CONCEPT',
           '내 돈 대비 수익률을 따지는 것이 진짜 실력입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', 'A는 1,000만 원으로 200만 원을 벌고, B는 1억 원으로 200만 원을 벌었대요. 둘 다 똑같은 실력자죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요! A는 20% 수익을 냈고(ROE 20%), B는 고작 2% 수익을 낸 거예요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '적은 돈으로 더 많은 수익을 내는 기업이 진짜 경영을 잘하는 곳입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 투자한 원금 대비 얼마나 벌었는지를 보는 게 ROE군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: ROE의 계산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS001', 'LV2_CH004_LS001_Q002', 'SELECT',
           '자기자본이 1,000억 원이고 당기순이익이 150억 원인 기업의 ROE는 몇 %일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('1.5%', '15%', '150%')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', 'ROE는 (당기순이익 / 자기자본) × 100으로 계산합니다.'),
           NULL
       );

-- Q3. MATCH: 복리의 마법
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS001', 'LV2_CH004_LS001_Q003', 'MATCH',
           '높은 ROE를 유지하며 이익을 재투자하면 자산이 눈덩이처럼 불어나는 {{blank}} 효과를 누릴 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('복리', '단리', '감액')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '지속적인 고ROE는 기업 가치를 기하급수적으로 키웁니다.'),
           NULL
       );

-- Q4. DRAG: ROE의 구성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS001', 'LV2_CH004_LS001_Q004', 'DRAG',
           'ROE는 기업이 {{blank}}를 얼마나 효율적으로 사용하여 {{blank}}을 내는지를 보여주는 지표입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('자기자본', '당기순이익', '부채')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '주주의 돈으로 낸 최종 수익률을 의미합니다.'),
           NULL
       );

-- Q5. LINK: ROE 수치별 해석 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS001', 'LV2_CH004_LS001_Q005', 'LINK',
           'ROE 상태에 따른 일반적인 평가를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','ROE > 15% 지속'),
                   JSON_OBJECT('id','L2','text','ROE < 예금 금리'),
                   JSON_OBJECT('id','L3','text','ROE 하락 추세'),
                   JSON_OBJECT('id','L4','text','ROE 급등 (부채 증가)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','워렌 버핏이 좋아하는 우량 기업'),
                           JSON_OBJECT('id','R2','text','차라리 은행에 맡기는 게 나은 경영'),
                           JSON_OBJECT('id','R3','text','기업의 경쟁력이 약화되는 신호'),
                           JSON_OBJECT('id','R4','text','재무 위험이 동반된 일시적 수익성')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', 'ROE는 시중 금리나 동종 업계와 비교해야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 주당 가치의 이해 (FAQ: 이익이 늘었는데 왜 1주당 가치는 줄어드나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS002', 'LV2_CH004_LS002_Q001', 'CONCEPT',
           '피자 판이 커져도 조각 수가 더 많이 늘어나면 내 몫은 줄어듭니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '회사가 작년보다 돈을 더 많이 벌었대요! 그럼 제 주식의 가치도 무조건 올라가나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그사이에 주식 수를 너무 많이 늘리지는 않았는지 봐야 해요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이익이 20% 늘었어도 주식 수가 50% 늘었다면, 1주가 가져가는 이익인 "EPS"는 오히려 줄어듭니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 전체 금액보다 "1주가 얼마를 버는가"가 주가에는 더 중요하겠네요!')
           ), NULL, NULL
       );

-- Q2. SELECT: EPS 계산하기
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS002', 'LV2_CH004_LS002_Q002', 'SELECT',
           '당기순이익이 100억 원이고 발행 주식 총수가 100만 주일 때, 이 기업의 EPS는 얼마일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('1,000원', '10,000원', '100,000원')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', 'EPS = 당기순이익 / 발행 주식 수 이므로 10,000원입니다.'),
           NULL
       );

-- Q3. MATCH: 자사주 소각의 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS002', 'LV2_CH004_LS002_Q003', 'MATCH',
           '회사가 주식을 사서 없애버리는 {{blank}}은 주식 수를 줄여 EPS를 높이는 효과가 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('자사주 소각', '액면 분할', '증자')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '주식 수가 줄어들면 1주당 돌아오는 이익 알맹이가 커집니다.'),
           NULL
       );

-- Q4. DRAG: EPS 하락 요인
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS002', 'LV2_CH004_LS002_Q004', 'DRAG',
           '이익이 그대로일 때 과도한 {{blank}}을 하면 주식 수가 늘어나 기존 주주의 {{blank}}가 희석됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('유상증자', 'EPS', '배당')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '주식 수가 늘어나면 주당 가치는 떨어집니다.'),
           NULL
       );

-- Q5. LINK: 실적과 주식 수의 변화 연결 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS002', 'LV2_CH004_LS002_Q005', 'LINK',
           '상황에 따른 EPS의 변화를 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','이익 증가, 주식 수 고정'),
                   JSON_OBJECT('id','L2','text','이익 고정, 자사주 소각'),
                   JSON_OBJECT('id','L3','text','이익 감소, 유상증자'),
                   JSON_OBJECT('id','L4','text','이익 증가 < 주식 수 증가')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','EPS 상승 (가장 이상적인 성장)'),
                           JSON_OBJECT('id','R2','text','EPS 상승 (주당 가치 제고)'),
                           JSON_OBJECT('id','R3','text','EPS 급락 (주당 가치 파괴)'),
                           JSON_OBJECT('id','R4','text','EPS 하락 (가치 희석 발생)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', 'EPS는 주가와 가장 밀접하게 동행하는 지표입니다.'),
           NULL
       );

-- Q1. CONCEPT: 프리미엄의 이유 (FAQ: 이 주식은 PBR이 5배나 되는데 왜 사나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS003', 'LV2_CH004_LS003_Q001', 'CONCEPT',
           '돈을 잘 버는 기계는 당연히 비싸게 팔립니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', 'A 회사는 장부 가치보다 5배 비싼데(PBR 5배), 사람들은 왜 이 주식을 좋아하죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 회사의 ROE가 30%나 되기 때문이에요. 내 돈을 매년 30%씩 불려주는 마법의 기계인 셈이죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반면 재산은 많아도 수익성(ROE)이 1%라면 아무도 비싸게 사려 하지 않겠죠?'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 높은 ROE가 높은 PBR을 정당화해 주는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 최상의 종목 조합
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS003', 'LV2_CH004_LS003_Q002', 'SELECT',
           '가치 투자자들이 가장 선호하는 "보석 같은 종목"의 지표 조합은?',
           JSON_OBJECT('choices', JSON_ARRAY('저ROE + 저PBR', '고ROE + 저PBR', '고ROE + 고PBR')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '실력은 좋은데(고ROE) 아직 가격은 싼(저PBR) 종목이 최고입니다.'),
           NULL
       );

-- Q3. MATCH: 시장의 평가
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS003', 'LV2_CH004_LS003_Q003', 'MATCH',
           '기업이 자본을 늘려가는데도 ROE가 꺾이지 않는다면, 시장은 주가에 더 높은 {{blank}}를 부여합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('멀티플(배수)', '이자율', '할인율')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '수익성 유지는 강력한 프리미엄의 근거입니다.'),
           NULL
       );

-- Q4. DRAG: 수익성과 가치
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS003', 'LV2_CH004_LS003_Q004', 'DRAG',
           '{{blank}}가 높을수록 주주는 빠른 자산 증식을 기대할 수 있으며, 이는 자연스럽게 {{blank}}의 상승으로 이어집니다.',
           JSON_OBJECT('choices', JSON_ARRAY('ROE', 'PBR', '부채비율')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '벌어들이는 능력이 가격을 결정합니다.'),
           NULL
       );

-- Q5. LINK: 지표 조합별 기업 성격 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS003', 'LV2_CH004_LS003_Q005', 'LINK',
           'ROE와 PBR의 조합에 따른 기업의 상태를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','고ROE + 저PBR'),
                   JSON_OBJECT('id','L2','text','고ROE + 고PBR'),
                   JSON_OBJECT('id','L3','text','저ROE + 저PBR'),
                   JSON_OBJECT('id','L4','text','저ROE + 고PBR')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','시장에서 소외된 저평가 우량주'),
                           JSON_OBJECT('id','R2','text','성장성을 인정받은 인기 종목'),
                           JSON_OBJECT('id','R3','text','자산은 많으나 효율이 낮은 소외주'),
                           JSON_OBJECT('id','R4','text','거품이 꼈을 가능성이 높은 위험주')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '수익성 지표는 반드시 가격 지표와 함께 봐야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 배당의 가치 (FAQ: 배당 많이 주는 회사가 무조건 좋나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS004', 'LV2_CH004_LS004_Q001', 'CONCEPT',
           '배당은 기업이 주주를 존중한다는 가장 확실한 증거입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '이 회사는 은행 이자보다 많은 5% 배당을 준대요! 무조건 사야겠죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '좋은 신호지만 "배당성향"도 봐야 해요. 번 돈보다 더 많은 배당을 준다면 회사의 미래가 위험할 수 있거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 내실을 다지면서 적당히 나눠주는지가 중요하군요?')
           ), NULL, NULL
       );

-- Q2. SELECT: 배당수익률 계산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS004', 'LV2_CH004_LS004_Q002', 'SELECT',
           '주가가 10,000원이고 주당 배당금이 500원일 때, 배당수익률은 몇 %일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('0.5%', '5%', '50%')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '배당수익률 = (주당배당금 / 주가) × 100입니다.'),
           NULL
       );

-- Q3. MATCH: 배당성향의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS004', 'LV2_CH004_LS004_Q003', 'MATCH',
           '기업이 벌어들인 당기순이익 중 배당금으로 얼마를 썼는지 보여주는 지표를 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('배당성향', '배당수익률', '배당락')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '이익 중 주주에게 돌아가는 몫의 비중을 뜻합니다.'),
           NULL
       );

-- Q4. DRAG: 배당의 성격
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS004', 'LV2_CH004_LS004_Q004', 'DRAG',
           '주로 성숙기에 접어든 {{blank}} 기업들이 배당을 많이 주며, 이는 주가 하락 시 {{blank}} 역할을 하기도 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('저성장', '안전판', '고성장')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '배당은 하락장에서 주가를 지탱해 주는 힘이 됩니다.'),
           NULL
       );

-- Q5. LINK: 투자 성향별 배당 전략 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS004', 'LV2_CH004_LS004_Q005', 'LINK',
           '투자 목적에 맞는 기업의 배당 특성을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','은퇴 후 정기 수익 필요'),
                   JSON_OBJECT('id','L2','text','공격적인 자산 증식'),
                   JSON_OBJECT('id','L3','text','주주 환원 강화 기업'),
                   JSON_OBJECT('id','L4','text','적자 상태의 기업')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','고배당주 및 배당성장주'),
                           JSON_OBJECT('id','R2','text','무배당 혹은 저배당 성장주'),
                           JSON_OBJECT('id','R3','text','배당성향과 배당금 확대 추세'),
                           JSON_OBJECT('id','R4','text','배당 여력이 없어 배당 중단 위험')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '나의 현금 흐름 계획에 맞는 종목 선택이 필요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 경제적 해자 (FAQ: 지금 잘 버는 게 내년에도 유지될까요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS005', 'LV2_CH004_LS005_Q001', 'CONCEPT',
           '적의 침입을 막는 성곽 주변의 연못, "해자"가 기업에도 있습니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '이 회사는 지금 수익이 엄청나요! 근데 경쟁사가 따라오면 어쩌죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그래서 "경제적 해자"가 중요해요. 강력한 브랜드나 특허 같은 진입 장벽 말이죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '해자가 없는 높은 ROE는 금방 무너지지만, 해자가 있는 기업은 높은 수익성을 10년 넘게 유지하죠.')
           ), NULL, NULL
       );

-- Q2. SELECT: 수익성 지속의 신호
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS005', 'LV2_CH004_LS005_Q002', 'SELECT',
           '다음 중 기업의 수익성이 장기적으로 지속될 가능성이 가장 높은 상황은?',
           JSON_OBJECT('choices', JSON_ARRAY('일시적인 자산 매각 이익 발생', '강력한 브랜드 충성도와 높은 점유율', '단순한 유행으로 인한 매출 급증')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '브랜드 가치는 경쟁자가 쉽게 빼앗을 수 없는 해자가 됩니다.'),
           NULL
       );

-- Q3. MATCH: 실적 안정성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS005', 'LV2_CH004_LS005_Q003', 'MATCH',
           '경기에 상관없이 꾸준한 수요가 있어 수익성이 안정적인 산업을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('경기 방어주', '경기 민감주', '테마주')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '음식료, 유틸리티 등이 대표적인 방어주입니다.'),
           NULL
       );

-- Q4. DRAG: 이익의 질 판단
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS005', 'LV2_CH004_LS005_Q004', 'DRAG',
           '좋은 수익성이란 일회성 이익이 아닌 {{blank}}에서 발생하며, 수년간 {{blank}}되는 것을 말합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('영업 활동', '유지', '부채 감소')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '지속 가능성이 없는 수익은 가짜 실력입니다.'),
           NULL
       );

-- Q5. LINK: 기업 상황별 수익 지속성 연결 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS005', 'LV2_CH004_LS005_Q005', 'LINK',
           '기업의 상태와 수익성에 대한 올바른 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','특허권 및 독점 기술 보유'),
                   JSON_OBJECT('id','L2','text','반복 구매가 일어나는 제품'),
                   JSON_OBJECT('id','L3','text','원자재 가격에 수익이 춤춤'),
                   JSON_OBJECT('id','L4','text','단순 조립 및 낮은 기술 장벽')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','강력한 해자로 높은 이익률 유지'),
                           JSON_OBJECT('id','R2','text','현금 흐름이 안정적이고 예측 가능'),
                           JSON_OBJECT('id','R3','text','외부 환경에 따른 수익 변동성 큼'),
                           JSON_OBJECT('id','R4','text','경쟁 심화로 수익성 악화 위험')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '수익의 크기보다 수익의 원천을 파악해야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 금리가 주가를 결정하는 원리 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS001', 'LV2_CH005_LS001_Q001', 'CONCEPT',
           '금리가 오르면 왜 주식 시장에서 돈이 빠져나갈까요? 그 심층적인 이유를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 금리가 오르면 제 주식은 왜 떨어지는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '두 가지 핵심 이유가 있어요. 첫째는 "기회비용" 때문입니다. 안전한 은행 이자가 5%라면, 위험을 무릅쓰고 주식에 투자할 매력이 줄어들죠. 그래서 돈이 주식 시장에서 은행으로 이동합니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '둘째는 "할인율" 때문이에요. 주가는 기업이 미래에 벌어들일 돈을 현재 가치로 당겨온 것인데, 금리가 높을수록 그 미래의 돈을 더 크게 깎아서 계산(할인)하게 됩니다. 즉, 기업 가치 자체가 낮게 평가되는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 안전한 돈의 몸값이 비싸지니까 위험한 주식의 인기가 떨어지고, 미래 수익의 가치도 깎이는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 금리 인상의 직접적 결과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS001', 'LV2_CH005_LS001_Q002', 'SELECT',
           '중앙은행이 금리를 인상했을 때 기업에게 나타나는 가장 즉각적인 부정적 영향은?',
           JSON_OBJECT('choices', JSON_ARRAY('대출 이자 비용 증가로 인한 순이익 감소', '제품 판매가 급격한 상승', '주식 발행 수의 자동 증가', '법인세율의 자동 인상')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '금리가 오르면 기업이 빌린 돈에 대한 이자 부담이 커져 최종 이익이 줄어듭니다.'), NULL
       );
-- Q3. MATCH: 할인율과 성장주
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS001', 'LV2_CH005_LS001_Q003', 'MATCH',
           '금리가 오를 때 미래 이익을 현재 가치로 환산하는 기준인 {{blank}}이 높아져 성장주 주가에 타격을 줍니다.',
           JSON_OBJECT('choices', JSON_ARRAY('할인율', '배당률', '성장률')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '할인율은 금리와 동행하며, 미래 꿈을 먹고 사는 성장주에 치명적입니다.'), NULL
       );
-- Q4. DRAG: 금리와 자금 흐름
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS001', 'LV2_CH005_LS001_Q004', 'DRAG',
           '금리가 하락하면 시중 유동성이 {{blank}}하여 주식 시장으로 돈이 들어오고, 금리가 상승하면 {{blank}} 자산 선호가 강해집니다.',
           JSON_OBJECT('choices', JSON_ARRAY('증가', '안전', '감소')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '금리는 돈의 흐름을 결정하는 밸브 역할을 합니다.'), NULL
       );
-- Q5. LINK: 금리 상황별 유리한 자산 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS001', 'LV2_CH005_LS001_Q005', 'LINK',
           '금리 주기와 상대적으로 투자 매력이 높아지는 대상을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','금리 인하 시작 지점'),
                   JSON_OBJECT('id','L2','text','금리 고점 및 유지'),
                   JSON_OBJECT('id','L3','text','제로 금리 시대'),
                   JSON_OBJECT('id','L4','text','금리 급격한 인상 시기')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','성장주 및 기술주 반등'),
                           JSON_OBJECT('id','R2','text','고금리 예금 및 채권 수익'),
                           JSON_OBJECT('id','R3','text','부동산 및 주식 등 위험자산 과열'),
                           JSON_OBJECT('id','R4','text','현금 비중 확대 및 관망')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '금리는 자산 가격을 결정하는 가장 강력한 중력입니다.'),
           NULL
       );

-- Q1. CONCEPT: 환율이 기업에 주는 영향 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS002', 'LV2_CH005_LS002_Q001', 'CONCEPT',
           '달러가 비싸지면(원화 약세) 우리 기업들에게는 어떤 일이 벌어질까요?',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 뉴스에서 "환율이 올라서 수출 기업 실적이 좋아진다"는데 왜 그런가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '미국에 1달러짜리 물건을 파는 기업을 생각해보세요. 환율이 1,000원일 땐 1,000원을 벌지만, 환율이 1,400원이 되면 똑같은 1달러를 받아도 한국 돈으로 1,400원을 벌게 됩니다. 가만히 앉아서 매출이 40% 늘어나는 효과죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반대로 해외에서 원재료를 사와야 하는 수입 기업은 죽을 맛입니다. 1,000원이면 사던 재료를 이제 1,400원 줘야 하니까요. 그래서 환율은 업종마다 호재와 악재가 극명히 갈립니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 수출 위주인 반도체나 자동차는 웃고, 기름을 사와야 하는 항공사나 음식료 회사는 힘들겠네요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 고환율 수혜 업종
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS002', 'LV2_CH005_LS002_Q002', 'SELECT',
           '원/달러 환율 상승(원화 가치 하락) 시 일반적으로 실적이 개선되는 기업의 특징은?',
           JSON_OBJECT('choices', JSON_ARRAY('해외 매출 비중이 높은 수출 기업', '원재료 수입 비중이 높은 제조 기업', '달러 부채가 많은 항공 기업', '내수 시장만 공략하는 서비스 기업')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '수출 기업은 원화 약세 시 가격 경쟁력이 높아지고 환차익을 얻습니다.'), NULL
       );
-- Q3. MATCH: 외국인 투자자의 심리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS002', 'LV2_CH005_LS002_Q003', 'MATCH',
           '환율이 급등하면 외국인은 주가가 올라도 환율에서 손해를 보는 {{blank}}을 우려하여 한국 주식을 매도합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('환차손', '환차익', '스왑포인트')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '외국인에게는 주가 수익률만큼 환율 변동이 중요합니다.'), NULL
       );
-- Q4. DRAG: 환율과 물가
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS002', 'LV2_CH005_LS002_Q004', 'DRAG',
           '환율이 상승하면 수입 물가가 {{blank}}하여 국내 인플레이션을 자극하고, 이는 다시 {{blank}} 인상 압박으로 이어집니다.',
           JSON_OBJECT('choices', JSON_ARRAY('상승', '금리', '하락')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '환율은 국내 물가와 금리 정책에도 큰 영향을 줍니다.'), NULL
       );
-- Q5. LINK: 환율 변동과 업종별 영향 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS002', 'LV2_CH005_LS002_Q005', 'LINK',
           '원/달러 환율 상승(원화 가치 하락) 시의 영향을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','자동차/조선업'),
                   JSON_OBJECT('id','L2','text','항공/해운업'),
                   JSON_OBJECT('id','L3','text','음식료/원자재 수입'),
                   JSON_OBJECT('id','L4','text','외국인 투자자')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','수출 가격 경쟁력 강화 및 환차익'),
                           JSON_OBJECT('id','R2','text','달러 결제 비용 및 부채 부담 증가'),
                           JSON_OBJECT('id','R3','text','수입 원가 상승으로 수익성 악화'),
                           JSON_OBJECT('id','R4','text','환차손 우려로 인한 매도세 출현')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '환율은 섹터별 수익률을 가르는 핵심 잣대입니다.'),
           NULL
       );

-- Q1. CONCEPT: 인플레이션과 주가의 관계 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS003', 'LV2_CH005_LS003_Q001', 'CONCEPT',
           '물가가 오르는 "인플레이션"이 왜 주식 시장에 공포를 줄까요?',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '물가가 오르면 기업들도 제품 가격을 올려서 돈을 더 많이 벌 텐데, 왜 주가엔 안 좋은가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '적당한 물가 상승은 호재지만, 급격한 인플레이션은 두 가지 독이 됩니다. 첫째, 원재료 값이 너무 빨리 올라 기업의 이익이 깎입니다. 둘째, 가장 무서운 건 중앙은행의 "금리 인상"이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '중앙은행은 물가를 잡기 위해 금리라는 소방수를 투입합니다. 금리를 높여 사람들이 돈을 덜 쓰게 만들죠. 이 과정에서 경기 둔화 우려와 금리 인상 공포가 시장을 덮치게 됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 인플레이션 그 자체보다 그걸 잡으려다 경기까지 망칠까 봐 시장이 떠는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 소비자물가지수(CPI)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS003', 'LV2_CH005_LS003_Q002', 'SELECT',
           '전 세계 투자자들이 매달 미국에서 발표되는 이 지표에 주목합니다. 물가 상승률을 나타내는 지표는?',
           JSON_OBJECT('choices', JSON_ARRAY('CPI (소비자물가지수)', 'GDP (국내총생산)', 'BDI (발틱운임지수)', 'KOSPI 지수')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'CPI가 예상보다 높으면 금리 인상 확률이 커져 주가에는 악재가 됩니다.'), NULL
       );
-- Q3. MATCH: 최악의 상황 스태그플레이션
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS003', 'LV2_CH005_LS003_Q003', 'MATCH',
           '경기는 불황인데 물가만 치솟는 주식 투자의 가장 어려운 시기를 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('스태그플레이션', '디플레이션', '하이퍼인플레이션')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '성장은 없는데 비용(물가)만 오르는 기업에겐 최악의 시나리오입니다.'), NULL
       );
-- Q4. DRAG: 인플레이션 수혜주
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS003', 'LV2_CH005_LS003_Q004', 'DRAG',
           '인플레이션 시기에는 원가 상승을 소비자에게 떠넘길 수 있는 {{blank}}이 강한 기업이나, 가치가 유지되는 {{blank}} 자산 관련주가 유리합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('가격 결정권', '실물', '부채')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '비용 전가 능력이 있는 기업이 인플레이션에서 살아남습니다.'), NULL
       );
-- Q5. LINK: 물가 지표 결과와 시장 반응 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS003', 'LV2_CH005_LS003_Q005', 'LINK',
           '물가 지표(CPI) 발표에 따른 시장의 일반적인 예측을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','CPI가 예상보다 높게 나옴'),
                   JSON_OBJECT('id','L2','text','CPI가 예상보다 낮게 나옴'),
                   JSON_OBJECT('id','L3','text','유가 및 원자재가 폭등'),
                   JSON_OBJECT('id','L4','text','기저효과로 물가 상승 둔화')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','긴축 우려 고조 → 주가 하락 가능성'),
                           JSON_OBJECT('id','R2','text','금리 인하 기대감 → 주가 반등 모멘텀'),
                           JSON_OBJECT('id','R3','text','생산 비용 증가 → 기업 이익 감소 우려'),
                           JSON_OBJECT('id','R4','text','금리 동결 가능성 → 시장 심리 안도')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '지표 하나가 중앙은행의 다음 수를 결정합니다.'),
           NULL
       );

-- Q1. CONCEPT: 섹터 로테이션 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS004', 'LV2_CH005_LS004_Q001', 'CONCEPT',
           '경기의 계절에 따라 옷을 갈아입듯 주식도 갈아타야 합니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '언제나 잘 나가는 주식은 없나요? 왜 제 주식은 예전처럼 안 오르죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주식 시장에는 "사계절"이 있기 때문이에요. 경기가 회복될 땐 기술주나 금융주가 먼저 가고, 경기가 너무 뜨거워져 금리를 올리면 산업재가 힘을 씁니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반대로 경기가 침체되면 사람들은 밥은 먹고 전기는 써야 하니 음식료나 유틸리티 같은 "방어주"로 숨어듭니다. 이걸 "섹터 로테이션"이라고 해요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 지금이 경기의 어떤 지점인지 알면 어떤 종목을 사야 할지도 보이겠네요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 경기 민감주의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS004', 'LV2_CH005_LS004_Q002', 'SELECT',
           '경기 회복기에 주가가 가장 탄력적으로 움직이는 "경기 민감주"에 속하는 업종은?',
           JSON_OBJECT('choices', JSON_ARRAY('철강, 화학, 조선', '통신, 전기, 수도', '병원, 제약', '정부 기관')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '제조업 중심인 우리나라는 경기 회복 시 산업재와 소재주가 강세를 보입니다.'), NULL
       );
-- Q3. MATCH: 불황의 신호
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS004', 'LV2_CH005_LS004_Q003', 'MATCH',
           '주가는 경기에 {{blank}}하는 성질이 있어, 실제 경기가 나빠지기 6개월~1년 전에 먼저 떨어지기 시작합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('선행', '후행', '동행')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '주식 시장은 미래를 선반영하는 거울과 같습니다.'), NULL
       );
-- Q4. DRAG: 사이클의 순서
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS004', 'LV2_CH005_LS004_Q004', 'DRAG',
           '경기 순서: 회복기 → {{blank}} → 후퇴기 → {{blank}}',
           JSON_OBJECT('choices', JSON_ARRAY('호황기', '침체기', '과열기')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '영원한 상승도, 영원한 하락도 없는 것이 자본주의의 사이클입니다.'), NULL
       );
-- Q5. LINK: 경기 국면별 유리한 섹터 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS004', 'LV2_CH005_LS004_Q005', 'LINK',
           '경기의 흐름과 그에 따른 주도 섹터를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','경기 회복기 (금리 낮음)'),
                   JSON_OBJECT('id','L2','text','경기 활황기 (금리 인상기)'),
                   JSON_OBJECT('id','L3','text','경기 하강기 (불황 진입)'),
                   JSON_OBJECT('id','L4','text','경기 침체기 (바닥 구간)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','IT, 반도체, 금융주 선호'),
                           JSON_OBJECT('id','R2','text','에너지, 소재, 산업재 강세'),
                           JSON_OBJECT('id','R3','text','통신, 필수소비재, 배당주 방어'),
                           JSON_OBJECT('id','R4','text','바이오, 서비스 등 낙폭과대주 주목')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '바람의 방향에 맞는 돛을 올리는 것이 실력입니다.'),
           NULL
       );

-- Q1. CONCEPT: 왜 미국 금리가 중요한가? (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS005', 'LV2_CH005_LS005_Q001', 'CONCEPT',
           '전 세계 돈줄을 쥐고 있는 "연준(Fed)"의 입을 주목해야 하는 이유를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '한국 주식을 하는데 왜 밤새 미국 금리 결정을 지켜봐야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '달러는 세계의 기준 화폐이기 때문이에요. 미국이 금리를 올리면 전 세계에 퍼져있던 달러들이 "더 높은 이자"를 찾아 미국으로 돌아갑니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '한국 시장에 들어와 있던 외국인 자금도 달러로 바뀌어 나가겠죠? 그럼 한국 주가는 빠지고 환율은 오르게 됩니다. 미국 연준(Fed)이 "세계의 경제 소방관"이자 "지갑 주인"인 셈이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 미국 금리가 모든 자산 가격의 기준점이 되는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: FOMC의 역할
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS005', 'LV2_CH005_LS005_Q002', 'SELECT',
           '미국 연준(Fed) 내에서 금리를 결정하는 최고 의사결정 기구의 명칭은?',
           JSON_OBJECT('choices', JSON_ARRAY('FOMC (연방공개시장위원회)', 'IMF (국제통화기금)', 'WTO (세계무역기구)', 'UN')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '1년에 8번 열리는 FOMC 회의 결과는 전 세계 금융 시장의 향방을 가릅니다.'), NULL
       );
-- Q3. MATCH: 양적 긴축(QT)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS005', 'LV2_CH005_LS005_Q003', 'MATCH',
           '중앙은행이 시중에 풀린 돈을 직접 빨아들여 유동성을 줄이는 정책을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('양적 긴축(QT)', '양적 완화(QE)', '제로 금리')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '시장에 돈이 마르면 주가에는 하락 압력으로 작용합니다.'), NULL
       );
-- Q4. DRAG: 금리 역전 현상
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS005', 'LV2_CH005_LS005_Q004', 'DRAG',
           '미국 금리가 한국 금리보다 높아지는 현상을 {{blank}}이라고 하며, 이는 {{blank}} 유출의 원인이 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('금리 역전', '외국인 자본', '환차익')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '돈은 이자가 높은 곳으로 흐르는 본능이 있습니다.'), NULL
       );
-- Q5. LINK: 연준의 발언과 시장의 해석 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH005_LS005', 'LV2_CH005_LS005_Q005', 'LINK',
           '연준의 정책 기조와 그에 따른 시장의 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','매파적 성향 (Hawkish)'),
                   JSON_OBJECT('id','L2','text','비둘기파적 성향 (Dovish)'),
                   JSON_OBJECT('id','L3','text','점도표 상향 조정'),
                   JSON_OBJECT('id','L4','text','베이비스텝 (0.25%p 인상)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','강력한 금리 인상 의지 → 긴축 우려'),
                           JSON_OBJECT('id','R2','text','금리 인하 혹은 동결 선호 → 시장 안도'),
                           JSON_OBJECT('id','R3','text','향후 금리 전망치 상승 → 주가 하방 압력'),
                           JSON_OBJECT('id','R4','text','점진적인 금리 인상 → 시장 예측 부합')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '연준의 단어 하나하나가 수천조 원의 돈을 움직입니다.'),
           NULL
       );

-- Q1. CONCEPT: 지지와 저항이 생기는 이유 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS001', 'LV2_CH006_LS001_Q001', 'CONCEPT',
           '차트 위에 보이지 않는 벽이 생기는 심리학적 이유를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주가는 왜 항상 비슷한 가격에서 떨어지거나 반등하는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 시장 참여자들의 "공통된 기억" 때문이에요. 예를 들어, 지난번에 주가가 10,000원에서 반등했던 기억이 있다면, 다시 그 가격이 왔을 때 사람들은 "아, 여기가 바닥이었지!"라고 생각하며 매수 버튼을 누릅니다. 이게 바로 "지지"입니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반대로 15,000원만 가면 떨어졌던 기억이 있다면, 그 근처만 가도 "이제 떨어질 때 됐어"라며 매도 물량이 쏟아지죠. 이게 "저항"입니다. 결국 수많은 투자자의 "본전 심리"와 "수익 실현 욕구"가 차트 위에 선으로 나타나는 거예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 차트의 선은 결국 사람들의 마음이 모여서 만들어진 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 지지선의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS001', 'LV2_CH006_LS001_Q002', 'SELECT',
           '주가가 하락하다가 더 이상 떨어지지 않고 멈추거나 반등할 것으로 예상되는 지점을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('지지선', '저항선', '추세선', '생명선')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '지지선은 매수세가 강하게 유입되어 하락을 방어하는 구간입니다.'),
           NULL
       );

-- Q3. MATCH: 저항선의 역할
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS001', 'LV2_CH006_LS001_Q003', 'MATCH',
           '주가가 상승하다가 매도 물량이 쏟아져 상승이 가로막히는 구간을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('저항선', '지지선', '박스권')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '이전에 물려있던 사람들의 본전 매물이나 수익 실현 매물이 나오는 지점입니다.'),
           NULL
       );

-- Q4. DRAG: 매수와 매도 심리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH002_LS001', 'LV2_CH006_LS001_Q004', 'DRAG',
           '지지선 부근에서는 {{blank}}세가 강해지고, 저항선 부근에서는 {{blank}}세가 강해지는 경향이 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('매수', '매도', '관망')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '이 두 힘의 균형에 따라 주가의 향방이 결정됩니다.'),
           NULL
       );

-- Q5. LINK: 차트 상황별 해석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS001', 'LV2_CH006_LS001_Q005', 'LINK',
           '차트의 움직임과 그에 담긴 의미를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','전고점 부근 접근'),
                   JSON_OBJECT('id','L2','text','전저점 부근 접근'),
                   JSON_OBJECT('id','L3','text','지지선 이탈(하락)'),
                   JSON_OBJECT('id','L4','text','저항선 돌파(상승)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','저항에 부딪힐 가능성 높음'),
                           JSON_OBJECT('id','R2','text','지지를 받고 반등할 가능성 높음'),
                           JSON_OBJECT('id','R3','text','실망 매물 출회 및 추가 하락 우려'),
                           JSON_OBJECT('id','R4','text','강한 매수세 확인 및 추가 상승 기대')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '과거의 지점들이 미래의 이정표가 됩니다.'),
           NULL
       );

-- Q1. CONCEPT: 박스권이 생기는 환경 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS002', 'LV2_CH006_LS002_Q001', 'CONCEPT',
           '주가가 일정한 범위 내에서만 움직이는 "박스권"은 언제 생길까요?',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '주가가 몇 달째 계속 20,000원에서 25,000원 사이만 왔다 갔다 해요. 답답해 죽겠어요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이게 바로 전형적인 "박스권" 상황이에요. 시장에 이 주식을 더 끌어올릴 만한 강력한 호재도 없지만, 그렇다고 던질만한 악재도 없을 때 이런 흐름이 나타나죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '투자자들은 "20,000원이면 싸다"고 느끼고 "25,000원이면 비싸다"고 느끼는 심리적 합의가 이루어진 상태입니다. 이때는 박스 하단에서 사고 상단에서 파는 전략이 유효하죠. 힘을 응축하고 있는 구간이기도 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 누군가 매집을 하거나 큰 방향성을 결정하기 전의 폭풍전야 같은 상태군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 박스권 매매 전략
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS002', 'LV2_CH006_LS002_Q002', 'SELECT',
           '박스권 장세에서 가장 정석적인 매매 방법은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('박스권 하단 매수, 상단 매도', '박스권 중간에서 몰빵 매수', '최고점에서 추격 매수', '거래가 없을 때 무조건 매도')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '지지와 저항의 경계선을 활용하는 것이 가장 확률 높은 전략입니다.'),
           NULL
       );

-- Q3. MATCH: 박스권 돌파의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS002', 'LV2_CH006_LS002_Q003', 'MATCH',
           '오랫동안 갇혀있던 박스권 상단을 거래량을 실어 돌파하는 것을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('박스권 돌파', '박스권 이탈', '횡보')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '새로운 상승 추세가 시작되는 강력한 신호입니다.'),
           NULL
       );

-- Q4. DRAG: 박스권의 끝
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS002', 'LV2_CH006_LS002_Q004', 'DRAG',
           '박스권 하단을 깨고 내려가면 {{blank}}가 시작될 수 있고, 상단을 뚫으면 {{blank}}가 시작될 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('추가 하락', '새로운 상승', '보합')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '박스권은 영원하지 않으며 깨지는 순간 방향성이 결정됩니다.'),
           NULL
       );

-- Q5. LINK: 박스권 구간별 대응
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS002', 'LV2_CH006_LS002_Q005', 'LINK',
           '박스권의 위치에 따른 실전 대응을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','박스권 하단 지지선'),
                   JSON_OBJECT('id','L2','text','박스권 상단 저항선'),
                   JSON_OBJECT('id','L3','text','하단 지지선 붕괴'),
                   JSON_OBJECT('id','L4','text','상단 저항선 돌파')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','1차 분할 매수 타점'),
                           JSON_OBJECT('id','R2','text','1차 수익 실현 타점'),
                           JSON_OBJECT('id','R3','text','손절 또는 관망 (리스크 관리)'),
                           JSON_OBJECT('id','R4','text','추가 매수 또는 홀딩 (시세 분출)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '박스권 안에서는 규칙적인 매매가 핵심입니다.'),
           NULL
       );

-- LV2_CH006_LS003 (추세선)

-- Q1. CONCEPT: 추세선의 의미와 긋는 법 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS003', 'LV2_CH006_LS003_Q001', 'CONCEPT',
           '추세선은 "주가가 가는 길"을 시각적으로 보여주는 지도입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 차트에 추세선은 꼭 그어야 하나요? 그냥 가격만 보면 안 돼요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '추세선은 단순한 선이 아니라, 시장 참여자들의 "매수·매도 기준선"이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '상승 추세에서는 저점을 연결해서 그리면 "매수 타점(지지)"이 보이고, 하락 추세에서는 고점을 연결해 "저항"이 보입니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '즉, 추세선은 "언제 사고 언제 팔아야 하는지" 확률이 높은 구간을 알려주는 도구죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 추세선은 미래를 맞추는 게 아니라 사람들이 반응하는 기준선을 찾아내는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 상승 추세선 그리는 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS003', 'LV2_CH006_LS003_Q002', 'SELECT',
           '상승 추세선(Uptrend Line)을 그릴 때 가장 올바른 방법은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY(
                   '고점들을 연결해서 그린다',
                   '저점(바닥)들을 연결해서 그린다',
                   '시가만 연결해서 그린다',
                   '거래량이 많은 날만 연결한다'
                                  )),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '상승 추세선은 저점들이 점점 높아지는 흐름을 연결해 지지선을 만드는 방식입니다.'),
           NULL
       );

-- Q3. MATCH: 추세선 이탈 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS003', 'LV2_CH006_LS003_Q003', 'MATCH',
           '상승 추세선 아래로 주가가 내려가며 지지선이 깨지는 현상을 {{blank}}이라고 하며, 이는 추세 약화를 의미합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('추세선 이탈', '추세선 지지', '상한가')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '추세선 이탈은 상승 흐름이 꺾일 수 있다는 경고 신호로 해석됩니다.'),
           NULL
       );

-- Q4. DRAG: 추세선 매매 심리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS003', 'LV2_CH006_LS003_Q004', 'DRAG',
           '상승 추세에서 추세선 부근은 {{blank}} 타점으로 활용되며, 추세선이 무너지면 {{blank}} 신호가 될 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('매수', '손절', '추격매수')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '추세선은 지지선 역할을 하므로 지지 시 매수, 이탈 시 손절 기준으로 쓰입니다.'),
           NULL
       );

-- Q5. LINK: 추세선 상황별 해석 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS003', 'LV2_CH006_LS003_Q005', 'LINK',
           '추세선 상황과 투자자의 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','상승 추세선에서 반등'),
                   JSON_OBJECT('id','L2','text','상승 추세선 이탈'),
                   JSON_OBJECT('id','L3','text','하락 추세선에서 눌림'),
                   JSON_OBJECT('id','L4','text','하락 추세선 돌파')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','지지가 확인되어 추가 상승 가능성'),
                           JSON_OBJECT('id','R2','text','상승 흐름 약화, 조정 가능성 확대'),
                           JSON_OBJECT('id','R3','text','저항에 막혀 추가 하락 위험 존재'),
                           JSON_OBJECT('id','R4','text','추세 전환 신호로 반등 기대')
                            )
           ),
           JSON_OBJECT(
                   'correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'),
                   'explanation', '추세선은 “방어선(지지)”과 “벽(저항)”의 역할을 하며, 돌파/이탈이 방향성을 결정합니다.'
           ),
           NULL
       );

-- Q1. CONCEPT: 지지와 저항의 역할 교대 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS004', 'LV2_CH006_LS004_Q001', 'CONCEPT',
           '저항선이 지지선으로 변하는 "역할의 반전" 현상을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님! 드디어 15,000원 저항선을 뚫었어요! 이제 무조건 전속력으로 가나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '축하해요! 하지만 중요한 과정이 하나 더 남았어요. 바로 "안착(확인)" 과정입니다. 신기하게도 뚫기 힘들었던 저항선은 한번 뚫리고 나면, 주가가 다시 내려왔을 때 강력한 지지선으로 변해요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '왜 그럴까요? 이전에 그 가격에서 팔았던 사람들이 "아, 더 갈 주식이었구나! 다시 내려오면 사야지"라고 대기하고 있기 때문이죠. 그래서 뚫린 저항선이 다시 지지를 받는지 확인하는 "리테스트" 구간이 가장 안전한 매수 타점이 되곤 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 뚫린 벽이 이제 든든한 바닥이 되는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 리테스트(Retest)의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS004', 'LV2_CH006_LS004_Q002', 'SELECT',
           '저항선을 뚫은 주가가 다시 내려와 해당 선에서 지지를 받는지 확인하는 과정을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('리테스트(안착)', '데드크로스', '패닉셀', '손절')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '성공적인 리테스트는 상승 추세가 견고하다는 증거입니다.'),
           NULL
       );

-- Q3. MATCH: 붕괴 후의 변화
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS004', 'LV2_CH006_LS004_Q003', 'MATCH',
           '강력했던 지지선이 무너지면, 주가가 다시 반등할 때 그 선은 강력한 {{blank}} 역할을 하게 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('저항선', '지지선', '이동평균선')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '이전에 지지받을 줄 알고 샀던 사람들의 본전 매물이 쏟아지기 때문입니다.'),
           NULL
       );

-- Q4. DRAG: 매수 타점 판단
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS004', 'LV2_CH006_LS004_Q004', 'DRAG',
           '저항선 돌파 시 {{blank}}하는 것보다, 돌파 후 다시 지지받는 {{blank}} 구간에서 사는 것이 더 안전합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('추격 매수', '눌림목(안착)', '손절 매도')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '속임수 돌파에 당하지 않는 현명한 방법입니다.'),
           NULL
       );

-- Q5. LINK: 상황별 지지/저항 반전 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS004', 'LV2_CH006_LS004_Q005', 'LINK',
           '돌파 및 이탈 상황과 그에 따른 역할 변화를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','저항선 강한 돌파 성공'),
                   JSON_OBJECT('id','L2','text','지지선 아래로 이탈 성공'),
                   JSON_OBJECT('id','L3','text','돌파 후 저항선 지지 확인'),
                   JSON_OBJECT('id','L4','text','이탈 후 지지선 저항 확인')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','해당 선은 이제 새로운 지지선'),
                           JSON_OBJECT('id','R2','text','해당 선은 이제 새로운 저항선'),
                           JSON_OBJECT('id','R3','text','상승 추세 확정 및 매수 시그널'),
                           JSON_OBJECT('id','R4','text','하락 추세 확정 및 매도 시그널')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '역할이 바뀌는 원리를 알면 차트가 입체적으로 보입니다.'),
           NULL
       );

-- Q1. CONCEPT: 이동평균선의 지지/저항 역할 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS005', 'LV2_CH006_LS005_Q001', 'CONCEPT',
           '이동평균선이 왜 "동적인 지지선"이 되는지 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주가가 20일 이동평균선만 닿으면 신기하게 튕겨 올라가요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 이동평균선이 시장 참여자들의 "평균 매수 단가"를 나타내기 때문이에요. 20일선은 한 달 동안 산 사람들의 평균 가격이죠. 상승 추세일 때 주가가 20일선까지 내려오면, 사람들은 "평균가까지 싸졌네? 사야지!"라고 생각합니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이런 매수세가 모여 이동평균선은 훌륭한 "달리는 지지선"이 됩니다. 반대로 하락장에서는 이동평균선이 머리 위를 누르는 "달리는 저항선"이 되죠. 선의 기울기가 가파를수록 그 지지와 저항의 힘은 더 강력해집니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 고정된 선만 있는 게 아니라 움직이는 선도 벽이 될 수 있군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 골든크로스의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS005', 'LV2_CH006_LS005_Q002', 'SELECT',
           '단기 이동평균선이 장기 이동평균선을 아래에서 위로 뚫고 올라가는 강력한 매수 신호는?',
           JSON_OBJECT('choices', JSON_ARRAY('골든크로스', '데드크로스', '정배열', '역배열')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '평균 가격이 상승하며 추세가 좋아진다는 신호입니다.'),
           NULL
       );

-- Q3. MATCH: 역배열의 상태
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS005', 'LV2_CH006_LS005_Q003', 'MATCH',
           '장기 이평선이 가장 위에 있고 단기 이평선이 아래에 있는, 전형적인 하락 추세 상태를 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('역배열', '정배열', '수렴')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '머리 위에 저항선이 겹겹이 쌓인 어려운 구간입니다.'),
           NULL
       );

-- Q4. DRAG: 이평선의 지지력
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS005', 'LV2_CH006_LS005_Q004', 'DRAG',
           '상승장에서는 이평선이 {{blank}} 역할을 하여 주가를 받쳐주고, 하락장에서는 {{blank}} 역할을 하여 주가를 누릅니다.',
           JSON_OBJECT('choices', JSON_ARRAY('지지선', '저항선', '박스권')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '추세의 방향에 따라 이평선의 성격이 바뀝니다.'),
           NULL
       );

-- Q5. LINK: 이동평균선 기간별 성격 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH006_LS005', 'LV2_CH006_LS005_Q005', 'LINK',
           '이동평균선의 기간별 실전 의미를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','5일 이동평균선'),
                   JSON_OBJECT('id','L2','text','20일 이동평균선'),
                   JSON_OBJECT('id','L3','text','60일 이동평균선'),
                   JSON_OBJECT('id','L4','text','120일 이동평균선')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','단기 급등주 매매의 기준'),
                           JSON_OBJECT('id','R2','text','한 달의 흐름을 보는 심리선'),
                           JSON_OBJECT('id','R3','text','중기 수급을 보여주는 수급선'),
                           JSON_OBJECT('id','R4','text','경기의 흐름을 보여주는 경기선')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '기간별 이평선을 조합하면 추세의 강도를 알 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 보조지표를 사용하는 이유 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS001', 'LV2_CH007_LS001_Q001', 'CONCEPT',
           '보조지표는 차트의 "속도계"입니다. 왜 필요한지 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 캔들이랑 거래량만 봐도 충분한데 왜 복잡한 지표들을 또 보나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '캔들만으로는 현재 주가의 기세가 얼마나 강한지, 혹은 꺾이기 직전인지 직관적으로 알기 어렵기 때문이에요. 보조지표는 주가와 거래량이라는 원재료를 수학적으로 가공해서 "지금은 너무 과열되었어" 혹은 "지금은 바닥권이야"라는 신호를 숫자로 명확하게 보여줍니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '자전거의 보조바퀴처럼, 주행(매매)이 서툰 초보자에게는 넘어지지 않게 도와주는 훌륭한 가이드가 되죠. 하지만 보조지표는 주가보다 늦게 움직이는 "후행성"이 있다는 점을 반드시 기억해야 해요. 결정을 내리는 주체는 주가이고, 지표는 그 결정을 뒷받침하는 근거로 활용해야 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 주가가 주인공이고 보조지표는 주인공의 상태를 알려주는 데이터군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 보조지표의 원재료
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS001', 'LV2_CH007_LS001_Q002', 'SELECT',
           '대부분의 기술적 보조지표를 계산할 때 가장 핵심적으로 쓰이는 두 가지 원재료는?',
           JSON_OBJECT('choices', JSON_ARRAY('주가와 거래량', '기업 뉴스와 공시', '금리와 환율', '배당금과 주식 수')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '보조지표는 과거의 가격(Price)과 거래량(Volume) 데이터를 수학적으로 재가공한 것입니다.'),
           NULL
       );

-- Q3. MATCH: 지표의 성격
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS001', 'LV2_CH007_LS001_Q003', 'MATCH',
           '주가가 움직인 뒤에 지표가 따라오는 성질을 {{blank}}이라고 하며, 이 때문에 지표만 맹신해서는 안 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('후행성', '선행성', '동행성')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '지표는 과거 데이터를 기반으로 하므로 실제 주가보다 조금 늦게 신호가 나옵니다.'),
           NULL
       );

-- Q4. DRAG: 지표의 분류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS001', 'LV2_CH007_LS001_Q004', 'DRAG',
           '일정한 범위 내에서 주가의 강도를 측정하는 지표를 {{blank}} 지표라고 하며, 추세의 방향을 알려주는 지표를 {{blank}} 지표라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('오실레이터', '추세형', '거래량')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', 'RSI는 대표적인 오실레이터, MACD는 대표적인 추세형 지표입니다.'),
           NULL
       );

-- Q5. LINK: 보조지표별 핵심 역할
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS001', 'LV2_CH007_LS001_Q005', 'LINK',
           '보조지표의 종류와 그 핵심 역할을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','RSI (상대강도지수)'),
                   JSON_OBJECT('id','L2','text','MACD (추세지표)'),
                   JSON_OBJECT('id','L3','text','볼린저 밴드'),
                   JSON_OBJECT('id','L4','text','OBV (거래량지표)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','주가의 과매수/과매도 구간 포착'),
                           JSON_OBJECT('id','R2','text','추세의 전환 시점(골든크로스) 포착'),
                           JSON_OBJECT('id','R3','text','주가의 변동 범위와 이격도 측정'),
                           JSON_OBJECT('id','R4','text','세력의 매집과 분산 상태 확인')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '각 지표의 강점을 알면 상황에 맞게 골라 쓸 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: RSI의 원리와 매매 기준 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS002', 'LV2_CH007_LS002_Q001', 'CONCEPT',
           '주가의 "상대적 강도"를 보여주는 RSI를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주가가 오를 때 더 오를지, 아니면 이제 떨어질지 어떻게 알 수 있나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', 'RSI($Relative Strength Index$)를 보세요. 최근 상승폭과 하락폭의 비율을 계산해 0에서 100 사이의 수치로 보여주는 지표예요. 보통 70 이상이면 "과매수" 구간이라고 해서 시장이 너무 과열되었으니 곧 떨어질 수 있다는 경고 신호로 봅니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반대로 30 이하이면 "과매도" 구간이라고 해서 너무 많이 떨어졌으니 반등할 때가 되었다는 신호로 보죠. 수영장 물이 너무 뜨거우면 나오고(매도), 너무 차가우면 들어갈 준비(매수)를 하는 것과 비슷합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 숫자가 너무 높으면 욕심을 버리고, 너무 낮으면 기회를 보라는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 과매수 구간의 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS002', 'LV2_CH007_LS002_Q002', 'SELECT',
           '일반적으로 RSI 지수가 몇 이상일 때 주가가 과도하게 올라 "과매수" 상태라고 판단할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('30 이상', '50 이상', '70 이상', '100 이상')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', 'RSI 70 이상은 단기 과열 국면으로 간주합니다.'),
           NULL
       );

-- Q3. MATCH: 과매도 구간의 매매 전략
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS002', 'LV2_CH007_LS002_Q003', 'MATCH',
           'RSI 지수가 30 이하인 {{blank}} 구간에 진입했다면, 매도보다는 반등을 노린 매수 관점으로 접근하는 것이 유리합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('과매도', '과매수', '보합')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '하락 에너지가 소진되어 반등할 가능성이 높은 구간입니다.'),
           NULL
       );

-- Q4. DRAG: RSI 계산의 원리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS002', 'LV2_CH007_LS002_Q004', 'DRAG',
           'RSI는 일정 기간 동안의 {{blank}} 평균값을 {{blank}} 평균값으로 나눈 상대적 강도를 측정합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('상승폭', '하락폭', '거래량')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '상승과 하락의 비율을 통해 힘의 우위를 가립니다.'),
           NULL
       );

-- Q5. LINK: RSI 수치별 대응 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS002', 'LV2_CH007_LS002_Q005', 'LINK',
           'RSI 수치 상태와 그에 따른 실전 대응을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','RSI 80 돌파'),
                   JSON_OBJECT('id','L2','text','RSI 20 이탈'),
                   JSON_OBJECT('id','L3','text','RSI 50 상향 돌파'),
                   JSON_OBJECT('id','L4','text','RSI 70에서 하락 반전')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','극심한 과열, 분할 매도 고려'),
                           JSON_OBJECT('id','R2','text','과도한 낙폭, 반등 매수 준비'),
                           JSON_OBJECT('id','R3','text','상승 에너지가 강해지는 구간'),
                           JSON_OBJECT('id','R4','text','단기 고점 형성 신호, 차익 실현')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', 'RSI는 추세의 강도를 숫자로 보여주는 훌륭한 계기판입니다.'),
           NULL
       );

-- Q1. CONCEPT: MACD의 원리와 신호 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS003', 'LV2_CH007_LS003_Q001', 'CONCEPT',
           '추세의 전환을 알려주는 MACD의 비밀을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '이동평균선 골든크로스는 너무 늦게 나오는 것 같아요. 더 빠른 방법 없나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럴 때 필요한 지표가 MACD($Moving Average Convergence Divergence$)입니다. 단기 이평선과 장기 이평선이 서로 멀어졌다(확산) 가까워지는(수렴) 원리를 이용해요. MACD 선이 "시그널 선"을 아래에서 위로 뚫고 올라올 때가 아주 강력한 매수 신호입니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '특히 "히스토그램"이라는 막대그래프가 0선 위로 올라오기 시작하면 추세가 상승으로 완전히 돌아섰다는 것을 뜻하죠. 이평선의 후행성을 보완해서 추세의 시작을 더 빨리 알려주는 고마운 지표입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 이평선끼리의 "간격"을 보고 에너지를 미리 읽는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: MACD 매수 신호
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS003', 'LV2_CH007_LS003_Q002', 'SELECT',
           'MACD 지표에서 가장 전형적인 매수 신호로 보는 상황은?',
           JSON_OBJECT('choices', JSON_ARRAY('MACD 곡선이 시그널 곡선을 골든크로스 할 때', 'MACD 곡선이 시그널 곡선을 데드크로스 할 때', 'MACD 곡선이 0선 아래로 내려갈 때')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'MACD의 골든크로스는 추세가 상승으로 전환됨을 알리는 신호입니다.'),
           NULL
       );

-- Q3. MATCH: 히스토그램의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH003_LS003', 'LV2_CH007_LS003_Q003', 'MATCH',
           'MACD 선과 시그널 선의 차이를 막대그래프로 나타낸 것을 {{blank}}이라고 하며, 이 막대가 길어질수록 추세가 강해집니다.',
           JSON_OBJECT('choices', JSON_ARRAY('히스토그램', '엔벨로프', '일목균형표')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '히스토그램은 추세의 강도를 시각적으로 가장 잘 보여줍니다.'),
           NULL
       );

-- Q4. DRAG: 0선의 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS003', 'LV2_CH007_LS003_Q004', 'DRAG',
           'MACD 지표에서 {{blank}}선 위는 상승 추세가 강한 구역이고, {{blank}}선 아래는 하락 추세가 우세한 구역입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('0', '50', '100')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 0), 'explanation', '0선은 추세의 방향을 결정짓는 기준선입니다.'),
           NULL
       );

-- Q5. LINK: MACD 신호 해석 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS003', 'LV2_CH007_LS003_Q005', 'LINK',
           'MACD의 움직임과 그에 따른 추세 판단을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','MACD 골든크로스 발생'),
                   JSON_OBJECT('id','L2','text','MACD 데드크로스 발생'),
                   JSON_OBJECT('id','L3','text','MACD 선이 0선 돌파'),
                   JSON_OBJECT('id','L4','text','히스토그램 막대 축소')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','단기적인 반등 및 매수 시점'),
                           JSON_OBJECT('id','R2','text','단기적인 하락 및 매도 시점'),
                           JSON_OBJECT('id','R3','text','중장기 상승 추세 확정 구간'),
                           JSON_OBJECT('id','R4','text','기존 추세의 힘이 약해지는 신호')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', 'MACD는 큰 흐름을 타는 투자자에게 필수적인 지표입니다.'),
           NULL
       );

-- Q1. CONCEPT: 볼린저 밴드의 원리 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS004', 'LV2_CH007_LS004_Q001', 'CONCEPT',
           '주가의 "변동성"을 보여주는 볼린저 밴드에 대해 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '주가가 어디까지 오르고 어디까지 떨어질지 미리 알 수 있는 방법은 없나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '볼린저 밴드를 활용해 보세요. 주가는 통계적으로 중앙의 이동평균선을 기준으로 위아래 "표준편차" 범위 안에서 움직일 확률이 95% 이상입니다. 이 울타리의 상단을 "상단 밴드", 하단을 "하단 밴드"라고 불러요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '밴드가 좁아졌을 때는 "에너지를 응축"하고 있는 상태라 조만간 큰 변화가 온다는 뜻이고, 주가가 하단 밴드를 터치하면 다시 중앙으로 돌아가려는 성질 때문에 반등 신호로 봅니다. 반대로 상단 밴드를 터치하면 너무 많이 올랐으니 조심하라는 뜻이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 주가가 돌아다니는 "운동장"의 경계선을 그려주는 지표군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 밴드 수축의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS004', 'LV2_CH007_LS004_Q002', 'SELECT',
           '볼린저 밴드의 상단과 하단 폭이 매우 좁아지는 구간(Squeeze)은 무엇을 암시할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('주가의 변동성이 곧 커질 것임을 암시', '주가가 영원히 횡보할 것임을 암시', '회사가 곧 상장 폐지될 것임을 암시')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '밴드가 좁아지면 에너지가 모여 곧 위나 아래로 큰 방향성이 결정됩니다.'),
           NULL
       );

-- Q3. MATCH: 밴드 하단의 역할
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS004', 'LV2_CH007_LS004_Q003', 'MATCH',
           '주가가 볼린저 밴드의 {{blank}} 밴드 근처에 도달하면 통계적으로 과매도 상태로 보고 반등을 기대할 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('하단', '상단', '중앙')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '하단 밴드는 강력한 통계적 지지선 역할을 합니다.'),
           NULL
       );

-- Q4. DRAG: 밴드의 구성 요소
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS004', 'LV2_CH007_LS004_Q004', 'DRAG',
           '볼린저 밴드는 중앙의 {{blank}}선과 그 위아래의 {{blank}} 범위인 상/하단 밴드로 구성됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('이동평균', '표준편차', '거래량')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '통계적 확률을 이용해 주가의 위치를 판단합니다.'),
           NULL
       );

-- Q5. LINK: 밴드 돌파 상황별 해석 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS004', 'LV2_CH007_LS004_Q005', 'LINK',
           '볼린저 밴드와 주가 관계에 따른 실전 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','하단 밴드에서 양봉 발생'),
                   JSON_OBJECT('id','L2','text','상단 밴드 돌파 후 안착'),
                   JSON_OBJECT('id','L3','text','밴드 폭의 급격한 확대'),
                   JSON_OBJECT('id','L4','text','중앙 이평선 하향 돌파')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','단기 반등을 노린 매수 타점'),
                           JSON_OBJECT('id','R2','text','강력한 상승 추세 진입 신호'),
                           JSON_OBJECT('id','R3','text','주가 변동성 확대 및 시세 분출'),
                           JSON_OBJECT('id','R4','text','추세 약화 및 하락 전환 경고')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '볼린저 밴드는 주가가 "비정상"적인 위치에 있는지 알려줍니다.'),
           NULL
       );

-- Q1. CONCEPT: 다이버전스의 원리 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS005', 'LV2_CH007_LS005_Q001', 'CONCEPT',
           '주가와 지표가 거꾸로 가는 "다이버전스"의 경고를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '주가는 계속 오르는데, RSI 숫자는 왜 자꾸 낮아지나요? 이상해요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 가장 강력한 추세 전환 신호인 "하락 다이버전스"예요. 주가는 오르고 있지만, 상승하려는 에너지는 이미 식어가고 있다는 뜻이죠. 마치 달리는 자동차의 속도계는 높은데 엔진 소리는 점점 작아지는 것과 같아요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반대로 주가는 떨어지는데 지표 수치가 올라간다면 "상승 다이버전스"라고 해서 강력한 바닥 신호로 봅니다. 이처럼 주가와 지표의 방향이 어긋날 때가 진짜 매수/매도 타이밍인 경우가 많으니 절대 놓치지 마세요!'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 겉모습(주가)과 속마음(지표)이 다를 때가 기회군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 상승 다이버전스의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS005', 'LV2_CH007_LS005_Q002', 'SELECT',
           '주가의 저점은 낮아지는데, 보조지표(RSI 등)의 저점은 오히려 높아지는 현상은?',
           JSON_OBJECT('choices', JSON_ARRAY('상승 다이버전스', '하락 다이버전스', '데드크로스', '정배열')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '하락 힘은 빠지고 반등 에너지가 모이고 있다는 강력한 신호입니다.'),
           NULL
       );

-- Q3. MATCH: 지표 결합의 목적
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS005', 'LV2_CH007_LS005_Q003', 'MATCH',
           '한 가지 지표의 가짜 신호(속임수)를 걸러내기 위해 여러 지표를 함께 사용하는 것을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('교차 검증', '몰빵 투자', '단순 매매')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '서로 다른 성격의 지표를 섞어 쓰면 매매 확률이 높아집니다.'),
           NULL
       );

-- Q4. DRAG: 실전 지표 조합
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS005', 'LV2_CH007_LS005_Q004', 'DRAG',
           '{{blank}}로 과매수/과매도를 체크하고, {{blank}}로 추세의 전환을 최종 확인하는 조합이 많이 쓰입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('RSI', 'MACD', '이동평균선')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '상호 보완적인 지표를 섞는 것이 정석입니다.'),
           NULL
       );

-- Q5. LINK: 실전 지표 결합 전략 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH007_LS005', 'LV2_CH007_LS005_Q005', 'LINK',
           '지표들의 신호가 겹칠 때의 실전 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','RSI 과매도 + MACD 골든크로스'),
                   JSON_OBJECT('id','L2','text','RSI 과매수 + MACD 데드크로스'),
                   JSON_OBJECT('id','L3','text','볼린저 하단 지지 + 양봉'),
                   JSON_OBJECT('id','L4','text','주가 신고가 + RSI 저점 하락')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','매우 강력한 저점 반등 매수 신호'),
                           JSON_OBJECT('id','R2','text','매우 강력한 고점 하락 매도 신호'),
                           JSON_OBJECT('id','R3','text','통계적 반등 구간 진입 신호'),
                           JSON_OBJECT('id','R4','text','하락 다이버전스, 추세 붕괴 주의')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '신호가 겹칠수록 신뢰도는 기하급수적으로 올라갑니다.'),
           NULL
       );

-- Q1. CONCEPT: 탑다운 투자법의 원리 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS001', 'LV2_CH008_LS001_Q001', 'CONCEPT',
           '투자의 순서를 바꾸면 수익률이 달라집니다. 탑다운 전략을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 좋은 종목을 찾으려고 재무제표를 뒤지고 있는데 너무 힘들어요. 더 효율적인 방법 없나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럴 땐 "탑다운(Top-Down)" 방식으로 접근해 보세요. 개별 기업을 먼저 찾기(Bottom-Up) 전에, 지금 전 세계 경제 상황이 어떤지(거시 경제), 그 상황에서 가장 큰 돈이 몰리는 산업이 무엇인지(산업 분석)를 먼저 정하는 거예요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '예를 들어 인공지능 시대가 온다면(매크로), 반도체 수요가 늘 것이고(산업), 그중에서 가장 기술력이 좋은 삼성전자의 가치를 보는 식이죠. "성장하는 산업"이라는 돛을 달면, 그 안의 배(기업)들은 훨씬 쉽게 앞으로 나아갑니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 숲을 먼저 보고 가장 비옥한 땅을 찾은 뒤에 최고의 나무를 고르는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 탑다운의 분석 순서
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS001', 'LV2_CH008_LS001_Q002', 'SELECT',
           '탑다운(Top-Down) 투자 전략의 올바른 분석 순서는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('거시 경제 → 산업 분석 → 기업 분석', '기업 분석 → 산업 분석 → 거시 경제', '뉴스 분석 → 차트 분석 → 기업 분석')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '큰 흐름에서 작은 디테일로 내려가는 방식이 탑다운의 핵심입니다.'),
           NULL
       );

-- Q3. MATCH: 산업 사이클의 이해
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS001', 'LV2_CH008_LS001_Q003', 'MATCH',
           '산업의 실적이 경기에 따라 주기적으로 반복되는 업종을 {{blank}} 산업이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('시클리컬(Cyclical)', '성장(Growth)', '방어(Defensive)')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '철강, 화학, 해운 등은 대표적인 경기 민감 산업입니다.'),
           NULL
       );

-- Q4. DRAG: 투자의 효율성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS001', 'LV2_CH008_LS001_Q004', 'DRAG',
           '{{blank}} 산업에서는 꼴찌 종목이라도 주가가 오르기 쉽지만, {{blank}} 산업에서는 1등 종목이라도 버티기 어렵습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('주도(성장)', '소외(침체)', '테마')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '어떤 산업군을 선택하느냐가 수익률의 절반 이상을 결정합니다.'),
           NULL
       );

-- Q5. LINK: 분석 단계별 핵심 체크리스트
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS001', 'LV2_CH008_LS001_Q005', 'LINK',
           '탑다운 분석 단계와 확인해야 할 항목을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','거시 경제 (Macro)'),
                   JSON_OBJECT('id','L2','text','산업 분석 (Industry)'),
                   JSON_OBJECT('id','L3','text','기업 분석 (Company)'),
                   JSON_OBJECT('id','L4','text','수급 분석 (Supply)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','금리, 물가, 환율, 성장률'),
                           JSON_OBJECT('id','R2','text','진입 장벽, 성장성, 시장 점유율'),
                           JSON_OBJECT('id','R3','text','재무제표, ROE, PER, 경영진'),
                           JSON_OBJECT('id','R4','text','외국인/기관 매수세, 거래량')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '체계적인 분석이 뇌동매매를 방지합니다.'),
           NULL
       );

-- Q1. CONCEPT: 주도주의 조건과 특징 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS002', 'LV2_CH008_LS002_Q001', 'CONCEPT',
           '왜 항상 "대장주"를 사라고 할까요? 주도주의 힘을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 반도체 업종이 좋은 건 알겠는데 삼성전자는 무거우니까 더 가벼운 중소형주를 사는 게 낫지 않나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '업종이 상승할 때 가장 먼저 오르고, 가장 늦게 떨어지며, 상승폭도 가장 큰 종목을 "주도주(대장주)"라고 해요. 주도주는 해당 산업에서 압도적인 기술력이나 점유율을 가진 기업인 경우가 많죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주도주는 시장의 모든 돈이 가장 먼저 모이는 "입구"와 같아요. 2등, 3등주는 대장이 한참 오른 뒤에야 찌꺼기 매수세를 받지만, 대장은 이미 멀리 가버린 상태죠. 하락장에서도 대장주는 "믿음"이 있어 가장 잘 버팁니다. 그래서 "수익은 주도주에서, 생존은 우량주에서"라는 말이 있는 거예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 1등주가 비싸 보여도 결국 가장 큰 수익을 준다는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 주도주를 찾는 지표
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS002', 'LV2_CH008_LS002_Q002', 'SELECT',
           '차트상에서 주도주를 선별하는 가장 강력한 힌트는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('지수가 내릴 때 덜 내리고, 오를 때 가장 먼저 신고가를 경신한다', '거래량이 전혀 없이 조용히 횡보한다', '매일 뉴스에 가장 나쁜 소식만 도배된다')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '상대적 강도가 높은 종목이 시장의 주도주입니다.'),
           NULL
       );

-- Q3. MATCH: 대장주의 교체
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS002', 'LV2_CH008_LS002_Q003', 'MATCH',
           '기존 주도주가 힘을 잃고 새로운 산업의 대장주가 시장을 이끄는 현상을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('주도주 교체', '박스권 형성', '데드크로스')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '시대의 변화에 따라 주도주는 계속해서 바뀝니다.'),
           NULL
       );

-- Q4. DRAG: 매수 전략
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS002', 'LV2_CH008_LS002_Q004', 'DRAG',
           '초보자는 무서워서 {{blank}}를 못 사고 싼 {{blank}}를 사지만, 고수는 비싸도 기세가 살아있는 {{blank}}를 삽니다.',
           JSON_OBJECT('choices', JSON_ARRAY('주도주', '낙폭과대주', '급등주')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1, 0), 'explanation', '주식은 싼 게 비지떡인 경우가 많습니다.'),
           NULL
       );

-- Q5. LINK: 종목 성격과 매매 관점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS002', 'LV2_CH008_LS002_Q005', 'LINK',
           '종목의 서열과 그에 따른 투자 전략을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','대장주 (주도주)'),
                   JSON_OBJECT('id','L2','text','2등주 (추종주)'),
                   JSON_OBJECT('id','L3','text','소외주'),
                   JSON_OBJECT('id','L4','text','품절주')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','가장 큰 수익률과 안정성 보유'),
                           JSON_OBJECT('id','R2','text','대장주를 따라가지만 상승폭은 낮음'),
                           JSON_OBJECT('id','R3','text','업종이 올라도 반응이 늦거나 없음'),
                           JSON_OBJECT('id','R4','text','유통 물량이 적어 변동성만 매우 큼')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '항상 업종 내 1등에 집중하는 습관이 중요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 테마주 매매의 위험과 기회 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS003', 'LV2_CH008_LS003_Q001', 'CONCEPT',
           '실체가 없는 테마주와 실적이 있는 산업주를 구분하는 법을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 정치인 테마주나 갑자기 뜨는 테마주로 돈 벌었다는 사람들이 많아요. 저도 해도 될까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '테마주는 아주 매혹적이지만 치명적인 독을 품고 있어요. 테마주와 산업주의 가장 큰 차이는 "실적"입니다. 산업주는 기술의 변화로 기업이 돈을 실제로 벌기 시작하며 오르지만, 테마주는 막연한 기대감이나 뉴스 하나에 수급만으로 오르죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '테마주는 뉴스가 사라지는 순간 주가가 제자리로 돌아오며 "폭락"하는 경우가 많습니다. 투기적인 매매가 아니라면, 최소한 그 테마가 실제 기업의 "이익"으로 연결될 수 있는지를 꼭 따져봐야 해요. 실체가 없는 테마는 결국 누군가에게 비싸게 넘기기 위한 폭탄 돌리기가 될 수 있습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 숫자로 증명되지 않는 급등은 언제든 사라질 수 있는 거품이군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 테마주의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS003', 'LV2_CH008_LS003_Q002', 'SELECT',
           '일반적인 테마주(Theme Stock)의 주가 흐름을 가장 잘 설명한 것은?',
           JSON_OBJECT('choices', JSON_ARRAY('단기간에 이유 없이 급등한 뒤, 뉴스 소멸과 함께 급락한다', '수년간 꾸준히 배당을 늘리며 완만하게 우상향한다', '실적 발표 때마다 기관 매수세가 꾸준히 유입된다')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '테마주는 수급에 의해 빠르게 오르고 빠르게 식습니다.'),
           NULL
       );

-- Q3. MATCH: 테마의 종류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS003', 'LV2_CH008_LS003_Q003', 'MATCH',
           '미세먼지, 계절병, 장마처럼 매년 특정 시기마다 반복해서 나타나는 테마를 {{blank}} 테마라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('계절성', '정책', '메가')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '반복되는 일정은 미리 선점하는 전략이 유효합니다.'),
           NULL
       );

-- Q4. DRAG: 성공적인 대응
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS003', 'LV2_CH008_LS003_Q004', 'DRAG',
           '테마주는 남들이 환호하며 {{blank}}할 때 파는 것이 정석이며, 아무도 관심 없을 때 {{blank}}하는 전략이 필요합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('추격 매수', '선취매', '손절')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '테마주의 고점은 대중이 가장 열광할 때입니다.'),
           NULL
       );

-- Q5. LINK: 산업주 vs 테마주 비교 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS003', 'LV2_CH008_LS003_Q005', 'LINK',
           '종목의 성격과 그에 따른 특징을 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','산업주 (성장주)'),
                   JSON_OBJECT('id','L2','text','단기 테마주'),
                   JSON_OBJECT('id','L3','text','정책 수혜주'),
                   JSON_OBJECT('id','L4','text','이벤트 드리븐')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','실적과 기술력이 주가를 견인함'),
                           JSON_OBJECT('id','R2','text','실체 없는 뉴스와 수급으로 움직임'),
                           JSON_OBJECT('id','R3','text','정부의 예산과 규제 변화가 핵심'),
                           JSON_OBJECT('id','R4','text','M&A, 분할 등 특정 사건에 반응')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '내가 투자하는 종목이 무엇에 움직이는지 알아야 대응이 가능합니다.'),
           NULL
       );

-- Q1. CONCEPT: 뉴스에 파는 이유 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS004', 'LV2_CH008_LS004_Q001', 'CONCEPT',
           '"소문에 사고 뉴스에 파라"는 격언이 주식 시장에서 통하는 이유를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '드디어 이 회사가 엄청난 수주 계약을 맺었다는 뉴스가 떴어요! 그런데 주가는 왜 바로 상한가 안 가고 떨어지죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 뉴스를 시장이 이미 알고 있었기 때문이에요. 똑똑한 투자자들은 뉴스가 나오기 전부터 그 소문을 듣고 주식을 사 모았고, 주가는 이미 그 기대감을 반영해서 올라와 있었던 거죠. 이걸 "선반영"이라고 해요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '뉴스가 공식적으로 뜨는 순간, 미리 샀던 사람들에게는 "최고의 매도 기회"가 됩니다. 더 이상 기대할 새로운 재료가 없기 때문이죠. 이걸 "재료 소멸"이라고 부릅니다. 호재가 떴을 때 주가가 못 오르고 밀린다면, 이미 선반영된 가격임을 인지하고 조심해야 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 뉴스는 시작이 아니라 과정이나 끝일 수도 있겠군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 선반영의 판단 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS004', 'LV2_CH008_LS004_Q002', 'SELECT',
           '호재 뉴스가 나왔음에도 주가가 하락하는 가장 유력한 원인은?',
           JSON_OBJECT('choices', JSON_ARRAY('이미 주가가 해당 호재를 반영해 선상승했기 때문', '거래소가 강제로 주가를 내렸기 때문', '회사가 너무 돈을 많이 벌어서')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '기대감이 주가에 이미 녹아있으면 뉴스는 매도 신호가 됩니다.'),
           NULL
       );

-- Q3. MATCH: 재료의 크기
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS004', 'LV2_CH008_LS004_Q003', 'MATCH',
           '뉴스가 나왔음에도 주가가 꺾이지 않고 계속 오르는 것은 재료가 시장의 {{blank}}를 뛰어넘었기 때문입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('예상치', '액면가', '수수료')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '예상을 뛰어넘는 어닝 서프라이즈 등은 선반영을 극복합니다.'),
           NULL
       );

-- Q4. DRAG: 매매 타이밍
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS004', 'LV2_CH008_LS004_Q004', 'DRAG',
           '정보가 없을 때 {{blank}}을 분석하고, 호재가 노출되면 {{blank}} 관점으로 대응해야 계좌를 지킬 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('수급', '비중 축소', '몰빵')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '뉴스가 떴을 때 추격 매수하는 것은 가장 위험한 행동 중 하나입니다.'),
           NULL
       );

-- Q5. LINK: 상황별 주가 반응 연결 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS004', 'LV2_CH008_LS004_Q005', 'LINK',
           '뉴스의 종류와 그에 따른 주가 움직임을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','오랫동안 기다린 대형 호재 공시'),
                   JSON_OBJECT('id','L2','text','전혀 예상치 못한 깜짝 호재'),
                   JSON_OBJECT('id','L3','text','이미 알고 있던 악재 발표'),
                   JSON_OBJECT('id','L4','text','모호한 소문만 무성함')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','재료 소멸로 인한 주가 급락'),
                           JSON_OBJECT('id','R2','text','강력한 수급 유입 및 추가 상승'),
                           JSON_OBJECT('id','R3','text','불확실성 해소로 인한 주가 반등'),
                           JSON_OBJECT('id','R4','text','변동성 확대 및 방향성 탐색')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '뉴스를 보고 사람들이 어떻게 행동할지 예측하는 훈련이 필요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 밸류체인(Value Chain)의 중요성 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS005', 'LV2_CH008_LS005_Q001', 'CONCEPT',
           '세상의 모든 산업은 사슬처럼 연결되어 있습니다. 밸류체인 분석을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '엔비디아 주가가 폭등했대요! 그럼 전 엔비디아 주식만 사야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '엔비디아가 잘 나가면 그 그래픽카드를 만드는 데 필요한 부품이나 장비를 대는 회사들도 돈을 벌게 되겠죠? 이게 바로 밸류체인 분석이에요. 원재료를 공급하는 "업스트림", 제품을 생산하는 "미드스트림", 판매 및 유통하는 "다운스트림"으로 나누어 생각해보세요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '완제품 업체가 너무 비싸다면, 그 회사의 핵심 부품을 독점 공급하는 작은 강소기업에 투자하는 게 더 큰 수익을 줄 수 있습니다. 사슬의 한쪽 끝이 당겨지면 전체 사슬이 움직인다는 원리를 기억하세요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 1등 기업의 성공을 함께 누릴 수 있는 "숨은 조력자"를 찾는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 전방 산업의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS005', 'LV2_CH008_LS005_Q002', 'SELECT',
           '우리 회사의 제품을 가져다가 최종 소비재를 만드는, 나보다 뒤에 있는 산업군을 무엇이라 부를까요?',
           JSON_OBJECT('choices', JSON_ARRAY('전방 산업', '후방 산업', '원재료 산업')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '전방 산업(자동차, 스마트폰 등)이 잘 되어야 부품사인 우리 회사도 잘 됩니다.'),
           NULL
       );

-- Q3. MATCH: 낙수 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS005', 'LV2_CH008_LS005_Q003', 'MATCH',
           '대기업이 대규모 설비 투자를 발표하면, 장비를 납품하는 중소기업들의 실적이 개선되는 현상을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('낙수 효과', '풍선 효과', '지렛대 효과')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '투자의 온기가 공급망 아래쪽으로 퍼져나가는 것입니다.'),
           NULL
       );

-- Q4. DRAG: 밸류체인 구성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS005', 'LV2_CH008_LS005_Q004', 'DRAG',
           '전기차 시장 분석 시 {{blank}} 산업은 배터리 소재(리튬 등)이고, {{blank}} 산업은 완성차 제조입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('후방', '전방', '중간')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '공급 흐름상 원재료 쪽이 후방, 완제품 쪽이 전방입니다.'),
           NULL
       );

-- Q5. LINK: 산업별 밸류체인 연결 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH008_LS005', 'LV2_CH008_LS005_Q005', 'LINK',
           '완성품 업체와 그에 따른 핵심 밸류체인(부품/장비)을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','전기차 완성차'),
                   JSON_OBJECT('id','L2','text','스마트폰 제조'),
                   JSON_OBJECT('id','L3','text','반도체 파운드리'),
                   JSON_OBJECT('id','L4','text','K-푸드/라면')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','배터리 셀 및 양극재/음극재'),
                           JSON_OBJECT('id','R2','text','디스플레이 및 카메라 모듈'),
                           JSON_OBJECT('id','R3','text','노광 장비 및 식각 공정 가스'),
                           JSON_OBJECT('id','R4','text','소매 유통 및 원재료(밀가루/팜유)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '사슬의 연결고리를 알면 한 종목의 호재를 여러 종목으로 확장할 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 공시를 반드시 봐야 하는 이유 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS001', 'LV2_CH009_LS001_Q001', 'CONCEPT',
           '뉴스는 걸러도 공시는 걸러선 안 됩니다. 그 이유를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 포털 뉴스만 봐도 충분한데 왜 굳이 복잡한 전자공시시스템(DART)까지 들어가야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '뉴스는 기자의 주관이나 요약이 들어가지만, 공시는 기업이 법적 책임을 지고 발표하는 "팩트 그 자체"이기 때문이에요. 특히 "수시공시"는 매출의 10%가 넘는 대규모 계약이나 부도 위험처럼 주가에 즉각적인 영향을 주는 사건들을 담고 있죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '뉴스는 이미 주가에 반영된 뒤에 나오는 경우가 많지만, 공시는 시장에 처음으로 정보가 공개되는 지점입니다. 공시를 읽을 줄 모르면 남들이 다 파는 악재 공시가 떴을 때도 혼자 들고 있다가 큰 손실을 볼 수 있어요. 공시는 내 자산을 지키는 최소한의 방어막입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 뉴스는 소문일 수 있지만, 공시는 기업이 공식적으로 하는 약속이군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 전자공시시스템의 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS001', 'LV2_CH009_LS001_Q002', 'SELECT',
           '금융감독원에서 운영하는 대한민국 모든 상장사의 공시를 확인할 수 있는 사이트는?',
           JSON_OBJECT('choices', JSON_ARRAY('DART (전자공시시스템)', 'KOSPI 홈페이지', '네이버 증권', '유튜브')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'DART는 투자자가 가장 신뢰해야 할 정보의 원천입니다.'),
           NULL
       );

-- Q3. MATCH: 정기공시의 종류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS001', 'LV2_CH009_LS001_Q003', 'MATCH',
           '기업이 매년 회계연도가 끝나고 90일 이내에 제출하는 가장 종합적인 보고서를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('사업보고서', '분기보고서', '임시보고서')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '사업보고서에는 1년 동안의 경영 성과와 향후 계획이 모두 담겨 있습니다.'),
           NULL
       );

-- Q4. DRAG: 공시의 긴급성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS001', 'LV2_CH009_LS001_Q004', 'DRAG',
           '일정한 시기마다 나오는 {{blank}}보다, 갑작스러운 사건을 알리는 {{blank}}가 주가 변동성을 더 크게 키웁니다.',
           JSON_OBJECT('choices', JSON_ARRAY('정기공시', '수시공시', '뉴스')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '예상치 못한 수시공시는 강력한 매수/매도 신호가 됩니다.'),
           NULL
       );

-- Q5. LINK: 공시 항목별 주가 영향
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS001', 'LV2_CH009_LS001_Q005', 'LINK',
           '공시 내용과 일반적인 주가 영향력을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','단일판매·공급계약 체결'),
                   JSON_OBJECT('id','L2','text','부도발생 또는 은행거래정지'),
                   JSON_OBJECT('id','L3','text','최대주주 변경'),
                   JSON_OBJECT('id','L4','text','자기주식 취득 결정')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','매출 증가 기대 (호재)'),
                           JSON_OBJECT('id','R2','text','상장폐지 위험 및 폭락 (악재)'),
                           JSON_OBJECT('id','R3','text','경영권 분쟁 또는 체질 개선 기대'),
                           JSON_OBJECT('id','R4','text','주가 부양 및 주주 환원 의지')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '공시의 제목만 봐도 대응 방향이 서야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 전환사채(CB)의 이면 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS002', 'LV2_CH009_LS002_Q001', 'CONCEPT',
           '회사가 돈을 빌릴 때 쓰는 기술, 전환사채(CB)를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, "전환사채(CB) 발행" 공시가 떴는데 이게 나쁜 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', 'CB는 쉽게 말해 "나중에 주식으로 바꿀 수 있는 권리가 있는 빚"이에요. 돈을 빌려준 사람은 주가가 오르면 주식으로 바꿔서 큰 차익을 얻고, 안 오르면 그냥 이자를 받으면 되죠. 투자자에게는 매우 유리하지만, 기존 주주에게는 위험해요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '왜냐하면 나중에 빚이 주식으로 변하는 순간, 시장에 풀린 주식 수가 늘어나 내 주식의 가치가 희석되기 때문이죠(오버행 이슈). 특히 주가가 떨어질 때 전환 가격을 낮춰주는 "리픽싱" 조항이 있다면, 나중에 쏟아질 주식 수가 더 많아져서 주가 상승을 억제하는 무거운 짐이 됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 빚이 나중에 주식 폭탄이 되어 돌아올 수 있다는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: CB의 핵심 권리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS002', 'LV2_CH009_LS002_Q002', 'SELECT',
           '전환사채(CB)를 보유한 투자자가 행사할 수 있는 가장 핵심적인 권리는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('사채를 미리 정해진 가격에 주식으로 바꿀 권리', '회사 경영진을 해고할 권리', '배당금을 남들보다 10배 더 받을 권리')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '이 권리 때문에 CB 투자자는 하방은 막히고 상방은 열린 투자를 하게 됩니다.'),
           NULL
       );

-- Q3. MATCH: 리픽싱(Refixing) 조항
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS002', 'LV2_CH009_LS002_Q003', 'MATCH',
           '주가가 하락함에 따라 CB의 주식 전환 가격을 함께 낮추어주는 조항을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('리픽싱', '액면분할', '권리락')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '리픽싱은 기존 주주들에게 매우 불리한 독소 조항으로 꼽히기도 합니다.'),
           NULL
       );

-- Q4. DRAG: 오버행 리스크
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS002', 'LV2_CH009_LS002_Q004', 'DRAG',
           'CB 물량이 시장에 쏟아질 가능성이 큰 상태를 {{blank}} 리스크라고 하며, 이는 주가 {{blank}}을 방해합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('오버행', '상승', '하락')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '잠재적인 대량 매물은 매수 심리를 위축시킵니다.'),
           NULL
       );

-- Q5. LINK: 채권 종류별 특징 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS002', 'LV2_CH009_LS002_Q005', 'LINK',
           '특수 사채의 종류와 그 특징을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','전환사채 (CB)'),
                   JSON_OBJECT('id','L2','text','신주인수권부사채 (BW)'),
                   JSON_OBJECT('id','L3','text','교환사채 (EB)'),
                   JSON_OBJECT('id','L4','text','일반사채')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','채권 자체가 주식으로 변함'),
                           JSON_OBJECT('id','R2','text','채권은 남고 새 주식을 살 권리만 줌'),
                           JSON_OBJECT('id','R3','text','회사가 가진 다른 회사 주식으로 바꿈'),
                           JSON_OBJECT('id','R4','text','권리 없이 이자만 받는 순수 빚')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '채권의 성격을 정확히 알아야 내 주식의 미래 물량을 예측할 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 제3자 배정 유상증자의 의미 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS003', 'LV2_CH009_LS003_Q001', 'CONCEPT',
           '유상증자 중에서도 "호재"로 인식되는 제3자 배정을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '증자는 주식 수가 늘어나니까 무조건 악재 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '대체로 그렇지만 "제3자 배정"은 예외인 경우가 많아요. 기존 주주가 아니라 대기업이나 큰 투자자(제3자)를 콕 찍어서 그 사람에게만 주식을 새로 파는 거거든요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '예를 들어 삼성이 어떤 중소기업의 유상증자에 "제3자"로 참여한다면 어떨까요? 삼성이 그 회사의 기술력을 인정하고 파트너가 되었다는 강력한 보증수표가 되죠. 주식 수가 좀 늘어나더라도, 삼성이 가져올 미래 이익이 훨씬 크다고 보기 때문에 주가는 폭등하는 경우가 많습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 든든한 뒷배가 생기는 공시일 수도 있군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 증자의 목적 확인
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS003', 'LV2_CH009_LS003_Q002', 'SELECT',
           '제3자 배정 유상증자 공시에서 투자자가 가장 눈여겨봐야 할 항목은?',
           JSON_OBJECT('choices', JSON_ARRAY('누가 투자하는지(배정 대상자)', '회사의 점심 메뉴', '증권사 직원의 이름')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '투자의 주체가 누구냐에 따라 공시의 무게가 완전히 달라집니다.'),
           NULL
       );

-- Q3. MATCH: 보호예수의 역할
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS003', 'LV2_CH009_LS003_Q003', 'MATCH',
           '제3자로 참여한 투자자가 받은 주식을 일정 기간 팔지 못하게 묶어두는 제도를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('보호예수', '공매도', '자사주 소각')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '보호예수는 단기적인 물량 폭탄을 막아주는 안전장치입니다.'),
           NULL
       );

-- Q4. DRAG: 증자의 명과 암
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS003', 'LV2_CH009_LS003_Q004', 'DRAG',
           '단순히 빚을 갚기 위한 {{blank}}은 악재이지만, 설비 투자를 위한 {{blank}}은 장기적 호재로 해석됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('운영자금 조달', '시설자금 조달', '증자')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '조달한 돈을 어디에 쓰느냐가 핵심입니다.'),
           NULL
       );

-- Q5. LINK: 증자 유형별 시장 반응
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS003', 'LV2_CH009_LS003_Q005', 'LINK',
           '증자 방식과 시장의 일반적인 시각을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','주주배정 유상증자'),
                   JSON_OBJECT('id','L2','text','제3자배정 (대기업)'),
                   JSON_OBJECT('id','L3','text','제3자배정 (불투명한 법인)'),
                   JSON_OBJECT('id','L4','text','일반공모 유상증자')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','기존 주주에게 돈을 요구함 (악재)'),
                           JSON_OBJECT('id','R2','text','전략적 제휴 및 자금 유입 (호재)'),
                           JSON_OBJECT('id','R3','text','자금 출처 의심 및 작전 우려'),
                           JSON_OBJECT('id','R4','text','누구든 사달라는 절박함 (강한 악재)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '증자의 "이름"보다 "내용"이 중요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 내부자 매수의 강력한 신호 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS004', 'LV2_CH009_LS004_Q001', 'CONCEPT',
           '회사의 주인과 임원들이 주식을 살 때를 주목해야 하는 이유를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '뉴스보다 더 믿을만한 정보가 있을까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, 바로 "임원 및 주요주주 특정증권 등 소유상황 보고" 공시예요. 회사를 가장 속속들이 아는 사람들이 자기 돈을 써서 주식을 사는 것만큼 확실한 호재는 없죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그들은 회사의 실적이 곧 좋아질지, 진행 중인 계약이 성공할지 우리보다 훨씬 먼저 압니다. 반대로 대주주가 주식을 팔기 시작한다면 "지금이 고점인가?"라는 강력한 의심을 해봐야 해요. 내부자의 돈은 거짓말을 하지 않습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 회사 상황을 제일 잘 아는 사람들의 행동을 복사하는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 임원 매수의 일반적 해석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS004', 'LV2_CH009_LS004_Q002', 'SELECT',
           '대표이사가 장내에서 주식을 대량으로 직접 매수했다면, 시장은 보통 어떻게 해석할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('기업 가치 대비 주가가 싸다는 자신감', '회사가 곧 망할 것 같아서', '돈이 너무 많아 버리려고')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '내부자의 매수는 주가 저점의 강력한 신호 중 하나입니다.'),
           NULL
       );

-- Q3. MATCH: 최대주주 변경의 위험
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS004', 'LV2_CH009_LS004_Q003', 'MATCH',
           '짧은 기간 내에 주인이 여러 번 바뀌는 기업은 {{blank}} 리스크가 매우 높다고 판단합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('경영 불안정', '성장 잠재력', '배당 확대')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '주인이 자주 바뀌는 회사는 작전주이거나 부실 기업일 확률이 높습니다.'),
           NULL
       );

-- Q4. DRAG: 매도 시점의 경고
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH004_LS001', 'LV2_CH009_LS004_Q004', 'DRAG',
           '주가가 급등할 때 대주주가 주식을 {{blank}}하는 것은 고점 신호일 수 있으며, 주가가 급락할 때 {{blank}}하는 것은 바닥 신호일 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('매도', '매수', '보유')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '내부자의 거래 타이밍은 일반 투자자에게 이정표가 됩니다.'),
           NULL
       );

-- Q5. LINK: 거래 주체별 의미 연결
INSERT INTO learning_question
(lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES
    (
        'LV2_CH009_LS004',
        'LV2_CH009_LS004_Q005',
        'LINK',
        '거래 주체와 그 행동의 일반적인 의미를 연결하세요.',

        JSON_OBJECT(
                'left', JSON_ARRAY(
                JSON_OBJECT('id','L1','text','대표이사의 장내 매수'),
                JSON_OBJECT('id','L2','text','대주주의 지분 블록딜 매도'),
                JSON_OBJECT('id','L3','text','국민연금의 지분 확대'),
                JSON_OBJECT('id','L4','text','우리사주 조합의 청약')
                        ),
                'right', JSON_ARRAY(
                        JSON_OBJECT('id','R1','text','책임 경영 및 주가 방어 의지'),
                        JSON_OBJECT('id','R2','text','오버행 부담 및 고점 우려'),
                        JSON_OBJECT('id','R3','text','기관의 장기적 우량성 인정'),
                        JSON_OBJECT('id','R4','text','직원들이 믿는 회사의 성장성')
                         )
        ),

        JSON_OBJECT(
                'correct', JSON_OBJECT(
                'L1','R1',
                'L2','R2',
                'L3','R3',
                'L4','R4'
                           ),
                'explanation', '누가 주식을 움직이는지 알면 흔들리지 않습니다.'
        ),

        NULL
    );

-- Q1. CONCEPT: 인적분할과 물적분할의 차이 (자세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS005', 'LV2_CH009_LS005_Q001', 'CONCEPT',
           '회사를 나누는 두 가지 방식, 주주에게 미치는 영향을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '회사가 분할한다는데 제 주식은 어떻게 되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '방식에 따라 완전히 달라요. "인적분할"은 회사를 수평으로 나눠서, 기존 주주도 새 회사의 주식을 똑같이 나눠 받는 방식이에요. 주주의 권리가 유지되니 보통 호재나 중립으로 봅니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반면 "물적분할"은 회사를 수직으로 나눠서, 새 회사가 원래 회사의 100% 자회사가 되는 방식이에요. 기존 주주는 새 회사 주식을 한 주도 못 받죠. 나중에 이 알짜 자회사를 따로 상장하면 원래 회사 주가는 "껍데기"가 된다며 폭락하는 경우가 많습니다. LG화학과 LG에너지솔루션의 사례가 대표적이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 인적분할은 주식을 나눠주지만, 물적분할은 자식으로만 두는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 인적분할의 장점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS005', 'LV2_CH009_LS005_Q002', 'SELECT',
           '인적분할 후 기존 주주가 받게 되는 혜택은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('새로 생긴 회사의 주식을 보유 비율대로 받음', '새 회사 주식을 한 주도 못 받음', '회사가 가진 현금을 모두 나눠줌')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '인적분할은 주주권을 직접적으로 보장해 주는 분할 방식입니다.'),
           NULL
       );

-- Q3. MATCH: 물적분할의 위험
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS005', 'LV2_CH009_LS005_Q003', 'MATCH',
           '물적분할 후 핵심 사업부를 따로 상장할 경우, 기존 모회사의 주식 가치가 떨어지는 현상을 지주사 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('할인(Discount)', '프리미엄', '배당')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '핵심 사업이 빠져나간 모회사는 시장에서 낮은 평가를 받게 됩니다.'),
           NULL
       );

-- Q4. DRAG: 분할의 의도
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS005', 'LV2_CH009_LS005_Q004', 'DRAG',
           '{{blank}}분할은 주로 지배구조 개선과 주주 환원을 위해, {{blank}}분할은 집중적인 투자 자금 유치를 위해 시행됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('인적', '물적', '흡수')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '분할의 방식만 봐도 대주주의 속마음을 엿볼 수 있습니다.'),
           NULL
       );

-- Q5. LINK: 기업 분할 상황별 결과 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH009_LS005', 'LV2_CH009_LS005_Q005', 'LINK',
           '분할 방식과 그에 따른 주주의 상황을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','인적분할 후 재상장'),
                   JSON_OBJECT('id','L2','text','물적분할 후 자회사 상장'),
                   JSON_OBJECT('id','L3','text','흡수 합병'),
                   JSON_OBJECT('id','L4','text','회사 매각(M&A)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','두 회사의 주식을 모두 소유함'),
                           JSON_OBJECT('id','R2','text','모회사가 껍데기화 될 위험'),
                           JSON_OBJECT('id','R3','text','두 기업이 하나로 합쳐짐'),
                           JSON_OBJECT('id','R4','text','경영권 프리미엄 반영 기대')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '분할 공시는 내 주식의 "질"이 바뀌는 대사건입니다.'),
           NULL
       );

-- Q1. CONCEPT: 비중 조절과 리스크 관리 (상세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS001', 'LV2_CH010_LS001_Q001', 'CONCEPT',
           '한 종목에 모든 돈을 거는 "몰빵"이 왜 투자가 아닌 도박인지 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 정말 확실한 종목인데 한 번에 크게 벌어야 자산이 빨리 불어나지 않을까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 "생존 확률"을 고려하지 않은 생각이에요. 주식 시장에서 100% 확실한 종목은 존재하지 않습니다. 만약 한 종목에 100%를 투자했는데 예상치 못한 악재로 -50%가 된다면, 원금을 회복하기 위해 100%의 수익을 내야 합니다. 복구가 거의 불가능해지죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '하지만 자산을 5종목으로 20%씩 나누어 담았다면, 한 종목이 -50%가 되어도 전체 계좌는 -10%에 그칩니다. 다른 종목에서 충분히 복구할 수 있는 수준이죠. 비중 조절은 단순히 수익을 나누는 것이 아니라, "실수했을 때 다시 일어설 기회"를 사는 것입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 비중 조절은 내 실력을 과신하지 않고 시장의 불확실성에 대비하는 보호장치군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 적절한 포트폴리오 종목 수
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS001', 'LV2_CH010_LS001_Q002', 'SELECT',
           '개인 투자자가 집중적으로 분석하고 관리하기에 가장 적절한 종목 수는 보통 몇 개일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('1개 (몰빵)', '3~5개', '30개 이상', '시장 모든 종목')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '너무 적으면 리스크가 크고, 너무 많으면 수익률이 시장 평균에 수렴하여 관리가 어렵습니다.'),
           NULL
       );

-- Q3. MATCH: 계좌의 변동성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS001', 'LV2_CH010_LS001_Q003', 'MATCH',
           '종목별 비중을 일정하게 유지하여 특정 종목의 급락이 전체 계좌에 주는 충격을 줄이는 것을 {{blank}} 관리라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('변동성', '수익성', '회전율')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '변동성을 통제해야 장기적인 복리 수익이 가능해집니다.'),
           NULL
       );

-- Q4. DRAG: 비중 설정의 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS001', 'LV2_CH010_LS001_Q004', 'DRAG',
           '확신이 강한 종목이라도 최대 비중은 {{blank}}%를 넘지 않는 것이 좋으며, 시장 상황이 불안할 때는 {{blank}} 비중을 높여야 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('30', '현금', '주식')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '현금도 하나의 훌륭한 종목임을 잊지 마세요.'),
           NULL
       );

-- Q5. LINK: 투자 성향별 비중 전략
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS001', 'LV2_CH010_LS001_Q005', 'LINK',
           '상황에 따른 적절한 비중 조절 전략을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','강력한 상승장 (불장)'),
                   JSON_OBJECT('id','L2','text','불확실한 횡보장'),
                   JSON_OBJECT('id','L3','text','하락장 초기 진입'),
                   JSON_OBJECT('id','L4','text','개별 종목의 악재 발생')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','주식 비중 최대화 및 수익 극대화'),
                           JSON_OBJECT('id','R2','text','현금 비중 확보 및 관망'),
                           JSON_OBJECT('id','R3','text','비중 축소 및 리스크 관리'),
                           JSON_OBJECT('id','R4','text','전량 매도 또는 비중 대폭 축소')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '비중은 시장의 기온에 맞춰 입는 옷과 같습니다.'),
           NULL
       );

-- Q1. CONCEPT: 손절이 필요한 이유 (상세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS002', 'LV2_CH010_LS002_Q001', 'CONCEPT',
           '손절(Stop-loss)은 실패가 아니라 "성공을 위한 포기"입니다. 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '팔지 않으면 손실이 아니잖아요. 언젠간 오르지 않을까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 "언젠가"를 기다리는 동안 당신의 돈은 감옥에 갇힌 것과 같아요. 이를 "기회비용"이라고 합니다. 만약 -30%인 종목을 잡고 2년을 버텨서 본전에 팔았다면, 그 2년 동안 다른 급등주에서 벌 수 있었던 수익을 모두 날린 셈이죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '또한, -10%에서 손절하면 다음 매매에서 11%만 벌면 복구되지만, -50%까지 방치하면 100%를 벌어야 합니다. 손절은 내 계좌에 치명적인 상처가 나지 않도록 하는 "안전벨트"입니다. 잘못된 판단을 인정하는 용기가 투자의 실력입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 손절은 더 좋은 기회로 갈아타기 위한 "자유"를 얻는 과정이군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 정석적인 손절 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS002', 'LV2_CH010_LS002_Q002', 'SELECT',
           '투자 고수들이 주로 사용하는 가장 객관적인 손절 기준은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('내가 기분이 나쁠 때', '미리 정해둔 손절가나 지지선을 이탈할 때', '주변 사람들이 다 팔 때', '원금의 절반이 사라졌을 때')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '기계적인 원칙이 감정을 이기는 유일한 방법입니다.'),
           NULL
       );

-- Q3. MATCH: 비자발적 장기투자
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS002', 'LV2_CH010_LS002_Q003', 'MATCH',
           '손절 타이밍을 놓쳐서 어쩔 수 없이 장기간 주식을 보유하게 되는 현상을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('비자발적 장기투자', '가치투자', '매집')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '계획 없는 보유는 투자가 아닌 방치입니다.'),
           NULL
       );

-- Q4. DRAG: 수익과 손실의 비대칭성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS002', 'LV2_CH010_LS002_Q004', 'DRAG',
           '손실이 {{blank}}%가 되면 복구하기 위해 {{blank}}%의 수익이 필요하므로 손실은 짧게 끊어야 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('50', '100', '20')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '복리 손실의 무서움을 이해해야 손절이 쉬워집니다.'),
           NULL
       );

-- Q5. LINK: 손절 상황별 판단 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS002', 'LV2_CH010_LS002_Q005', 'LINK',
           '종목의 상태와 그에 따른 손절 판단을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','투자 아이디어가 훼손됨'),
                   JSON_OBJECT('id','L2','text','주요 지지선 거래량 실어 이탈'),
                   JSON_OBJECT('id','L3','text','단순한 시장 하락으로 동반 하락'),
                   JSON_OBJECT('id','L4','text','기업의 횡령/배임 발생')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','즉시 손절 (더 이상 보유 이유 없음)'),
                           JSON_OBJECT('id','R2','text','기계적 손절 (추가 하락 위험)'),
                           JSON_OBJECT('id','R3','text','일시적 관망 또는 분할 매수 고려'),
                           JSON_OBJECT('id','R4','text','전량 매도 (상장 폐지 리스크)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '손절은 내 돈을 더 가치 있는 곳으로 보내는 결정입니다.'),
           NULL
       );

-- Q1. CONCEPT: 분할 매매의 심리적 이점 (상세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS003', 'LV2_CH010_LS003_Q001', 'CONCEPT',
           '왜 고수들은 "한 번에 다 사지 마라"고 할까요? 그 이유를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주가가 오를 것 같으면 그냥 한 번에 다 사버리는 게 수익이 제일 크지 않나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '만약 사고 나서 바로 떨어지면 어떡하실 건가요? 한 번에 다 샀다면 공포심에 바로 손절하거나 패닉에 빠지기 쉽습니다. 하지만 3번에 나누어 사기로 계획했다면, 주가가 떨어졌을 때 "더 싼 가격에 살 기회"가 남은 것이니 심리적으로 훨씬 여유로워지죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '매도도 마찬가지예요. 머리 꼭대기에서 팔고 싶겠지만 아무도 고점은 모릅니다. 분할 매도를 하면 수익을 챙기면서도 추가 상승의 기쁨을 누릴 수 있죠. 결국 분할 매매는 내 예측이 틀렸을 때를 대비한 "심리 보험"입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 분할 매매는 내 욕심을 제어하고 시장의 변화에 유연하게 대처하는 방법이군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 분할 매수의 장점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS003', 'LV2_CH010_LS003_Q002', 'SELECT',
           '분할 매수를 통해 얻을 수 있는 가장 큰 실전적 이점은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('평균 단가를 조절하여 심리적 안정을 얻음', '수수료를 아낄 수 있음', '주가가 오를 때만 살 수 있음')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '나누어 사면 주가가 출렁여도 대응할 힘이 생깁니다.'),
           NULL
       );

-- Q3. MATCH: 불타기와 물타기
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS003', 'LV2_CH010_LS003_Q003', 'MATCH',
           '주가가 오를 때 비중을 더 싣는 것을 {{blank}}, 내릴 때 평균 단가를 낮추려 더 사는 것을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('불타기', '물타기', '손절')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '하락장에서는 계획 없는 물타기가 가장 위험합니다.'),
           NULL
       );

-- Q4. DRAG: 매도 원칙
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS003', 'LV2_CH010_LS003_Q004', 'DRAG',
           '수익이 날 때는 목표가에서 {{blank}}을 하고, 추세가 살아있다면 나머지는 {{blank}}하여 수익을 극대화합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('일부 매도', '홀딩', '전량 손절')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '줄 때 먹는 것과 끝까지 먹는 것의 조화가 필요합니다.'),
           NULL
       );

-- Q5. LINK: 분할 매매 실전 전략 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS003', 'LV2_CH010_LS003_Q005', 'LINK',
           '상황별 분할 매매 방법을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','확신하는 종목 첫 진입'),
                   JSON_OBJECT('id','L2','text','1차 목표가 도달'),
                   JSON_OBJECT('id','L3','text','예상 지지선 이탈 시'),
                   JSON_OBJECT('id','L4','text','강력한 저항선 돌파 시')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','전체 비중의 30% 내외 정찰병'),
                           JSON_OBJECT('id','R2','text','수익의 절반 현금화 (수익 확정)'),
                           JSON_OBJECT('id','R3','text','추가 매수 중단 및 손절 검토'),
                           JSON_OBJECT('id','R4','text','수익금으로 비중 확대 (불타기)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '잘게 나누어 대응할수록 계좌는 단단해집니다.'),
           NULL
       );

-- Q1. CONCEPT: 매매 일지의 위력 (상세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS004', 'LV2_CH010_LS004_Q001', 'CONCEPT',
           '매일 쓰는 매매 일지가 당신을 프로로 만듭니다. 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '매매 일지 쓰는 거 너무 귀찮아요. 수익률만 보면 되는 거 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '수익률은 결과일 뿐, 당신이 왜 그 주식을 샀는지, 그때 기분은 어땠는지 기록하지 않으면 똑같은 실수를 반복하게 됩니다. 매매 일지는 "나만의 오답 노트"예요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '일지를 쓰다 보면 내가 언제 감정에 휘둘려 뇌동매매를 하는지, 어떤 패턴에서 수익이 잘 나는지 패턴이 보이기 시작합니다. 시장은 매일 변하지만, 나의 실수는 늘 반복되거든요. 그 실수를 기록하고 교정하는 과정이 쌓일 때, 비로소 운에 맡기지 않는 실력 있는 투자자가 됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 일지는 어제의 나를 이기기 위한 가장 강력한 훈련 도구군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 매매 일지의 필수 항목
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS004', 'LV2_CH010_LS004_Q002', 'SELECT',
           '매매 일지를 작성할 때 가장 중요하게 기록해야 할 내용은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('그날의 점심 메뉴', '매수/매도의 구체적인 이유와 근거', '연예인 뉴스', '계좌 비밀번호')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '근거를 기록해야 나중에 복기하고 교정할 수 있습니다.'),
           NULL
       );

-- Q3. MATCH: 복기의 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS004', 'LV2_CH010_LS004_Q003', 'MATCH',
           '과거의 매매를 다시 돌아보며 잘한 점과 못한 점을 분석하는 과정을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('복기', '매집', '추종')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '바둑 기사들이 대국 후 복기를 하듯, 투자자도 반드시 복기해야 성장합니다.'),
           NULL
       );

-- Q4. DRAG: 일지 작성의 핵심
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS004', 'LV2_CH010_LS004_Q004', 'DRAG',
           '수익이 난 매매보다 {{blank}}이 난 매매를 기록할 때 더 많이 배울 수 있으며, 이를 통해 {{blank}}를 줄여나가야 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('손실', '반복적인 실수', '수익')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '실수를 줄이는 것이 곧 수익률을 높이는 길입니다.'),
           NULL
       );

-- Q5. LINK: 매매 상황별 복기 포인트 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS004', 'LV2_CH010_LS004_Q005', 'LINK',
           '매매 결과에 따라 스스로에게 던져야 할 질문을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','수익이 났을 때'),
                   JSON_OBJECT('id','L2','text','손절을 했을 때'),
                   JSON_OBJECT('id','L3','text','추격 매수를 했을 때'),
                   JSON_OBJECT('id','L4','text','수익 후 급락을 맞았을 때')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','운이었나, 원칙에 의한 결과였나?'),
                           JSON_OBJECT('id','R2','text','원칙대로 잘 끊어냈는가?'),
                           JSON_OBJECT('id','R3','text','탐욕에 눈이 멀어 뇌동매매했는가?'),
                           JSON_OBJECT('id','R4','text','익절 원칙이 없어서 놓쳤는가?')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '정직한 질문이 실력을 만듭니다.'),
           NULL
       );

-- Q1. CONCEPT: 투자 심리와 본능 제어 (상세한 설명)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS005', 'LV2_CH010_LS005_Q001', 'CONCEPT',
           '주식 투자는 결국 자신과의 싸움입니다. 심리 조절법을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '머리로는 아는데 막상 차트가 움직이면 손이 멋대로 매수 버튼을 눌러요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 인간의 본능인 "공포"와 "탐욕" 때문이에요. 남들이 돈을 벌 땐 나만 뒤처질까 봐 사고(FOMO), 떨어질 땐 원금을 잃을까 봐 공포에 질려 바닥에서 팔죠. 시장은 우리의 이런 약점을 정확히 파고듭니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '본능을 이기는 유일한 방법은 "기계적인 시스템"입니다. 매매하기 전에 미리 시나리오를 써두고 그대로 실행만 하세요. 차트를 보며 실시간으로 결정하지 마세요. 당신의 감정은 믿을 게 못 되지만, 당신이 미리 세운 "원칙"은 믿을 만합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 차가운 머리로 계획하고, 뜨거운 가슴은 매매할 때 잠시 꺼두어야겠군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 뇌동매매의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS005', 'LV2_CH010_LS005_Q002', 'SELECT',
           '자신만의 원칙 없이 시장 분위기나 남의 말에 휩쓸려 즉흥적으로 매매하는 것을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('뇌동매매', '가치매매', '추세매매', '알고리즘 매매')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '뇌동매매는 계좌를 망치는 가장 빠른 지름길입니다.'),
           NULL
       );

-- Q3. MATCH: FOMO 증후군
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS005', 'LV2_CH010_LS005_Q003', 'MATCH',
           '상승장에서 나만 소외되어 돈을 못 벌 것 같은 두려움에 무리하게 추격 매수하는 심리를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('FOMO', '패닉셀', '멘탈붕괴')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '남과 비교하는 마음이 투자를 그르치게 합니다.'),
           NULL
       );

-- Q4. DRAG: 매매의 마음가짐
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS005', 'LV2_CH010_LS005_Q004', 'DRAG',
           '수익이 날 때 너무 {{blank}}하지 말고, 손실이 날 때 너무 {{blank}}하지 않는 평정심이 가장 큰 실력입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('자만', '좌절', '행복')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '일희일비하지 않는 태도가 장기 투자의 핵심입니다.'),
           NULL
       );

-- Q5. LINK: 심리적 함정과 극복법 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV2_CH010_LS005', 'LV2_CH010_LS005_Q005', 'LINK',
           '투자의 심리적 함정과 그 해결책을 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','주가가 오를 때의 탐욕'),
                   JSON_OBJECT('id','L2','text','주가가 내릴 때의 공포'),
                   JSON_OBJECT('id','L3','text','손실을 인정하기 싫은 마음'),
                   JSON_OBJECT('id','L4','text','계속 차트만 보게 되는 불안')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','분할 매도로 수익 확정하기'),
                           JSON_OBJECT('id','R2','text','분할 매수로 단가 조절하기'),
                           JSON_OBJECT('id','R3','text','기계적인 손절가 준수하기'),
                           JSON_OBJECT('id','R4','text','알람 설정 후 HTS/MTS 끄기')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '심리를 이기는 시스템을 만드는 것이 중급의 완성입니다.'),
           NULL
       );
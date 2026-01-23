-- ALTER TABLE LEARNING_QUESTION RENAME COLUMN options_json TO options;

-- Q1. CONCEPT: 주식의 기원 (FAQ: 주식은 도박인가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS001', 'LV1_CH001_LS001_Q001', 'CONCEPT',
           '주식은 도대체 왜 만들어졌을까요? 역사 속으로 가봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'mentor', 'text', '옛날 네덜란드 탐험가들이 큰 배를 띄워 보물을 찾으러 가고 싶어 했어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '혼자서는 돈이 너무 많이 들었겠는데요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 그래서 여러 사람에게 돈을 조금씩 모으고, 그 증거로 "증서"를 나눠줬죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '나중에 보물을 가져오면 그 증서를 가진 만큼 수익을 나눠주기로 한 거예요. 이게 주식의 시작입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '위험은 나누고 이익은 공유하는 지혜로운 시스템이네요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 주식 발행의 근본 목적
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS001', 'LV1_CH001_LS001_Q002', 'SELECT',
           '기업이 주식 시장을 통해 주식을 발행하는 가장 큰 이유는 무엇인가요?',
           JSON_OBJECT('choices', JSON_ARRAY('은행 이자를 갚기 위해', '회사의 이름을 알리기 위해', '사업 성장에 필요한 대규모 자금을 모으기 위해', '직원들에게 주식을 무료로 나눠주기 위해')),
           JSON_OBJECT('correct', JSON_ARRAY(3), 'explanation', '기업은 공장 건설이나 연구 개발 등 큰 자금이 필요할 때 주주들로부터 투자를 받습니다.'),
           NULL
       );

-- Q3. MATCH: 주인(주주)의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS001', 'LV1_CH001_LS001_Q003', 'MATCH',
           '회사의 주식을 단 1주라도 소유하여 그 기업의 주인이 된 사람을 {{blank}}라고 부릅니다.',
           JSON_OBJECT('choices', JSON_ARRAY('주주', '채권자', '은행원', '고객')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '주주(Shareholder)는 기업의 소유권을 나누어 가진 사람을 뜻합니다.'),
           NULL
       );

-- Q4. DRAG: 투자의 핵심 원리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS001', 'LV1_CH001_LS001_Q004', 'DRAG',
           '주식 시스템은 여러 사람이 {{blank}}을 나누어 부담하고, 성공했을 때 그 {{blank}}을 공유하기 위해 만들어졌습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('위험(Risk)', '수익(Return)', '책임', '세금')),
           JSON_OBJECT('correct', JSON_ARRAY(1, 2), 'explanation', '하이 리스크 하이 리턴은 주식 투자의 가장 기본적인 원리입니다.'),
           NULL
       );

-- Q5. LINK: 주식과 도박의 차이
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS001', 'LV1_CH001_LS001_Q005', 'LINK',
           '주식 투자와 도박을 구분하는 특징을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','주식 투자'),
                   JSON_OBJECT('id','L2','text','도박')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','누군가 잃어야 내가 따는 제로섬(Zero-sum) 게임'),
                           JSON_OBJECT('id','R2','text','기업 성장을 통해 사회 전체의 부가 늘어나는 생산적 활동')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1'), 'explanation', '투자는 가치를 창출하는 곳에 자본을 공급하는 건전한 경제 활동입니다.'),
           NULL
       );
-- Q1. CONCEPT: 인플레이션의 위험 (FAQ: 은행 예금만 하면 안전한 거 아닌가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS002', 'LV1_CH001_LS002_Q001', 'CONCEPT',
           '현금을 금고에 넣어두기만 하면 벌어지는 일입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '전 원금 잃는 게 너무 무서워요. 그냥 은행에만 넣어두고 싶은데 왜 주식을 하라는 거죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '숫자는 지킬 수 있겠지만, 그 돈의 "가치"는 매일 조금씩 녹아내리고 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '네? 제 지갑 속 만 원이 오천 원이 되기라도 한다는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '물가가 오르는 "인플레이션" 때문이죠. 20년 전 자장면 가격과 지금을 비교해보세요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '기업은 물가가 오르면 제품 가격을 올려 방어하지만, 현금은 가만히 앉아서 구매력을 잃게 됩니다. 그래서 우리는 "자산"을 사야 해요.')
           ), NULL, NULL
       );

-- Q2. SELECT: 자본소득의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS002', 'LV1_CH001_LS002_Q002', 'SELECT',
           '내가 자는 동안에도 내 돈(자산)이 나를 위해 일하게 만드는 소득의 종류는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('근로소득', '자본소득', '연말정산', '기부소득')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '경제적 자유로 가기 위해서는 노동이 아닌 자본이 돈을 버는 구조를 만들어야 합니다.'),
           NULL
       );

-- Q3. MATCH: 복리의 마법
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS002', 'LV1_CH001_LS002_Q003', 'MATCH',
           '원금에 붙은 수익이 다시 원금이 되어 눈덩이처럼 불어나는 원리를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('단리', '복리', '수수료', '세금')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '복리는 시간을 내 편으로 만들 때 가장 큰 힘을 발휘합니다.'),
           NULL
       );

-- Q4. DRAG: 실질 수익률 계산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS002', 'LV1_CH001_LS002_Q004', 'DRAG',
           '은행 이자가 2%인데 물가 상승률이 5%라면, 나의 실질적인 자산 가치는 연간 {{blank}}%씩 {{blank}}하는 셈입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('3', '감소', '5', '증가')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '물가 상승률보다 낮은 수익은 실질적으로 손해입니다.'),
           NULL
       );

-- Q5. LINK: 자산별 특징 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS002', 'LV1_CH001_LS002_Q005', 'LINK',
           '자산의 성격과 그에 따른 결과를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','현금 예금'),
                   JSON_OBJECT('id','L2','text','주식 투자')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','원금 보장 가능성이 높지만 인플레이션에 취약함'),
                           JSON_OBJECT('id','R2','text','원금 손실 위험이 있지만 기업 성장의 결실을 공유함')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '투자는 안전과 수익 사이의 균형을 찾아가는 과정입니다.'),
           NULL
       );

-- Q1. CONCEPT: 주주총회와 의결권 (FAQ: 1주만 있어도 주인인가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS003', 'LV1_CH001_LS003_Q001', 'CONCEPT',
           '주주가 되면 어떤 힘을 갖게 되는지 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 저 삼성전자 1주 샀는데 저도 삼성의 주인인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럼요! 1주만 있어도 당신은 당당한 삼성전자의 주인 중 한 명입니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '회사의 중요한 의사결정을 하는 "주주총회"에 참석해서 투표할 수 있는 "의결권"도 생기죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '우와, 제가 회사의 앞날에 투표할 수 있다니 신기하네요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 비록 지분은 작지만, 경영진이 일을 잘하는지 감시하고 의견을 낼 권리가 법적으로 보장됩니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 배당받을 권리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS003', 'LV1_CH001_LS003_Q002', 'SELECT',
           '회사가 벌어들인 이익의 일부를 주주들에게 나누어 줄 때, 이를 받을 수 있는 권리는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('의결권', '이익배당청구권', '신주인수권', '잔여재산분배권')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '기업 성과의 결실을 나누어 받는 것은 주주의 핵심적인 권리입니다.'),
           NULL
       );

-- Q3. MATCH: 주주총회의 성격
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS003', 'LV1_CH001_LS003_Q003', 'MATCH',
           '주주들이 모여 회사의 이사를 선임하거나 정관을 변경하는 등 중요한 사항을 결정하는 회의를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('이사회', '주주총회', '노사협의회', '감사위원회')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '주주총회는 주식회사의 최고 의사결정 기관입니다.'),
           NULL
       );

-- Q4. DRAG: 유한책임의 원칙
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS003', 'LV1_CH001_LS003_Q004', 'DRAG',
           '주주는 자신이 투자한 {{blank}} 범위 내에서만 책임을 지는 {{blank}} 책임을 집니다.',
           JSON_OBJECT('choices', JSON_ARRAY('투자금', '유한', '무한', '전재산')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '회사가 망해도 주주는 자신이 낸 돈만 잃을 뿐, 개인 재산으로 회사의 빚을 갚을 의무는 없습니다.'),
           NULL
       );

-- Q5. LINK: 주주 권리 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS003', 'LV1_CH001_LS003_Q005', 'LINK',
           '주주의 권리와 그 상세 내용을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','의결권'),
                   JSON_OBJECT('id','L2','text','신주인수권'),
                   JSON_OBJECT('id','L3','text','정보공개청구권')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','새로 발행하는 주식을 우선 배정받을 권리'),
                           JSON_OBJECT('id','R2','text','주주총회 안건에 찬성/반대 투표할 권리'),
                           JSON_OBJECT('id','R3','text','회사의 장부나 서류 열람을 요청할 권리')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1', 'L3','R3'), 'explanation', '주주는 경영 참여, 이익 공유, 감시 등 다양한 법적 권리를 행사할 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 인플레이션 (FAQ: 왜 현금만 들고 있으면 안 되나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS004', 'LV1_CH001_LS004_Q001', 'CONCEPT',
           '돈의 가치가 조금씩 사라지는 인플레이션의 무서움을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '전 손해 보는 게 너무 무서워서 그냥 현금으로 가지고 있으려고요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '숫자는 지킬 수 있겠지만, 그 돈의 "진짜 힘"은 매일 조금씩 약해지고 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '네? 제 지갑 속 만 원이 오천 원이 되기라도 한다는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '물가가 오르는 "인플레이션" 때문이죠. 20년 전 1,000원으로 살 수 있었던 물건을 지금은 못 사잖아요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '기업은 물가가 오르면 제품 가격을 올려 방어하지만, 현금은 가만히 앉아서 구매력을 잃게 됩니다. 그래서 주식 같은 "자산"이 필요해요.')
           ), NULL, NULL
       );

-- Q2. SELECT: 인플레이션의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS004', 'LV1_CH001_LS004_Q002', 'SELECT',
           '물가가 지속적으로 상승하여 화폐의 가치가 떨어지는 현상을 무엇이라 하나요?',
           JSON_OBJECT('choices', JSON_ARRAY('디플레이션', '스태그플레이션', '인플레이션', '하이퍼인플레이션')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '인플레이션이 발생하면 실물 자산인 주식이나 부동산의 가치는 상대적으로 상승합니다.'),
           NULL
       );

-- Q3. MATCH: 실질 금리 계산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS004', 'LV1_CH001_LS004_Q003', 'MATCH',
           '은행 이자가 3%인데 물가 상승률이 5%라면, 나의 실질적인 구매력은 연간 {{blank}}% 감소하는 셈입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('2', '3', '5', '8')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '이익보다 물가가 더 많이 오르면 내 자산의 실질 가치는 마이너스가 됩니다.'),
           NULL
       );

-- Q4. DRAG: 경제 주체의 대응
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS004', 'LV1_CH001_LS004_Q004', 'DRAG',
           '인플레이션 시기에 기업은 원가 상승분을 {{blank}}에 반영하여 가치를 지키지만, {{blank}}은 구매력이 하락하여 손해를 봅니다.',
           JSON_OBJECT('choices', JSON_ARRAY('제품 가격', '현금 보유자', '대출 금리', '기부금')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '기업은 인플레이션을 방어할 수 있는 수단이 있지만, 순수 현금은 방어 수단이 없습니다.'),
           NULL
       );

-- Q5. LINK: 경제 상황별 유리한 대상
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS004', 'LV1_CH001_LS004_Q005', 'LINK',
           '경제 상황과 가치가 상대적으로 오르는 대상을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','심각한 인플레이션'),
                   JSON_OBJECT('id','L2','text','디플레이션 (물가 하락)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','현금 및 예금의 가치 상승'),
                           JSON_OBJECT('id','R2','text','실물 자산 (주식, 원자재) 가치 상승')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1'), 'explanation', '물가가 오를 때는 물건(자산)이 귀해지고, 물가가 내릴 때는 현금이 귀해집니다.'),
           NULL
       );

-- Q1. CONCEPT: 투자와 투기의 차이 (FAQ: 단기간에 대박 날 수 없나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS005', 'LV1_CH001_LS005_Q001', 'CONCEPT',
           '투자와 도박의 경계선이 어디인지 확인해 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '아는 형님이 조만간 대박 난다는 종목 알려줬는데, 전 재산 다 걸어볼까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 "투자"가 아니라 "투기" 혹은 "도박"에 가까워요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '투자는 기업이 어떻게 돈을 버는지 분석하고 성장 가능성에 거는 것이지만, 투기는 오로지 요행과 근거 없는 소문에 의존하는 것이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 운에 맡기는 게 아니라 공부를 해서 확률을 높이는 게 진짜 투자군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요! 실패했을 때 운을 탓하면 투기, 원인을 분석해서 다음 성공의 밑거름으로 삼으면 투자입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 올바른 투자 태도
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS005', 'LV1_CH001_LS005_Q002', 'SELECT',
           '다음 중 장기적으로 성공하는 투자자의 올바른 습관은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('급등하는 종목을 보고 따라 산다', '기업의 실적과 성장성을 꼼꼼히 분석한다', '전 재산을 한 종목에 집중 투자한다', '주위 사람들의 소문만 믿고 투자한다')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '철저한 분석은 투자 리스크를 줄이는 가장 강력한 방법입니다.'),
           NULL
       );

-- Q3. MATCH: 복리의 힘
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS005', 'LV1_CH001_LS005_Q003', 'MATCH',
           '시간이 흐를수록 수익이 다시 원금이 되어 자산이 기하급수적으로 불어나는 마법을 {{blank}} 효과라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('단리', '복리', '감액', '손절')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '복리는 투자의 시간을 내 편으로 만들 때 가장 큰 위력을 발휘합니다.'),
           NULL
       );

-- Q4. DRAG: 투자와 투기의 구분 키워드
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS005', 'LV1_CH001_LS005_Q004', 'DRAG',
           '투자는 {{blank}}을 바탕으로 합리적인 결정을 내리지만, 투기는 {{blank}}에 의존하여 위험한 베팅을 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('데이터와 분석', '요행과 소문', '직관', '운')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '지식이 쌓일수록 투기는 줄어들고 투자는 정교해집니다.'),
           NULL
       );

-- Q5. LINK: 투자 철학 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH001_LS005', 'LV1_CH001_LS005_Q005', 'LINK',
           '현명한 투자자가 기억해야 할 3대 원칙을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','분산 투자'),
                   JSON_OBJECT('id','L2','text','장기 투자'),
                   JSON_OBJECT('id','L3','text','가치 분석')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','위험을 줄이기 위해 돈을 나누어 담음'),
                           JSON_OBJECT('id','R2','text','시간의 힘을 믿고 복리 효과를 누림'),
                           JSON_OBJECT('id','R3','text','기업이 실제 돈을 잘 버는지 확인함')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '이 세 가지 원칙만 지켜도 시장에서 살아남을 확률이 매우 높아집니다.'),
           NULL
       );

-- Q1. CONCEPT: 코스피와 코스닥의 차이 (FAQ: 어디가 더 좋은 시장인가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS001', 'LV1_CH002_LS001_Q001', 'CONCEPT',
           '우리나라 주식 시장의 두 기둥을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'mentor', 'text', '우리나라 시장은 크게 두 개로 나뉘어요. 코스피와 코스닥이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '백화점과 벤처기업 단지 같은 느낌인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 코스피는 삼성전자처럼 덩치가 크고 역사가 깊은 "대기업"들이 모인 곳이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '코스닥은 IT, 바이오, 엔터테인먼트 등 성장 가능성이 큰 "중소·벤처기업"들이 주로 모여 있죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '안정적인 걸 원하면 코스피, 높은 성장을 원하면 코스닥을 먼저 보면 되겠네요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 코스피(KOSPI)의 성격
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS001', 'LV1_CH002_LS001_Q002', 'SELECT',
           '주로 대기업들이 상장되어 있으며, 우리나라 주식 시장을 대표하는 유가증권시장의 지수는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('나스닥', '코스닥', '코스피', '다우존스')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', 'KOSPI는 우리나라 경제의 중심인 대기업들이 상장된 시장입니다.'),
           NULL
       );

-- Q3. MATCH: 코스닥(KOSDAQ)의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS001', 'LV1_CH002_LS001_Q003', 'MATCH',
           'IT, 바이오, 게임 등 기술력과 성장성이 높은 유망 기업들이 주로 상장된 시장을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('코스피', '코스닥', '금거래소', '중고시장')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '코스닥은 성장 잠재력이 높은 기업들의 자금 조달을 돕는 시장입니다.'),
           NULL
       );

-- Q4. DRAG: 시장별 대표 기업 구분
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS001', 'LV1_CH002_LS001_Q004', 'DRAG',
           '전통적인 대기업인 현대차는 {{blank}}에, 혁신적인 기술 기업들은 주로 {{blank}}에 상장되어 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('코스피', '코스닥', '뉴욕증시', '장외시장')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '기업의 규모와 업종에 따라 소속된 시장이 달라집니다.'),
           NULL
       );

-- Q5. LINK: 시장 특징 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS001', 'LV1_CH002_LS001_Q005', 'LINK',
           '각 시장의 일반적인 특징을 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','코스피'),
                   JSON_OBJECT('id','L2','text','코스닥')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','변동성이 크지만 고수익을 기대하는 성장주 위주'),
                           JSON_OBJECT('id','R2','text','안정적인 실적을 내는 대형 우량주 위주')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1'), 'explanation', '시장의 성격에 따라 투자 전략도 달라져야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 정규 거래 시간 (FAQ: 밤이나 주말에도 살 수 있나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS002', 'LV1_CH002_LS002_Q001', 'CONCEPT',
           '주식 시장은 24시간 열려 있을까요?',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '퇴근하고 밤 10시에 주식을 주문했는데 왜 체결이 안 되죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주식 시장은 정해진 "정규 시간"에만 실시간으로 거래가 돼요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '우리나라 정규장은 평일 아침 9시부터 오후 3시 30분까지 열립니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '점심시간에도 밥 먹으러 안 가고 계속 거래가 되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요! 한국 주식 시장은 점심시간 휴게 시간 없이 계속 운영됩니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 장 마감 시간
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS002', 'LV1_CH002_LS002_Q002', 'SELECT',
           '대한민국 주식 시장 정규 거래가 종료되는 정확한 시간은?',
           JSON_OBJECT('choices', JSON_ARRAY('오후 3시', '오후 3시 30분', '오후 4시', '오전 9시')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '오후 3시 20분부터 주문을 모아 3시 30분에 장이 마감됩니다.'),
           NULL
       );

-- Q3. MATCH: 휴장일의 이해
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS002', 'LV1_CH002_LS002_Q003', 'MATCH',
           '주식 시장은 평일에만 열리며, 토요일, 일요일 및 법정 {{blank}}에는 쉽니다.',
           JSON_OBJECT('choices', JSON_ARRAY('월급날', '공휴일', '기념일', '출장일')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '은행이 쉬는 공휴일에는 주식 시장도 거래를 멈춥니다.'),
           NULL
       );

-- Q4. DRAG: 정규장 외 시간 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS002', 'LV1_CH002_LS002_Q004', 'DRAG',
           '아침 9시 이전의 주문 접수 시간을 {{blank}}, 오후 3시 30분 이후의 시간을 {{blank}}이라고 부릅니다.',
           JSON_OBJECT('choices', JSON_ARRAY('장 시작 전', '장 마감 후', '새벽장', '야간장')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '정규장 외에도 시간외 거래라는 특수 거래 시간이 존재합니다.'),
           NULL
       );

-- Q5. LINK: 시간대별 활동 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS002', 'LV1_CH002_LS002_Q005', 'LINK',
           '시간대와 해당 매매 상태를 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','09:00 ~ 15:30'),
                   JSON_OBJECT('id','L2','text','08:30 ~ 09:00'),
                   JSON_OBJECT('id','L3','text','15:40 ~ 18:00')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','장 시작 전 주문 접수 및 시가 결정'),
                           JSON_OBJECT('id','R2','text','정규 매매 시간 (실시간 체결)'),
                           JSON_OBJECT('id','R3','text','장 마감 후 시간외 단일가 매매')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1', 'L3','R3'), 'explanation', '거래 시간대를 정확히 알아야 매매 계획을 세울 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 동시호가의 원리 (FAQ: 왜 주문했는데 바로 안 사지나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS003', 'LV1_CH002_LS003_Q001', 'CONCEPT',
           '장 시작 전과 마감 전, 주문이 쌓이기만 하는 이유를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '아침 8시 50분에 삼성전자를 샀는데 9시까지 아무 반응이 없어요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 "동시호가" 시간이라 그래요. 모든 주문을 바구니에 일단 담아만 두는 거죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '9시 정각이 되면 그동안 모인 주문을 한꺼번에 분석해서 가장 적절한 "하나의 가격"으로 체결시켜요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 경매처럼 주문을 다 받은 다음에 낙찰시키는 거군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요! 가격의 급변을 막고 공정한 시작 가격을 정하기 위한 시스템입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 장 마감 동시호가 시간
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS003', 'LV1_CH002_LS003_Q002', 'SELECT',
           '오후 장 마감 전, "종가"를 결정하기 위해 동시호가가 진행되는 10분간의 시간대는?',
           JSON_OBJECT('choices', JSON_ARRAY('15:00 ~ 15:10', '15:10 ~ 15:20', '15:20 ~ 15:30', '15:30 ~ 15:40')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '오후 3시 20분부터 30분 사이의 주문이 종가를 결정합니다.'),
           NULL
       );

-- Q3. MATCH: 가격의 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS003', 'LV1_CH002_LS003_Q003', 'MATCH',
           '아침 9시에 처음 결정된 가격을 시가, 오후 3시 30분에 마지막으로 결정된 가격을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('종가', '고가', '저가', '현재가')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '하루의 주가 범위는 시가와 종가 사이에서 결정됩니다.'),
           NULL
       );

-- Q4. DRAG: 동시호가의 체결 순서
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS003', 'LV1_CH002_LS003_Q004', 'DRAG',
           '동시호가 때는 주문한 {{blank}}은 따지지 않고, 오직 {{blank}}과 수량만 고려하여 체결 순서를 정합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('시간', '가격', '이름', '종류')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '동시(同時)에 낸 것으로 간주하기 때문입니다.'),
           NULL
       );

-- Q5. LINK: 매매 방식 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS003', 'LV1_CH002_LS003_Q005', 'LINK',
           '매매 상황과 체결 방식을 알맞게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','실시간 정규장 매매'),
                   JSON_OBJECT('id','L2','text','동시호가 매매')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','주문을 일정 시간 모아 하나의 가격으로 체결'),
                           JSON_OBJECT('id','R2','text','가격이 맞는 즉시 순차적으로 체결')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1'), 'explanation', '시간대에 따라 내 주문이 처리되는 방식이 달라집니다.'),
           NULL
       );

-- Q1. CONCEPT: 비대면 계좌 개설 (FAQ: 증권사에 직접 가야 하나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS004', 'LV1_CH002_LS004_Q001', 'CONCEPT',
           '스마트폰 하나로 계좌를 만드는 법을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '주식 계좌 만들려면 평일에 은행이나 증권사 방문해야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요! 요즘은 스마트폰만 있으면 집에서도 5분 만에 가능해요.'),
                   JSON_OBJECT('sender', 'user', 'text', '뭐가 필요하죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '본인 신분증(민증/면허증)과 본인 명의 휴대폰, 그리고 기존 은행 계좌번호만 있으면 됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 계좌로 1원 보내서 인증하는 그거군요? 바로 해볼게요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 필수 확인 사항
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS004', 'LV1_CH002_LS004_Q002', 'SELECT',
           '비대면 계좌 개설 시 본인 인증을 위해 가장 먼저 촬영해야 하는 준비물은?',
           JSON_OBJECT('choices', JSON_ARRAY('가족관계증명서', '신분증 (주민등록증/운전면허증)', '집 매매 계약서', '졸업 증명서')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '신분증 촬영은 비대면 인증의 가장 핵심적인 단계입니다.'),
           NULL
       );

-- Q3. MATCH: 보안 매체의 이름
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS004', 'LV1_CH002_LS004_Q003', 'MATCH',
           '계좌 보안을 강화하고 큰 금액을 이체할 때 사용하는 일회용 비밀번호 생성 장치를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('MTS', 'OTP', 'HTS', 'WTS')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '요즘은 물리적인 기기 대신 앱 내의 "모바일 OTP"를 주로 사용합니다.'),
           NULL
       );

-- Q4. DRAG: 계좌 개설 단계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS004', 'LV1_CH002_LS004_Q004', 'DRAG',
           '계좌 개설: 앱 설치 → {{blank}} 촬영 → 개인정보 입력 → 타행 계좌 {{blank}} 확인 순으로 진행됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('신분증', '1원 입금', '얼굴', '전화')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '정해진 순서대로 진행하면 누구나 쉽게 개설할 수 있습니다.'),
           NULL
       );

-- Q5. LINK: 계좌 용도 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS004', 'LV1_CH002_LS004_Q005', 'LINK',
           '계좌의 명칭과 주요 특징을 알맞게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','위탁계좌(종합계좌)'),
                   JSON_OBJECT('id','L2','text','ISA계좌'),
                   JSON_OBJECT('id','L3','text','CMA계좌')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','세금 혜택을 주는 만능 통장'),
                           JSON_OBJECT('id','R2','text','일반적으로 주식을 사고파는 기본 통장'),
                           JSON_OBJECT('id','R3','text','매일 이자가 붙어 비상금 보관에 유리한 통장')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1', 'L3','R3'), 'explanation', '자신에게 필요한 계좌의 성격을 이해하는 것이 중요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 예수금의 이해 (FAQ: 돈을 넣었는데 왜 삼성전자가 안 사지죠?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS005', 'LV1_CH002_LS005_Q001', 'CONCEPT',
           '내 계좌에 들어있는 현금의 이름, "예수금"을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '증권 계좌로 100만 원 보냈어요! 이제 바로 주식 사면 되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네! 그 100만 원은 이제 "예수금"이라는 이름으로 잡혀 있을 거예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '예수금이 정확히 뭐죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '"주식을 사기 위해 잠시 맡겨둔 현금"이라는 뜻이에요. 이 돈이 있어야만 주문을 낼 수 있죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주식을 사면 이 예수금에서 돈이 빠져나가고, 팔면 다시 예수금으로 들어옵니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 매일 이자가 붙는 계좌
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS005', 'LV1_CH002_LS005_Q002', 'SELECT',
           '주식을 사지 않고 계좌에 남겨둔 돈에 대해 매일매일 이자를 주는 방식의 계좌는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('청약계좌', 'CMA계좌', '적금계좌', '마이너스통장')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', 'CMA는 단 하루만 맡겨도 이자가 붙어 현금 관리에 매우 유리합니다.'),
           NULL
       );

-- Q3. MATCH: 입금의 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS005', 'LV1_CH002_LS005_Q003', 'MATCH',
           '일반 은행 계좌에서 증권 계좌로 주식 투자금을 옮기는 것을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('매수', '입금(이체)', '매도', '공시')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '이체가 완료되어 예수금이 확보되어야 매수 주문이 가능합니다.'),
           NULL
       );

-- Q4. DRAG: 예수금의 변화
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS005', 'LV1_CH002_LS005_Q004', 'DRAG',
           '주식을 사면 예수금은 {{blank}}하고, 주식을 팔면 예수금은 {{blank}}합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('감소', '증가', '유지', '동결')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '현금과 주식이 교환되는 원리입니다.'),
           NULL
       );

-- Q5. LINK: 자산 상태 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, `options`, answer, image)
VALUES (
           'LV1_CH002_LS005',
           'LV1_CH002_LS005_Q005',
           'LINK',
           '내 계좌에서 볼 수 있는 용어와 설명을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','예수금'),
                   JSON_OBJECT('id','L2','text','인출가능금액'),
                   JSON_OBJECT('id','L3','text','총자산평가액')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','현재 당장 내 통장으로 뺄 수 있는 현금'),
                           JSON_OBJECT('id','R2','text','주식을 사기 위해 대기 중인 전체 현금'),
                           JSON_OBJECT('id','R3','text','주식 가치와 현금을 모두 합친 총 금액')
                            )
           ),
           JSON_OBJECT(
                   'correct', JSON_OBJECT('L1','R2', 'L2','R1', 'L3','R3'),
                   'explanation', '자신의 자산 현황을 읽는 가장 기본이 되는 용어들입니다.'
           ),
           NULL
       );

-- Q1. CONCEPT: 지정가 주문의 원리 (FAQ: 가격을 정했는데 왜 안 사지나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS001', 'LV1_CH003_LS001_Q001', 'CONCEPT',
           '원하는 가격을 정해두고 기다리는 "지정가 주문"입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '삼성전자를 70,000원에 사겠다고 주문했는데 왜 바로 안 사질까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '지정가는 "딱 이 가격이나 이보다 싼 가격에만 사줘"라는 뜻이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '현재 시장 가격이 70,100원이라면, 누군가 70,000원에 팔겠다고 나설 때까지 기다려야 해요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 가격이 안 오면 하루 종일 안 사질 수도 있겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 하지만 내가 생각한 예산 안에서 계획적으로 살 수 있다는 장점이 있죠.')
           ), NULL, NULL
       );

-- Q2. SELECT: 지정가 주문의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS001', 'LV1_CH003_LS001_Q002', 'SELECT',
           '투자자가 매수 또는 매도할 가격을 직접 입력하는 주문 방식을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('시장가 주문', '지정가 주문', '조건부 주문', '최유리 주문')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '지정가 주문은 가격 변동 리스크를 줄일 수 있는 가장 일반적인 주문입니다.'),
           NULL
       );

-- Q3. MATCH: 유리한 가격의 이해
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS001', 'LV1_CH003_LS001_Q003', 'MATCH',
           '지정가 매수 주문을 넣으면 내가 적은 가격보다 {{blank}} 가격에는 절대 체결되지 않습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('높은', '낮은', '비슷한', '평균')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '사려는 가격보다 비싸게는 사지 않겠다는 약속이 지정가 주문입니다.'),
           NULL
       );

-- Q4. DRAG: 매수와 매도의 지정가 설정
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS001', 'LV1_CH003_LS001_Q004', 'DRAG',
           '주식을 더 싸게 사고 싶다면 현재가보다 {{blank}} 가격에 주문을 걸고, 더 비싸게 팔고 싶다면 현재가보다 {{blank}} 가격에 주문을 겁니다.',
           JSON_OBJECT('choices', JSON_ARRAY('낮은', '높은', '동일한', '복잡한')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '시장의 흐름을 보며 유리한 가격대에 줄을 서는 과정입니다.'),
           NULL
       );

-- Q5. LINK: 주문 상황 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS001', 'LV1_CH003_LS001_Q005', 'LINK',
           '지정가 주문의 장단점을 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','장점'),
                   JSON_OBJECT('id','L2','text','단점')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','가격이 맞지 않으면 체결되지 않을 수 있음'),
                           JSON_OBJECT('id','R2','text','원하는 가격 범위 내에서 안정적인 매매 가능')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1'), 'explanation', '지정가는 안정성은 높지만 체결 확률은 상대적으로 낮습니다.'),
           NULL
       );

-- Q1. CONCEPT: 시장가 주문의 특징 (FAQ: 급등주를 살 때 왜 위험한가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS002', 'LV1_CH003_LS002_Q001', 'CONCEPT',
           '가격보다 속도가 중요할 때 쓰는 "시장가 주문"입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '지금 당장 이 주식을 사고 싶은데, 가격 입력하기 귀찮아요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럴 땐 "시장가"로 주문해 보세요. 가격 상관없이 지금 파는 물량 중 가장 싼 것부터 즉시 사주는 방식이에요.'),
                   JSON_OBJECT('sender', 'user', 'text', '오, 그럼 무조건 바로 사지겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, 하지만 주가가 급등락할 때는 조심해야 해요. 내가 생각한 가격보다 훨씬 비싸게 사질 수도 있거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아하, 속도는 빠르지만 가격 면에서는 손해를 볼 수도 있겠군요.')
           ), NULL, NULL
       );

-- Q2. SELECT: 시장가 주문의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS002', 'LV1_CH003_LS002_Q002', 'SELECT',
           '종목과 수량만 정하고 가격은 시장에 형성된 가격으로 즉시 체결시키는 주문 방식은?',
           JSON_OBJECT('choices', JSON_ARRAY('지정가 주문', '시장가 주문', '예약 주문', '단일가 주문')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '시장가 주문은 가장 빠른 체결을 보장합니다.'),
           NULL
       );

-- Q3. MATCH: 시장가 매매의 우선순위
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS002', 'LV1_CH003_LS002_Q003', 'MATCH',
           '시장가 주문은 가격을 정해둔 지정가 주문보다 체결 {{blank}}순위가 훨씬 높습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('우선', '후순위', '동일', '낮은')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '가격을 포기한 대신 체결의 권리를 먼저 가져갑니다.'),
           NULL
       );

-- Q4. DRAG: 시장가 주문의 실행 결과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS002', 'LV1_CH003_LS002_Q004', 'DRAG',
           '시장가 매수는 호가창의 가장 낮은 {{blank}} 가격에, 시장가 매도는 호가창의 가장 높은 {{blank}} 가격에 즉시 체결됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('매도 호가', '매수 호가', '시가', '종가')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '상대방이 내놓은 가장 유리한 가격부터 즉시 거래를 맺습니다.'),
           NULL
       );

-- Q5. LINK: 주문 방식별 적절한 상황
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS002', 'LV1_CH003_LS002_Q005', 'LINK',
           '매매 상황에 맞는 주문 유형을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','악재가 터져서 지금 당장 팔고 탈출해야 할 때'),
                   JSON_OBJECT('id','L2','text','여유를 가지고 싼 가격에 사려고 기다릴 때')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','시장가 매도'),
                           JSON_OBJECT('id','R2','text','지정가 매수')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '긴박할 때는 시장가, 차분할 때는 지정가를 활용하세요.'),
           NULL
       );

-- Q1. CONCEPT: 최유리 지정가 (FAQ: "최유리"가 사람 이름인가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS003', 'LV1_CH003_LS003_Q001', 'CONCEPT',
           '나에게 가장 "유리한" 가격을 찾아주는 주문입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '주문창에 "최유리"라는 게 있는데, 이게 뭔가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '매수할 때 "지금 파는 사람 중 제일 싼 가격에 주문 넣어줘"라고 명령하는 거예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '시장가랑 비슷해 보이는데요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '비슷하지만 달라요! 시장가는 물량이 부족하면 더 비싼 가격까지 다 사버리지만, 최유리는 그 순간의 가장 싼 가격에만 주문을 딱 넣고 멈춰요.'),
                   JSON_OBJECT('sender', 'user', 'text', '오, 그럼 너무 비싸게 사지는 걸 막아주면서도 빠르게 살 수 있겠네요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 최우선 지정가의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS003', 'LV1_CH003_LS003_Q002', 'SELECT',
           '매수 시 "사는 사람 중 가장 높은 가격(1순위)"으로 주문을 넣는 방식은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('시장가', '지정가', '최우선 지정가', '최유리 지정가')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '사는 사람 중 1등으로 줄을 서서 체결 확률을 높이는 주문입니다.'),
           NULL
       );

-- Q3. MATCH: 최유리의 영어 표현
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS003', 'LV1_CH003_LS003_Q003', 'MATCH',
           '최유리 지정가는 상대방 측의 가장 {{blank}} 가격에 주문을 내는 방식입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('유리한', '불리한', '비싼', '동일한')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '매수자 입장에서는 가장 싼 매도 호가에 주문을 내는 것이 유리하기 때문입니다.'),
           NULL
       );

-- Q4. DRAG: 복잡한 주문의 활용
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS003', 'LV1_CH003_LS003_Q004', 'DRAG',
           '{{blank}} 주문은 즉시 체결되지만 가격 오차가 크고, {{blank}} 지정가는 즉시 체결되면서 가격을 고정해 줍니다.',
           JSON_OBJECT('choices', JSON_ARRAY('시장가', '최유리', '지정가', '최우선')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '시장가와 최유리의 미묘한 차이를 이해하면 고수가 됩니다.'),
           NULL
       );

-- Q5. LINK: 주문 명칭과 행동 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS003', 'LV1_CH003_LS003_Q005', 'LINK',
           '주문 명칭에 따른 시스템의 행동을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','최유리 지정가 매수'),
                   JSON_OBJECT('id','L2','text','최우선 지정가 매수')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','현재 파는 사람들의 가장 낮은 가격(매도 1호가)에 주문'),
                           JSON_OBJECT('id','R2','text','현재 사는 사람들의 가장 높은 가격(매수 1호가)에 주문')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '유리는 상대방 쪽 호가, 우선은 내 쪽 호가에 줄을 서는 것입니다.'),
           NULL
       );

-- Q1. CONCEPT: 정정 주문 (FAQ: 주문을 잘못 넣었는데 돈이 더 나가나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS004', 'LV1_CH003_LS004_Q001', 'CONCEPT',
           '이미 넣은 주문을 수정하고 싶을 때 사용하는 기능입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '10,000원에 사려고 했는데 실수로 1,000원에 주문했어요. 어쩌죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '당황하지 마세요! 아직 "미체결" 상태라면 "정정 주문"을 통해 가격을 바꿀 수 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '새로 주문하는 거랑 뭐가 다른가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '새로 주문하면 줄의 맨 뒤로 가지만, 수량만 줄이는 정정은 기존 순서를 유지할 수도 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아하, 이미 체결된 후에는 정정이 안 된다는 점만 명심하면 되겠군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 정정 가능한 상태
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS004', 'LV1_CH003_LS004_Q002', 'SELECT',
           '다음 중 정정 주문을 할 수 있는 상태는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('체결 완료', '미체결', '장 종료 후 1시간 뒤', '이미 취소된 주문')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '아직 거래가 성사되지 않은 미체결 주문만 수정이 가능합니다.'),
           NULL
       );

-- Q3. MATCH: 정정 가능 항목
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS004', 'LV1_CH003_LS004_Q003', 'MATCH',
           '정정 주문을 통해 바꿀 수 없는 것은 {{blank}}입니다. (이것을 바꾸려면 취소 후 새로 주문해야 합니다.)',
           JSON_OBJECT('choices', JSON_ARRAY('가격', '수량', '종목', '주문 유형')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '삼성전자를 사려다 현대차로 바꾸는 것은 정정 주문으로 불가능합니다.'),
           NULL
       );

-- Q4. DRAG: 정정 시의 순서 변화
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS004', 'LV1_CH003_LS004_Q004', 'DRAG',
           '정정 주문으로 가격을 변경하면 {{blank}} 우선의 원칙에 따라 체결 순서가 줄의 {{blank}}로 밀려나게 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('시간', '맨 뒤', '가격', '맨 앞')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '가격을 바꾸는 것은 새로운 주문을 낸 것과 같기 때문입니다.'),
           NULL
       );

-- Q5. LINK: 주문 수정 행위 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS004', 'LV1_CH003_LS004_Q005', 'LINK',
           '원하는 목적과 수행할 기능을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','사려는 가격을 높이고 싶을 때'),
                   JSON_OBJECT('id','L2','text','사려는 수량을 줄이고 싶을 때'),
                   JSON_OBJECT('id','L3','text','아예 안 사기로 마음먹었을 때')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','가격 정정'),
                           JSON_OBJECT('id','R2','text','수량 정정'),
                           JSON_OBJECT('id','R3','text','취소 주문')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '상황에 맞게 주문을 제어하는 능력이 필요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 취소 주문의 한계 (FAQ: 취소했는데 주식이 들어왔어요!)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS005', 'LV1_CH003_LS005_Q001', 'CONCEPT',
           '내 주문을 거둬들이는 "취소 주문"입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '아차! 주문 잘못 넣어서 바로 취소 버튼 눌렀는데 "취소 실패"가 떠요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이미 거래가 성사되어 버렸을 수도 있어요. 주식 시장은 눈 깜빡할 사이에 체결이 되거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '취소 버튼 누르면 무조건 취소되는 거 아니었나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '"미체결" 상태일 때만 취소가 가능해요. "체결 완료"라고 떴다면 이미 주식 소유권이 넘어온 것이라 되돌릴 수 없답니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 다시 팔아야겠네요. 주문 전 확인이 정말 중요하군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 취소 주문의 효력
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS005', 'LV1_CH003_LS005_Q002', 'SELECT',
           '취소 주문이 성공했을 때 계좌에서 일어나는 변화는?',
           JSON_OBJECT('choices', JSON_ARRAY('주식이 들어온다', '묶여있던 예수금이 다시 사용 가능해진다', '세금이 빠져나간다', '다음 날 자동으로 다시 주문된다')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '취소 성공 시 주문에 사용될 예정이던 현금이 다시 자유로운 상태가 됩니다.'),
           NULL
       );

-- Q3. MATCH: 일부 취소
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS005', 'LV1_CH003_LS005_Q003', 'MATCH',
           '10주 주문 중 5주만 체결되고 나머지는 아직 체결되지 않았을 때, 남은 5주만 골라 {{blank}} 할 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('취소', '정정', '복사', '삭제')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '미체결된 수량에 대해서만 선별적으로 취소가 가능합니다.'),
           NULL
       );

-- Q4. DRAG: 취소 주문이 불가능한 경우
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS005', 'LV1_CH003_LS005_Q004', 'DRAG',
           '장 마감 후 정규 시간이 끝나거나, 주문이 이미 {{blank}} 되었을 때는 취소 주문을 넣어도 {{blank}} 처리됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('체결', '거부(실패)', '접수', '성공')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '시장이 닫혔거나 이미 계약이 끝난 후에는 취소할 수 없습니다.'),
           NULL
       );

-- Q5. LINK: 주문 상태와 가능 여부 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH003_LS005', 'LV1_CH003_LS005_Q005', 'LINK',
           '주문의 상태에 따른 취소 가능 여부를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','미체결 주문'),
                   JSON_OBJECT('id','L2','text','전부 체결된 주문'),
                   JSON_OBJECT('id','L3','text','일부 체결된 주문')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','남은 미체결 수량만 취소 가능'),
                           JSON_OBJECT('id','R2','text','언제든지 취소 가능'),
                           JSON_OBJECT('id','R3','text','취소 절대 불가능')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R3', 'L3','R1'), 'explanation', '자신의 주문 내역(미체결 잔고)을 수시로 확인하는 습관이 필요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 가격 우선의 원칙 (FAQ: 누가 먼저 주식을 가져가나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS001', 'LV1_CH004_LS001_Q001', 'CONCEPT',
           '주식 시장에서 줄을 서는 첫 번째 규칙입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 전 10,000원에 사겠다고 주문했는데 다른 사람이 먼저 가로채 갔어요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '혹시 그 사람은 얼마에 사겠다고 했나요?'),
                   JSON_OBJECT('sender', 'user', 'text', '물어보니 10,100원에 샀다더라고요. 전 100원 아끼려고 한 건데...'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주식 시장은 경매와 같아요. 더 비싸게 사겠다는 사람이 먼저 가져가는 게 규칙이죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반대로 팔 때는 더 싸게 팔겠다는 사람이 우선권을 가져요. 이걸 "가격 우선의 원칙"이라고 합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 매수 시 우선순위
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS001', 'LV1_CH004_LS001_Q002', 'SELECT',
           '다음 중 매수(사기) 주문 시 가장 먼저 체결되는 주문은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('10,000원에 사겠다는 주문', '10,500원에 사겠다는 주문', '9,500원에 사겠다는 주문', '가격을 입력하지 않은 대기 주문')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '가장 높은 가격을 제시한 매수자가 체결 우선순위를 갖습니다.'),
           NULL
       );

-- Q3. MATCH: 원칙의 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS001', 'LV1_CH004_LS001_Q003', 'MATCH',
           '유리한 가격을 제시한 주문을 먼저 처리하는 것을 {{blank}} 우선의 원칙이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('시간', '가격', '수량', '위탁')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '체결의 3대 원칙 중 가장 강력하고 최우선되는 원칙입니다.'),
           NULL
       );

-- Q4. DRAG: 매도와 매도의 우선권
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS001', 'LV1_CH004_LS001_Q004', 'DRAG',
           '매수자는 가장 {{blank}} 가격을 부른 사람이 1등이고, 매도자는 가장 {{blank}} 가격을 부른 사람이 1등입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('높은', '낮은', '평균적인', '동일한')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '상대방에게 더 매력적인 가격을 제시한 사람이 먼저 거래합니다.'),
           NULL
       );

-- Q5. LINK: 상황별 체결 순서 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS001', 'LV1_CH004_LS001_Q005', 'LINK',
           '매매 상황에 따른 우선순위를 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','100원에 사고 싶은 A와 110원에 사고 싶은 B'),
                   JSON_OBJECT('id','L2','text','100원에 팔고 싶은 C와 90원에 팔고 싶은 D')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','더 낮은 가격을 부른 D가 우선'),
                           JSON_OBJECT('id','R2','text','더 높은 가격을 부른 B가 우선')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1'), 'explanation', '가격이 다르면 원칙은 아주 단순하고 명확합니다.'),
           NULL
       );

-- Q1. CONCEPT: 시간 우선의 원칙 (FAQ: 똑같은 가격인데 왜 제 건 안 사지나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS002', 'LV1_CH004_LS002_Q001', 'CONCEPT',
           '가격이 같을 때 승부를 가르는 "시간 우선의 원칙"입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '방금 10,000원에 사겠다고 주문했어요. 호가창 보니까 같은 가격에 거래가 일어나던데 왜 제 주식수는 안 변하죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '10,000원에 줄 서 있는 사람이 당신 혼자가 아닐 거예요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '가격이 똑같다면, 1초라도 먼저 주문을 전산에 등록한 사람부터 순서대로 체결됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 제 앞에 먼저 줄 서 있는 사람들이 다 사야 제 차례가 오는 거군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 맛집 줄서기와 똑같아요. 이를 "시간 우선의 원칙"이라고 합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 시간 우선의 적용 조건
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS002', 'LV1_CH004_LS002_Q002', 'SELECT',
           '시간 우선의 원칙이 적용되는 전제 조건은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('종목이 같을 때', '가격이 동일할 때', '수량이 동일할 때', '증권사가 같을 때')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '가격이 다르면 가격 우선 원칙이 먼저 작동하고, 가격이 같을 때만 시간을 따집니다.'),
           NULL
       );

-- Q3. MATCH: 원칙의 예외 상황
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS002', 'LV1_CH004_LS002_Q003', 'MATCH',
           '장 시작 전 주문을 모으는 {{blank}} 시간에는 모두가 같은 시간에 낸 것으로 간주하여 시간 우선 원칙이 적용되지 않습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('정규장', '동시호가', '시간외 단일가', '야간장')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '동시호가 때는 가격과 수량 우선 원칙을 주로 따집니다.'),
           NULL
       );

-- Q4. DRAG: 정정 주문과 시간
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS002', 'LV1_CH004_LS002_Q004', 'DRAG',
           '이미 낸 주문의 가격을 변경(정정)하면, 기존에 줄 서 있던 순서를 잃고 줄의 {{blank}}로 밀려나게 됩니다. 이를 {{blank}}의 효력이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('맨 뒤', '시간 번호 변경', '맨 앞', '순서 유지')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '가격을 바꾸는 것은 새 주문으로 간주하기 때문입니다.'),
           NULL
       );

-- Q5. LINK: 체결 시나리오 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS002', 'LV1_CH004_LS002_Q005', 'LINK',
           '다음 상황에서 누가 먼저 체결될지 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','9:00:01에 1만원 매수 주문한 A'),
                   JSON_OBJECT('id','L2','text','9:00:05에 1만원 매수 주문한 B'),
                   JSON_OBJECT('id','L3','text','9:00:10에 1만100원 매수 주문한 C')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','1등 (가격 우선)'),
                           JSON_OBJECT('id','R2','text','2등 (시간 우선)'),
                           JSON_OBJECT('id','R3','text','3등 (시간 우선)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L3','R1', 'L1','R2', 'L2','R3'), 'explanation', '가격이 최우선이고, 그 다음이 시간입니다.'),
           NULL
       );

-- Q1. CONCEPT: 호가창의 기본 구조 (FAQ: 왜 가격들이 계단처럼 쌓여 있나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS003', 'LV1_CH004_LS003_Q001', 'CONCEPT',
           '매수와 매도의 대결 현장, 호가창을 읽어봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'mentor', 'text', '호가창은 시장의 실시간 지도예요. 가운데 현재가를 기준으로 위아래 숫자들이 있죠?'),
                   JSON_OBJECT('sender', 'user', 'text', '네, 위쪽은 파란색 배경이고 아래쪽은 빨간색 배경이네요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '위쪽 파란 영역은 "팔고 싶은 사람들(매도 호가)"이 줄 서 있는 곳이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아래쪽 빨간 영역은 "사고 싶은 사람들(매수 호가)"이 대기하는 곳이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그래서 내가 즉시 사려면 파란 영역의 가장 낮은 가격을 골라야 하는군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 매도 잔량의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS003', 'LV1_CH004_LS003_Q002', 'SELECT',
           '호가창에서 특정 가격에 "팔겠다"고 줄을 서 있는 주식 수량의 합계를 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('매수 잔량', '매도 잔량', '현재가', '거래량')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '팔려는 물량이 얼마나 쌓여 있는지 보여주는 지표입니다.'),
           NULL
       );

-- Q3. MATCH: 호가의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS003', 'LV1_CH004_LS003_Q003', 'MATCH',
           '투자자가 주식을 사고팔기 위해 제시하는 가격 단위를 {{blank}}라고 부릅니다.',
           JSON_OBJECT('choices', JSON_ARRAY('호가', '시가', '종가', '낙폭')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '부를 호(呼), 값 가(價)를 써서 가격을 부른다는 뜻입니다.'),
           NULL
       );

-- Q4. DRAG: 호가창의 상하 구성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS003', 'LV1_CH004_LS003_Q004', 'DRAG',
           '호가창에서 현재가보다 높은 위쪽은 {{blank}} 호가, 현재가보다 낮은 아래쪽은 {{blank}} 호가 영역입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('매도', '매수', '고정', '변동')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '매도는 비싸게 팔고 싶어 하고, 매수는 싸게 사고 싶어 하기 때문입니다.'),
           NULL
       );

-- Q5. LINK: 호가창 용어 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS003', 'LV1_CH004_LS003_Q005', 'LINK',
           '호가창에서 볼 수 있는 정보와 그 설명을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','최우선 매도호가'),
                   JSON_OBJECT('id','L2','text','최우선 매수호가'),
                   JSON_OBJECT('id','L3','text','체결 강도')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','파는 사람 중 가장 낮은 가격 (즉시 매수 가능 가격)'),
                           JSON_OBJECT('id','R2','text','사는 사람 중 가장 높은 가격 (즉시 매도 가능 가격)'),
                           JSON_OBJECT('id','R3','text','사려는 힘과 팔려는 힘 중 어느 쪽이 강한지 나타낸 수치')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '호가창만 잘 읽어도 시장의 분위기를 파악할 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 호가 단위의 규칙 (FAQ: 왜 1원 단위로 주문이 안 되나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS004', 'LV1_CH004_LS004_Q001', 'CONCEPT',
           '주식마다 가격을 올릴 수 있는 "최소 마디"가 정해져 있어요.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '10,005원에 사고 싶은데 앱에서 자꾸 10,000원 아니면 10,010원만 입력하래요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 그 주식의 가격대에 맞는 "호가 단위" 때문이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주가가 1만원~5만원 미만이면 10원 단위로만 가격을 부를 수 있거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 주가가 비싸지면 단위도 커지나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 50만원 넘는 주식은 한 번에 1,000원씩 움직이기도 하죠. 효율적인 거래를 위한 약속입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 호가 단위의 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS004', 'LV1_CH004_LS004_Q002', 'SELECT',
           '주식 시장에서 가격이 변하는 최소 단위를 무엇이라 부를까요?',
           JSON_OBJECT('choices', JSON_ARRAY('틱(Tick)', '포인트(Point)', '센트(Cent)', '비율(Ratio)')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '흔히 "한 틱 올랐다"라고 말할 때의 그 단위입니다.'),
           NULL
       );

-- Q3. MATCH: 가격대별 호가 단위
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS004', 'LV1_CH004_LS004_Q003', 'MATCH',
           '현재 코스피 시장에서 주가가 2,000원 미만인 종목의 최소 호가 단위는 {{blank}}원입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('1', '5', '10', '100')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '저가 종목일수록 호가 단위가 세밀합니다.'),
           NULL
       );

-- Q4. DRAG: 호가 단위의 영향
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS004', 'LV1_CH004_LS004_Q004', 'DRAG',
           '주가가 {{blank}} 단위를 넘어가는 지점을 흔히 "라운드 피겨"라고 하며, 이곳에서는 호가 {{blank}}가 바뀌어 저항이나 지지가 생기기 쉽습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('단위(마디)', '단위(Tick)', '상승', '하락')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '호가 단위가 바뀌면 수익률 계산도 달라지므로 중요한 지점입니다.'),
           NULL
       );

-- Q5. LINK: 가격대와 호가 단위 연결 (코스피 기준)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS004', 'LV1_CH004_LS004_Q005', 'LINK',
           '주가 범위에 따른 코스피 호가 단위를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','5,000원 ~ 10,000원 미만'),
                   JSON_OBJECT('id','L2','text','10,000원 ~ 50,000원 미만'),
                   JSON_OBJECT('id','L3','text','50,000원 ~ 100,000원 미만')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','10원'),
                           JSON_OBJECT('id','R2','text','50원'),
                           JSON_OBJECT('id','R3','text','100원')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '주가에 따라 호가 창 한 칸의 가치가 달라집니다.'),
           NULL
       );

-- Q1. CONCEPT: 위탁 우선의 원칙 (FAQ: 증권사가 제 주문을 가로챌 수 있나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS005', 'LV1_CH004_LS005_Q001', 'CONCEPT',
           '투자자의 주문을 최우선으로 보호하는 규칙입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '증권사도 주식 투자를 하잖아요. 그럼 좋은 가격일 때 자기들이 먼저 사버리면 어떡하죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 법적으로 엄격히 금지되어 있어요. "위탁 우선의 원칙" 때문이죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '증권사 자신의 주문과 고객의 주문이 같은 가격에 들어오면, 무조건 고객의 주문을 먼저 처리해야 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '오, 증권사는 고객의 심부름꾼이니까 당연히 고객이 먼저라는 거군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 시장의 공정성을 유지하기 위한 아주 중요한 원칙입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 체결 3대 원칙이 아닌 것
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS005', 'LV1_CH004_LS005_Q002', 'SELECT',
           '주식 시장의 공정한 거래를 위한 3대 원칙에 포함되지 않는 것은?',
           JSON_OBJECT('choices', JSON_ARRAY('가격 우선의 원칙', '시간 우선의 원칙', '위탁 우선의 원칙', '지역 우선의 원칙')),
           JSON_OBJECT('correct', JSON_ARRAY(3), 'explanation', '어느 지역에서 주문했는지는 체결 순서에 영향을 주지 않습니다.'),
           NULL
       );

-- Q3. MATCH: 원칙의 주체
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS005', 'LV1_CH004_LS005_Q003', 'MATCH',
           '증권사(중개인)의 주문보다 고객의 주문을 먼저 체결하는 것을 {{blank}} 우선의 원칙이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('기관', '개인', '위탁', '수량')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '위탁(맡긴) 사람의 주문을 우선한다는 뜻입니다.'),
           NULL
       );

-- Q4. DRAG: 원칙의 적용 순위
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS005', 'LV1_CH004_LS005_Q004', 'DRAG',
           '주식 체결의 가장 절대적인 기준은 {{blank}}이며, 가격이 같으면 {{blank}}을 따지고, 이마저도 같다면 고객의 주문을 증권사보다 우선합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('가격', '시간', '수량', '거래소')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '가격 > 시간 > 위탁 순서로 원칙이 적용됩니다.'),
           NULL
       );

-- Q5. LINK: 체결 원칙 요약 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH004_LS005', 'LV1_CH004_LS005_Q005', 'LINK',
           '각 원칙의 핵심 키워드를 알맞게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','가격 우선'),
                   JSON_OBJECT('id','L2','text','시간 우선'),
                   JSON_OBJECT('id','L3','text','위탁 우선')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','유리한 조건(높은 매수/낮은 매도)이 1등'),
                           JSON_OBJECT('id','R2','text','먼저 접수된 주문이 1등'),
                           JSON_OBJECT('id','R3','text','고객의 주문이 증권사 주문보다 1등')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '이 세 가지 원칙이 주식 시장을 움직이는 기본 법도입니다.'),
           NULL
       );

-- Q1. CONCEPT: 결제 시스템의 원리 (FAQ: 팔았는데 왜 출금이 안 되나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS001', 'LV1_CH005_LS001_Q001', 'CONCEPT',
           '주식 매매와 실제 돈이 오가는 시차를 이해해 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님! 방금 주식을 다 팔았거든요? 근데 내 통장으로 돈을 빼려고 하니까 0원이라고 나와요. 사기 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '진정하세요! 주식 시장은 편의점처럼 물건과 돈을 바로 바꾸지 않아요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '오늘 거래가 성사(체결)되면, 실제 돈이 들어오는 건 영업일 기준으로 2일 뒤예요. 이걸 "D+2 결제"라고 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 오늘 월요일에 팔았으면 수요일에 돈을 뺄 수 있는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 체결된 날을 포함해서 3일째 되는 날에 최종 결제가 완료됩니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 결제 소요 시간
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS001', 'LV1_CH005_LS001_Q002', 'SELECT',
           '주식을 매도한 후, 실제 현금이 내 계좌로 정산되어 들어오기까지 걸리는 시간은?',
           JSON_OBJECT('choices', JSON_ARRAY('즉시', '영업일 기준 1일 뒤', '영업일 기준 2일 뒤', '영업일 기준 7일 뒤')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '오늘(D) 매매하면 모레(D+2)에 결제가 완료됩니다.'),
           NULL
       );

-- Q3. MATCH: 결제일의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS001', 'LV1_CH005_LS001_Q003', 'MATCH',
           '주식 거래가 체결된 날로부터 영업일 기준 2일 뒤, 실제로 돈과 주식이 교환되는 날을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('영업일', '결제일', '매매일', '입금일')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '결제일이 되어야 비로소 현금을 외부로 출금할 수 있습니다.'),
           NULL
       );

-- Q4. DRAG: 매도 후 현금화 과정
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS001', 'LV1_CH005_LS001_Q004', 'DRAG',
           '주식 매도 주문 → {{blank}} 완료 → 2영업일 대기 → {{blank}} 완료 및 출금 가능.',
           JSON_OBJECT('choices', JSON_ARRAY('체결', '결제', '정지', '취소')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '체결은 약속, 결제는 실제 돈의 이동입니다.'),
           NULL
       );

-- Q5. LINK: 날짜별 상태 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS001', 'LV1_CH005_LS001_Q005', 'LINK',
           '월요일에 주식을 팔았을 때(공휴일 없음) 날짜별 상태를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','월요일 (D)'),
                   JSON_OBJECT('id','L2','text','화요일 (D+1)'),
                   JSON_OBJECT('id','L3','text','수요일 (D+2)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','매매 체결일'),
                           JSON_OBJECT('id','R2','text','결제 진행 중'),
                           JSON_OBJECT('id','R3','text','결제 완료 및 출금 가능')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '중간에 주말이나 공휴일이 끼면 그만큼 결제일이 밀립니다.'),
           NULL
       );

-- Q1. CONCEPT: 영업일의 계산 (FAQ: 금요일에 팔았는데 왜 일요일에 돈이 안 들어오죠?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS002', 'LV1_CH005_LS002_Q001', 'CONCEPT',
           '결제 기간 계산 시 주의해야 할 "영업일"의 개념입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '금요일에 주식을 팔았어요. 그럼 토, 일 지났으니까 월요일 아침에 돈 찾을 수 있죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요, 틀렸어요! 토요일과 일요일은 "영업일"이 아니기 때문에 계산에서 빠져요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '금요일(D)에 팔았으면, 월요일(D+1)을 거쳐 화요일(D+2)에 돈이 들어옵니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아... 주말은 아무리 기다려도 결제일 카운트가 안 되는군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 공휴일이나 명절 연휴가 길면 돈을 찾는 데 일주일 넘게 걸릴 수도 있으니 미리 계획해야 해요.')
           ), NULL, NULL
       );

-- Q2. SELECT: 출금 가능 시점 계산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS002', 'LV1_CH005_LS002_Q002', 'SELECT',
           '목요일에 주식을 매도했습니다. 중간에 공휴일이 없다면 언제 현금을 인출할 수 있을까요?',
           JSON_OBJECT('choices', JSON_ARRAY('금요일', '토요일', '다음 주 월요일', '다음 주 화요일')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '목(D) -> 금(D+1) -> 주말 제외 -> 월(D+2) 입니다.'),
           NULL
       );

-- Q3. MATCH: 영업일의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS002', 'LV1_CH005_LS002_Q003', 'MATCH',
           '주식 시장이 열리고 금융 기관이 업무를 수행하는 날을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('달력일', '영업일', '공휴일', '정지일')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '주말과 공휴일은 영업일에 포함되지 않습니다.'),
           NULL
       );

-- Q4. DRAG: 현금 인출 계획
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS002', 'LV1_CH005_LS002_Q004', 'DRAG',
           '명절 연휴 직전에 돈이 필요하다면, 연휴 시작 {{blank}} 영업일 전에는 주식을 {{blank}} 해야 안전하게 현금을 찾을 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('2', '매도', '1', '매수')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '결제 시차를 고려하지 않으면 낭패를 볼 수 있습니다.'),
           NULL
       );

-- Q5. LINK: 상황별 출금 가능 여부
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS002', 'LV1_CH005_LS002_Q005', 'LINK',
           '매도 요일에 따른 실제 출금 가능 요일을 연결하세요 (공휴일 없음).',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','월요일 매도'),
                   JSON_OBJECT('id','L2','text','수요일 매도'),
                   JSON_OBJECT('id','L3','text','금요일 매도')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','수요일 출금 가능'),
                           JSON_OBJECT('id','R2','text','금요일 출금 가능'),
                           JSON_OBJECT('id','R3','text','다음 주 화요일 출금 가능')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '주말이 끼어있는 금요일 매매를 특히 주의해야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 증거금의 원리 (FAQ: 100만 원 있는데 왜 250만 원어치가 사지죠?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS003', 'LV1_CH005_LS003_Q001', 'CONCEPT',
           '주식을 살 때 필요한 "계약금"의 개념, 증거금을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '계좌에 100만 원뿐인데 200만 원어치 주문이 들어갔어요! 증권사가 선물 주는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '선물이 아니라 "증거금 제도" 때문이에요. 주식을 살 때 당장 전액이 필요한 게 아니라, 일종의 계약금만 먼저 받는 거죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '예를 들어 증거금률이 40%라면, 40만 원만 있어도 100만 원어치 주식을 주문할 수 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '오, 그럼 나머지 60만 원은 안 내도 되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요! 나머지 60만 원은 결제일(D+2)까지 반드시 계좌에 채워넣어야 해요. 안 그러면 "미수금"이 발생합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 증거금 100%의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS003', 'LV1_CH005_LS003_Q002', 'SELECT',
           '종목 정보에 "증거금 100%"라고 표시된 주식의 의미는?',
           JSON_OBJECT('choices', JSON_ARRAY('외상으로 살 수 있는 주식', '내가 가진 현금만큼만 살 수 있는 주식', '증권사가 돈을 빌려주는 주식', '수수료가 없는 주식')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '위험 종목이나 우량하지 않은 종목은 외상 거래가 불가능하도록 증거금을 100%로 설정합니다.'),
           NULL
       );

-- Q3. MATCH: 증거금률의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS003', 'LV1_CH005_LS003_Q003', 'MATCH',
           '주식을 주문할 때 필요한 최소한의 현금 비율을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('증거금률', '이자율', '세율', '할인율')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '종목마다 20%, 40%, 100% 등 증거금률이 다르게 정해져 있습니다.'),
           NULL
       );

-- Q4. DRAG: 증거금 계산 실습
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS003', 'LV1_CH005_LS003_Q004', 'DRAG',
           '증거금률 40%인 주식 100만 원어치를 주문하면, 오늘 당장은 {{blank}}만 빠져나가고, 나머지 60만 원은 {{blank}} 뒤에 결제됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('40만 원', '2영업일', '100만 원', '즉시')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '나머지 대금은 결제일에 맞춰 준비되어 있어야 합니다.'),
           NULL
       );

-- Q5. LINK: 계좌 설정 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS003', 'LV1_CH005_LS003_Q005', 'LINK',
           '자신의 투자 스타일에 맞는 계좌 설정을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','내 돈만큼만 안전하게 매매하고 싶을 때'),
                   JSON_OBJECT('id','L2','text','일시적으로 외상을 써서 더 많이 사고 싶을 때')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','증거금 100% 계좌 설정'),
                           JSON_OBJECT('id','R2','text','스펙트럼/미수 가능 계좌 설정')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '초보자는 미수금 사고 방지를 위해 증거금 100% 설정을 권장합니다.'),
           NULL
       );

-- Q1. CONCEPT: 미수금의 무서움 (FAQ: 돈이 모자라면 나중에 갚아도 되나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS004', 'LV1_CH005_LS004_Q001', 'CONCEPT',
           '증권사에서 빌린 외상값, 미수금을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '실수로 제 돈보다 주식을 더 많이 샀나 봐요. 계좌에 -60만 원이라고 적혀 있는데 어떡하죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 "미수금"이에요. 모레까지 60만 원을 입금하지 않으면 큰일 납니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '이자 조금 내고 천천히 갚으면 안 되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '안 돼요! 주식 시장은 아주 냉정해요. 결제일까지 돈을 안 갚으면, 그다음 날 아침에 증권사가 당신의 주식을 강제로 팔아서 돈을 회수해 가요.'),
                   JSON_OBJECT('sender', 'user', 'text', '헐... 제 허락도 없이 주식을 판다고요?')
           ), NULL, NULL
       );

-- Q2. SELECT: 미수금 해결 방법
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS004', 'LV1_CH005_LS004_Q002', 'SELECT',
           '발생한 미수금을 해결하기 위한 가장 올바른 방법은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('그냥 무시하고 기다린다', '결제일 장 마감 전까지 부족한 현금을 입금한다', '증권사에 전화를 걸어 사정한다', '앱을 삭제한다')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '현금을 직접 입금하거나, 결제일 전에 주식을 일부 팔아서 대금을 마련해야 합니다.'),
           NULL
       );

-- Q3. MATCH: 미수금의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS004', 'LV1_CH005_LS004_Q003', 'MATCH',
           '주식 대금을 제때 내지 못해 증권사에 갚아야 할 외상값을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('예수금', '미수금', '증거금', '보증금')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '미수금이 남으면 연 10%가 넘는 높은 연체 이자가 발생할 수 있습니다.'),
           NULL
       );

-- Q4. DRAG: 미수 동결 계좌
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS004', 'LV1_CH005_LS004_Q004', 'DRAG',
           '미수금을 갚지 못하면 한 달 동안 모든 증권사에서 미수 거래를 할 수 없는 {{blank}} 계좌로 지정되는 {{blank}}를 받게 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('미수 동결', '페널티', '우수', '혜택')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '한 번의 실수가 한 달간의 매매 제약으로 이어집니다.'),
           NULL
       );

-- Q5. LINK: 미수금 방지 행동 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS004', 'LV1_CH005_LS004_Q005', 'LINK',
           '미수금 발생을 막기 위한 행동을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','사전 예방'),
                   JSON_OBJECT('id','L2','text','주문 후 확인'),
                   JSON_OBJECT('id','L3','text','발생 시 조치')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','증거금 100% 계좌로 설정 변경'),
                           JSON_OBJECT('id','R2','text','실제 결제될 예정인 D+2 예수금 확인'),
                           JSON_OBJECT('id','R3','text','결제일 전날까지 부족한 현금 입금')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '내 돈의 상태를 수시로 체크하는 습관이 제일 중요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 반대매매의 실행 (FAQ: 왜 제 동의 없이 주식을 팔았죠?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS005', 'LV1_CH005_LS005_Q001', 'CONCEPT',
           '외상값을 갚지 않았을 때 벌어지는 강제 집행, 반대매매입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '아침 9시에 앱을 켰는데 제 주식이 멋대로 팔려버렸어요! 해킹당한 거 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '해킹이 아니라 "반대매매"예요. 미수금을 제때 안 갚으셔서 증권사가 강제로 판 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그래도 제가 비싸게 팔려고 기다리고 있었는데, 왜 이렇게 싼 가격에 팔린 거죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반대매매는 증권사가 돈을 회수하는 게 목적이라, 무조건 팔리도록 "하한가" 근처의 아주 낮은 가격으로 주문을 던져버려요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '결국 주주님은 주식도 잃고, 아주 큰 손해를 보게 된 거예요.')
           ), NULL, NULL
       );

-- Q2. SELECT: 반대매매가 일어나는 시점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS005', 'LV1_CH005_LS005_Q002', 'SELECT',
           '미수금을 결제일까지 갚지 못했을 때, 반대매매는 보통 언제 실행될까요?',
           JSON_OBJECT('choices', JSON_ARRAY('결제일 당일 오후', '결제일 다음 날 아침 9시', '일주일 뒤', '다음 달 1일')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '결제일(D+2) 다음 날 장이 열리자마자 시장가로 팔려나갑니다.'),
           NULL
       );

-- Q3. MATCH: 반대매매의 주문 가격
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS005', 'LV1_CH005_LS005_Q003', 'MATCH',
           '증권사는 반대매매 시 주식이 확실히 팔리도록 하기 위해 {{blank}} 가격으로 주문을 냅니다.',
           JSON_OBJECT('choices', JSON_ARRAY('상한가', '하한가', '시장가', '현재가')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '하한가로 주문을 내어 무조건 체결되게 만드므로 매도 가격이 매우 불리합니다.'),
           NULL
       );

-- Q4. DRAG: 반대매매의 피해
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS005', 'LV1_CH005_LS005_Q004', 'DRAG',
           '반대매매를 당하면 원치 않는 시점에 주식을 뺏길 뿐만 아니라, {{blank}} 손실과 높은 {{blank}}를 모두 부담해야 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('가격(매매)', '연체 이자', '배당', '수수료 면제')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '심리적 충격과 경제적 타격이 동시에 오는 최악의 상황입니다.'),
           NULL
       );

-- Q5. LINK: 미수 거래의 위험 요소 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH005_LS005', 'LV1_CH005_LS005_Q005', 'LINK',
           '미수 거래 시 겪을 수 있는 위험 상황을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','담보유지비율 하락'),
                   JSON_OBJECT('id','L2','text','결제 대금 부족'),
                   JSON_OBJECT('id','L3','text','하락장에서의 매매')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','마진콜(추가 담보 요구) 발생'),
                           JSON_OBJECT('id','R2','text','익일 아침 반대매매 실행'),
                           JSON_OBJECT('id','R3','text','내 돈보다 더 큰 폭의 원금 손실 발생')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '외상은 양날의 검입니다. 초보자는 반드시 피해야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 캔들의 구성 (FAQ: 왜 막대기 모양인가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS001', 'LV1_CH006_LS001_Q001', 'CONCEPT',
           '주가의 움직임을 담은 그릇, 캔들에 대해 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'mentor', 'text', '차트를 보면 위아래로 꼬리가 달린 막대기들이 가득하죠? 이걸 양초를 닮았다고 해서 "캔들"이라고 불러요.'),
                   JSON_OBJECT('sender', 'user', 'text', '막대기 하나에 정보가 여러 개 들어있다고 들었어요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요! 막대 하나에 "시작 가격(시가), 최고 가격(고가), 최저 가격(저가), 끝난 가격(종가)" 이렇게 네 가지 정보가 다 담겨 있죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '와, 그럼 막대 하나만 봐도 하루 동안 치열했던 싸움을 다 알 수 있겠네요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 캔들의 몸통은 시작과 끝을, 꼬리는 그날 찍었던 정점과 바닥을 의미합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 캔들의 구성 요소
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS001', 'LV1_CH006_LS001_Q002', 'SELECT',
           '캔들(봉)에서 시작가와 종가를 연결하여 두껍게 표시한 부분을 무엇이라 부를까요?',
           JSON_OBJECT('choices', JSON_ARRAY('꼬리', '몸통', '머리', '심지')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '시가와 종가 사이의 가격 범위를 몸통(Body)이라고 합니다.'),
           NULL
       );

-- Q3. MATCH: 꼬리의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS001', 'LV1_CH006_LS001_Q003', 'MATCH',
           '몸통 위아래로 삐져나온 선은 장중에 찍었던 최고가와 최저가를 나타내며, 이를 {{blank}}라고 부릅니다.',
           JSON_OBJECT('choices', JSON_ARRAY('그림자(꼬리)', '가이드라인', '추세선', '지지선')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '꼬리는 장중에 가격이 갔다가 되돌아온 흔적입니다.'),
           NULL
       );

-- Q4. DRAG: 4대 가격의 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS001', 'LV1_CH006_LS001_Q004', 'DRAG',
           '캔들을 구성하는 4대 가격은 {{blank}}, 고가, 저가, {{blank}} 입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('시가', '종가', '평균가', '현재가')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '이 네 가지 가격이 모여 하나의 캔들을 완성합니다.'),
           NULL
       );

-- Q5. LINK: 캔들 부위별 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS001', 'LV1_CH006_LS001_Q005', 'LINK',
           '캔들의 부위와 해당 가격의 의미를 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','윗꼬리의 끝'),
                   JSON_OBJECT('id','L2','text','아래꼬리의 끝'),
                   JSON_OBJECT('id','L3','text','몸통의 상단/하단')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','장중 최고가'),
                           JSON_OBJECT('id','R2','text','장중 최저가'),
                           JSON_OBJECT('id','R3','text','시가 혹은 종가')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '부위별 의미를 알아야 차트 해석이 가능해집니다.'),
           NULL
       );

-- Q1. CONCEPT: 양봉과 음봉 (FAQ: 왜 미국 주식은 색깔이 반대인가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS002', 'LV1_CH006_LS002_Q001', 'CONCEPT',
           '캔들의 색깔이 결정되는 원리를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '빨간색 캔들이 나오면 좋은 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네! 시작한 가격보다 끝난 가격이 높으면 빨간색 "양봉"이 생겨요. 매수세가 강했다는 뜻이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 파란색은 가격이 떨어진 거겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 시작가보다 낮게 끝나면 파란색 "음봉"이 됩니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '참고로 미국은 상승이 초록색, 하락이 빨간색이에요. 국가마다 약속이 조금 다르니 한국 시장에서는 빨간색(상승)을 기억하세요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 양봉의 조건
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS002', 'LV1_CH006_LS002_Q002', 'SELECT',
           '다음 중 빨간색 "양봉"이 만들어지는 조건은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('시가 > 종가', '시가 < 종가', '시가 = 종가', '고가 = 저가')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '종가가 시가보다 높게 마감되면 양봉이 생성됩니다.'),
           NULL
       );

-- Q3. MATCH: 음봉의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS002', 'LV1_CH006_LS002_Q003', 'MATCH',
           '장 시작 가격보다 주가가 떨어져서 마감하여 파란색으로 표시되는 캔들을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('양봉', '음봉', '도지', '망치형')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '음봉은 해당 기간 동안 매도세가 더 강했음을 보여줍니다.'),
           NULL
       );

-- Q4. DRAG: 캔들의 심리 해석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS002', 'LV1_CH006_LS002_Q004', 'DRAG',
           '몸통이 매우 긴 {{blank}}양봉은 강력한 매수 에너지를, 몸통이 긴 {{blank}}음봉은 강력한 매도 에너지를 상징합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('장대', '장대', '단순', '꼬리')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '몸통의 길이는 그만큼 한쪽 방향으로의 힘이 강했음을 의미합니다.'),
           NULL
       );

-- Q5. LINK: 색깔과 가격 관계 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS002', 'LV1_CH006_LS002_Q005', 'LINK',
           '캔들 종류와 가격 상태를 알맞게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','양봉 (Red)'),
                   JSON_OBJECT('id','L2','text','음봉 (Blue)'),
                   JSON_OBJECT('id','L3','text','십자형 (Doji)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','종가가 시가보다 높음'),
                           JSON_OBJECT('id','R2','text','종가가 시가보다 낮음'),
                           JSON_OBJECT('id','R3','text','시가와 종가가 거의 같음')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '캔들의 색깔만 봐도 누가 이겼는지 한눈에 알 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 거래량의 중요성 (FAQ: 주가만 보면 안 되나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS003', 'LV1_CH006_LS003_Q001', 'CONCEPT',
           '주가 변동의 "진짜" 신호를 찾는 법을 배워봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'mentor', 'text', '주가는 속임수를 쓸 수 있지만, 거래량은 속이기 힘들어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '거래량이 많다는 건 무슨 뜻인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그만큼 많은 돈이 오가며 치열하게 싸웠다는 증거죠. 주가가 오를 때 거래량이 터지면 "진짜 상승"일 확률이 높아요.'),
                   JSON_OBJECT('sender', 'user', 'text', '반대로 거래량 없이 조금씩 오르는 건 위험한가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, 관심을 못 받고 있다는 뜻이라 언제든 다시 무너질 수 있어요. 거래량은 주가의 "에너지"입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 거래량의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS003', 'LV1_CH006_LS003_Q002', 'SELECT',
           '특정 기간 동안 주식이 매매된 총 수량을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('시가총액', '예수금', '거래량', '자본금')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '거래량은 시장의 관심도를 나타내는 가장 정직한 지표입니다.'),
           NULL
       );

-- Q3. MATCH: 거래량 막대 색깔
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS003', 'LV1_CH006_LS003_Q003', 'MATCH',
           '일반적으로 거래량 막대가 어제보다 많으면 {{blank}}, 어제보다 적으면 파란색으로 표시됩니다. (설정에 따라 다를 수 있음)',
           JSON_OBJECT('choices', JSON_ARRAY('노란색', '빨간색', '검은색', '보라색')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '거래량의 색깔은 주가의 상승/하락보다는 "전일 대비 증가/감소"를 나타내는 경우가 많습니다.'),
           NULL
       );

-- Q4. DRAG: 주가와 거래량의 관계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS003', 'LV1_CH006_LS003_Q004', 'DRAG',
           '주가가 전고점을 돌파할 때 {{blank}}이 함께 늘어나야 신뢰도가 높고, 주가는 오르는데 거래량이 {{blank}}하면 하락 반전의 위험이 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('거래량', '감소', '시가총액', '증가')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '신뢰할 수 있는 상승에는 반드시 대량 거래가 동반되어야 합니다.'),
           NULL
       );

-- Q5. LINK: 거래량 상황별 해석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS003', 'LV1_CH006_LS003_Q005', 'LINK',
           '거래량 상황과 그에 대한 일반적인 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','바닥권에서 거래량 급증'),
                   JSON_OBJECT('id','L2','text','고점권에서 거래량 급증'),
                   JSON_OBJECT('id','L3','text','거래량 없는 하락')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','새로운 매수 세력의 진입 가능성'),
                           JSON_OBJECT('id','R2','text','보유자들의 이익 실현 및 탈출 가능성'),
                           JSON_OBJECT('id','R3','text','본격적인 매도보다는 소외된 상태')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '거래량의 변화는 주가 변화보다 먼저 나타나기도 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 이동평균선의 개념 (FAQ: 차트에 그려진 꼬불꼬불한 선들은 뭔가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS004', 'LV1_CH006_LS004_Q001', 'CONCEPT',
           '주가의 "평균치"를 연결한 선의 의미를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '차트에 캔들 말고도 빨강, 노랑, 초록 선들이 겹쳐져 있는데 이게 뭔가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 "이동평균선"이라고 해요. 예를 들어 "5일 이평선"은 최근 5일간의 주가를 평균 내서 점으로 찍고 선으로 이은 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '평균을 내면 뭐가 좋나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '매일의 잔파동을 무시하고 주가가 위로 가는지 아래로 가는지 큰 "흐름(추세)"을 한눈에 볼 수 있게 해줘요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '선이 위를 향하면 상승 추세, 아래를 향하면 하락 추세라고 봅니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 주요 이동평균선의 기간
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS004', 'LV1_CH006_LS004_Q002', 'SELECT',
           '일반적으로 주식 시장에서 일주일간의 심리를 나타내는 단기 이동평균선은 몇 일 선일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('5일선', '20일선', '60일선', '120일선')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '주말을 제외한 평일 5일이 일주일의 거래일이므로 5일선은 주간 추세를 뜻합니다.'),
           NULL
       );

-- Q3. MATCH: 이평선의 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS004', 'LV1_CH006_LS004_Q003', 'MATCH',
           '단기 이평선이 장기 이평선을 아래에서 위로 뚫고 올라가는 강력한 상승 신호를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('골든크로스', '데드크로스', '데드캣바운스', '박스권')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '최근 주가의 흐름이 좋아지고 있다는 아주 긍정적인 신호입니다.'),
           NULL
       );

-- Q4. DRAG: 정배열과 역배열
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS004', 'LV1_CH006_LS004_Q004', 'DRAG',
           '위에서부터 단기, 중기, 장기 이평선이 차례대로 놓인 상태를 {{blank}}이라 하며 전형적인 상승장을, 반대의 경우를 {{blank}}이라 하며 하락장을 의미합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('정배열', '역배열', '수평배열', '혼합배열')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '배열의 상태만 봐도 현재 시장이 대세 상승인지 하락인지 알 수 있습니다.'),
           NULL
       );

-- Q5. LINK: 이평선 기간별 성격 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS004', 'LV1_CH006_LS004_Q005', 'LINK',
           '이동평균선의 기간과 그 별명을 알맞게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','20일 이동평균선'),
                   JSON_OBJECT('id','L2','text','60일 이동평균선'),
                   JSON_OBJECT('id','L3','text','120일 이동평균선')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','심리선 (한 달의 흐름)'),
                           JSON_OBJECT('id','R2','text','수급선 (분기 실적의 흐름)'),
                           JSON_OBJECT('id','R3','text','경기선 (반년의 흐름)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '각 이평선은 투자자들의 다양한 호흡을 나타냅니다.'),
           NULL
       );

-- Q1. CONCEPT: 주기 설정 (FAQ: 일봉, 주봉, 분봉이 뭔가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS005', 'LV1_CH006_LS005_Q001', 'CONCEPT',
           '시간의 돋보기를 조절하는 법을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '어제는 올랐는데 한 달 전보다는 떨어졌어요. 뭘 봐야 하죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '차트 상단의 "일/주/월/분" 버튼을 활용해 보세요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '"일봉"은 하루를 캔들 하나에 담고, "주봉"은 일주일의 흐름을 캔들 하나에 담아요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 그럼 단타를 할 때는 분봉을 보고, 길게 투자할 때는 주봉이나 월봉을 보면 되겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 내가 얼마나 오래 투자할지에 따라 차트의 주기를 바꿔보는 게 중요합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 단기 매매에 적합한 차트
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS005', 'LV1_CH006_LS005_Q002', 'SELECT',
           '오늘 하루 동안의 주가 움직임을 아주 세밀하게 관찰하여 단기 매매를 하고 싶을 때 가장 적합한 차트는?',
           JSON_OBJECT('choices', JSON_ARRAY('년봉 차트', '월봉 차트', '주봉 차트', '분봉 차트')),
           JSON_OBJECT('correct', JSON_ARRAY(3), 'explanation', '분봉(1분, 3분, 5분 등)은 장중의 미세한 움직임을 보여줍니다.'),
           NULL
       );

-- Q3. MATCH: 보조지표 추가
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS005', 'LV1_CH006_LS005_Q003', 'MATCH',
           '차트에 거래량이나 이평선 외에 RSI, MACD 같은 수학적 지표를 추가하는 메뉴를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('관심종목', '보조지표', '현재가', '주문내역')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '보조지표는 주가 데이터를 가공하여 매수/매도 타이밍을 잡는 데 도움을 줍니다.'),
           NULL
       );

-- Q4. DRAG: 차트 설정 순서
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS005', 'LV1_CH006_LS005_Q004', 'DRAG',
           '차트 최적화: 투자 주기(일/주/분) 선택 → 지표 설정에서 {{blank}} 추가 → 보기 편한 {{blank}}로 조정 순으로 진행합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('이동평균선', '색상/굵기', '자동주문', '뉴스알림')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '나만의 차트 환경을 만드는 것이 분석의 첫걸음입니다.'),
           NULL
       );

-- Q5. LINK: 주기와 용도 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH006_LS005', 'LV1_CH006_LS005_Q005', 'LINK',
           '차트의 주기와 가장 잘 어울리는 투자 스타일을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','분봉 차트'),
                   JSON_OBJECT('id','L2','text','일봉 차트'),
                   JSON_OBJECT('id','L3','text','월봉 차트')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','스캘핑, 데이트레이딩 (초단기 매매)'),
                           JSON_OBJECT('id','R2','text','스윙 투자 (며칠에서 몇 주 보유)'),
                           JSON_OBJECT('id','R3','text','가치 투자, 적립식 투자 (수년 장기 보유)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '멀리 보려면 큰 차트를, 자세히 보려면 작은 차트를 보세요.'),
           NULL
       );

-- Q1. CONCEPT: 가격제한폭 (FAQ: 하루에 반토막이 날 수도 있나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS001', 'LV1_CH007_LS001_Q001', 'CONCEPT',
           '주가가 하루에 움직일 수 있는 범위가 정해져 있습니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '제가 산 주식이 오늘 -50%가 될 수도 있나요? 너무 무서워요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '걱정 마세요. 한국 주식 시장에는 "상/하한가 제도"라는 울타리가 있어요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '전일 종가를 기준으로 위아래로 딱 30%까지만 움직일 수 있도록 법으로 정해두었죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 아무리 떨어져도 하루에 -30% 밑으로는 안 내려가는 거군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 투자자들이 너무 큰 충격을 받지 않도록 보호하는 최소한의 안전장치입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 상한가 비율
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS001', 'LV1_CH007_LS001_Q002', 'SELECT',
           '현재 대한민국 주식 시장(코스피/코스닥)의 하루 최대 가격제한폭은 전일 종가 대비 몇 %일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('15%', '30%', '50%', '제한 없음')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '2015년부터 가격제한폭이 ±30%로 확대되어 유지되고 있습니다.'),
           NULL
       );

-- Q3. MATCH: 하한가의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS001', 'LV1_CH007_LS001_Q003', 'MATCH',
           '주가가 하루 동안 내려갈 수 있는 최저 가격인 -30%에 도달한 상태를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('상한가', '하한가', '보합', '공모가')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '하한가에 도달하면 그 이하 가격으로는 팔 수 없습니다.'),
           NULL
       );

-- Q4. DRAG: 상한가 잔량의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS001', 'LV1_CH007_LS001_Q004', 'DRAG',
           '주가가 {{blank}}에 도달했는데도 사려는 주문(매수 잔량)이 엄청나게 쌓여 있다면, 다음 날 주가가 추가로 {{blank}} 가능성이 높습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('상한가', '상승할', '하한가', '하락할')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '상한가 잔량은 해당 종목의 매수 에너지가 얼마나 강한지 보여줍니다.'),
           NULL
       );

-- Q5. LINK: 가격 상황 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS001', 'LV1_CH007_LS001_Q005', 'LINK',
           '어제 종가가 10,000원인 주식의 오늘 가격 한계를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','상한가 (+30%)'),
                   JSON_OBJECT('id','L2','text','하한가 (-30%)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','13,000원'),
                           JSON_OBJECT('id','R2','text','7,000원')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '가격제한폭 계산법을 알면 오늘 최대 손실과 이익을 가늠할 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: VI의 목적 (FAQ: 호가창이 갑자기 멈추고 주문이 안 돼요!)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS002', 'LV1_CH007_LS002_Q001', 'CONCEPT',
           '개별 종목의 과열을 식혀주는 냉각기, VI를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '제가 보던 주식이 갑자기 2분 동안 거래가 안 되고 멈춰버렸어요! 큰일 난 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요, 정상적인 과정이에요. 주가가 너무 짧은 시간에 급변하면 거래소가 "잠깐 진정하세요"라며 거래를 멈추는 거예요. 이걸 "VI"라고 하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '왜 멈추는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '투자자들이 너무 흥분해서 묻지마 매수를 하거나 공포에 질려 던지는 걸 막기 위해서예요. 2~3분간 단일가 매매로 진행하며 마음을 가다듬을 시간을 주는 거죠.')
           ), NULL, NULL
       );

-- Q2. SELECT: VI 발동 시 매매 방식
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH002_LS002', 'LV1_CH007_LS002_Q002', 'SELECT',
           'VI(변동성 완화 장치)가 발동된 약 2분 동안 주문은 어떤 방식으로 처리될까요?',
           JSON_OBJECT('choices', JSON_ARRAY('실시간 즉시 체결', '주문을 모았다가 한꺼번에 체결(단일가)', '모든 주문 자동 취소', '거래소 직원 승인 후 체결')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', 'VI 발동 중에는 동시호가처럼 주문을 모아 하나의 가격으로 체결시킵니다.'),
           NULL
       );

-- Q3. MATCH: VI의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS002', 'LV1_CH007_LS002_Q003', 'MATCH',
           '주가가 직전 체결가나 시가 대비 일정 비율 이상 급변할 때 발동되는 장치를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('VI', '증거금', '상장폐지', '공시')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'Volatility Interruption의 약자로, 변동성을 잠시 차단한다는 뜻입니다.'),
           NULL
       );

-- Q4. DRAG: VI의 종류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS002', 'LV1_CH007_LS002_Q004', 'DRAG',
           '순간적인 가격 급변을 막는 것을 {{blank}} VI, 장 시작 전과 대비해 큰 변화가 있을 때 발동하는 것을 {{blank}} VI라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('동적', '정적', '능동', '수동')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '주가 변동의 폭과 기준에 따라 두 종류로 나뉩니다.'),
           NULL
       );

-- Q5. LINK: 상황별 대응 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS002', 'LV1_CH007_LS002_Q005', 'LINK',
           'VI 발동 상황에 따른 올바른 태도를 연결하세요.',
           JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','VI가 상승 방향으로 발동'),
                   JSON_OBJECT('id','L2','text','VI가 하락 방향으로 발동')
           ),
           JSON_OBJECT('right', JSON_ARRAY(
                   JSON_OBJECT('id','R1','text','추격 매수보다는 고점 돌파 여부를 차분히 관찰'),
                   JSON_OBJECT('id','R2','text','패닉 셀(투매)보다는 하락 원인을 파악하며 대기')
                                )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', 'VI는 생각할 시간을 벌어주는 도구로 활용해야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 서킷 브레이커 (FAQ: 시장이 끝났나요? 왜 다 멈췄죠?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS003', 'LV1_CH007_LS003_Q001', 'CONCEPT',
           '시장 전체의 폭락을 막기 위한 최후의 보루입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '모든 주식이 파란색이고 아무것도 거래가 안 돼요! 국가 부도인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아주 이례적인 폭락장이 오면 "서킷 브레이커"가 발동돼요. 시장 전체를 20분 동안 아예 꺼버리는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '전기 차단기(Circuit Breaker) 같은 거네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요! 시장 전체가 공포에 질려 이성을 잃었을 때, 강제로 휴식 시간을 주는 거예요. 일상적으로 보기는 힘들지만, 큰 경제 위기 때 나타납니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 서킷 브레이커 발동 기준(1단계)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS003', 'LV1_CH007_LS003_Q002', 'SELECT',
           '지수가 전일 종가보다 몇 % 이상 하락하여 1분간 지속될 때 서킷 브레이커 1단계가 발동될까요?',
           JSON_OBJECT('choices', JSON_ARRAY('5%', '8%', '15%', '20%')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '종합주가지수가 8% 이상 폭락하면 1단계 서킷 브레이커가 작동합니다.'),
           NULL
       );

-- Q3. MATCH: 사이드카의 성격
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS003', 'LV1_CH007_LS003_Q003', 'MATCH',
           '선물 시장의 급변이 현물 시장에 영향을 주지 않도록 프로그램 매매를 잠시 제한하는 것을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('사이드카', '세이프티카', '백카', '가드레일')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '서킷 브레이커보다는 자주 발동되며, 5분간 프로그램 매매를 제한합니다.'),
           NULL
       );

-- Q4. DRAG: 시장 정지 후 재개
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS003', 'LV1_CH007_LS003_Q004', 'DRAG',
           '서킷 브레이커가 발동되면 20분간 거래가 {{blank}}되고, 이후 10분간 {{blank}} 매매를 거쳐 거래가 재개됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('중단', '단일가(동시호가)', '진행', '실시간')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '재개 시에도 가격 안정을 위해 단일가 방식을 거칩니다.'),
           NULL
       );

-- Q5. LINK: 제도와 역할 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS003', 'LV1_CH007_LS003_Q005', 'LINK',
           '안전장치와 그 성격을 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','VI'),
                   JSON_OBJECT('id','L2','text','사이드카'),
                   JSON_OBJECT('id','L3','text','서킷 브레이커')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','개별 종목의 급변을 방어'),
                           JSON_OBJECT('id','R2','text','선물 시장 과열에 따른 현물 시장 보호'),
                           JSON_OBJECT('id','R3','text','시장 전체 폭락 시 거래 전면 중단')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '시장의 중첩된 보호 장치들이 투자자를 보호하고 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 분할 매수의 이유 (FAQ: 한 번에 다 사면 안 되나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS004', 'LV1_CH007_LS004_Q001', 'CONCEPT',
           '손실 위험을 줄이는 가장 쉬운 마법, 분할 매수입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '이 주식 지금 당장 다 사고 싶어요! 내일 오르면 어떡해요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반대로 내일 떨어지면요? 그때는 더 살 돈이 없어서 구경만 해야 하잖아요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '자금을 3~4번으로 나누어 사보세요. 가격이 내려갈 때 추가로 사면 나의 평균 매수 단가(평단가)가 낮아져서 나중에 수익 내기가 훨씬 쉬워져요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 내 돈을 한 번에 다 걸지 않는 게 내 마음의 평화와 지갑을 동시에 지키는 거군요!')
           ), NULL, NULL
       );

-- Q2. SELECT: 분할 매수의 장점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS004', 'LV1_CH007_LS004_Q002', 'SELECT',
           '분할 매수를 통해 얻을 수 있는 가장 큰 이점은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('수수료가 전혀 안 든다', '평균 매수 단가를 낮추고 심리적 안정을 얻는다', '무조건 수익이 보장된다', '주식 개수가 더 많아진다')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '진입 가격을 분산함으로써 주가 하락 시의 리스크를 방어할 수 있습니다.'),
           NULL
       );

-- Q3. MATCH: 물타기 vs 분할 매수
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS004', 'LV1_CH007_LS004_Q003', 'MATCH',
           '계획 없이 하락할 때마다 무작정 사는 것은 물타기라고 하며, 미리 정한 기준에 따라 나누어 사는 것을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('몰빵', '분할 매수', '상따', '하따')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '계획이 있느냐 없느냐가 투기꾼과 투자자를 가릅니다.'),
           NULL
       );

-- Q4. DRAG: 매수 시점의 분산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS004', 'LV1_CH007_LS004_Q004', 'DRAG',
           '분할 매수는 {{blank}}을 나누는 것만큼이나 {{blank}}을 나누는 것도 중요합니다. 하루에 다 사는 것이 아니라 며칠에 걸쳐 사는 것이죠.',
           JSON_OBJECT('choices', JSON_ARRAY('금액', '시간', '종목', '인원')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '시간의 분산은 변동성을 이기는 가장 좋은 방법입니다.'),
           NULL
       );

-- Q5. LINK: 매수 전략 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS004', 'LV1_CH007_LS004_Q005', 'LINK',
           '매수 방식에 따른 특징을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','일괄 매수 (몰빵)'),
                   JSON_OBJECT('id','L2','text','분할 매수')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','예측이 빗나갈 경우 큰 손실과 패닉 가능성'),
                           JSON_OBJECT('id','R2','text','주가 등락에 유연한 대처와 안정적 대응 가능')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '초보자일수록 분할 매수를 생활화해야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 분할 매도의 중요성 (FAQ: 팔고 나서 더 오를까 봐 못 팔겠어요!)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS005', 'LV1_CH007_LS005_Q001', 'CONCEPT',
           '수익을 확정 짓는 용기, 분할 매도입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '수익 중인데 더 오를 것 같아서 못 팔겠어요. 근데 또 떨어질까 봐 무섭기도 하고요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럴 땐 반만 팔아보세요! 수익을 일부 챙겨두면(익절), 나중에 더 올라도 남은 절반이 있어 기쁘고, 떨어져도 이미 수익을 냈으니 마음이 편하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 매수뿐만 아니라 매도도 나누어서 하면 제 감정을 다스리기가 훨씬 쉽겠네요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 주식은 머리가 아니라 무릎에서 사서 어깨에서 팔라는 말처럼, 한꺼번에 꼭대기를 맞추려는 욕심을 버리는 게 핵심입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 손절(Stop-Loss)의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS005', 'LV1_CH007_LS005_Q002', 'SELECT',
           '주가가 예상과 다르게 하락할 때, 더 큰 손실을 막기 위해 주식을 파는 것을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('익절', '손절', '추매', '방치')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '손절은 자산을 지키기 위한 아프지만 필수적인 결단입니다.'),
           NULL
       );

-- Q3. MATCH: 익절의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS005', 'LV1_CH007_LS005_Q003', 'MATCH',
           '매수한 주식이 올라서 이익이 났을 때, 주식을 팔아 실제 현금으로 수익을 확정하는 것을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('익절', '손절', '공매도', '유상증자')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '팔기 전까지의 수익은 "사이버 머니"일 뿐, 익절을 해야 내 돈이 됩니다.'),
           NULL
       );

-- Q4. DRAG: 매도 전략의 수립
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS005', 'LV1_CH007_LS005_Q004', 'DRAG',
           '성공적인 투자자는 주식을 사기 전에 이미 어느 정도 수익이 나면 팔겠다는 {{blank}}가와, 어디까지 떨어지면 팔겠다는 {{blank}}가를 미리 정해둡니다.',
           JSON_OBJECT('choices', JSON_ARRAY('목표', '손절', '시가', '상한')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '계획 없는 매도는 감정에 휘둘리기 쉽습니다.'),
           NULL
       );

-- Q5. LINK: 매도 심리 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH007_LS005', 'LV1_CH007_LS005_Q005', 'LINK',
           '매도 시 겪는 감정과 올바른 대처법을 연결하세요.',
           JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','수익 시: 더 벌고 싶은 욕심'),
                   JSON_OBJECT('id','L2','text','하락 시: 본전 찾고 싶은 미련')
           ),
           JSON_OBJECT('right', JSON_ARRAY(
                   JSON_OBJECT('id','R1','text','분할 매도로 수익을 차곡차곡 챙기기'),
                   JSON_OBJECT('id','R2','text','냉정하게 손절 원칙을 지켜 원금 보호하기')
                                )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '주식은 기술보다 심리 싸움입니다.'),
           NULL
       );

-- Q1. CONCEPT: 선반영 (FAQ: 호재 뉴스가 떴는데 왜 주가는 하락하죠?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS001', 'LV1_CH008_LS001_Q001', 'CONCEPT',
           '뉴스와 주가의 시차를 이해해 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님! 제가 산 회사가 대박 계약을 맺었다는 뉴스가 방금 떴어요! 이제 상한가 가겠죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '글쎄요, 차트를 한번 보세요. 이미 며칠 전부터 주가가 많이 올라있지 않나요?'),
                   JSON_OBJECT('sender', 'user', 'text', '어? 그러네요. 뉴스는 지금 나왔는데 주가는 3일 전부터 계속 올랐어요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 "선반영"이에요. 정보가 빠른 사람들은 이미 알고 미리 샀다는 뜻이죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '뉴스가 터지는 순간은 오히려 그들이 주식을 팔아 이익을 챙기는 시점이 될 수 있으니 주의해야 해요.')
           ), NULL, NULL
       );

-- Q2. SELECT: 선반영의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS001', 'LV1_CH008_LS001_Q002', 'SELECT',
           '어떤 호재나 악재의 내용이 공식 발표 전에 이미 주가에 수치로 반영되어 있는 현상을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('역반영', '선반영', '후반영', '무반영')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '시장은 미래의 기대치를 미리 반영하는 속성이 있습니다.'),
           NULL
       );

-- Q3. MATCH: 정보의 유통 기한
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS001', 'LV1_CH008_LS001_Q003', 'MATCH',
           '개미 투자자가 스마트폰 뉴스로 접하는 정보는 이미 시장에서 {{blank}} 되었을 가능성이 매우 높습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('선반영', '은폐', '삭제', '무시')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '내가 아는 정보는 이미 모두가 아는 정보일 수 있음을 명심해야 합니다.'),
           NULL
       );

-- Q4. DRAG: 매수 시점의 교훈
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS001', 'LV1_CH008_LS001_Q004', 'DRAG',
           '주식 격언 중에 "{{blank}}에 사서 {{blank}}에 팔아라"라는 말은 정보의 선반영 특성을 잘 나타냅니다.',
           JSON_ARRAY('소문', '뉴스', '공포', '환희'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '기대감이 있을 때 사고, 사실이 확인될 때 파는 전략입니다.'),
           NULL
       );

-- Q5. LINK: 상황별 주가 움직임 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS001', 'LV1_CH008_LS001_Q005', 'LINK',
           '뉴스와 주가의 관계를 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','이미 많이 오른 상태에서 호재 뉴스'),
                   JSON_OBJECT('id','L2','text','이미 많이 떨어진 상태에서 악재 뉴스')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','재료 소멸로 인한 주가 하락 가능성'),
                           JSON_OBJECT('id','R2','text','악재 해소로 인한 주가 반등 가능성')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '주가는 정보의 내용뿐만 아니라 현재 위치가 중요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 재료 소멸 (FAQ: 실적이 역대급이라는데 왜 떨어져요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS002', 'LV1_CH008_LS002_Q001', 'CONCEPT',
           '기대감이 현실이 되는 순간 일어나는 일입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '실적 발표날인데 실적이 정말 좋게 나왔어요! 근데 주가는 왜 5%나 빠지죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 실적에 대한 기대 때문에 그동안 주가가 올랐던 거예요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이제 발표가 났으니 더 이상 기대할 "재료"가 없어진 거죠. 이걸 "재료 소멸"이라고 해요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 이제 더 이상 궁금할 게 없으니 사람들이 팔고 나가는 거군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 주식은 미래를 먹고 사는데, 미래가 현재가 되어버리면 매력이 떨어지는 법이죠.')
           ), NULL, NULL
       );

-- Q2. SELECT: 재료 소멸의 전형적인 사례
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS002', 'LV1_CH008_LS002_Q002', 'SELECT',
           '다음 중 재료 소멸로 인한 주가 하락이 나타나기 쉬운 시점은?',
           JSON_OBJECT('choices', JSON_ARRAY('임상 시험 성공 소문이 돌 때', '신제품 출시 당일 발표 직후', '회사가 적자라는 뉴스가 처음 떴을 때', '갑작스러운 경영권 분쟁 발생 시')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '기대하던 이벤트가 실제로 일어나는 순간이 종종 고점이 됩니다.'),
           NULL
       );

-- Q3. MATCH: 기대감의 소멸
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS002', 'LV1_CH008_LS002_Q003', 'MATCH',
           '투자자들이 기대하던 호재가 공식적으로 확인되어 더 이상 주가를 끌어올릴 힘이 없어지는 현상을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('재료 소멸', '상장 폐지', '액면 분할', '배당 낙')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '재료가 살아있는지, 이미 수명이 다했는지 판단하는 것이 중요합니다.'),
           NULL
       );

-- Q4. DRAG: 매도 심리 변화
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS002', 'LV1_CH008_LS002_Q004', 'DRAG',
           '호재 발표 직후에는 {{blank}}을 실현하려는 매도 물량이 쏟아지기 때문에 주가가 {{blank}}할 위험이 큽니다.',
           JSON_ARRAY('이익', '하락', '손실', '상승'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '발표를 기다렸다가 팔려는 사람들이 많기 때문입니다.'),
           NULL
       );

-- Q5. LINK: 정보 단계별 투자자 심리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS002', 'LV1_CH008_LS002_Q005', 'LINK',
           '정보의 단계에 따른 시장의 일반적인 심리를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','소문 단계'),
                   JSON_OBJECT('id','L2','text','공식 뉴스 보도 단계'),
                   JSON_OBJECT('id','L3','text','뉴스 보도 이후')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','기대감으로 인한 주가 상승'),
                           JSON_OBJECT('id','R2','text','사실 확인 및 차익 실현 고민'),
                           JSON_OBJECT('id','R3','text','관심 저하 및 가격 조정')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '정보의 생애 주기를 이해하면 고점에 물리는 일을 피할 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 공시의 중요성 (FAQ: 뉴스가 맞는지 어떻게 확인하죠?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS003', 'LV1_CH008_LS003_Q001', 'CONCEPT',
           '기업의 공식 발표 채널, DART를 소개합니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '뉴스가 너무 많아서 뭐가 진짜인지 모르겠어요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럴 땐 기업이 직접 올리는 "공시"를 확인해야 해요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '금융감독원의 전자공시 시스템(DART)은 기업이 법적으로 꼭 알려야 할 정보를 공적으로 올리는 곳이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '뉴스는 기자가 쓰지만, 공시는 회사가 직접 책임지고 쓰는 거네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 가장 정확하고 신뢰할 수 있는 사실 확인 창구입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: DART의 정식 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS003', 'LV1_CH008_LS003_Q002', 'SELECT',
           '대한민국 모든 상장사의 경영 정보를 투명하게 공개하는 전자공시 시스템의 약칭은?',
           JSON_OBJECT('choices', JSON_ARRAY('DART', 'CART', 'MART', 'START')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'DART(Data Analysis, Retrieval and Transfer System)는 투자자의 필수 도구입니다.'),
           NULL
       );

-- Q3. MATCH: 사업보고서의 주기
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS003', 'LV1_CH008_LS003_Q003', 'MATCH',
           '상장사는 1년에 한 번 경영 성과를 총망라한 {{blank}}를 반드시 공시해야 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('사업보고서', '일일보고서', '주간일기', '반성문')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '사업보고서에는 회사의 비즈니스 모델, 재무, 주주 현황 등이 상세히 담겨 있습니다.'),
           NULL
       );

-- Q4. DRAG: 정보의 신뢰도 비교
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS003', 'LV1_CH008_LS003_Q004', 'DRAG',
           '{{blank}}는 기자의 주관이나 과장이 섞일 수 있지만, {{blank}}는 허위로 작성할 경우 법적 처벌을 받는 강력한 오피셜 정보입니다.',
           JSON_ARRAY('뉴스 기사', '전자공시', '유튜브', '커뮤니티'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '정보의 소스를 항상 확인하는 습관을 가져야 합니다.'),
           NULL
       );

-- Q5. LINK: 공시 확인 용도 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS003', 'LV1_CH008_LS003_Q005', 'LINK',
           '궁금한 점에 따른 DART 메뉴를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','이 회사가 작년에 돈을 얼마나 벌었을까?'),
                   JSON_OBJECT('id','L2','text','최근에 큰 계약을 딴 게 진짜일까?'),
                   JSON_OBJECT('id','L3','text','대주주가 주식을 팔았을까?')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','사업보고서(재무제표)'),
                           JSON_OBJECT('id','R2','text','단일판매·공급계약체결 공시'),
                           JSON_OBJECT('id','R3','text','최대주주 등 소유주식 변동신고서')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', 'DART를 활용하면 정보의 질이 달라집니다.'),
           NULL
       );

-- Q1. CONCEPT: 유상증자의 양면성 (FAQ: 주식을 더 발행한다는데 좋은 건가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS004', 'LV1_CH008_LS004_Q001', 'CONCEPT',
           '공시 중에서 가장 헷갈리는 "유상증자"를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님! 제가 가진 회사가 "유상증자"를 한대요. 돈을 더 모으는 거니까 좋은 거 맞죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 돈을 "어디에" 쓰느냐에 따라 천지 차이예요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '공장에 투자해서 돈을 더 벌려고 하는 증자는 호재일 수 있지만, 빚을 갚거나 월급 주려고 하는 증자는 큰 악재예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 무조건 돈이 들어온다고 좋아하는 게 아니었군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, 그리고 주식 수가 늘어나서 기존 주주들의 지분 가치가 희석된다는 점도 꼭 고려해야 합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 대표적인 호재 공시
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS004', 'LV1_CH008_LS004_Q002', 'SELECT',
           '다음 중 일반적으로 시장에서 강력한 호재로 받아들여지는 공시는?',
           JSON_OBJECT('choices', JSON_ARRAY('전환사채 발행', '자사주 소각', '최대주주 변경', '영업정지')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '회사가 자기 주식을 사서 없애버리는 "자사주 소각"은 주식의 가치를 높여주는 최고의 호재 중 하나입니다.'),
           NULL
       );

-- Q3. MATCH: 불성실 공시법인
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS004', 'LV1_CH008_LS004_Q003', 'MATCH',
           '공시 내용을 번복하거나 거짓으로 알려 시장에 혼란을 준 기업을 {{blank}} 법인이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('모범', '불성실 공시', '우량', '장기 미상장')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '이런 기업은 신뢰도가 낮아 투자를 피하는 것이 좋습니다.'),
           NULL
       );

-- Q4. DRAG: 공시 용어와 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS004', 'LV1_CH008_LS004_Q004', 'DRAG',
           '돈을 빌려주는 공시인 {{blank}}은 리스크가 크고, 회사의 이익을 나눠주는 {{blank}} 공시는 주주 친화적인 호재입니다.',
           JSON_ARRAY('채무 보증', '배당 결정', '증자', '감자'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '회사가 돈을 어떻게 쓰는지 감시하는 것이 공시 확인의 목적입니다.'),
           NULL
       );

-- Q5. LINK: 공시 제목별 성격 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS004', 'LV1_CH008_LS004_Q005', 'LINK',
           '공시 제목과 일반적인 시장 반응을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','단일판매·공급계약 체결'),
                   JSON_OBJECT('id','L2','text','횡령·배임 혐의 발생'),
                   JSON_OBJECT('id','L3','text','무상증자 결정')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','매출 증가 기대감 (호재)'),
                           JSON_OBJECT('id','R2','text','신뢰도 추락 및 거래 정지 위기 (악재)'),
                           JSON_OBJECT('id','R3','text','주주 가치 제고 및 유동성 공급 (호재)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '제목만 보고도 긴급 상황을 판단할 수 있어야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 지라시의 함정 (FAQ: 텔레그램에 뜬 정보인데 진짜겠죠?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS005', 'LV1_CH008_LS005_Q001', 'CONCEPT',
           '떠도는 소문에 휘둘리지 않는 법을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님! 단톡방에서 이 종목 삼성에 인수된다는 소문이 돌아요. 지금 안 사면 늦겠죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '잠시만요! 그 소문의 근거가 어디인가요? 뉴스나 공시가 있나요?'),
                   JSON_OBJECT('sender', 'user', 'text', '아니요, 그냥 "내부자 피셜"이래요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주식 시장에서 소위 말하는 "지라시"는 개미들을 유인해서 비싼 가격에 주식을 넘기려는 작전일 때가 많아요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '확인되지 않은 정보에 내 소중한 돈을 거는 건 투자가 아니라 도박입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 지라시를 받았을 때 행동
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS005', 'LV1_CH008_LS005_Q002', 'SELECT',
           '인터넷 게시판이나 메신저를 통해 확인되지 않은 소문을 들었을 때 가장 현명한 대처는?',
           JSON_OBJECT('choices', JSON_ARRAY('전 재산을 바로 매수한다', '가족과 친구들에게 공유한다', 'DART나 공식 뉴스를 통해 사실 여부를 확인한다', '소문이 사실이라고 믿고 기도한다')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '사실 관계가 증명되지 않은 정보는 무시하는 것이 자산을 지키는 길입니다.'),
           NULL
       );

-- Q3. MATCH: 풍문 또는 보도에 대한 해명
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS005', 'LV1_CH008_LS005_Q003', 'MATCH',
           '지라시나 오보가 퍼졌을 때 거래소가 기업에 사실 여부를 묻고, 기업이 답하는 공시를 {{blank}} 공시라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('자발적', '조회공시', '의무', '비밀')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '조회공시 답변을 통해 "사실무근"인지 "검토 중"인지 공식 입장을 알 수 있습니다.'),
           NULL
       );

-- Q4. DRAG: 가짜 뉴스 판별법
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS005', 'LV1_CH008_LS005_Q004', 'DRAG',
           '진짜 정보는 {{blank}}을 바탕으로 논리적이지만, 가짜 정보는 {{blank}}을 자극하며 당장 사지 않으면 큰일 날 것처럼 유혹합니다.',
           JSON_ARRAY('근거와 팩트', '공포와 탐욕', '차트', '거래량'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '심리적으로 조급함을 만드는 정보는 의심부터 해야 합니다.'),
           NULL
       );

-- Q5. LINK: 정보 소스별 신뢰도 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH008_LS005', 'LV1_CH008_LS005_Q005', 'LINK',
           '정보가 나오는 곳과 신뢰 수준을 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','금융감독원 DART'),
                   JSON_OBJECT('id','L2','text','메이저 경제 신문 뉴스'),
                   JSON_OBJECT('id','L3','text','정체불명의 텔레그램/단톡방')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','최상 (법적 책임이 있는 공식 정보)'),
                           JSON_OBJECT('id','R2','text','상 (사실 위주의 취재 정보)'),
                           JSON_OBJECT('id','R3','text','하 (의도를 가진 왜곡 가능성 농후)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '신뢰할 수 있는 소스에서만 정보를 얻는 습관이 필요합니다.'),
           NULL
       );

-- Q1. CONCEPT: 액면분할의 원리 (FAQ: 주가가 1/10이 됐어요! 망한 건가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS001', 'LV1_CH009_LS001_Q001', 'CONCEPT',
           '주식의 숫자를 조절하는 액면분할을 이해해 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님! 50만 원 하던 주식이 오늘 갑자기 5만 원이 됐어요. 제 돈 다 날아간 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '진정하세요! 그건 회사가 "액면분할"을 해서 그래요. 피자 한 판을 10조각으로 나눈 것과 같죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '조각을 내면 뭐가 달라지나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '한 조각의 크기(가격)는 작아지지만, 대신 당신이 가진 조각 수(주식 수)가 10배로 늘어났을 거예요. 전체 피자의 양(자산 가치)은 그대로랍니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '오히려 가격이 싸 보여서 더 많은 사람이 사게 되는 효과가 있죠.')
           ), NULL, NULL
       );

-- Q2. SELECT: 액면분할의 목적
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS001', 'LV1_CH009_LS001_Q002', 'SELECT',
           '기업이 너무 비싸진 주식 가격을 낮추어 거래를 활발하게 만들기 위해 실시하는 것은?',
           JSON_OBJECT('choices', JSON_ARRAY('액면분할', '액면병합', '유상감자', '자발적 상장폐지')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '액면분할을 하면 소액 투자자들도 쉽게 주식을 살 수 있어 거래가 활발해집니다.'),
           NULL
       );

-- Q3. MATCH: 액면병합의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS001', 'LV1_CH009_LS001_Q003', 'MATCH',
           '너무 낮은 주가를 올리기 위해 여러 개의 주식을 하나로 합치는 과정을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('액면분할', '액면병합', '무상증자', '권리락')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '분할의 반대 개념으로, 주식 수는 줄어들고 주당 가격은 올라갑니다.'),
           NULL
       );

-- Q4. DRAG: 분할 전후의 변화
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS001', 'LV1_CH009_LS001_Q004', 'DRAG',
           '액면분할을 하면 주식 1주의 가격은 {{blank}}하고, 내가 보유한 주식의 수량은 {{blank}}합니다.',
           JSON_ARRAY('하락', '상승', '유지', '동결'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '전체 자산 가치는 변하지 않는 것이 원칙입니다.'),
           NULL
       );

-- Q5. LINK: 변동 상황 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS001', 'LV1_CH009_LS001_Q005', 'LINK',
           '기업의 결정과 그에 따른 주식 상태를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','1:5 액면분할'),
                   JSON_OBJECT('id','L2','text','5:1 액면병합')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','주가는 1/5이 되고 주식 수는 5배가 됨'),
                           JSON_OBJECT('id','R2','text','주가는 5배가 되고 주식 수는 1/5이 됨')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '비율에 따라 가격과 수량이 반대로 움직입니다.'),
           NULL
       );

-- Q1. CONCEPT: 배당락의 원리 (FAQ: 배당금 받는 날인데 왜 주가는 떨어지나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS002', 'LV1_CH009_LS002_Q001', 'CONCEPT',
           '배당받을 권리가 사라지는 날, "배당락"을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '오늘 주식을 들고 있으면 배당을 준대서 샀는데, 오늘 주가가 딱 배당금만큼 떨어졌어요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 "배당락"이에요. 배당을 줄 만큼 회사의 현금이 빠져나갔으니 그만큼 가치를 깎는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 배당받아도 손해 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '당장은 그렇게 보일 수 있죠. 하지만 우량한 기업은 배당락으로 떨어진 주가를 실적으로 다시 회복해요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '중요한 건 "언제까지 주식을 들고 있어야 배당을 받느냐"를 아는 것입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 배당을 받기 위한 조건
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS002', 'LV1_CH009_LS002_Q002', 'SELECT',
           '배당을 받기 위해 주식을 반드시 보유하고 있어야 하는 마지막 날을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('배당락일', '배당기준일', '주주총회일', '결제일')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '배당기준일에 주주 명부에 이름이 올라 있어야 배당을 받을 수 있습니다.'),
           NULL
       );

-- Q3. MATCH: 배당락일의 타이밍
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS002', 'LV1_CH009_LS002_Q003', 'MATCH',
           'D+2 결제 시스템 때문에, 배당기준일 {{blank}} 영업일 전까지는 주식을 매수해야 배당을 받을 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('1', '2', '3', '7')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '주식 매수 후 실제 결제까지 2일이 걸리기 때문입니다.'),
           NULL
       );

-- Q4. DRAG: 배당락의 주가 현상
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS002', 'LV1_CH009_LS002_Q004', 'DRAG',
           '배당을 받을 권리가 사라진 {{blank}}일에는 배당금 예상액만큼 주가가 {{blank}}하여 시작하는 것이 일반적입니다.',
           JSON_ARRAY('배당락', '하락', '상승', '유지'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '권리가 사라진 것에 대한 가격 조정 과정입니다.'),
           NULL
       );

-- Q5. LINK: 날짜별 이벤트 연결 (12월 결산법인 예시)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS002', 'LV1_CH009_LS002_Q005', 'LINK',
           '날짜와 그날 일어나는 일을 연결하세요 (공휴일 없음).',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','12월 26일 (매수 마감일)'),
                   JSON_OBJECT('id','L2','text','12월 27일 (배당락일)'),
                   JSON_OBJECT('id','L3','text','12월 31일 (배당기준일)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','이날까지 주식을 사야 배당 수령 가능'),
                           JSON_OBJECT('id','R2','text','오늘 주식을 사도 배당 못 받음, 주가 하락'),
                           JSON_OBJECT('id','R3','text','공식적으로 주주 명부가 확정되는 날')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '날짜 계산을 잘못하면 배당을 놓칠 수 있습니다.'),
           NULL
       );

-- Q1. CONCEPT: 권리락의 발생 (FAQ: 주가가 왜 이렇게 많이 깎였나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS003', 'LV1_CH009_LS003_Q001', 'CONCEPT',
           '신주를 받을 권리가 정해진 뒤의 가격 변화를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '무상증자 공시 보고 주식을 샀는데, 오늘 주가가 갑자기 30%나 급락했어요! 악재인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요, 그건 "권리락" 때문이에요. 새로 나올 주식을 받을 주주들이 이미 다 정해졌거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '권리가 정해졌는데 왜 주가가 떨어지죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '나중에 주식 수가 엄청나게 늘어날 테니, 1주의 가치를 미리 조정하는 거예요. 대신 나중에 새 주식을 공짜(무상)나 싼값(유상)으로 받게 되니 손해는 아니죠.')
           ), NULL, NULL
       );

-- Q2. SELECT: 권리락의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS003', 'LV1_CH009_LS003_Q002', 'SELECT',
           '증자로 인해 늘어날 주식 수를 반영하여 주가를 인위적으로 낮추는 것을 무엇이라 할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('배당락', '권리락', '서킷브레이커', '자산동결')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '권리(Right)가 떨어진다(Drop)는 뜻의 권리락입니다.'),
           NULL
       );

-- Q3. MATCH: 무상증자 권리락
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS003', 'LV1_CH009_LS003_Q003', 'MATCH',
           '무상증자 비율이 1:1이라면, 권리락일의 기준 주가는 전일 종가의 {{blank}} 가격으로 시작합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('1/2', '1/3', '2배', '동일한')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '주식 수가 2배가 될 예정이므로 가격은 반으로 조정됩니다.'),
           NULL
       );

-- Q4. DRAG: 권리락일의 착시 현상
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS003', 'LV1_CH009_LS003_Q004', 'DRAG',
           '권리락일에는 주가가 매우 {{blank}} 보이기 때문에 일시적으로 매수세가 몰리는 {{blank}} 효과가 나타나기도 합니다.',
           JSON_ARRAY('저렴해', '착시', '비싸', '거품'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '갑자기 싸진 가격 때문에 차트가 왜곡되어 보일 수 있습니다.'),
           NULL
       );

-- Q5. LINK: 용어 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS003', 'LV1_CH009_LS003_Q005', 'LINK',
           '상황과 명칭을 알맞게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','현금 배당을 받을 권리가 사라짐'),
                   JSON_OBJECT('id','L2','text','새 주식을 배정받을 권리가 사라짐')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','배당락'),
                           JSON_OBJECT('id','R2','text','권리락')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '둘 다 주주 명부가 확정된 다음 날 발생합니다.'),
           NULL
       );

-- Q1. CONCEPT: 무상증자의 비밀 (FAQ: 주식을 공짜로 준다는데 무조건 좋은 건가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS004', 'LV1_CH009_LS004_Q001', 'CONCEPT',
           '공짜 주식 선물, 무상증자를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '회사에서 주식을 공짜로 준대요! 대박 호재 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '보통은 호재로 보죠. 회사가 번 돈(잉여금)을 주식으로 바꿔서 주주들에게 나눠주는 거니까요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '하지만 조심하세요. 주식 수가 늘어난 만큼 권리락으로 주가도 깎이기 때문에, 내 계좌의 총액은 처음엔 그대로예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '어? 그럼 뭐가 좋은 거죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '시장에 "우리 회사 돈 잘 벌고 자신 있다"는 신호를 주는 거고, 거래가 활발해지는 효과가 있어 주가가 다시 오를 힘을 주기도 하죠.')
           ), NULL, NULL
       );

-- Q2. SELECT: 유상증자의 일반적 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS004', 'LV1_CH009_LS004_Q002', 'SELECT',
           '기존 주주나 제3자에게 새로 발행한 주식을 돈을 받고 파는 방식은?',
           JSON_OBJECT('choices', JSON_ARRAY('무상증자', '유상증자', '무상감자', '자사주 매입')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '기업이 자본금을 확충하기 위해 투자자에게 돈을 받고 주식을 발행하는 것입니다.'),
           NULL
       );

-- Q3. MATCH: 제3자 배정 유상증자
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS004', 'LV1_CH009_LS004_Q003', 'MATCH',
           '특정한 대기업이나 큰 투자자 한 곳으로부터 돈을 투자를 받는 방식을 {{blank}} 유상증자라고 하며, 보통 호재로 해석됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('주주 우선', '일반 공모', '제3자 배정', '임직원')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '강력한 파트너가 생기는 것이므로 기업 가치 상승에 도움이 됩니다.'),
           NULL
       );

-- Q4. DRAG: 증자의 목적과 시장 반응
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS004', 'LV1_CH009_LS004_Q004', 'DRAG',
           '빚을 갚기 위한 유상증자는 {{blank}}로 작용하지만, 신규 공장 건설을 위한 유상증자는 중장기적으로 {{blank}}가 될 수 있습니다.',
           JSON_ARRAY('악재', '호재', '배당', '감자'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '증자는 그 목적(자금 조달의 이유)을 확인하는 것이 필수입니다.'),
           NULL
       );

-- Q5. LINK: 증자 방식 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS004', 'LV1_CH009_LS004_Q005', 'LINK',
           '증자 방식과 그 특징을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','무상증자'),
                   JSON_OBJECT('id','L2','text','유상증자 (주주배정)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','주주에게 공짜로 주식을 나눠줌 (잉여금의 자본화)'),
                           JSON_OBJECT('id','R2','text','주주에게 돈을 받고 주식을 새로 팖 (자본금 확충)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '유상은 내 지갑에서 돈이 나가고, 무상은 공짜로 들어옵니다.'),
           NULL
       );

-- Q1. CONCEPT: 자사주 매입과 소각 (FAQ: 회사가 자기 주식을 사면 왜 좋나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS005', 'LV1_CH009_LS005_Q001', 'CONCEPT',
           '주주들이 가장 환영하는 공시, 자사주 소각을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'mentor', 'text', '회사가 시장에서 자기 주식을 사들인 뒤(매입), 아예 없애버리는(소각) 것을 말해요.'),
                   JSON_OBJECT('sender', 'user', 'text', '멀쩡한 주식을 왜 없애버리죠? 아깝게!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '피자 조각이 10개였는데 2개를 없애면, 남은 8조각의 크기가 더 커지는 것과 같아요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 전체 가치는 그대로인데 주식 수가 줄어드니까 한 주당 가치가 올라가는군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '빙고! 주주들에게 가장 직접적으로 이득을 주는 강력한 주주 환원 정책입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 자사주 소각의 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS005', 'LV1_CH009_LS005_Q002', 'SELECT',
           '기업이 자사주를 소각했을 때 나타나는 현상으로 옳은 것은?',
           JSON_OBJECT('choices', JSON_ARRAY('유통 주식 수 증가', '주당 가치 상승', '배당금 감소', '부채 비율 증가')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '전체 파이(기업 가치)는 그대로인데 나누는 수(주식 수)가 줄어들어 1주의 가치가 상승합니다.'),
           NULL
       );

-- Q3. MATCH: 주주환원 정책
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS005', 'LV1_CH009_LS005_Q003', 'MATCH',
           '회사가 번 돈을 배당이나 자사주 소각 등을 통해 주주들에게 돌려주는 모든 활동을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('주주 환원', '경영권 승계', '자본 잠식', '기업 공개')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '주주 환원이 활발한 기업일수록 주가가 우상향할 가능성이 높습니다.'),
           NULL
       );

-- Q4. DRAG: 매입과 소각의 차이
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS005', 'LV1_CH009_LS005_Q004', 'DRAG',
           '단순히 주식을 사기만 하는 {{blank}}은 나중에 다시 팔 수도 있어 효과가 제한적이지만, 아예 없애는 {{blank}}은 영구적으로 가치를 높입니다.',
           JSON_ARRAY('자사주 매입', '자사주 소각', '배당', '증자'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '소각이 수반되지 않은 매입은 "반쪽짜리" 호재일 수 있습니다.'),
           NULL
       );

-- Q5. LINK: 기업 행동과 의미 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH009_LS005', 'LV1_CH009_LS005_Q005', 'LINK',
           '기업의 행동과 그 주된 목적을 알맞게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','유상증자'),
                   JSON_OBJECT('id','L2','text','자사주 소각')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','주주로부터 돈을 모아 사업에 활용 (자금 조달)'),
                           JSON_OBJECT('id','R2','text','주식 가치를 높여 주주에게 이익을 돌려줌 (가치 제고)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '주식 수가 늘어나는지 줄어드는지가 투자의 핵심 포인트입니다.'),
           NULL
       );

-- Q1. CONCEPT: 투자주의/경고의 의미 (FAQ: 종목명 앞에 [경]자가 붙었어요!)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS001', 'LV1_CH010_LS001_Q001', 'CONCEPT',
           '종목 이름 옆에 붙는 작은 글자들의 의미를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님! 제가 사려는 주식 이름 앞에 빨간색으로 [경]이라고 적혀 있어요. 이거 좋은 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요, 조심하라는 신호예요! 그건 "투자경고" 종목이라는 뜻입니다.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주가가 단기간에 너무 비정상적으로 급등해서 거래소가 투자자들에게 "지뢰밭이니 조심하세요!"라고 경고를 준 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '와, 그럼 초보자인 저한테는 위험한 종목이겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 이런 종목은 변동성이 너무 커서 순식간에 큰 손실을 볼 수 있고, 신용 대출로 살 수도 없게 제한됩니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 경고 단계의 순서
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS001', 'LV1_CH010_LS001_Q002', 'SELECT',
           '거래소가 지정하는 시장경보제도의 단계 중 가장 낮은(첫 번째) 단계는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('투자경고', '투자주의', '투자위험', '상장폐지')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '주의 -> 경고 -> 위험 순으로 단계가 높아집니다.'),
           NULL
       );

-- Q3. MATCH: 지정 사유
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS001', 'LV1_CH010_LS001_Q003', 'MATCH',
           '특정 계좌에서 집중적으로 매매가 일어나거나 주가가 급등할 때 지정되는 것을 {{blank}} 종목이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('투자주의', '우량', '배당', '저평가')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '투자주의는 가장 빈번하게 발생하는 초기 경고 신호입니다.'),
           NULL
       );

-- Q4. DRAG: 경보 종목의 제약
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS001', 'LV1_CH010_LS001_Q004', 'DRAG',
           '투자경고 종목이 되면 해당 주식을 {{blank}}으로 살 수 없으며, 증거금을 {{blank}}% 내야 하는 등 거래 조건이 까다로워집니다.',
           JSON_OBJECT('choices', JSON_ARRAY('외상(신용)', '100', '무료', '50')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '과열을 막기 위해 증권사가 대출을 차단하기 때문입니다.'),
           NULL
       );

-- Q5. LINK: 단계별 명칭 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS001', 'LV1_CH010_LS001_Q005', 'LINK',
           '시장경보 단계와 그 의미를 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','투자주의'),
                   JSON_OBJECT('id','L2','text','투자경고'),
                   JSON_OBJECT('id','L3','text','투자위험')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','투기적 가수요가 있어 주의가 필요한 단계'),
                           JSON_OBJECT('id','R2','text','주가가 급등하여 투자가 매우 위험한 단계'),
                           JSON_OBJECT('id','R3','text','가장 높은 단계로 매매정지가 발생할 수 있는 단계')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '단계가 올라갈수록 원금 손실 위험이 기하급수적으로 커집니다.'),
           NULL
       );

-- Q1. CONCEPT: 투자위험과 매매정지 (FAQ: 왜 제 주식이 오늘 거래가 안 되죠?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS002', 'LV1_CH010_LS002_Q001', 'CONCEPT',
           '시장경보의 끝판왕, 투자위험 종목입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님! 제가 어제 산 종목 앞에 [위]라고 붙더니 오늘 아예 거래가 안 돼요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 "투자위험" 종목으로 지정되어 하루 동안 "매매거래정지"가 된 거예요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '경고를 줬는데도 주가가 계속 폭등하니, 거래소가 강제로 거래를 멈춰서 투자자들을 식히는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 망한 건 아니지만 거래가 안 되니 정말 답답하네요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 이런 종목은 세력들의 작전이나 과도한 테마에 엮인 경우가 많으니 초보자는 쳐다보지도 않는 게 상책입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 투자위험 종목의 거래 제한
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS002', 'LV1_CH010_LS002_Q002', 'SELECT',
           '투자위험 종목으로 지정되는 날, 해당 종목에 일어나는 일은?',
           JSON_OBJECT('choices', JSON_ARRAY('상장폐지 된다', '1일간 매매거래가 정지된다', '배당금을 두 배로 준다', '모든 주주에게 사과문을 보낸다')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '과열 방지를 위해 지정 당일 1일간 거래가 정지됩니다.'),
           NULL
       );

-- Q3. MATCH: 지정 기관
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS002', 'LV1_CH010_LS002_Q003', 'MATCH',
           '시장경보 종목(주의/경고/위험)을 판단하고 지정하는 기관은 {{blank}}입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('한국거래소(KRX)', '한국은행', '기획재정부', '국세청')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '한국거래소는 시장의 공정성을 지키기 위해 실시간으로 시장을 감시합니다.'),
           NULL
       );

-- Q4. DRAG: 매매 재개 후의 위험
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS002', 'LV1_CH010_LS002_Q004', 'DRAG',
           '거래정지가 풀린 뒤에도 주가가 계속 오르면 다시 {{blank}} 정지가 될 수 있으며, 반대로 거품이 빠지며 {{blank}} 할 위험이 매우 큽니다.',
           JSON_OBJECT('choices', JSON_ARRAY('매매', '폭락', '배당', '급등')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '비이성적 과열의 끝은 대개 날카로운 하락으로 이어집니다.'),
           NULL
       );

-- Q5. LINK: 경보 상태별 매매 전략
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS002', 'LV1_CH010_LS002_Q005', 'LINK',
           '시장 경보를 대하는 현명한 자세를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','종목명 앞 [주의], [경고]'),
                   JSON_OBJECT('id','L2','text','종목명 앞 [위험]')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','호기심에라도 사지 말고 관망하기'),
                           JSON_OBJECT('id','R2','text','이미 보유 중이라면 이익 실현 고려하기')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R2', 'L2','R1'), 'explanation', '딱지가 붙은 종목은 수익보다 리스크가 훨씬 큽니다.'),
           NULL
       );

-- Q1. CONCEPT: 관리종목의 의미 (FAQ: [관]자 붙은 주식은 왜 싼가요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS003', 'LV1_CH010_LS003_Q001', 'CONCEPT',
           '상장폐지의 대기실, 관리종목을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '이 주식은 엄청 싼데 앞에 [관]이라고 써있네요. 지금 사면 대박 아닐까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '절대 안 돼요! [관]은 "관리종목"의 약자로, 기업이 망하기 직전이라는 뜻이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '자본금이 다 떨어졌거나(자본잠식), 실적이 몇 년째 최악이거나, 감사를 거부당했을 때 지정되죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 싸다고 좋은 게 아니라 곧 사라질 수도 있는 위험한 주식이군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 관리종목은 언제든 "상장폐지"되어 휴지 조각이 될 수 있으니 초보자는 무조건 피해야 합니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 관리종목 지정 사유가 아닌 것
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS003', 'LV1_CH010_LS003_Q002', 'SELECT',
           '다음 중 기업이 관리종목으로 지정될 수 있는 사유로 적절하지 않은 것은?',
           JSON_OBJECT('choices', JSON_ARRAY('자본잠식 50% 이상', '사업보고서 미제출', '매출액 미달', '사장님이 휴가를 감')),
           JSON_OBJECT('correct', JSON_ARRAY(3), 'explanation', '관리종목은 경영의 지속 가능성이 위협받을 때 지정됩니다.'),
           NULL
       );

-- Q3. MATCH: 자본잠식의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS003', 'LV1_CH010_LS003_Q003', 'MATCH',
           '회사의 적자가 쌓여 처음 사업을 시작할 때 넣었던 원금(자본금)까지 깎아 먹는 상태를 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('자본잠식', '이익잉여', '자산증식', '부채상환')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '자본잠식이 심해지면 관리종목을 거쳐 상장폐지 됩니다.'),
           NULL
       );

-- Q4. DRAG: 관리종목의 페널티
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS003', 'LV1_CH010_LS003_Q004', 'DRAG',
           '관리종목으로 지정되면 {{blank}} 매매가 불가능해지며, 일정 기간 동안 거래가 {{blank}} 될 수도 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('신용/미수', '정지', '현금', '활성화')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '금융기관에서도 위험한 종목으로 분류하여 거래를 제한합니다.'),
           NULL
       );

-- Q5. LINK: 기업의 위기 신호 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS003', 'LV1_CH010_LS003_Q005', 'LINK',
           '관리종목 지정 가능성이 높은 상황을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','재무적 위기'),
                   JSON_OBJECT('id','L2','text','신뢰도 위기'),
                   JSON_OBJECT('id','L3','text','유동성 위기')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','4~5년 연속 영업이익 적자'),
                           JSON_OBJECT('id','R2','text','회계 감사 결과 "의견 거절" 발생'),
                           JSON_OBJECT('id','R3','text','주식 거래량이 너무 적어 시장성이 없음')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '이런 신호가 보이면 즉시 탈출을 고민해야 합니다.'),
           NULL
       );

-- Q1. CONCEPT: 상장폐지의 무서움 (FAQ: 제 주식이 왜 리스트에서 사라졌나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS004', 'LV1_CH010_LS004_Q001', 'CONCEPT',
           '투자자가 겪을 수 있는 최악의 시나리오, 상장폐지입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 뉴스에 제가 가진 종목이 "상장폐지" 결정됐다고 떠요. 어떡하죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정말 안타까운 상황이네요. 상장폐지는 해당 기업의 주식이 시장에서 거래될 자격을 잃고 쫓겨나는 거예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 제 돈은 아예 없어지는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '회사가 아예 망하지 않았다면 주주로서의 권리는 남지만, 시장에서 팔 수가 없으니 사실상 "휴지 조각"이나 다름없게 되죠.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '마지막으로 주식을 팔 기회인 "정리매매" 기간이 주어지긴 하지만, 가격은 원래의 1/10도 안 될 가능성이 높습니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 상장폐지의 치명적 사유
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS004', 'LV1_CH010_LS004_Q002', 'SELECT',
           '상장사가 회계 장부의 신뢰성을 잃어 외부 감사인으로부터 받는 판정 중 상장폐지 사유가 되는 것은?',
           JSON_OBJECT('choices', JSON_ARRAY('적정 의견', '한정 의견', '의견 거절', '참고 의견')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '의견 거절이나 부적정 판정은 기업이 무언가를 숨기고 있거나 망하기 일보 직전이라는 뜻입니다.'),
           NULL
       );

-- Q3. MATCH: 상장폐지 실질심사
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS004', 'LV1_CH010_LS004_Q003', 'MATCH',
           '횡령이나 배임 등 중대한 사건이 발생했을 때, 상장폐지를 시킬지 말지 심사하는 과정을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('상장예비심사', '실질심사', '배당심사', '세무조사')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '심사 결과에 따라 회생 기회(개선 기간)를 주거나 즉시 퇴출당합니다.'),
           NULL
       );

-- Q4. DRAG: 완전 자본잠식
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS004', 'LV1_CH010_LS004_Q004', 'DRAG',
           '회사의 빚이 자산보다 많아져서 자본금이 마이너스(-)가 되는 {{blank}} 자본잠식 상태가 되면 별도의 유예 없이 즉시 {{blank}} 사유가 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('완전', '상장폐지', '부분', '이익잉여')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '껍데기만 남은 회사는 시장에서 퇴출당하는 것이 원칙입니다.'),
           NULL
       );

-- Q5. LINK: 상장폐지 단계 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS004', 'LV1_CH010_LS004_Q005', 'LINK',
           '상장폐지가 진행되는 일반적인 순서를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','1단계: 사고 발생'),
                   JSON_OBJECT('id','L2','text','2단계: 심판의 시간'),
                   JSON_OBJECT('id','L3','text','3단계: 마지막 기회')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','사유 발생 및 매매거래 정지'),
                           JSON_OBJECT('id','R2','text','상장폐지 실질심사 진행'),
                           JSON_OBJECT('id','R3','text','상장폐지 결정 및 정리매매 시작')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3'), 'explanation', '이 과정이 시작되기 전에 도망치는 것이 최선의 전략입니다.'),
           NULL
       );

-- Q1. CONCEPT: 정리매매의 특징 (FAQ: 상폐되기 전 마지막으로 팔 수 있나요?)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS005', 'LV1_CH010_LS005_Q001', 'CONCEPT',
           '시장에서 쫓겨나기 전 주주들에게 주는 마지막 기회입니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'mentor', 'text', '상장폐지가 확정되면 딱 7일 동안만 다시 거래를 열어줘요. 이걸 "정리매매"라고 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '오, 그럼 그때 제 가격에 팔 수 있겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '절대 아니요! 정리매매는 상/하한가 제한이 없어서 주가가 하루 만에 -90%가 되기도 해요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그리고 30분에 한 번씩만 주문을 모아서 체결시키죠. 아주 천천히, 그리고 아주 아프게 가격이 내려갑니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '무섭네요... "상폐 주식 대박" 노리고 들어오는 사람들도 있던데 위험하겠죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, 그건 투자가 아니라 불길 속으로 뛰어드는 거예요. 정리매매는 오직 "탈출"을 위한 시간입니다.')
           ), NULL, NULL
       );

-- Q2. SELECT: 정리매매의 가격제한폭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS005', 'LV1_CH010_LS005_Q002', 'SELECT',
           '정리매매 기간 중 주가의 하루 변동 폭(가격제한폭)에 대한 설명으로 옳은 것은?',
           JSON_OBJECT('choices', JSON_ARRAY('상하 30%로 제한된다', '가격제한폭이 아예 없다', '10% 이내로만 움직인다', '주가가 고정된다')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '정리매매는 단기간에 처분을 돕기 위해 가격 제한을 두지 않습니다.'),
           NULL
       );

-- Q3. MATCH: 매매 방식의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS005', 'LV1_CH010_LS005_Q003', 'MATCH',
           '정리매매는 실시간 체결이 아니라, 주문을 모아 30분 단위로 한꺼번에 체결하는 {{blank}} 매매 방식으로 진행됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('시장가', '단일가', '지정가', '최유리')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '과열을 막기 위해 30분 간격으로만 거래를 성사시킵니다.'),
           NULL
       );

-- Q4. DRAG: 정리매매 기간
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS005', 'LV1_CH010_LS005_Q004', 'DRAG',
           '정리매매는 보통 {{blank}} 영업일 동안 진행되며, 이 기간이 끝나면 해당 주식은 시장에서 {{blank}} 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('7', '퇴출(폐지)', '30', '유지')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '7일은 주주들이 눈물을 머금고 손절할 수 있는 마지막 법적 기한입니다.'),
           NULL
       );

-- Q5. LINK: 일반 매매 vs 정리매매 비교
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV1_CH010_LS005', 'LV1_CH010_LS005_Q005', 'LINK',
           '매매 종류에 따른 규칙 차이를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','일반 정규장 매매'),
                   JSON_OBJECT('id','L2','text','상장폐지 정리매매')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','상하 30% 제한, 실시간 즉시 체결'),
                           JSON_OBJECT('id','R2','text','가격 제한 없음, 30분 단위 단일가 체결')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2'), 'explanation', '완전히 다른 규칙이 적용되므로 극도로 주의해야 합니다.'),
           NULL
       );
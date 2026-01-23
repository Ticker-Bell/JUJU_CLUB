-- Q001. CONCEPT: 발생주의와 현금주의의 충돌 (상세 심화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS001', 'LV3_CH001_LS001_Q001', 'CONCEPT',
           '당기순이익과 영업현금흐름이 왜 다르게 나타나는지 그 복잡한 원리를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 뉴스에선 100억 흑자라는데 현금흐름표를 보면 영업으로 번 돈이 -20억이에요. 장부가 가짜인 거 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '사기라고 단정할 순 없지만, "이익의 질"이 매우 나쁜 상태인 건 확실해요. 주식 시장은 "발생주의" 원칙을 따르거든요. 물건을 외상으로 팔아도 장부에는 즉시 "이익"으로 기록되지만, 실제 현금은 아직 들어오지 않았기 때문이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 외상값이 너무 많으면 장부만 화려하고 실제 금고는 비어있겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 그걸 "매출채권의 증가"라고 불러요. 반대로 팔리지 않은 재고가 창고에 가득 쌓여도 현금은 그 안에 묶이게 되죠. 이걸 "재고자산의 증가"라고 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '이익은 났는데 현금이 안 돌면 결국 부도가 날 수도 있는 거 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞습니다. 그걸 "흑자도산"이라고 해요. 그래서 프로 투자자는 당기순이익보다 영업현금흐름을 훨씬 더 신뢰합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 두 숫자를 어떻게 비교해서 진짜 실력을 찾나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '당기순이익에서 시작해서, 감가상각비처럼 실제 돈은 안 나갔는데 비용 처리된 걸 다시 더하고, 재고처럼 현금을 묶어둔 자산의 증가분을 빼는 과정을 거쳐 "진짜 번 현금"을 찾아내야 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 장부 숫자는 경영진의 의도가 섞일 수 있지만, 통장의 숫자는 거짓말을 못 한다는 뜻이군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 현금 유입 조정 항목
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS001', 'LV3_CH001_LS001_Q002', 'SELECT',
           '당기순이익에서 영업현금흐름을 계산할 때, 실제 현금 유출이 없어 다시 "더해주는" 대표적인 항목은?',
           JSON_OBJECT('choices', JSON_ARRAY('감가상각비', '매출채권의 증가', '배당금 지급', '원재료 구입비')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '감가상각비는 회계상 비용일 뿐 실제 현금이 나가지 않으므로 현금흐름 계산 시 다시 더해줍니다.'),
           NULL
       );

-- Q003. MATCH: 이익의 신뢰도 지표
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS001', 'LV3_CH001_LS001_Q003', 'MATCH',
           '당기순이익보다 영업현금흐름이 지속적으로 낮게 유지되는 기업은 {{blank}}이 매우 낮다고 판단합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('이익의 질', '성장 잠재력', '자산 규모')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '현금이 수반되지 않는 이익은 장부상 숫자에 불과할 수 있습니다.'),
           NULL
       );

-- Q004. DRAG: 현금흐름 차감 요인
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS001', 'LV3_CH001_LS001_Q004', 'DRAG',
           '장부상 이익은 늘지만 현금을 묶어버리는 요인: {{blank}}의 증가, {{blank}}의 증가',
           JSON_OBJECT('choices', JSON_ARRAY('매출채권', '재고자산', '매입채무')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '외상값과 안 팔린 재고가 늘어나면 장부상 이익만 늘고 현금은 마르게 됩니다.'),
           NULL
       );

-- Q005. LINK: 활동과 현금흐름의 상관관계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS001', 'LV3_CH001_LS001_Q005', 'LINK',
           '기업의 영업 활동 변화와 그에 따른 현금흐름의 영향을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','대규모 감가상각비 계상'),
                   JSON_OBJECT('id','L2','text','공격적인 외상 판매 확대'),
                   JSON_OBJECT('id','L3','text','매입채무(외상값) 결제 연장'),
                   JSON_OBJECT('id','L4','text','재고 밀어내기식 판매')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','장부상 이익보다 현금흐름이 좋아짐'),
                           JSON_OBJECT('id','R2','text','이익은 늘지만 현금은 고갈됨'),
                           JSON_OBJECT('id','R3','text','일시적으로 가용 현금이 늘어남'),
                           JSON_OBJECT('id','R4','text','이익 수치는 보전되나 실질 현금흐름 악화')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '현금의 유입과 유출 시점을 아는 것이 고급 분석의 핵심입니다.'),
           NULL
       );

-- Q001. CONCEPT: 투자와 재무 부호의 반전 매력 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS002', 'LV3_CH001_LS002_Q001', 'CONCEPT',
           '투자현금흐름과 재무현금흐름의 플러스/마이너스가 가진 반전의 의미를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 투자현금흐름이 -500억이면 500억 손해 봤다는 뜻인가요? 주가가 떨어지겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요, 현금흐름표에서는 정반대로 해석해야 해요! 마이너스(-)는 돈이 기업 밖으로 "나갔다"는 뜻입니다. 기업이 미래를 위해 500억 규모의 새 공장을 지었거나 신기술을 "샀다"는 아주 강력한 성장 신호죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '오, 그럼 반대로 플러스(+)면 좋은 게 아닌가요? 돈이 들어온 거잖아요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '투자현금흐름이 플러스(+)라는 건 기업이 가지고 있던 공장이나 주식을 "팔아서" 현금을 마련했다는 뜻이에요. 회사가 어려워서 자산을 처분하는 것일 수도 있으니 주의해야 하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '재무현금흐름은 어떤가요? 플러스면 빚이 늘어난 거니까 나쁜 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '재무가 플러스(+)면 은행 대출이나 증자로 돈이 들어온 거예요. 성장을 위한 조달이라면 약이지만, 운영비가 없어서 빌리는 거라면 독이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 어떤 조합이 가장 완벽한가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '가장 건강한 기업은 본업에서 벌고(영업+), 미래를 위해 투자하며(투자-), 남은 돈으로 빚을 갚는(재무-) 패턴을 보입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 부호의 절대값이 아니라 그 "방향"이 기업의 의도를 말해주는 거군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 우량 기업의 재무 패턴
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS002', 'LV3_CH001_LS002_Q002', 'SELECT',
           '돈을 잘 벌어서 은행 빚을 갚거나 주주에게 배당을 주는 우량 기업의 "재무현금흐름" 부호는?',
           JSON_OBJECT('choices', JSON_ARRAY('플러스(+)', '마이너스(-)', '0', '알 수 없음')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '부채 상환이나 배당 지급은 기업 밖으로 현금이 유출되는 활동이므로 마이너스로 기록됩니다.'),
           NULL
       );

-- Q003. MATCH: 자산 매각의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS002', 'LV3_CH001_LS002_Q003', 'MATCH',
           '경영난에 처한 기업이 급전을 마련하기 위해 핵심 공장이나 부동산을 팔면 투자현금흐름은 {{blank}} 상태가 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('플러스(+)', '마이너스(-)', '보합')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '자산 매각은 기업 내부로 현금이 유입되는 활동이기 때문입니다.'),
           NULL
       );

-- Q004. DRAG: 현금흐름의 성격 분류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS002', 'LV3_CH001_LS002_Q004', 'DRAG',
           '설비 확충이나 타법인 주식 취득은 {{blank}}에, 유상증자나 회사채 발행은 {{blank}}에 기록됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('투자현금흐름', '재무현금흐름', '영업현금흐름')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '돈을 쓰는 목적(투자)과 가져오는 방법(재무)에 따라 나뉩니다.'),
           NULL
       );

-- Q005. LINK: 현금흐름 부호와 기업 상태
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS002', 'LV3_CH001_LS002_Q005', 'LINK',
           '현금흐름 부호 조합과 기업의 현재 상태를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','영업(+), 투자(-), 재무(-)'),
                   JSON_OBJECT('id','L2','text','영업(+), 투자(-), 재무(+)'),
                   JSON_OBJECT('id','L3','text','영업(-), 투자(+), 재무(+)'),
                   JSON_OBJECT('id','L4','text','영업(+), 투자(+), 재무(-)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','가장 이상적인 성숙기 우량주'),
                           JSON_OBJECT('id','R2','text','공격적인 투자 확대 및 성장주'),
                           JSON_OBJECT('id','R3','text','자산 팔고 빚내서 버티는 부실주'),
                           JSON_OBJECT('id','R4','text','사업 정리 및 자금 회수 상태')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '부호의 조합만으로도 기업의 건강검진이 가능합니다.'),
           NULL
       );

-- Q001. CONCEPT: FCF가 가치평가의 종착역인 이유 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS003', 'LV3_CH001_LS003_Q001', 'CONCEPT',
           '당기순이익보다 잉여현금흐름(FCF)이 주가에 더 큰 영향을 주는 이유를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 이익이 많이 나면 당연히 배당도 많이 줄 수 있는 거 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 큰 오해예요. 이익이 아무리 많아도 그 돈을 전부 노후화된 공장 고치거나 새 기계 사는 데(CapEx) 써야 한다면 주주에게 줄 돈은 한 푼도 없게 되죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 떼어낼 거 다 떼어내고 기업 손에 남은 "진짜 여유분"을 봐야겠군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 잉여현금흐름($FCF$)은 영업으로 번 현금에서 필수 설비 투자비를 뺀 "진짜 자유로운 돈"을 뜻해요.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 이 FCF로 기업은 무엇을 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이 돈이 풍부해야 기업이 배당도 늘리고, 자사주도 사서 태워버릴 수 있습니다. 주주 가치가 올라가는 진짜 엔진이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '이익은 나는데 FCF가 계속 마이너스인 회사는 어떨까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그런 회사는 겉으로는 성장하는 것처럼 보여도, 속으로는 계속 돈이 마르는 "돈 먹는 하마"일 가능성이 커요. 실질적인 배당 체력을 보려면 반드시 FCF를 계산해야 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 주주에게 돌아올 "진짜 몫"의 원천이 바로 FCF군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: FCF의 계산 공식
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS003', 'LV3_CH001_LS003_Q002', 'SELECT',
           '잉여현금흐름(FCF)을 구하는 가장 올바른 공식은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('영업현금흐름 - 자본적 지출(CapEx)', '당기순이익 - 영업비용', '재무현금흐름 + 투자현금흐름', '자산 - 부채')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '본업으로 번 돈에서 필수적인 설비 투자비를 뺀 것이 잉여현금입니다.'),
           NULL
       );

-- Q003. MATCH: 자본적 지출의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS003', 'LV3_CH001_LS003_Q003', 'MATCH',
           '기업이 미래 경쟁력을 유지하기 위해 공장이나 기계 등 유무형 자산을 취득하는 데 쓰는 돈을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('CapEx', 'OpEx', '배당금')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'CapEx가 너무 크면 이익이 나도 주주에게 줄 현금이 부족해질 수 있습니다.'),
           NULL
       );

-- Q004. DRAG: FCF의 활용 순위
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS003', 'LV3_CH001_LS003_Q004', 'DRAG',
           '풍부한 FCF를 가진 기업은 적극적인 {{blank}}을 하거나 {{blank}} 소각을 통해 주당 가치를 높일 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('배당', '자사주', '부채')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '잉여현금은 주주 환원 정책의 가장 강력한 원동력입니다.'),
           NULL
       );

-- Q005. LINK: FCF 상황별 가치 분석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS003', 'LV3_CH001_LS003_Q005', 'LINK',
           'FCF 상태에 따른 투자자의 올바른 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','이익 증가 + FCF 증가'),
                   JSON_OBJECT('id','L2','text','이익 증가 + FCF 감소'),
                   JSON_OBJECT('id','L3','text','FCF가 시총의 10% 이상'),
                   JSON_OBJECT('id','L4','text','FCF 마이너스 지속')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','수익성과 현금 창출력 동반 성장'),
                           JSON_OBJECT('id','R2','text','투자가 과도하거나 이익의 질 하락'),
                           JSON_OBJECT('id','R3','text','매력적인 저평가 알짜 기업'),
                           JSON_OBJECT('id','R4','text','외부 수혈 없이는 생존이 어려운 상태')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', 'FCF는 기업의 실제 몸값을 결정하는 핵심 지표입니다.'),
           NULL
       );

-- Q001. CONCEPT: 현금흐름 부호의 마법 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS004', 'LV3_CH001_LS004_Q001', 'CONCEPT',
           '영업, 투자, 재무현금흐름의 부호 조합으로 기업의 운명을 읽는 법을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 현금흐름표의 세 가지 부호만 봐도 기업의 미래를 알 수 있나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럼요! 가장 이상적인 패턴은 (+, -, -)입니다. 본업에서 돈을 잘 벌고(+), 그 돈으로 미래를 위해 투자하며(-), 남은 돈으로 빚을 갚거나 배당을 주는(-) 전형적인 우량 기업의 모습이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 가장 위험한 패턴은 무엇인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '바로 (-, +, +)입니다. 본업은 적자인데(-), 팔 수 있는 건 다 팔고(+), 그것도 모자라 빚을 내서(+) 버티는 좀비 기업의 패턴이죠. 상장폐지 전조 현상에서 가장 많이 발견됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '성장하는 벤처 기업들은 어떤가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '성장기 기업은 영업(+), 투자(-), 재무(+)인 경우가 많아요. 벌기도 하지만 성장이 너무 빨라 외부에서 돈을 더 끌어와 대규모 투자를 단행하는 "공격적인 성장" 상태죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '반대로 영업이 플러스인데 투자도 플러스인 경우는요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 사업을 축소하거나 정리하는 중일 확률이 높아요. 돈은 벌지만 미래를 위한 투자를 멈추고 자산을 팔아 치우고 있는 거니까요.'),
                   JSON_OBJECT('sender', 'user', 'text', '부호의 조합이 마치 기업의 유전자를 보여주는 것 같네요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 성숙기 우량주 패턴
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS004', 'LV3_CH001_LS004_Q002', 'SELECT',
           '안정적으로 돈을 벌어 배당을 많이 주는 "현금 흐름 끝판왕" 우량주의 패턴은?',
           JSON_OBJECT('choices', JSON_ARRAY('영업(+), 투자(-), 재무(-)', '영업(-), 투자(+), 재무(+)', '영업(+), 투자(+), 재무(+)')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '수익, 투자, 부채 상환의 밸런스가 가장 완벽한 구조입니다.'),
           NULL
       );

-- Q003. MATCH: 사업 철수의 징후
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS004', 'LV3_CH001_LS004_Q003', 'MATCH',
           '영업은 적자인데 투자현금흐름이 큰 플러스(+)라면, 이는 기업이 생존을 위해 {{blank}}을 팔고 있음을 의미합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('핵심 자산(공장 등)', '자사주', '부채')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '본업 대신 자산을 매각해 현금을 마련하는 것은 대단히 위험한 신호입니다.'),
           NULL
       );

-- Q004. DRAG: 기업 생애별 흐름
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS004', 'LV3_CH001_LS004_Q004', 'DRAG',
           '초기 기업은 영업(-)과 {{blank}}(+)가 나타나고, 안정된 기업은 영업(+)과 {{blank}}(-)가 나타납니다.',
           JSON_OBJECT('choices', JSON_ARRAY('재무현금흐름', '투자현금흐름', '이익잉여금')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '기업의 성장 단계에 따라 자금 흐름의 성격이 바뀝니다.'),
           NULL
       );

-- Q005. LINK: 패턴별 실전 진단
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS004', 'LV3_CH001_LS004_Q005', 'LINK',
           '현금흐름 패턴과 기업의 현실을 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','(+, -, -)'),
                   JSON_OBJECT('id','L2','text','(+, -, +)'),
                   JSON_OBJECT('id','L3','text','(-, +, +)'),
                   JSON_OBJECT('id','L4','text','(+, +, -)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','가장 이상적인 우량 기업'),
                           JSON_OBJECT('id','R2','text','공격적인 투자 확대 및 성장 가속'),
                           JSON_OBJECT('id','R3','text','자산 매각과 대출로 연명 중인 위기'),
                           JSON_OBJECT('id','R4','text','사업 정리 및 대규모 현금 회수 단계')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '부호의 조합만으로도 기업의 운명을 가늠할 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: 돈이 도는 속도가 생명인 이유 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS005', 'LV3_CH001_LS005_Q001', 'CONCEPT',
           '이익은 나는데 왜 회사가 망할까요? 현금전환주기가 그 답을 줍니다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 장부상 이익은 엄청난데 갑자기 부도가 나는 회사가 있어요. 이게 가능한가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, "현금전환주기($CCC$, $Cash Conversion Cycle$)"가 너무 길면 가능합니다. 원재료를 사서 제품을 만들고, 팔아서 돈을 회수할 때까지 걸리는 총 시간을 말하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '음, 물건은 팔았는데 돈을 너무 늦게 받으면 그 사이에 쓸 현금이 없겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 만약 원재료 값은 즉시 줘야 하는데 물건값은 1년 뒤에 받는다면, 그 사이에 회사는 현금이 말라버려요. 이걸 "흑자도산"이라고 하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 반대로 돈을 빨리 받으면 회사가 훨씬 건강하겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그렇죠. 애플이나 아마존 같은 초우량 기업은 CCC가 마이너스인 경우도 있어요. 물건값은 미리 받고 협력업체엔 돈을 천천히 줘서 "남의 돈"으로 장사하는 최강의 효율을 보이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 "돈이 회전하는 속도"가 기업의 심장 박동과 같군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 효율적인 자금 운영
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS005', 'LV3_CH001_LS005_Q002', 'SELECT',
           '기업의 자산 운영 효율성이 가장 높다고 판단되는 상태는?',
           JSON_OBJECT('choices', JSON_ARRAY('CCC가 점점 짧아지거나 마이너스(-)일 때', 'CCC가 점점 길어질 때', 'CCC가 매출액과 동일할 때', 'CCC 수치가 0일 때')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '현금이 빨리 돌수록 적은 자본으로도 더 큰 매출을 일으킬 수 있습니다.'),
           NULL
       );

-- Q003. MATCH: 회수 지연의 위험성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS005', 'LV3_CH001_LS005_Q003', 'MATCH',
           '물건을 팔고 현금을 받을 때까지 걸리는 시간을 {{blank}}이라고 하며, 이게 길어지면 현금 흐름이 막힙니다.',
           JSON_OBJECT('choices', JSON_ARRAY('매출채권 회수 기간', '재고자산 회전 기간', '매입채무 지급 기간')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '외상값을 빨리 받아야 기업의 혈액순환이 원활해집니다.'),
           NULL
       );

-- Q004. DRAG: CCC 계산 구성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS005', 'LV3_CH001_LS005_Q004', 'DRAG',
           '현금전환주기 = (재고 회전 기간 + {{blank}}) - {{blank}}',
           JSON_OBJECT('choices', JSON_ARRAY('매출채권 회수 기간', '매입채무 지급 기간', '당기순이익')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '나가는 돈은 늦추고 들어오는 돈은 당기는 것이 경영 효율의 핵심입니다.'),
           NULL
       );

-- Q005. LINK: CCC 변화와 기업 진단
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH001_LS005', 'LV3_CH001_LS005_Q005', 'LINK',
           '현금전환주기(CCC)의 변화 현상과 그에 따른 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','CCC의 대폭 하락'),
                   JSON_OBJECT('id','L2','text','CCC의 대폭 상승'),
                   JSON_OBJECT('id','L3','text','재고 회전 기간의 급증'),
                   JSON_OBJECT('id','L4','text','매입채무 지급 기간의 단축')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','경영 효율성 개선 및 현금 여력 증대'),
                           JSON_OBJECT('id','R2','text','자금 운용의 경고등, 유동성 위기 우려'),
                           JSON_OBJECT('id','R3','text','물건이 안 팔려 창고에 돈이 묶임'),
                           JSON_OBJECT('id','R4','text','현금 유출 속도가 빨라져 불리해짐')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '현금의 속도가 기업의 생사를 결정할 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: Valuation의 철학적 차이 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS001', 'LV3_CH002_LS001_Q001', 'CONCEPT',
           '기업의 가치를 산정하는 두 가지 접근법에 대해 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주식의 가치를 매기는 게 단순히 PER만 보면 되는 거 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', 'PER은 "상대 가치" 평가의 일종이에요. 옆집 식당이 매출 10배에 팔리니까 우리 식당도 10배는 받아야 한다는 논리죠. 쉽고 빠르지만, 옆집이 이미 거품이라면 우리 집도 비싸게 계산된다는 단점이 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 다른 방법은 무엇이 있나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '바로 "절대 가치(내재 가치)" 평가입니다. 남들이 얼마에 팔리든 상관없이, 이 기업이 미래에 벌어다 줄 현금을 꼼꼼히 따져서 현재의 가치를 매기는 방식이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '어떤 게 더 정확한가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '절대 가치는 논리적으로 완벽하지만 가정이 복잡하고, 상대 가치는 현실적이지만 시장 분위기에 휩쓸리기 쉬워요. 프로 투자자는 이 두 가지를 적절히 섞어 "적정 주가의 범위"를 찾아냅니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 남들의 시선(상대)과 기업의 본질(절대)을 동시에 봐야 한다는 거군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 절대 가치 평가 모델의 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS001', 'LV3_CH002_LS001_Q002', 'SELECT',
           '기업이 미래에 창출할 현금흐름을 현재 가치로 할인하여 가치를 매기는 대표적인 절대 가치 평가법은?',
           JSON_OBJECT('choices', JSON_ARRAY('DCF (현금흐름할인법)', 'PER 비교법', 'PBR 비교법', 'EV/EBITDA 비교법')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'DCF는 타 기업과의 비교 없이 기업 자체의 현금 창출력만으로 가치를 산정합니다.'),
           NULL
       );

-- Q003. MATCH: 상대 가치 평가의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS001', 'LV3_CH002_LS001_Q003', 'MATCH',
           '유사한 비즈니스 모델을 가진 기업들의 평균 배수(Multiple)를 적용하는 방식을 {{blank}} 평가라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('상대 가치', '절대 가치', '청산 가치')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '시장 가격을 기준으로 가치를 산정하므로 직관적이고 이해하기 쉽습니다.'),
           NULL
       );

-- Q004. DRAG: 가치 평가의 한계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS001', 'LV3_CH002_LS001_Q004', 'DRAG',
           '절대 가치는 {{blank}} 설정에 따라 결과가 크게 변하고, 상대 가치는 시장 전체의 {{blank}}에 영향을 많이 받습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('미래 가정', '가격 거품', '과거 실적')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '모든 가치 평가 모델은 불완전성을 내포하고 있으므로 보수적인 접근이 필요합니다.'),
           NULL
       );

-- Q005. LINK: 상황별 적합한 평가법 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS001', 'LV3_CH002_LS001_Q005', 'LINK',
           '기업의 상태와 가장 권장되는 가치 평가 방법을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','이익이 일정하고 예측 가능한 기업'),
                   JSON_OBJECT('id','L2','text','동종 업계 상장사가 많은 성장주'),
                   JSON_OBJECT('id','L3','text','자산은 많으나 적자 상태인 기업'),
                   JSON_OBJECT('id','L4','text','여러 사업부가 섞인 지주사')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','DCF (현금흐름할인법)'),
                           JSON_OBJECT('id','R2','text','상대 PER 멀티플'),
                           JSON_OBJECT('id','R3','text','PBR 및 자산 가치 평가'),
                           JSON_OBJECT('id','R4','text','SOTP (사업별 합산)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '상황에 맞는 도구를 골라야 "오답"을 피할 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: 할인율과 시간 가치의 원리 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS002', 'LV3_CH002_LS002_Q001', 'CONCEPT',
           'DCF의 핵심인 "할인율"이 주가에 미치는 영향을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 미래에 100억을 벌 회사면 지금 가치도 100억 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그렇지 않아요. 미래의 100억을 지금 받으려면 "위험"과 "기회비용"을 깎아야 해요. 만약 은행 이자가 10%라면, 내년에 받을 110억은 지금의 100억과 가치가 같죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 미래로 갈수록 가치가 점점 작아지겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 이걸 "할인"이라고 하고, 이때 사용하는 비율을 "할인율($WACC$)"이라고 합니다. 금리가 오르면 이 할인율이 높아져서 미래의 돈이 더 헐값이 돼요. 그래서 고금리 때 성장주 주가가 박살 나는 겁니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 영원히 벌 돈은 어떻게 계산하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 "영구 가치($Terminal Value$)"라는 개념을 써요. 특정 시점 이후로는 매년 일정하게 성장한다고 가정하고 뭉텅이 가치를 매기는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '가정 하나에 주가가 춤을 추겠는데요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확한 지적입니다. 그래서 DCF는 매우 논리적이지만, 입력하는 숫자에 따라 결과가 천차만별이라 "쓰레기를 넣으면 쓰레기가 나온다"는 말도 있습니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 할인율(WACC)의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS002', 'LV3_CH002_LS002_Q002', 'SELECT',
           'DCF에서 기업의 미래 현금흐름을 할인할 때 주로 사용하는 "가중평균자본비용"의 약자는?',
           JSON_OBJECT('choices', JSON_ARRAY('WACC', 'ROE', 'EBITDA', 'EPS')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'WACC은 기업이 자금을 조달할 때 지불하는 평균적인 비용이자 투자자의 기대수익률입니다.'),
           NULL
       );

-- Q003. MATCH: 영구 가치(Terminal Value)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS002', 'LV3_CH002_LS002_Q003', 'MATCH',
           '추정 기간 이후 기업이 영구히 창출할 가치를 현재 가치로 합산한 것을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('영구 가치', '청산 가치', '장부 가치')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'DCF 결과값에서 영구 가치가 차지하는 비중은 보통 50%를 넘습니다.'),
           NULL
       );

-- Q004. DRAG: 할인율과 주가의 반비례
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS002', 'LV3_CH002_LS002_Q004', 'DRAG',
           '할인율이 {{blank}}할수록 미래 현금의 현재 가치는 {{blank}}하여 적정 주가는 하락합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('상승', '하락', '유지')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '할인율은 주가를 누르는 중력과 같습니다.'),
           NULL
       );

-- Q005. LINK: DCF 구성 요소 연결 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS002', 'LV3_CH002_LS002_Q005', 'LINK',
           'DCF 모델의 주요 구성 요소와 그 의미를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','FCF (잉여현금흐름)'),
                   JSON_OBJECT('id','L2','text','WACC (할인율)'),
                   JSON_OBJECT('id','L3','text','Terminal Value'),
                   JSON_OBJECT('id','L4','text','Growth Rate')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','할인의 대상이 되는 기초 현금'),
                           JSON_OBJECT('id','R2','text','미래 돈을 깎는 기준 비율'),
                           JSON_OBJECT('id','R3','text','먼 미래 가치의 총합'),
                           JSON_OBJECT('id','R4','text','현금 흐름이 매년 증가하는 속도')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '이 구성 요소들을 이해해야 보고서의 수치를 해독할 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: SOTP 분석이 필요한 상황 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS003', 'LV3_CH002_LS003_Q001', 'CONCEPT',
           '복잡한 기업의 가치를 정교하게 매기는 SOTP 기법을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 이 회사는 화학도 하고 배터리도 하는데, PER을 화학으로 매겨야 할까요 배터리로 매겨야 할까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '둘 다 따로 해야 해요! 그걸 "SOTP($Sum$-$of$-$the$-$Parts$)"라고 합니다. 화학 부문 가치와 배터리 부문 가치를 각각의 멀티플로 계산해서 합치는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 사업부마다 "급"이 다르니 각각 계산하는 게 공정하겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 여기에 회사가 가진 현금을 더하고 빚은 빼야죠. 그런데 주의할 점이 있어요. 바로 "지주사 할인"입니다. 여러 사업을 한 바구니에 담고 있으면 시장은 보통 20~50% 정도 깎아서 평가하거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '왜 깎는 건가요? 귀한 걸 다 모아놨는데!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '투자자가 직접 배터리 주식을 살 수 있는데 굳이 복잡한 지주사를 거쳐서 살 이유가 적기 때문이죠. 경영권 분쟁이나 불투명한 지배구조 위험도 포함되고요.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 "다 더한 것(SOTP)"보다 주가가 너무 낮다면 그게 바로 저평가 기회가 되겠군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: SOTP 계산의 시작점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS003', 'LV3_CH002_LS003_Q002', 'SELECT',
           'SOTP 분석 시 사업 부문별 가치 외에 기업의 몸값에 반드시 "더해줘야" 하는 항목은?',
           JSON_OBJECT('choices', JSON_ARRAY('순현금 및 보유 자산 가치', '총부채 규모', '미래 마케팅 비용', '직원들의 평균 연봉')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '사업 가치에 기업이 보유한 실제 현금과 부동산 가치를 더해야 전체 가치가 나옵니다.'),
           NULL
       );

-- Q003. MATCH: 지주사 할인(Holding Co. Discount)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS003', 'LV3_CH002_LS003_Q003', 'MATCH',
           '자회사의 가치를 합산한 금액보다 지주사의 시가총액이 낮게 형성되는 현상을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('할인(Discount)', '프리미엄(Premium)', '버블(Bubble)')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '한국 시장에서 특히 지주사 할인이 심하게 나타나는 편입니다.'),
           NULL
       );

-- Q004. DRAG: SOTP 계산 프로세스
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS003', 'LV3_CH002_LS003_Q004', 'DRAG',
           'SOTP 순서: 각 사업부 영업가치 합산 → {{blank}} 가치 합산 → {{blank}} 차감 → 지주사 할인 적용',
           JSON_OBJECT('choices', JSON_ARRAY('비영업자산', '순부채', '매출액')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '영업 가치에 재산은 더하고 빚은 빼는 과정이 필요합니다.'),
           NULL
       );

-- Q005. LINK: 사업 부문별 적정 멀티플 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS003', 'LV3_CH002_LS003_Q005', 'LINK',
           '복합 기업의 사업부 성격에 따라 적용해야 할 적절한 잣대를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','안정적인 현금 창출 사업부'),
                   JSON_OBJECT('id','L2','text','폭발적 성장이 기대되는 신사업'),
                   JSON_OBJECT('id','L3','text','적자가 지속되는 한계 사업'),
                   JSON_OBJECT('id','L4','text','비상장 자회사 지분')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','낮은 PER 또는 배당 수익률 적용'),
                           JSON_OBJECT('id','R2','text','높은 PSR 또는 성장성 프리미엄'),
                           JSON_OBJECT('id','R3','text','청산 가치로 보수적 평가'),
                           JSON_OBJECT('id','R4','text','장부 가치에 일정 할인율 적용')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '각 사업의 색깔에 맞는 멀티플을 써야 정확한 합계가 나옵니다.'),
           NULL
       );

-- Q001. CONCEPT: EV/EBITDA를 쓰는 이유 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS004', 'LV3_CH002_LS004_Q001', 'CONCEPT',
           'PER의 한계를 보완하는 EV/EBITDA 지표에 대해 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 공장을 엄청 크게 짓는 회사는 이익이 안 나서 PER이 너무 높게 나와요. 이럴 땐 어떻게 평가하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럴 때 "EV/EBITDA"가 구세주가 됩니다. 공장을 지으면 장부상 "감가상각비"가 이익을 깎아 먹지만, 사실 통장에서 현금이 나가는 건 아니잖아요?'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 그럼 장부상 적자라도 실제 현금은 많이 벌고 있을 수 있겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '빙고! EBITDA는 이자, 세금, 감가상각비를 빼기 전 이익이라 "순수 현금 창출력"을 보여줘요. 여기에 시가총액에 빚을 더한 "기업 가치(EV)"를 대입하면, 이 기업을 통째로 인수했을 때 투자금을 회수하는 데 몇 년 걸리는지 알 수 있죠.'),
                   JSON_OBJECT('sender', 'user', 'text', 'PER보다 훨씬 더 "인수합병" 관점에 가깝네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다. 설비 투자가 많은 제조업이나 감가상각비가 큰 통신업종 분석에 필수적이죠. 다만 이자와 세금을 무시한다는 점은 꼭 기억해야 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '장부상 착시를 걷어내고 알맹이만 보는 거군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: EV(Enterprise Value)의 구성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS004', 'LV3_CH002_LS004_Q002', 'SELECT',
           '기업 전체의 가치를 뜻하는 EV를 계산하는 공식은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('시가총액 + 순부채', '시가총액 - 현금', '매출액 + 이익', '자산 - 자본')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'EV는 시가총액에 순부채(총부채-현금)를 더해 산출하며, 기업을 인수할 때 지불해야 할 실제 가격을 뜻합니다.'),
           NULL
       );

-- Q003. MATCH: EBITDA의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS004', 'LV3_CH002_LS004_Q003', 'MATCH',
           'EBITDA는 영업이익에 현금 지출이 없는 비용인 {{blank}}를 다시 더해서 구합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('감가상각비', '인건비', '마케팅비')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '유무형자산 상각비를 더해 실제 현금 유입 능력을 파악합니다.'),
           NULL
       );

-- Q004. DRAG: 지표별 적합 산업
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS004', 'LV3_CH002_LS004_Q004', 'DRAG',
           '금융업이나 서비스업은 {{blank}}을 주로 사용하고, 장치 산업인 철강이나 반도체는 {{blank}}을 함께 보는 것이 유리합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('PER', 'EV/EBITDA', 'PBR')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '산업의 비용 구조에 따라 적합한 잣대가 다릅니다.'),
           NULL
       );

-- Q005. LINK: EV/EBITDA 수치 해석 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS004', 'LV3_CH002_LS004_Q005', 'LINK',
           'EV/EBITDA 수치 변화에 따른 투자자의 판단을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','지표가 5배 미만인 제조업'),
                   JSON_OBJECT('id','L2','text','지표가 급격히 하락 중'),
                   JSON_OBJECT('id','L3','text','지표가 동종 업계보다 높음'),
                   JSON_OBJECT('id','L4','text','EBITDA는 늘고 EV는 정체')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','현금 창출력 대비 저평가 상태'),
                           JSON_OBJECT('id','R2','text','현금 흐름 개선 또는 주가 하락 신호'),
                           JSON_OBJECT('id','R3','text','고평가 또는 미래 기대감 선반영'),
                           JSON_OBJECT('id','R4','text','적극적인 매수 검토 구간')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '현금 흐름과 몸값의 비율은 거짓말을 하지 않습니다.'),
           NULL
       );

-- Q001. CONCEPT: 민감도 분석의 필요성 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS005', 'LV3_CH002_LS005_Q001', 'CONCEPT',
           '완벽한 모델은 없습니다. 오차 범위를 관리하는 기술을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 정성껏 계산해서 적정 주가 10만 원을 뽑았어요! 이제 10만 원 갈 때까지 버티면 되죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 숫자를 너무 믿지 마세요! 가령 성장률을 5%로 잡으셨는데, 3%로 떨어지면 어떻게 될까요?'),
                   JSON_OBJECT('sender', 'user', 'text', '음... 그럼 가치가 확 깎이겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '빙고! 그래서 고급 투자자는 "민감도 분석($Sensitivity$-$Analysis$)"을 해요. 성장률이나 금리가 바뀔 때 주가가 어떻게 변하는지 표로 그려보는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, "경우의 수"를 미리 따져보는 거군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그렇죠. 최악의 상황($Bear$-$Case$)에서도 지금 주가보다 가치가 높은지 확인하는 게 "안전마진"을 확보하는 법입니다. 10만 원이라는 "점"이 아니라, 8만 원에서 12만 원 사이라는 "범위"로 생각해야 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 겸손한 마음으로 내 가정이 틀릴 상황까지 대비하는 거군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 민감도 분석의 주요 변수
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS005', 'LV3_CH002_LS005_Q002', 'SELECT',
           'DCF 모델에서 적정 주가에 가장 "민감하게" 영향을 주는 두 가지 핵심 변수는?',
           JSON_OBJECT('choices', JSON_ARRAY('할인율(WACC)과 영구성장률', '회사의 로고 디자인과 사옥 위치', '직원들의 복지 수준과 점심 메뉴')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '할인율과 성장률은 수식의 분모와 분자에 직접 관여하여 결과값을 수십 %씩 변화시킵니다.'),
           NULL
       );

-- Q003. MATCH: 시나리오 분석(Scenario Analysis)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS005', 'LV3_CH002_LS005_Q003', 'MATCH',
           '강세장(Bull), 약세장(Bear), 기본(Base) 상황으로 나누어 가치를 추정하는 것을 {{blank}} 분석이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('시나리오', '기술적', '수급')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '다양한 매크로 환경 변화에 대비하기 위함입니다.'),
           NULL
       );

-- Q004. DRAG: 매수 결정의 근거
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS005', 'LV3_CH002_LS005_Q004', 'DRAG',
           '보수적인 시나리오 하에서도 현재 주가가 내재 가치보다 {{blank}}다면, {{blank}} 확보로 인해 투자 매력도가 높습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('낮다', '안전마진', '높다')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '최악의 경우를 가정해도 싸다면 잃지 않는 투자가 가능합니다.'),
           NULL
       );

-- Q005. LINK: 상황별 주가 예측 변화
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH002_LS005', 'LV3_CH002_LS005_Q005', 'LINK',
           '변수가 아래와 같이 변할 때, 모델상의 기업 가치 변화를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','기준 금리의 인하'),
                   JSON_OBJECT('id','L2','text','영구 성장률의 상향'),
                   JSON_OBJECT('id','L3','text','원자재 값 상승으로 이익률 하락'),
                   JSON_OBJECT('id','L4','text','경쟁사 대비 점유율 하락')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','할인율 하락 → 기업 가치 상승'),
                           JSON_OBJECT('id','R2','text','미래 현금 증가 → 기업 가치 상승'),
                           JSON_OBJECT('id','R3','text','잉여현금흐름 감소 → 기업 가치 하락'),
                           JSON_OBJECT('id','R4','text','멀티플 하향 → 기업 가치 하락')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '변수 간의 유기적 관계를 이해해야 실시간 대응이 가능합니다.'),
           NULL
       );

-- Q001. CONCEPT: 연준의 존재 목적과 시장의 영향 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS001', 'LV3_CH003_LS001_Q001', 'CONCEPT',
           '전 세계 경제의 사령탑인 연준이 어떤 기준으로 움직이는지 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 연준은 왜 물가만 잡으면 되지 고용 지표까지 신경 쓰는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 연준의 "이중 책무(Dual Mandate)" 때문이에요. 법적으로 "물가 안정"과 "최대 고용" 두 가지를 동시에 달성해야 하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '물가가 오르면 금리를 올리는 건 알겠는데, 그럼 고용이 너무 좋으면 금리를 내리나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '반대예요! 고용이 너무 강력하면 사람들의 지갑이 두둑해져서 소비가 늘고, 이게 다시 물가를 자극할 수 있어요. 그래서 연준은 고용 시장이 "적당히 뜨거운지"를 봅니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 주식 시장 입장에서는 고용 지표가 너무 좋게 나오면 오히려 악재일 수도 있겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다! 그걸 "Good is Bad"라고 불러요. 경제가 너무 좋으면 연준이 금리를 더 올릴까 봐 시장이 겁을 먹는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '연준의 금리 결정이 결국 주식 시장의 "돈줄"을 쥐고 있는 셈이군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 연준이 금리를 올리면 시장의 할인율이 높아져 주가 하락 압력이 커지고, 금리를 내리면 유동성이 공급되어 주가가 상승하는 동력이 됩니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 연준의 이중 책무 항목
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS001', 'LV3_CH003_LS001_Q002', 'SELECT',
           '미국 연방준비제도(Fed)가 통화 정책을 결정할 때 가장 중요하게 고려하는 두 가지 핵심 목표는?',
           JSON_OBJECT('choices', JSON_ARRAY('물가 안정과 최대 고용', '주가 지수 상승과 기업 이익 증대', '환율 안정과 수출 증대', '금리 인하와 통화량 무제한 확대')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '연준은 인플레이션을 통제하고 고용을 극대화하는 것을 최우선 과제로 삼습니다.'),
           NULL
       );

-- Q003. MATCH: 연준의 성향 구분
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS001', 'LV3_CH003_LS001_Q003', 'MATCH',
           '물가 안정을 위해 금리 인상을 선호하는 매파(Hawkish)와 달리, 성장을 위해 금리 인하를 선호하는 성향을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('비둘기파(Dovish)', '중립파', '올빼미파')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '비둘기파적 발언은 보통 시장에 유동성 공급 신호로 해석되어 호재로 작용합니다.'),
           NULL
       );

-- Q004. DRAG: 통화 정책의 경로
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS001', 'LV3_CH003_LS001_Q004', 'DRAG',
           '기준 금리 인상 → 시장 {{blank}} 상승 → 기업의 {{blank}} 하락 → 주가 하락 압력',
           JSON_OBJECT('choices', JSON_ARRAY('할인율', '적정 가치(Valuation)', '통화량')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '금리는 자산 가격을 결정하는 가장 강력한 중력과 같습니다.'),
           NULL
       );

-- Q005. LINK: 지표 결과와 시장의 반응
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS001', 'LV3_CH003_LS001_Q005', 'LINK',
           '지표 발표 상황과 시장의 일반적인 해석(긴축기 기준)을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','예상보다 높은 물가(CPI)'),
                   JSON_OBJECT('id','L2','text','예상보다 강력한 고용 지표'),
                   JSON_OBJECT('id','L3','text','실업률의 급격한 상승'),
                   JSON_OBJECT('id','L4','text','연준 의장의 비둘기파적 발언')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id', 'R1', 'text', '추가 금리 인상 공포 및 주가 하락'),
                           JSON_OBJECT('id', 'R2', 'text', '금리 동결 기대 및 시장 안도'),
                           JSON_OBJECT('id', 'R3', 'text', '경기 침체 우려 및 금리 인하 기대'),
                           JSON_OBJECT('id', 'R4', 'text', '유동성 공급 기대 및 주가 반등')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R1', 'L3','R3', 'L4','R4'), 'explanation', '시장의 상황(인플레이션기 vs 침체기)에 따라 지표 해석이 달라질 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: 장단기 금리 역전의 공포 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS002', 'LV3_CH003_LS002_Q001', 'CONCEPT',
           '금융 시장에서 가장 신뢰받는 침체 예보관, 수익률 곡선에 대해 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 뉴스에서 장단기 금리가 역전됐다고 난리인데, 이게 왜 그렇게 무서운 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '원래는 돈을 빌리는 기간이 길수록 이자가 높은 게 정상이에요(우상향 곡선). 그런데 2년짜리 짧은 금리가 10년짜리 긴 금리보다 높아지는 기현상이 발생한 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '왜 그런 일이 생기나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '투자자들이 "가까운 미래(단기)"는 연준의 긴축 때문에 위험하지만, "먼 미래(장기)"는 경기가 나빠져서 금리가 낮아질 거라고 믿기 때문이에요. 즉, 시장이 공식적으로 "미래의 불황"을 점치고 있다는 뜻이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '역전됐다고 바로 침체가 오나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요, 보통 역전된 후 6개월에서 18개월 뒤에 진짜 침체가 찾아왔어요. 역사가 증명하는 아주 높은 확률의 시그널이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 주식은 언제 팔아야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아이러니하게도 역전된 직후보다, 다시 "정상화(Un-inversion)"되는 과정에서 주가가 폭락하는 경우가 많았습니다. 침체가 눈앞에 닥쳤음을 깨닫는 순간이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 금리의 차이가 경기의 온도계를 보여주는 거군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 침체 신호의 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS002', 'LV3_CH003_LS002_Q002', 'SELECT',
           '경기 침체를 예고하는 가장 대표적인 장단기 금리 차(Spread)의 기준은?',
           JSON_OBJECT('choices', JSON_ARRAY('미국채 10년물 금리 - 2년물 금리', '미국채 30년물 금리 - 10년물 금리', '미국 기준금리 - 한국 기준금리')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '10년물과 2년물의 금리 차이가 마이너스가 될 때 시장은 비상등을 켭니다.'),
           NULL
       );

-- Q003. MATCH: 수익률 곡선의 형태
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS002', 'LV3_CH003_LS002_Q003', 'MATCH',
           '경기가 회복되고 성장이 기대될 때 나타나는 일반적인 수익률 곡선의 형태를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('우상향(Steepening)', '평탄화(Flattening)', '역전(Inversion)')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '미래 성장이 기대되면 장기 금리가 단기 금리보다 높은 것이 정상입니다.'),
           NULL
       );

-- Q004. DRAG: 금리 역전의 진행 과정
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS002', 'LV3_CH003_LS002_Q004', 'DRAG',
           '연준의 급격한 긴축 → {{blank}} 금리 급등 → 수익률 곡선 {{blank}} → 경기 침체 우려 확산',
           JSON_OBJECT('choices', JSON_ARRAY('단기', '역전', '장기')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '기준 금리에 민감한 단기 금리가 먼저 튀어 오르며 역전이 시작됩니다.'),
           NULL
       );

-- Q005. LINK: 곡선 형태별 경제 전망
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS002', 'LV3_CH003_LS002_Q005', 'LINK',
           '수익률 곡선의 변화 모습과 그에 따른 경제 전망을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','곡선이 가파르게 우상향'),
                   JSON_OBJECT('id','L2','text','곡선이 평평해짐(Flattening)'),
                   JSON_OBJECT('id','L3','text','곡선의 역전(Inversion)'),
                   JSON_OBJECT('id','L4','text','역전 후 재정상화(Bull-Steepening)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','강력한 경기 회복 및 인플레이션 기대'),
                           JSON_OBJECT('id','R2','text','경기 정점 통과 및 성장 둔화 우려'),
                           JSON_OBJECT('id','R3','text','가까운 미래의 경기 침체 예고'),
                           JSON_OBJECT('id','R4','text','침체 진입 직전 및 금리 인하 임박')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '금리 곡선은 자본주의 경제의 가장 정교한 지도입니다.'),
           NULL
       );

-- Q001. CONCEPT: 유동성 파티와 숙취 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS003', 'LV3_CH003_LS003_Q001', 'CONCEPT',
           '금리 조절이 안 통할 때 꺼내 드는 연준의 최종 병기, QE와 QT를 파헤쳐 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 금리 인하만으로 부족해서 돈을 직접 찍어낸다는 "양적 완화(QE)"가 정확히 뭔가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '연준이 시장에 있는 국채나 주택저당증권(MBS)을 직접 사들이는 거예요. 그 대가로 시장에 현금을 쏟아붓는 거죠. 시중에 돈이 넘쳐나니 자산 가격이 오르고 멀티플이 팽창하게 됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '와, 그럼 주식 시장엔 무조건 축제겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그렇죠. 하지만 파티가 끝나면 "양적 긴축(QT)"이 시작돼요. 연준이 갖고 있던 채권을 다시 시장에 팔거나, 만기가 되어 돌아온 돈을 재투자하지 않고 사라지게 만드는 거죠. 시중의 현금을 빨아들이는 겁니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '돈을 빨아들이면 주식 살 돈이 줄어드니까 주가가 힘을 못 쓰겠군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 특히 QT는 장기 금리를 끌어올리는 효과가 있어서 성장주들에게는 아주 치명적인 환경을 만듭니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '연준의 대차대조표가 줄어드는지 늘어나는지가 내 주식의 "가격표"를 결정하는 셈이네요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '빙고! 연준의 지갑이 닫히기 시작할 때가 가장 주의해야 할 타이밍입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 양적 완화(QE)의 직접적 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS003', 'LV3_CH003_LS003_Q002', 'SELECT',
           '연준이 양적 완화(QE)를 단행할 때 금융 시장에서 나타나는 가장 전형적인 현상은?',
           JSON_OBJECT('choices', JSON_ARRAY('시중 유동성 확대 및 자산 가격 상승', '장기 금리의 급격한 상승', '달러 가치의 폭등', '기업 부도율의 수직 상승')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'QE는 시장에 돈을 풀어 자산 가치를 인위적으로 부양하는 정책입니다.'),
           NULL
       );

-- Q003. MATCH: 양적 긴축(QT)의 매커니즘
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS003', 'LV3_CH003_LS003_Q003', 'MATCH',
           '연준이 보유 자산을 매각하거나 재투자를 중단하여 시중 통화량을 줄이는 것을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('양적 긴축(QT)', '테이퍼링(Tapering)', '금리 인상')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'QT는 연준의 대차대조표를 축소하는 직접적인 유동성 회수 작업입니다.'),
           NULL
       );

-- Q004. DRAG: 정책 변화의 순서
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS003', 'LV3_CH003_LS003_Q004', 'DRAG',
           '유동성 회수 단계: {{blank}} (자산 매입 축소) → 금리 인상 → {{blank}} (자산 매각 및 회수)',
           JSON_OBJECT('choices', JSON_ARRAY('테이퍼링', '양적 긴축(QT)', '양적 완화(QE)')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '연준은 시장 충격을 줄이기 위해 단계적으로 돈줄을 죄어갑니다.'),
           NULL
       );

-- Q005. LINK: 정책과 자산 가격의 관계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS003',
           'LV3_CH003_LS003_Q005',
           'LINK',
           '연준의 조치와 그에 따른 시장의 일반적인 반응을 연결하세요.',

           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','양적 완화(QE) 단행'),
                   JSON_OBJECT('id','L2','text','테이퍼링(Tapering) 발표'),
                   JSON_OBJECT('id','L3','text','금리 인상'),
                   JSON_OBJECT('id','L4','text','양적 긴축(QT) 실행')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','시장 유동성 증가 → 자산 가격 상승 압력'),
                           JSON_OBJECT('id','R2','text','완화 축소 신호 → 변동성 확대 및 기대감 약화'),
                           JSON_OBJECT('id','R3','text','할인율 상승 → 성장주 밸류에이션 압박'),
                           JSON_OBJECT('id','R4','text','현금 회수 → 유동성 감소 및 위험자산 약세')
                            )
           ),

           JSON_OBJECT(
                   'correct', JSON_OBJECT(
                   'L1','R1',
                   'L2','R2',
                   'L3','R3',
                   'L4','R4'
                              ),
                   'explanation', '정책은 “돈의 양(유동성)”과 “돈의 값(금리)”을 동시에 움직이고, 그 변화가 자산 가격의 방향을 결정합니다.'
           ),

           NULL
       );

-- Q001. CONCEPT: 피셔 방정식과 투자 심리 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS004', 'LV3_CH003_LS004_Q001', 'CONCEPT',
           '물가와 금리의 숨바꼭질, "실질 금리"의 위력을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 금리가 5%면 저축하기 좋은 거 아닌가요? 왜 다들 울상이죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '만약 물가 상승률(인플레이션)이 7%라면 어떨까요? 은행에 돈을 넣어둬도 매년 내 돈의 가치가 2%씩 깎이는 셈이죠. 이걸 "실질 금리가 마이너스"라고 해요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 겉보기에만 5%인 거군요. 진짜 수익은 물가를 빼야 보이는 거네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다! 실질 금리는 $r = i - \pi$ (실질금리 = 명목금리 - 인플레이션)로 계산해요. 실질 금리가 낮거나 마이너스일 때는 돈의 가치가 떨어지니 사람들이 주식, 코인, 금 같은 실물 자산으로 달려갑니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '반대로 실질 금리가 플러스로 높게 올라가면요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그때는 현금 가치가 높아지니 위험 자산인 주식, 특히 꿈을 먹고 사는 성장주들이 가장 먼저 타격을 입습니다. 할인율이 실질적으로 높아지기 때문이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 연준이 금리를 올리는 속도가 물가 상승 속도보다 빠를 때가 진짜 위기겠네요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 투자자는 항상 명목 금리 너머의 "물가를 뺀 진짜 금리"를 체크해야 합니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 실질 금리의 계산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS004', 'LV3_CH003_LS004_Q002', 'SELECT',
           '은행 금리가 4%이고 예상 물가 상승률이 5%일 때, 현재의 실질 금리는 얼마일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('9%', '1%', '-1%', '0%')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '실질 금리 = 명목 금리(4%) - 인플레이션(5%) = -1% 입니다.'),
           NULL
       );

-- Q003. MATCH: 기대 인플레이션(BEI)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS004', 'LV3_CH003_LS004_Q003', 'MATCH',
           '채권 시장에서 예상하는 향후 물가 상승률을 {{blank}}이라고 하며, 이는 연준의 정책 결정에 큰 영향을 줍니다.',
           JSON_OBJECT('choices', JSON_ARRAY('기대 인플레이션(BEI)', '근원 물가(Core CPI)', '생산자 물가(PPI)')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '시장의 심리가 반영된 기대 인플레이션은 실제 물가의 선행 지표 역할을 합니다.'),
           NULL
       );

-- Q004. DRAG: 금과 실질 금리의 관계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS004', 'LV3_CH003_LS004_Q004', 'DRAG',
           '실질 금리가 {{blank}}할수록 이자가 없는 자산인 금(Gold)의 매력은 높아지고, 실질 금리가 {{blank}}하면 금값은 하락 압력을 받습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('하락', '상승', '유지')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '금은 실질 금리와 아주 강력한 역상관 관계를 가집니다.'),
           NULL
       );

-- Q005. LINK: 금리/물가 조합별 투자 전략
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS004', 'LV3_CH003_LS004_Q005', 'LINK',
           '매크로 환경 조합에 따른 유리한 자산군을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','저금리 + 고물가 (실질금리 저하)'),
                   JSON_OBJECT('id','L2','text','고금리 + 저물가 (실질금리 상승)'),
                   JSON_OBJECT('id','L3','text','금리 인상 < 물가 상승'),
                   JSON_OBJECT('id','L4','text','금리 동결 + 물가 하락')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','금, 구리 등 원자재 및 실물 자산'),
                           JSON_OBJECT('id','R2','text','현금 및 단기 채권 (현금 가치 상승)'),
                           JSON_OBJECT('id','R3','text','가치주 및 원자재 관련주'),
                           JSON_OBJECT('id','R4','text','성장주 및 기술주 반등')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '인플레이션을 이기는 자산을 찾는 것이 고급 투자의 묘미입니다.'),
           NULL
       );

-- Q001. CONCEPT: 달러의 패권과 자금 흐름 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS005', 'LV3_CH003_LS005_Q001', 'CONCEPT',
           '전 세계 자금의 "지나가는 길"인 달러 인덱스의 비밀을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 미국이 금리를 올리면 왜 한국 주식 시장에서 외국인들이 돈을 빼 가나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 "달러의 몸값" 때문이에요. 미국 금리가 오르면 전 세계 돈들이 더 높은 이자를 찾아 달러로 바뀝니다. 달러 인덱스($DXY$)가 치솟는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '외국인 입장에선 한국 주식이 올라도 달러 가치가 더 오르면 손해겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정답입니다! 그걸 "환차손"이라고 해요. 그래서 달러가 강세일 땐 신흥국 시장에서 자금이 이탈해 안전한 미국으로 돌아갑니다. 반대로 달러가 약세가 되면 유동성이 다시 전 세계로 퍼지며 한국 같은 시장에 훈풍이 불죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 무조건 달러가 약해야 좋은 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그것도 아니에요. "달러 스마일" 이론에 따르면, 미국 경제가 독보적으로 너무 좋거나(성장), 반대로 전 세계 위기가 와서 다들 겁을 먹을 때(공포) 달러는 강해집니다. 웃는 모양의 양 끝이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 전 세계 돈이 "어디로 고이는지" 보려면 달러 차트를 제일 먼저 봐야겠군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞습니다. 글로벌 유동성의 "댐"이 열리는지 닫히는지는 달러 인덱스가 말해줍니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 달러 인덱스(DXY)의 구성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS005', 'LV3_CH003_LS005_Q002', 'SELECT',
           '달러 인덱스(DXY)를 계산할 때 비중이 가장 높은(약 57.6%) 주요 통화는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('유로화(EUR)', '일본 엔화(JPY)', '영국 파운드화(GBP)', '중국 위안화(CNY)')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '달러 인덱스는 주로 유로화와의 상대적 가치에 의해 결정됩니다.'),
           NULL
       );

-- Q003. MATCH: 달러 스마일(Dollar Smile)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS005', 'LV3_CH003_LS005_Q003', 'MATCH',
           '미국 경제의 압도적 성장이나 글로벌 금융 위기 시 달러가 동시에 강세를 보이는 현상을 {{blank}} 이론이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('달러 스마일', '트리핀의 딜레마', '빅맥 지수')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '성장과 공포라는 두 양극단에서 달러 수요가 집중되는 현상입니다.'),
           NULL
       );

-- Q004. DRAG: 자금의 대이동 원리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS005', 'LV3_CH003_LS005_Q004', 'DRAG',
           '달러 강세 → 신흥국 통화 가치 {{blank}} → 외국인 투자자의 {{blank}} 우려 → 자금 유출 발생',
           JSON_OBJECT('choices', JSON_ARRAY('하락', '환차손', '상승')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '환율 변동은 글로벌 투자자의 기대 수익률을 통째로 바꿉니다.'),
           NULL
       );

-- Q005. LINK: 환율 상황별 실전 대응
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS005', 'LV3_CH003_LS005_Q005', 'LINK',
           '달러 가치 변화에 따른 투자 판단을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','달러 인덱스 110 돌파 (초강세)'),
                   JSON_OBJECT('id','L2','text','달러 인덱스 하락 추세 전환'),
                   JSON_OBJECT('id','L3','text','미국 금리 인상 중단 시점'),
                   JSON_OBJECT('id','L4','text','엔화/유로화의 동반 강세')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','리스크 오프, 현금 비중 확대 필요'),
                           JSON_OBJECT('id','R2','text','신흥국 주식 및 위험 자산 매수 기회'),
                           JSON_OBJECT('id','R3','text','달러 정점 통과 신호, 자산 재배분'),
                           JSON_OBJECT('id','R4','text','상대적인 달러 약세 유도 환경')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '달러의 힘을 읽는 자가 글로벌 시장의 승자가 됩니다.'),
           NULL
       );

-- Q001. CONCEPT: 인간의 뇌는 투자에 부적합하다? (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS001', 'LV3_CH004_LS001_Q001', 'CONCEPT',
           '왜 똑똑한 사람들도 주식 시장에서 돈을 잃는지, 퀀트가 그 해답이 되는 이유를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 전 차트도 보고 뉴스도 열심히 분석하는데 왜 자꾸 고점에서 사고 저점에서 팔까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 사용자님의 지능 문제가 아니라 인간의 "진화된 본능" 때문이에요. 인간의 뇌는 손실을 보면 고통을 2.5배 더 크게 느끼고(손실 회피 편향), 최신 뉴스에 더 큰 무게를 두도록 설계되었거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 머리로는 알겠는데 가슴이 시키는 대로 매매하게 되는 거군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 퀀트($Quant$) 투자는 바로 이런 "감정"을 완전히 제거하고, 미리 정해진 "수학적 규칙"에 따라 기계적으로 매매하는 방식입니다. "PER이 낮고 ROE가 높은 종목 20개를 사서 6개월마다 바꾼다"는 명확한 알고리즘을 따르는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 퀀트는 예측을 하는 게 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '예측보다는 "확률"에 베팅하는 거예요. 과거 20년 동안 이런 규칙을 따랐을 때 시장보다 수익률이 높았다는 통계적 근거를 가지고, 이번에도 그럴 확률이 높다고 믿고 베팅하는 시스템이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 나 자신보다 차가운 숫자의 규칙을 더 믿는 것이 퀀트의 핵심이군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 퀀트 투자의 핵심 요소
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS001', 'LV3_CH004_LS001_Q002', 'SELECT',
           '퀀트 투자(Quantitative Investing)를 정의할 때 가장 부합하는 설명은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('직관과 영감에 의존한 예술적 매매', '데이터와 통계 기반의 규칙적 매매', '유명 유튜버의 추천에 따른 매매', '기업 탐방을 통한 주관적 판단 매매')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '퀀트는 객관적인 데이터와 정량적 지표만을 사용하여 투자 결정을 내립니다.'),
           NULL
       );

-- Q003. MATCH: 투자의 적, 심리 편향
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS001', 'LV3_CH004_LS001_Q003', 'MATCH',
           '내가 산 주식은 무조건 오를 것이라 믿고 유리한 정보만 수집하는 현상을 {{blank}} 편향이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('확증', '최신성', '군집')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '확증 편향은 객관적인 판단을 가로막는 가장 무서운 심리적 함정입니다.'),
           NULL
       );

-- Q004. DRAG: 퀀트 투자 프로세스
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH004_LS001', 'LV3_CH004_LS001_Q005', 'LINK',
  '전통적 가치 투자와 퀀트 투자의 특징을 올바르게 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','전통적 가치 투자'),
      JSON_OBJECT('id','L2','text','퀀트(계량) 투자'),
      JSON_OBJECT('id','L3','text','기술적 분석 매매'),
      JSON_OBJECT('id','L4','text','뇌동 매매')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','소수 종목 정성적 분석 및 장기 보유'),
      JSON_OBJECT('id','R2','text','대규모 종목 정량적 스크리닝 및 분산'),
      JSON_OBJECT('id','R3','text','차트 패턴과 추세를 이용한 타이밍 포착'),
      JSON_OBJECT('id','R4','text','원칙 없이 감정에 휩쓸린 즉흥적 거래')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '좋은 지표를 고르고 이를 규칙에 따라 실행하는 과정입니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 저평가 우량주를 찾는 퀀트의 공식 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS002', 'LV3_CH004_LS002_Q001', 'CONCEPT',
           '퀀트 투자자들이 가장 사랑하는 두 가지 무기, 가치(Value)와 퀄리티(Quality)를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 팩터($Factor$)라는 말이 어렵게 들려요. 쉽게 설명해 주실 수 있나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '쉽게 말해 "주가를 움직이는 유전적 특징" 같은 거예요. 예를 들어 "가치 팩터"는 주가가 실적이나 자산에 비해 싼 종목들이 결국 오르더라는 통계적 성질을 이용하는 거죠. 저PER, 저PBR 종목을 고르는 것이 여기에 해당합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 단순히 싼 것만 고르면 되는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럼 "싼 게 비지떡"인 지뢰주에 걸릴 수 있어요. 그래서 "퀄리티 팩터"를 섞어줍니다. 돈을 얼마나 효율적으로 잘 버는지(ROE), 빚은 적은지(부채비율), 현금은 잘 도는지(GP/A)를 따지는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 싼 것 중에서 진짜 실력이 좋은 녀석들만 추려내는 거군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정답입니다! 가치 지표로 하방을 지지하고, 퀄리티 지표로 우상향의 가능성을 높이는 거예요. 이 두 지표를 조합한 "슈퍼 퀄리티" 전략은 수십 년간 시장 지수를 압도하는 성과를 보여왔습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 좋은 팩터를 조합하는 것이 퀀트 전략의 핵심 요리법이네요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 대표적인 퀄리티 팩터
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS002', 'LV3_CH004_LS002_Q002', 'SELECT',
           '기업의 수익성과 효율성을 측정하는 "퀄리티(Quality) 팩터"에 가장 가까운 지표는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('ROE (자기자본이익률)', '시가총액', '일일 거래량', '어제 주가 상승률')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'ROE는 기업이 자본을 얼마나 잘 활용하여 돈을 벌었는지 보여주는 핵심 퀄리티 지표입니다.'),
           NULL
       );

-- Q003. MATCH: 가치 팩터의 지표
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS002', 'LV3_CH004_LS002_Q003', 'MATCH',
           '장부 가치 대비 주가가 싼 기업을 고르는 가치 팩터의 대표 지표는 {{blank}}입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('PBR', 'RSI', 'MACD')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'PBR이 낮을수록 순자산 대비 저평가된 것으로 판단합니다.'),
           NULL
       );

-- Q004. DRAG: 멀티 팩터 전략의 장점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH004_LS002', 'LV3_CH004_LS002_Q005', 'LINK',
  '퀀트 지표와 그 지표가 속한 팩터군을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','저PER / 저PBR'),
      JSON_OBJECT('id','L2','text','고ROE / 저부채비율'),
      JSON_OBJECT('id','L3','text','52주 신고가 근접'),
      JSON_OBJECT('id','L4','text','낮은 시가총액')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','가치 (Value) 팩터'),
      JSON_OBJECT('id','R2','text','퀄리티 (Quality) 팩터'),
      JSON_OBJECT('id','R3','text','모멘텀 (Momentum) 팩터'),
      JSON_OBJECT('id','R4','text','사이즈 (Size) 팩터')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '서로 다른 성격의 팩터를 섞으면 상호 보완 효과가 발생합니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 상승의 관성과 소외된 진주 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS003', 'LV3_CH004_LS003_Q001', 'CONCEPT',
           '시장의 에너지를 이용하는 모멘텀과 소형주 전략에 대해 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주가가 많이 오른 주식은 떨어질 것 같아 무서운데, 이걸 사는 퀀트 전략이 있다고요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, 바로 "모멘텀($Momentum$)" 전략이에요. 최근 6개월에서 1년 동안 시장보다 많이 오른 주식은 그 기세를 몰아 앞으로도 더 오르려는 "관성"이 있다는 통계적 사실에 기반하죠. "달리는 말에 올라타는" 기술입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '떨어지는 칼날보다 달리는 말이 더 안전하다는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '통계적으로는 그래요. 상승 추세에 있는 종목은 대중의 관심과 수급이 몰리기 때문이죠. 여기에 하나 더, "소형주 효과($Small$-$cap$-$Effect$)"라는 아주 강력한 팩터가 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '우량한 대형주가 더 좋은 거 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '대형주는 이미 가치가 널리 알려져 있죠. 하지만 시가총액 하위 20%의 소형주는 애널리스트들의 관심 밖인 경우가 많아 "숨겨진 보석"들이 저렴한 가격에 방치되곤 합니다. 역사적으로 소형주이면서 저평가된 종목들의 수익률은 대형주를 압도해 왔습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 시장의 소외와 열광을 모두 데이터로 이용하는 거군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 모멘텀의 판단 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS003', 'LV3_CH004_LS003_Q002', 'SELECT',
           '퀀트에서 "모멘텀"을 측정할 때 주로 사용하는 데이터는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('과거 3~12개월간의 주가 수익률', '기업 대표의 사회적 명성', '제품의 디자인 혁신성', '내년도 예상 영업이익률')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '가격 모멘텀은 과거의 수익률 추세가 지속될 확률을 수치화한 것입니다.'),
           NULL
       );

-- Q003. MATCH: 사이즈 팩터의 핵심
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS003', 'LV3_CH004_LS003_Q003', 'MATCH',
           '시가총액이 작을수록 초과 수익이 발생할 확률이 높다는 통계적 현상을 {{blank}} 효과라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('소형주', '대형주', '중견주')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '소형주는 저평가 기회가 많고 성장 탄력이 큽니다.'),
           NULL
       );

-- Q004. DRAG: 모멘텀의 함정
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH004_LS003', 'LV3_CH004_LS003_Q005', 'LINK',
  '팩터의 성격과 적합한 매수 논리를 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','가치 팩터 매수'),
      JSON_OBJECT('id','L2','text','모멘텀 팩터 매수'),
      JSON_OBJECT('id','L3','text','소형주 팩터 매수'),
      JSON_OBJECT('id','L4','text','퀄리티 팩터 매수')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','제 가치보다 싸니까 언젠가 오를 거야'),
      JSON_OBJECT('id','R2','text','남들이 미친 듯이 사니까 더 갈 거야'),
      JSON_OBJECT('id','R3','text','아무도 모르지만 조만간 발견될 거야'),
      JSON_OBJECT('id','R4','text','장사를 너무 잘하니까 망할 리가 없어')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '기세가 꺾이는 지점을 잘 포착하는 것이 모멘텀의 숙제입니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 과거의 영광은 미래의 보증수표인가? (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS004', 'LV3_CH004_LS004_Q001', 'CONCEPT',
           '전략을 완성했다면 검증해야 합니다. 백테스팅의 기술을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님! 제 전략을 지난 10년치 데이터로 돌려봤더니 연 수익률 100%가 넘게 나왔어요! 저 이제 부자 된 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '잠깐만요, 축하하기엔 일러요! 혹시 "과적합($Overfitting$)"이라는 덫에 빠진 게 아닐까요? 오직 그 과거 기간에만 우연히 잘 들어맞도록 공식을 억지로 끼워 맞춘 것일 수 있거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 과거에는 우연히 맞았지만 미래에는 안 통할 수도 있다는 거군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그렇죠. 백테스팅($Backtesting$)은 전략의 신뢰도를 보는 거지, 미래 수익을 보장하는 게 아니에요. 특히 상장 폐지된 기업을 제외하고 테스트하는 "생존자 편향"이나, 수수료와 세금을 계산 안 한 경우 성과가 뻥튀기될 수 있죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 어떻게 해야 진짜 실력 있는 전략인지 알 수 있나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '데이터를 둘로 나눠보세요. 2010~2019년 데이터로 전략을 만들고($In$-$Sample$), 한 번도 안 본 2020~2025년 데이터로 검증($Out$-$of$-$Sample$)해보는 거죠. 두 기간 모두 성과가 좋다면 그 전략은 "강건(Robust)"하다고 볼 수 있습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 전략도 가혹한 테스트를 거쳐야 실전에 나갈 수 있겠군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 과적합(Overfitting)의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS004', 'LV3_CH004_LS004_Q002', 'SELECT',
           '퀀트 전략 수립 시 "과적합"이 발생했을 때 나타나는 현상은?',
           JSON_OBJECT('choices', JSON_ARRAY('과거 데이터에는 완벽하지만 실전(미래)에서는 처참하게 실패함', '수익률이 영원히 일정하게 유지됨', '전략이 너무 단순해서 이해하기 쉬움')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '과적합은 과거의 "소음"까지 신호로 오해하여 공식을 만든 결과입니다.'),
           NULL
       );

-- Q003. MATCH: 생존자 편향(Survivorship Bias)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS004', 'LV3_CH004_LS004_Q003', 'MATCH',
           '현재 상장되어 있는 기업들로만 과거 수익률을 테스트하여 결과가 실제보다 좋게 나오는 오류를 {{blank}} 편향이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('생존자', '확증', '낙관')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '망해서 없어진 기업의 데이터도 포함해야 공정한 테스트입니다.'),
           NULL
       );

-- Q004. DRAG: 백테스팅 필수 고려 항목
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH004_LS004', 'LV3_CH004_LS004_Q005', 'LINK',
  '전략 검증 시 사용되는 핵심 지표와 그 의미를 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','CAGR'),
      JSON_OBJECT('id','L2','text','MDD'),
      JSON_OBJECT('id','L3','text','Sharpe Ratio'),
      JSON_OBJECT('id','L4','text','Turnover')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','연평균 기하 수익률'),
      JSON_OBJECT('id','R2','text','전 고점 대비 최대 낙폭'),
      JSON_OBJECT('id','R3','text','위험 대비 수익의 효율성'),
      JSON_OBJECT('id','R4','text','종목 교체 주기 및 매매 빈도')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '실제 매매 시 발생하는 비용은 수익률을 갉아먹는 핵심 요소입니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 끝까지 살아남는 퀀트의 비결 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS005', 'LV3_CH004_LS005_Q001', 'CONCEPT',
           '수익보다 리스크를 먼저 관리하는 퀀트의 철학을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 수익률만 높으면 장땡 아닌가요? 왜 자꾸 리스크 관리를 강조하시죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '사용자님, 만약 계좌가 -50%가 된다면 멘탈을 지키고 전략을 계속 유지할 수 있을까요? 아마 대부분은 공포에 질려 투자를 그만두겠죠. 그래서 퀀트에선 "MDD($Maximum$-$Drawdown$)"를 가장 중요하게 봅니다. 내 자산이 고점 대비 가장 많이 깨졌을 때 얼마나 아픈지를 나타내는 수치죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 아무리 많이 벌어도 중간에 포기하면 끝이니까요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. MDD를 낮게 유지해야 복리의 마법을 끝까지 누릴 수 있습니다. 그리고 이를 위해 필요한 것이 "리밸런싱($Rebalancing$)"이에요. 정해진 기간마다 종목의 순위를 다시 매겨서, 팩터 점수가 낮아진 종목은 팔고 새로 좋아진 종목으로 갈아끼우는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '정기적으로 잡초를 뽑고 꽃을 심는 과정이군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '완벽한 비유예요! 리밸런싱을 통해 한 종목에 쏠리는 리스크를 막고, 시장 상황에 맞는 최적의 포트폴리오를 유지할 수 있습니다. 퀀트 투자는 결국 "잘 버티는 놈이 이긴다"는 것을 보여주는 리스크 관리의 예술입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 겸손하게 위험을 관리하는 자가 승리한다는 진리를 데이터가 말해주네요!')
           ), NULL, NULL
       );

-- Q002. SELECT: MDD의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS005', 'LV3_CH004_LS005_Q002', 'SELECT',
           '투자자의 인내심을 테스트하는 지표로, 고점 대비 최대 하락폭을 뜻하는 용어는?',
           JSON_OBJECT('choices', JSON_ARRAY('MDD (Maximum Drawdown)', 'CAGR', 'PBR', 'Volatility')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'MDD는 하락장의 고통을 수치화한 것이며, 이를 낮추는 것이 전략의 핵심 목표 중 하나입니다.'),
           NULL
       );

-- Q003. MATCH: 리밸런싱의 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH004_LS005', 'LV3_CH004_LS005_Q003', 'MATCH',
           '주기적으로 자산 비중이나 종목 구성을 조정하여 리스크를 관리하는 행위를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('리밸런싱', '몰빵 투자', '장외 거래')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '리밸런싱은 통계적 우위를 유지하고 리스크를 분산시키는 필수 작업입니다.'),
           NULL
       );

-- Q004. DRAG: 리스크와 보상
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH004_LS005', 'LV3_CH004_LS005_Q005', 'LINK',
  '투자 시 직면하는 리스크와 그에 대한 퀀트적 해결책을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','특정 종목의 급락 리스크'),
      JSON_OBJECT('id','L2','text','상승 추세 붕괴 리스크'),
      JSON_OBJECT('id','L3','text','과도한 하락장 고통'),
      JSON_OBJECT('id','L4','text','팩터 유효성 상실')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','20개 이상의 종목 분산 투자'),
      JSON_OBJECT('id','R2','text','이동평균선 기반 현금 비중 조절'),
      JSON_OBJECT('id','R3','text','자산 배분(주식+채권+현금)'),
      JSON_OBJECT('id','R4','text','주기적 리밸런싱 및 전략 보완')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '안정적이면서 수익성 높은 전략을 찾는 것이 퀀트의 목표입니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 손실 회피의 심리학 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS001', 'LV3_CH005_LS001_Q001', 'CONCEPT',
           '우리가 손절을 못 하고 수익은 짧게 끊는 이유를 행동 경제학 관점에서 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 수익 난 주식은 조금만 올라도 팔고 싶어서 안달인데, 왜 손실 난 주식은 마이너스 50%가 되어도 못 팔겠나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 사용자님이 부족해서가 아니라 인간의 본능인 "손실 회피 편향" 때문이에요. 대니얼 카너먼 교수가 입증했죠. 인간은 100만 원을 벌었을 때의 기쁨보다, 100만 원을 잃었을 때의 고통을 2배 이상 크게 느낍니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그래서 손실을 확정 짓는 게 그렇게 괴로웠던 거군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 손실이 나면 사람은 "도박적 성향"으로 변해요. 손실을 인정하기 싫어서 "본전까지만 오면 팔아야지" 하며 비합리적으로 버티거나 물을 타죠. 반대로 이익이 나면 "이거라도 챙겨야 해"라며 확실한 이익을 챙기려는 "위험 회피" 성향으로 변합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 "수익은 짧게, 손실은 길게"라는 최악의 투자를 하게 되는 거네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다. 이걸 극복하려면 손실을 "비용"으로 생각하는 훈련이 필요해요. 낚시꾼이 미끼를 잃는 것을 아까워하지 않듯, 투자자도 원칙을 지키기 위한 손절을 투자의 일부로 받아들여야 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '내 본능이 투자의 성공을 방해하고 있었다니 충격적이네요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '성공한 1%의 투자자는 이 본능을 억제하고 "시스템"에 의존합니다. 고통스럽더라도 기계가 되기로 결심하는 순간부터가 진짜 고급 투자자의 시작입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 손실 회피 성향의 결과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS001', 'LV3_CH005_LS001_Q002', 'SELECT',
           '인간이 손실 회피 편향에 빠졌을 때 나타나는 가장 전형적인 행동은?',
           JSON_OBJECT('choices', JSON_ARRAY('이익은 길게 가져가고 손실은 즉시 끊는다', '이익은 조기에 확정하고 손실은 방치하며 본전을 기다린다', '이익과 손실에 똑같은 감정을 느낀다')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '인간은 본능적으로 손실 확정을 회피하려다 더 큰 손실을 초래합니다.'),
           NULL
       );

-- Q003. MATCH: 처분 효과(Disposition Effect)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS001', 'LV3_CH005_LS001_Q003', 'MATCH',
           '오르는 주식은 빨리 팔고, 내리는 주식은 끝까지 보유하는 투자자의 심리적 오류를 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('처분 효과', '매몰 비용', '후광 효과')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '처분 효과는 계좌 수익률을 갉아먹는 가장 큰 주범 중 하나입니다.'),
           NULL
       );

-- Q004. DRAG: 심리적 프레이밍
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH005_LS001', 'LV3_CH005_LS001_Q005', 'LINK',
  '투자의 상황과 그에 적합한 심리적 처방을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','보유 종목 급락 시'),
      JSON_OBJECT('id','L2','text','수익 구간 진입 시'),
      JSON_OBJECT('id','L3','text','손절 후 재매수 고민 시'),
      JSON_OBJECT('id','L4','text','전체 장이 공포에 질릴 때')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','기계적 손절가 준수 및 냉정 유지'),
      JSON_OBJECT('id','R2','text','추세 붕괴 전까지 수익 극대화'),
      JSON_OBJECT('id','R3','text','과거 매수가를 잊고 현재 가치 집중'),
      JSON_OBJECT('id','R4','text','대중의 패닉을 역발상 기회로 활용')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '관점을 바꾸는 것이 심리적 고통을 줄이는 기술입니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 숫자의 감옥, 앵커링 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS002', 'LV3_CH005_LS002_Q001', 'CONCEPT',
           '내가 산 주식 가격이 내 판단을 가로막는 무서운 원리를 파헤쳐 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주가가 떨어졌는데도 "내가 5만 원에 샀으니까 최소한 5만 원은 다시 오겠지"라는 생각에 팔 수가 없어요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 "닻 내리기(Anchoring) 효과"에 당하신 거예요. 5만 원이라는 숫자에 뇌가 닻을 내리고 고정되어 버린 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '시장은 제가 얼마에 샀는지 전혀 관심이 없는데 말이죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 주식 시장은 사용자님이 얼마에 샀는지 알지도 못하고 배려하지도 않아요. 오직 기업의 현재 가치와 수급에 의해서만 움직이죠. 하지만 우리는 무의식중에 "내 매수가"를 기준으로 싸다 비싸다를 판단합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '어떻게 해야 이 닻을 끊어낼 수 있나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '매일 아침 스스로에게 물어보세요. "내가 오늘 이 종목을 안 들고 있다면, 지금 이 가격에 새로 살 것인가?"'),
                   JSON_OBJECT('sender', 'user', 'text', '오, "새로 사지 않을 종목"이라면 들고 있을 이유도 없다는 거군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정답입니다! 매수가라는 허상을 지우고 현재의 냉정한 데이터에 집중하는 것, 그것이 닻을 끊고 자유로운 항해를 시작하는 첫걸음입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 앵커링의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS002', 'LV3_CH005_LS002_Q002', 'SELECT',
           '행동 경제학에서 "닻 내리기 효과(Anchoring Effect)"가 투자자에게 미치는 영향은?',
           JSON_OBJECT('choices', JSON_ARRAY('처음 제시된 숫자(매수가 등)에 사로잡혀 새로운 정보를 무시하게 된다', '파도를 잘 타서 수익을 극대화하게 도와준다', '기업의 재무제표를 더 꼼꼼히 보게 만든다')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '과거의 숫자나 내 매수가에 집착하면 합리적인 판단을 내릴 수 없습니다.'),
           NULL
       );

-- Q003. MATCH: 매몰 비용의 오류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS002', 'LV3_CH005_LS002_Q003', 'MATCH',
           '이미 지불하여 회복할 수 없는 시간과 돈에 집착하여 잘못된 결정을 유지하는 것을 {{blank}} 오류라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('매몰 비용', '기회비용', '한계 비용')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '투자한 시간과 돈이 아까워서 나쁜 투자를 지속하는 것은 비합리적입니다.'),
           NULL
       );

-- Q004. DRAG: 객관적 판단의 방해물
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH005_LS002', 'LV3_CH005_LS002_Q005', 'LINK',
  '심리적 앵커링을 극복하기 위한 생각의 전환을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','52주 최고가 대비 반토막'),
      JSON_OBJECT('id','L2','text','내 매수가보다 -30%'),
      JSON_OBJECT('id','L3','text','익절 후 주가가 더 오를 때'),
      JSON_OBJECT('id','L4','text','유명 전문가의 목표가 10만 원')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','과거의 영광일 뿐 현재 악재 확인'),
      JSON_OBJECT('id','R2','text','매수가는 잊고 보유 근거 재점검'),
      JSON_OBJECT('id','R3','text','내 수익은 내 원칙의 몫임을 인정'),
      JSON_OBJECT('id','R4','text','남의 숫자가 아닌 나만의 시나리오 작성')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '수익률 계산보다는 기업의 미래 가치 변화에 주목해야 합니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 군중 심리와 주도주의 끝 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS003', 'LV3_CH005_LS003_Q001', 'CONCEPT',
           '남들이 다 돈 벌었다고 할 때 주식을 사고 싶은 이유와 그 위험성을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 요즘 에코OOO 안 들고 있으면 바보라는 소리를 들어요. 지금이라도 영끌해서 사야 할까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 소외감이 바로 "FOMO($Fear$-$of$-$Missing$-$Out$)"예요. 인간은 사회적 동물이라 무리에서 떨어져 나가는 것을 죽음만큼 무서워하죠. 주식 시장은 이 공포를 먹고 거품을 키웁니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '하지만 다들 사니까 안전해 보이기도 하는데요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 함정입니다. "군집 행동(Herding)"은 책임감을 분산시켜서 사람들을 눈멀게 해요. 역사적으로 튤립 투기부터 닷컴 버블까지, "이번에는 다르다"며 집단 광기에 빠졌을 때가 언제나 폭락 직전이었습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 남들이 환호할 때 전 어떻게 해야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '하워드 막스는 말했습니다. "남들과 똑같이 해서는 결코 시장을 이길 수 없다." 최고의 수익은 남들이 공포에 질려 던질 때 사고, 남들이 탐욕에 눈이 멀어 달려들 때 조용히 파는 "역발상 투자"에서 나옵니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 외로움을 견디는 자만이 큰 수익을 얻는다는 뜻이군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 투자자는 무리의 한가운데가 아니라, 무리를 밖에서 지켜보는 관찰자가 되어야 합니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: FOMO 증후군의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS003', 'LV3_CH005_LS003_Q002', 'SELECT',
           '주식 투자에서 말하는 "FOMO" 증후군의 핵심적인 심리는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('나만 기회를 놓치고 가난해질 것 같은 두려움', '주가가 너무 많이 올라서 팔고 싶은 욕구', '기업의 재무 상태가 나빠질까 봐 걱정하는 마음')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '타인과의 비교에서 오는 열등감과 소외감이 무리한 투자를 유발합니다.'),
           NULL
       );

-- Q003. MATCH: 정보 전염(Information Cascade)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS003', 'LV3_CH005_LS003_Q003', 'MATCH',
           '개인이 자신의 정보를 무시하고 타인의 행동만을 따라가는 현상을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('군집 행동', '독립적 사고', '역발상 투자')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '군집 행동은 가격의 왜곡(거품)을 만드는 근본적인 원인입니다.'),
           NULL
       );

-- Q004. DRAG: 매매의 역행적 지표
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH005_LS003', 'LV3_CH005_LS003_Q005', 'LINK',
  '시장의 신호와 그에 따른 심리적 대응을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','공포/탐욕 지수 90점 돌파'),
      JSON_OBJECT('id','L2','text','공포/탐욕 지수 10점 기록'),
      JSON_OBJECT('id','L3','text','주변에서 대출받아 주식 시작'),
      JSON_OBJECT('id','L4','text','뉴스에서 연일 "주식 폭망" 보도')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','광기 확인, 비중 축소 및 익절'),
      JSON_OBJECT('id','R2','text','극심한 공포, 분할 매수 타점'),
      JSON_OBJECT('id','R3','text','정점 징후, 현금 비중 확대'),
      JSON_OBJECT('id','R4','text','바닥 징후, 핵심 종목 홀딩')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '시장의 에너지가 한쪽 끝으로 쏠릴 때가 기회 혹은 위기입니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 과거는 맑음, 미래는 안개 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS004', 'LV3_CH005_LS004_Q001', 'CONCEPT',
           '우리가 과거 차트를 볼 때 왜 다 쉬워 보이는지, 그 무서운 착각에 대해 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 지나간 차트를 보면 저점이랑 고점이 너무 뻔히 보이는데, 왜 실전에서는 그걸 못 잡을까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 "사후 확신 편향($Hindsight$ $Bias$)" 때문이에요. 결과가 이미 나온 뒤에는 그 사건이 일어난 원인들만 눈에 띄거든요. 그래서 마치 내가 처음부터 다 알고 있었던 것 같은 착각에 빠지죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '맞아요! 급등주를 보면서 "아, 저때 살까 말까 고민했었는데 역시 내 생각이 맞았어"라고 위안 삼곤 해요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 가장 위험한 지점입니다. "나는 시장을 잘 맞혀"라는 가짜 자신감이 생기거든요. 실전에서는 안개 속을 걷는 것처럼 수많은 변수가 섞여 있는데, 지나간 뒤에는 그 안개가 싹 걷힌 상태로 보이니까요.'),
                   JSON_OBJECT('sender', 'user', 'text', '이 착각이 실전 매매에 어떤 영향을 주나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '운 좋게 번 돈을 내 실력이라고 믿게 만들어요. 그러면 리스크 관리를 소홀히 하게 되고, 결국 다음 매매에서 큰 코를 다치게 되죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 이 편향을 어떻게 이겨낼 수 있을까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '매수 버튼을 누르기 직전의 "솔직한 생각"을 기록하는 수밖에 없어요. 매매 일지에 "지금 너무 무섭다"거나 "이런 지표 때문에 산다"고 적어두면, 나중에 결과를 보고 "그럴 줄 알았어"라고 변명하지 못하게 되죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 기록만이 내 뇌의 거짓말을 잡아낼 수 있는 증거가 되겠군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그렇습니다. 결과가 아닌 "과정의 기록"에 집중할 때, 투자자는 비로소 근거 있는 자신감을 가질 수 있습니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 사후 확신 편향의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS004', 'LV3_CH005_LS004_Q002', 'SELECT',
           '이미 발생한 사건에 대해 "그럴 줄 알았다"며 자신의 예측력을 과대평가하는 심리적 현상은?',
           JSON_OBJECT('choices', JSON_ARRAY('사후 확신 편향', '확증 편향', '후광 효과', '매몰 비용')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '결과를 알고 나면 그 과정이 필연적이었다고 착각하게 됩니다.'),
           NULL
       );

-- Q003. MATCH: 자만심의 근원
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS004', 'LV3_CH005_LS004_Q003', 'MATCH',
           '사후 확신 편향은 투자자에게 근거 없는 {{blank}}을 심어주어 과도한 베팅을 유발하는 원인이 됩니다.',
           JSON_OBJECT('choices', JSON_ARRAY('자만심', '불안감', '냉정함')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '자신이 시장을 예측할 수 있다는 착각은 파산의 지름길입니다.'),
           NULL
       );

-- Q004. DRAG: 매매 일지의 역할
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH005_LS004', 'LV3_CH005_LS004_Q005', 'LINK',
  '매매 결과에 따른 올바른 자기 객관화 질문을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','수익이 났을 때'),
      JSON_OBJECT('id','L2','text','손실이 났을 때'),
      JSON_OBJECT('id','L3','text','예측과 다르게 흘러갈 때'),
      JSON_OBJECT('id','L4','text','급등주를 놓쳤을 때')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','원칙에 의한 수익인가, 우연인가?'),
      JSON_OBJECT('id','R2','text','내가 놓친 데이터는 무엇이었나?'),
      JSON_OBJECT('id','R3','text','당시 내 기록에 이런 변수가 있었나?'),
      JSON_OBJECT('id','R4','text','당시 내가 못 샀던 합리적 이유는?')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '기록은 과거의 나를 객관적으로 마주하게 해줍니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 밤 10시에 테슬라를 사면 안 되는 이유 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS005', 'LV3_CH005_LS005_Q001', 'CONCEPT',
           '의지력이 바닥났을 때 나타나는 "자아 고갈" 현상과 투자 대응법을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 낮에는 냉정하게 생각하다가도, 퇴근하고 밤늦게 미국 주식 창을 보면 왜 그렇게 손가락이 가벼워질까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그건 "자아 고갈($Ego$ $Depletion$)" 현상 때문이에요. 인간의 의지력은 한정된 배터리와 같아서, 낮 동안 업무에 시달리며 에너지를 다 쓰고 나면 밤에는 "참는 능력"이 급격히 떨어지거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그래서 평소엔 거들떠보지도 않던 급등주에 나도 모르게 올라타는 거군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 뇌가 지치면 깊은 분석보다는 본능적이고 짜릿한 보상을 원하게 되죠. 이때는 리스크가 전혀 보이지 않고 수익의 환상만 보입니다. 주식 시장에서 가장 위험한 시간은 내 몸과 정신이 가장 지쳐있을 때예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 지친 뇌로 매매하지 않으려면 어떻게 해야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '두 가지 해결책이 있어요. 첫째는 "중요한 결정은 오전에만 내리는 것"이고, 둘째는 "자동화된 예약 매매"를 활용하는 거예요. 정신이 맑을 때 세운 계획을, 지친 내가 건드리지 못하게 시스템으로 묶어두는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '내 의지력을 믿지 말고, 미리 짜놓은 시스템을 믿으라는 거군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '빙고! 투자 고수들은 자신의 의지력이 약하다는 것을 인정하는 사람입니다. 뇌의 배터리가 방전되었을 때 내리는 결정은 투자가 아니라 "충동"일 뿐이라는 걸 명심하세요.'),
                   JSON_OBJECT('sender', 'user', 'text', '오늘 밤엔 HTS를 끄고 잠부터 자야겠네요. 감사합니다!')
           ), NULL, NULL
       );

-- Q002. SELECT: 자아 고갈 상태의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS005', 'LV3_CH005_LS005_Q002', 'SELECT',
           '정신적 에너지가 소진된 "자아 고갈" 상태에서 투자자가 저지르기 쉬운 가장 흔한 실수는?',
           JSON_OBJECT('choices', JSON_ARRAY('더 꼼꼼하게 재무제표를 분석한다', '충동적으로 매수 버튼을 누르거나 원칙 없는 물타기를 한다', '장기 투자를 위해 매매 앱을 삭제한다')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '의지력이 약해지면 본능적 욕구가 통제력을 압도합니다.'),
           NULL
       );

-- Q003. MATCH: 투자 시점의 최적화
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH005_LS005', 'LV3_CH005_LS005_Q003', 'MATCH',
           '중요한 매매 결정은 뇌의 에너지가 가장 충만한 {{blank}} 시간대에 내리는 것이 통계적으로 가장 유리합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('오전', '심야', '취중')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '맑은 정신일 때 내린 결정이 복잡한 변수를 가장 잘 고려할 수 있습니다.'),
           NULL
       );

-- Q004. DRAG: 시스템의 필요성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH005_LS005', 'LV3_CH005_LS005_Q005', 'LINK',
  '현재 자신의 상태에 따른 올바른 투자 처방을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','업무 스트레스가 극심함'),
      JSON_OBJECT('id','L2','text','연속적인 손절로 화가 남'),
      JSON_OBJECT('id','L3','text','충동적으로 매수하고 싶음'),
      JSON_OBJECT('id','L4','text','너무 피곤해서 판단이 안 됨')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','오늘 하루 매매 금지 (관망)'),
      JSON_OBJECT('id','R2','text','HTS 끄고 휴식 (복수심 제거)'),
      JSON_OBJECT('id','R3','text','HTS 로그아웃 후 산책하기'),
      JSON_OBJECT('id','R4','text','예약 매도만 걸고 바로 취침')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '시스템은 지치지도, 흥분하지도 않습니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 선물 거래의 본질과 레버리지 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS001', 'LV3_CH006_LS001_Q001', 'CONCEPT',
           '주식과는 다른 선물의 세계, 미래를 사고파는 원리를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 뉴스에서 "선물 지수가 하락했다"는 말이 자주 나오는데, 선물은 우리가 받는 선물(Gift)인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '하하, 아니에요. 한자로 "먼저 선(先), 물건 물(物)"을 써요. 물건을 나중에 받기로 하고 가격을 "먼저" 정해서 계약하는 걸 말하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '왜 굳이 나중에 받을 물건의 가격을 지금 정하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '위험을 피하기 위해서예요. 예를 들어 배추 농사를 짓는 농부는 수확 때 배추값이 폭락할까 봐 무섭죠? 그래서 지금 상인과 "포기당 1,000원"에 미리 계약을 맺는 거예요. 그럼 나중에 값이 500원이 되어도 농부는 1,000원을 받을 수 있죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 가격 변동에 대한 보험 같은 거군요! 주식 시장에서도 똑같은가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 코스피 지수가 오를 것 같으면 선물을 사고(매수), 내릴 것 같으면 선물을 팔죠(매도). 특히 선물은 "레버리지"가 엄청나요. 1,000만 원만 있어도 1억 원어치 계약을 할 수 있거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '와, 그럼 수익도 10배지만 손실도 10배겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다. 그래서 선물은 방향을 잘 맞히면 대박이지만, 틀리면 원금이 순식간에 사라지는 "증거금 부족(Margin Call)" 사태를 겪을 수 있어요. 아주 조심해서 다뤄야 하는 도구입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 선물 거래의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS001', 'LV3_CH006_LS001_Q002', 'SELECT',
           '선물 거래(Futures)가 현물 주식 거래와 가장 크게 다른 점은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('거래 대상이 오직 삼성전자뿐이다', '미래의 특정 시점에 정해진 가격으로 매매하기로 약속하는 계약이다', '손실이 나도 절대 원금을 잃지 않는다')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '선물은 현재 시점에서 미래의 가격을 확정 짓는 "계약"입니다.'),
           NULL
       );

-- Q003. MATCH: 마진 콜(Margin Call)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS001', 'LV3_CH006_LS001_Q003', 'MATCH',
           '선물 매매 중 손실이 커져 계좌의 담보금이 일정 수준 이하로 떨어졌을 때, 돈을 더 채워 넣으라는 요구를 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('마진 콜', '골든 크로스', '어닝 서프라이즈')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '마진 콜에 응하지 못하면 보유 중인 선물이 강제로 청산당하게 됩니다.'),
           NULL
       );

-- Q004. DRAG: 선물의 포지션
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH006_LS001', 'LV3_CH006_LS001_Q005', 'LINK',
  '선물 거래의 핵심 용어와 그 의미를 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','증거금 (Margin)'),
      JSON_OBJECT('id','L2','text','만기일 (Expiry)'),
      JSON_OBJECT('id','L3','text','기초 자산 (Underlying)'),
      JSON_OBJECT('id','L4','text','콘탱고 (Contango)')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','계약을 이행하기 위한 보증금'),
      JSON_OBJECT('id','R2','text','계약이 종료되어 물건을 주고받는 날'),
      JSON_OBJECT('id','R3','text','선물 가격의 기준이 되는 지수나 상품'),
      JSON_OBJECT('id','R4','text','선물 가격이 현물보다 비싼 정상 상태')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '선물은 하락에 베팅(숏)하여 수익을 낼 수 있다는 점이 큰 특징입니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 옵션, 프리미엄을 내고 사는 보험 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS002', 'LV3_CH006_LS002_Q001', 'CONCEPT',
           '의무가 아닌 "선택권"을 사고파는 옵션의 세계를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 옵션은 선물과 뭐가 다른가요? 둘 다 미래를 거래하는 거 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '선물은 "반드시 지켜야 할 계약"이고, 옵션은 "할지 말지 결정할 수 있는 권리"예요. 마치 부동산 계약금과 비슷하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '부동산 계약금이요? 더 자세히 알려주세요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '1억 원짜리 아파트를 한 달 뒤에 살 수 있는 "권리"를 100만 원에 샀다고 해봐요. 만약 한 달 뒤 아파트가 2억이 되면? 사용자님은 권리를 행사해서 1억에 사고 1억의 이익을 보겠죠. 이게 "콜 옵션" 매수예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '반대로 아파트 값이 5,000만 원으로 폭락하면요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럼 권리를 "포기"하면 돼요. 계약금 100만 원만 날리고 손실을 끝내는 거죠. 즉, 옵션 매수자는 손실은 제한적이고 수익은 무한대일 수 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '와, 그럼 내릴 때 돈을 버는 보험 같은 것도 있겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요! 주가가 떨어질 때 팔 수 있는 권리를 "풋 옵션"이라고 해요. 주가가 폭락할 때 내 포트폴리오를 지켜주는 아주 훌륭한 보험이 되죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 "권리"를 사는 대가로 지불하는 돈(프리미엄)이 보험료 같은 거군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 옵션의 종류 구분
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS002', 'LV3_CH006_LS002_Q002', 'SELECT',
           '주식 시장 하락에 대비하여 "정해진 가격에 팔 수 있는 권리"를 뜻하는 용어는?',
           JSON_OBJECT('choices', JSON_ARRAY('콜 옵션 (Call Option)', '풋 옵션 (Put Option)', '현물 주식', '전환사채')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '풋 옵션은 주가 하락 시 가치가 상승하는 보험 성격의 파생상품입니다.'),
           NULL
       );

-- Q003. MATCH: 옵션 프리미엄
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS002', 'LV3_CH006_LS002_Q003', 'MATCH',
           '옵션 권리를 갖기 위해 매수자가 매도자에게 지불하는 가격을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('프리미엄', '증거금', '액면가')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '프리미엄은 옵션의 시간 가치와 내재 가치를 합친 가격입니다.'),
           NULL
       );

-- Q004. DRAG: 옵션의 손익 구조
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH006_LS002', 'LV3_CH006_LS002_Q005', 'LINK',
  '시장의 방향성 예측과 그에 적합한 옵션 전략을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','주가가 폭등할 것 같을 때'),
      JSON_OBJECT('id','L2','text','주가가 폭락할 것 같을 때'),
      JSON_OBJECT('id','L3','text','주가가 일정 수준을 안 넘을 때'),
      JSON_OBJECT('id','L4','text','주가가 크게 안 빠질 것 같을 때')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','콜 옵션 매수 (수익 극대화)'),
      JSON_OBJECT('id','R2','text','풋 옵션 매수 (하락장 수익)'),
      JSON_OBJECT('id','R3','text','콜 옵션 매도 (프리미엄 획득)'),
      JSON_OBJECT('id','R4','text','풋 옵션 매도 (안정적 수익)')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '매수자는 보험 가입자, 매도자는 보험사 역할을 하는 것과 같습니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 없는 걸 파는 기술, 공매도 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS003', 'LV3_CH006_LS003_Q001', 'CONCEPT',
           '하락장에서도 미소를 짓는 투자자들, 공매도의 원리를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주식은 싸게 사서 비싸게 파는 거 아닌가요? 비싸게 팔고 싸게 산다는 게 도대체 어떻게 가능한 거죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 "공매도($Short$ $Selling$)"의 마법이에요. 사용자님한테 주식이 없어도, 증권사에서 주식을 "빌려서" 시장에 먼저 파는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '빌려서 판다... 그럼 나중에는 어떻게 되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주가가 예상대로 떨어지면, 시장에서 싼 가격에 다시 사서 빌린 주식을 갚는 거예요. 1만 원에 빌려 팔았는데 5,000원이 됐다면, 5,000원 수익을 챙기고 주식만 돌려주면 되죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '오, 그럼 하락장에서는 공매도가 최고겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이론상으론 그렇죠. 하지만 공매도는 주식 매수보다 훨씬 위험해요. 주가는 떨어져 봐야 0원이지만, 올라가면 천장 없이 무한대로 오를 수 있거든요. 그럼 갚아야 할 돈도 무한대로 늘어납니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, "숏 스퀴즈"라는 말이 그래서 나오는 거군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 주가가 갑자기 튀어 오르면 공매도 세력들이 손실을 막으려고 급하게 주식을 되사면서(숏 커버링) 주가가 더 폭등하는 현상이죠. 공매도는 거품을 걷어내는 역할도 하지만, 감당할 수 없는 리스크를 동반하기도 합니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 공매도의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS003', 'LV3_CH006_LS003_Q002', 'SELECT',
           '주식을 보유하지 않은 상태에서 빌려 매도한 후, 주가가 떨어지면 다시 사서 갚는 매매 기법은?',
           JSON_OBJECT('choices', JSON_ARRAY('공매도', '신용 융자', '자사주 소각', '배당 투자')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '공매도는 주가 하락이 예상될 때 수익을 내기 위한 전략입니다.'),
           NULL
       );

-- Q003. MATCH: 숏 스퀴즈(Short Squeeze)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS003', 'LV3_CH006_LS003_Q003', 'MATCH',
           '주가가 예상과 달리 급등할 때 공매도 투자자가 주식을 급하게 되사며 주가가 폭등하는 현상을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('숏 스퀴즈', '데드 캣 바운스', '블랙 먼데이')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '숏 스퀴즈는 하락 베팅 세력이 항복하며 발생하는 강력한 매수세입니다.'),
           NULL
       );

-- Q004. DRAG: 공매도 프로세스
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH006_LS003', 'LV3_CH006_LS003_Q005', 'LINK',
  '매매 포지션과 투자자의 기대 수익 방향을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','롱 (Long) 포지션'),
      JSON_OBJECT('id','L2','text','숏 (Short) 포지션'),
      JSON_OBJECT('id','L3','text','롱-숏 중립 전략'),
      JSON_OBJECT('id','L4','text','무차입 공매도 (불법)')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','주가 상승 시 수익 발생'),
      JSON_OBJECT('id','R2','text','주가 하락 시 수익 발생'),
      JSON_OBJECT('id','R3','text','시장 전체 흐름과 무관하게 종목 수익만 추구'),
      JSON_OBJECT('id','R4','text','빌리지 않고 파는 행위 (엄격히 금지)')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '비싸게 팔고 싸게 사서 주식으로 갚는 과정입니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 하락장에서 주식을 팔지 않고 버티는 기술 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS004', 'LV3_CH006_LS004_Q001', 'CONCEPT',
           '폭풍우가 올 때 배를 항구로 옮기는 대신 방수포를 덮는 기술, 헤징을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 다음 달에 시장이 크게 빠질 것 같은데, 제가 가진 우량주들을 다 팔아야 할까요? 양도세랑 수수료가 너무 아까워요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럴 때 바로 "헤징($Hedging$)"이 필요합니다. 주식은 그대로 들고 가면서, 파생상품을 이용해 하락분만큼 수익이 나도록 설계하는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '오, 구체적으로 어떻게 하는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '가장 대표적인 방법은 "지수 선물 매도(숏)"예요. 사용자님이 1억 원어치 주식을 들고 있다면, 지수 선물을 1억 원어치 파는 거죠. 만약 시장이 10% 빠지면? 주식에선 1,000만 원 손실이 나지만, 선물 매도 포지션에선 1,000만 원 수익이 나서 전체 자산은 그대로 유지됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '우와, 진짜 보험이네요! 그럼 시장이 오르면요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 헤징의 대가예요. 주식이 10% 올라도 선물에서 10% 손실이 나니 수익이 0이 되죠. 즉, 헤징은 "수익을 포기하는 대신 안전을 사는 행위"입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '수익보다는 "내 원금을 지키는 게 최우선"인 구간에서 써야겠군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 또 다른 방법으로는 "풋 옵션 매수"가 있어요. 이건 일정한 보험료(프리미엄)만 내고 하락 위험만 딱 막아버리는 방식이죠. 시장이 오르면 보험료만 날리고 주가 상승 이익은 다 챙길 수 있어 더 고급 기술로 통합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '자산의 크기에 따라 선물이나 옵션을 섞어서 나만의 방어막을 짜야겠네요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 헤징(Hedging)의 목적
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS004', 'LV3_CH006_LS004_Q002', 'SELECT',
           '투자 포트폴리오에서 헤징 전략을 사용하는 가장 핵심적인 이유는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('시장의 방향성과 무관하게 자산 가치를 보호하기 위해', '단기간에 10배 이상의 수익을 내기 위해', '배당금을 더 많이 받기 위해')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '헤징은 예상치 못한 하락 리스크를 상쇄하여 자산을 방어하는 것이 주된 목적입니다.'),
           NULL
       );

-- Q003. MATCH: 델타 헤징(Delta Hedging)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS004', 'LV3_CH006_LS004_Q003', 'MATCH',
           '기초 자산의 가격 변화에 따른 옵션 가격의 변화율을 맞춰 중립 상태를 만드는 것을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('델타 헤징', '감마 스캘핑', '롤오버')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '델타값을 0으로 맞추면 기초 자산이 움직여도 포트폴리오 가치는 변하지 않습니다.'),
           NULL
       );

-- Q004. DRAG: 헤징 수단 선택
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH006_LS004', 'LV3_CH006_LS004_Q005', 'LINK',
  '투자의 상황과 그에 적합한 헤징 도구를 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','장기 보유 주식의 단기 급락 대비'),
      JSON_OBJECT('id','L2','text','강세장 속에서 보험만 들고 싶을 때'),
      JSON_OBJECT('id','L3','text','수익권 종목의 이익을 보존하고 싶을 때'),
      JSON_OBJECT('id','L4','text','보유 현금의 가치 하락(인플레) 방어')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','미니 코스피 200 선물 매도'),
      JSON_OBJECT('id','R2','text','외가격(OTM) 풋 옵션 소량 매수'),
      JSON_OBJECT('id','R3','text','선물 매도 또는 보호 풋(Protective Put)'),
      JSON_OBJECT('id','R4','text','금 선물 또는 원자재 선물 매수')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '비용과 목적에 따라 적절한 파생 도구를 선택해야 합니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 공포의 온도계, VIX 지수 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS005', 'LV3_CH006_LS005_Q001', 'CONCEPT',
           '시장이 얼마나 떨고 있는지 알려주는 "VIX" 지수의 비밀을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, "VIX 지수가 폭등했다"는 기사가 뜨면 주식 시장은 왜 난리가 나는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', 'VIX($Volatility$ $Index$)는 S&P 500 지수 옵션 가격을 바탕으로, 시장이 향후 30일 동안 얼마나 출렁일지 계산한 지수예요. 흔히 "공포 지수"라고 부르죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '숫자가 높을수록 사람들이 무서워하고 있다는 뜻인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 보통 VIX가 20 이하면 시장이 평온한 상태고, 30을 넘어가면 "비정상적인 공포" 상태로 봐요. 2020년 팬데믹 때는 80까지 치솟기도 했죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 VIX가 높을 때 주식을 다 팔아야겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '오히려 반대일 때가 많아요! "역발상 투자"의 관점에서는 "VIX가 천장을 칠 때가 주식의 바닥"인 경우가 아주 많거든요. 남들이 공포에 질려 보험(풋 옵션)을 비싼 값에 마구 살 때 VIX가 급등하기 때문이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 남들이 보험료를 비싸게 지불하며 도망갈 때가 기회일 수 있다는 거군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '빙고! 반대로 VIX가 너무 낮아 10~12 수준이라면, 시장이 너무 자만하고 있다는 신호일 수 있으니 경계해야 합니다. VIX는 "시장의 날씨"를 미리 알려주는 아주 정교한 레이더입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: VIX와 주가의 관계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS005', 'LV3_CH006_LS005_Q002', 'SELECT',
           '일반적으로 주가 지수(S&P 500 등)와 VIX 지수 사이의 상관관계는 어떠한가요?',
           JSON_OBJECT('choices', JSON_ARRAY('강한 역상관 관계 (주가 하락 시 VIX 상승)', '강한 양의 상관관계 (주가 상승 시 VIX 상승)', '전혀 무관한 움직임')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'VIX는 주가가 급락하거나 변동성이 커질 때 급등하는 성질이 있습니다.'),
           NULL
       );

-- Q003. MATCH: 평균 회귀(Mean Reversion)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH006_LS005', 'LV3_CH006_LS005_Q003', 'MATCH',
           'VIX 지수가 비정상적으로 치솟았다가 다시 역사적 평균값으로 돌아오려는 성질을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('평균 회귀', '추세 지속', '지수 폭발')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '공포는 영원할 수 없으므로 극단적인 VIX 수치는 결국 낮아지게 됩니다.'),
           NULL
       );

-- Q004. DRAG: VIX 수치 해석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
  'LV3_CH006_LS005', 'LV3_CH006_LS005_Q005', 'LINK',
  'VIX 지수의 상태에 따른 적절한 투자 행동을 연결하세요.',
  JSON_OBJECT(
    'left', JSON_ARRAY(
      JSON_OBJECT('id','L1','text','VIX가 10~13 (매우 낮음)'),
      JSON_OBJECT('id','L2','text','VIX가 25~30 (상승 중)'),
      JSON_OBJECT('id','L3','text','VIX가 40~50 (폭등 상태)'),
      JSON_OBJECT('id','L4','text','VIX가 고점에서 하락 전환')
    ),
    'right', JSON_ARRAY(
      JSON_OBJECT('id','R1','text','안일함 경계, 분할 익절 및 현금 확보'),
      JSON_OBJECT('id','R2','text','변동성 확대 대비, 헤징 비중 확대'),
      JSON_OBJECT('id','R3','text','극심한 패닉, 분할 매수 진입 검토'),
      JSON_OBJECT('id','R4','text','안도 랠리 기대, 비중 확대 및 홀딩')
    )
  ),
  JSON_OBJECT(
    'correct', JSON_OBJECT(
      'L1','R1',
      'L2','R2',
      'L3','R3',
      'L4','R4'
    ),
    'explanation', '공포 지수는 시장의 과열과 냉각을 판단하는 훌륭한 역발상 지표입니다.'
  ),
  NULL
);


-- Q001. CONCEPT: 상관관계 계수와 분산 투자 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS001', 'LV3_CH007_LS001_Q001', 'CONCEPT',
           '단순히 많이 사는 것이 왜 분산 투자가 아닌지, "상관관계"의 비밀을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 저는 삼성전자, SK하이닉스, 현대차를 다 갖고 있어요. 이 정도면 분산 투자가 완벽한 거 맞죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요, 그건 분산의 탈을 쓴 "집중 투자"예요. 세 종목 모두 "한국 주식"이라는 같은 바구니에 들어있거든요. 지수가 빠지면 세 놈 다 같이 하락할 확률이 90%가 넘습니다. 이걸 "상관관계가 높다"고 해요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 어떤 자산들을 섞어야 진짜 분산인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '서로 다르게 움직이는 자산들을 찾아야 해요. 주식과 "상관관계 계수"가 마이너스(-)인 자산, 즉 주식이 떨어질 때 오르는 자산을 섞는 것이 핵심입니다. 대표적인 것이 "미국 장기채권"과 "금"이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '상관관계 계수가 정확히 뭔가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '두 자산이 얼마나 비슷하게 움직이는지를 -1에서 +1 사이의 숫자로 나타낸 거예요. +1은 완벽하게 똑같이 움직이는 거고, -1은 거울처럼 정반대로 움직이는 거죠. 0은 아무 상관 없이 제멋대로 움직인다는 뜻이고요.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 포트폴리오에 -1이나 0에 가까운 자산을 넣어야겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정답입니다! 주식 100%일 때보다 주식 50%, 채권 50%를 섞었을 때 수익률은 조금 낮아질지 몰라도, 계좌가 박살 나는 고통(MDD)은 절반 이하로 줄어듭니다. 이게 바로 현대 포트폴리오 이론의 핵심인 "공짜 점심"입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '수익은 유지하면서 위험만 쏙 빼낼 수 있다는 거군요. 놀랍습니다!')
           ), NULL, NULL
       );

-- Q002. SELECT: 상관관계 계수의 해석
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS001', 'LV3_CH007_LS001_Q002', 'SELECT',
           '두 자산의 가격이 항상 정반대 방향으로 움직일 때, 두 자산 사이의 상관관계 계수(Correlation Coefficient)는 얼마일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('+1.0', '0.0', '-1.0', '+0.5')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '-1.0은 완벽한 역상관 관계로, 분산 투자 효과가 가장 극대화되는 상태입니다.'),
           NULL
       );

-- Q003. MATCH: 자산 간 상관관계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS001', 'LV3_CH007_LS001_Q003', 'MATCH',
           '시장이 공포에 질려 주식이 급락할 때, 안전자산 선호 현상으로 인해 주식과 낮은 상관관계를 보이는 대표 자산은 {{blank}}입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('미국 국채', '레버리지 ETF', '비트코인')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '국채는 경제 위기 시 주식의 하락을 방어해 주는 가장 강력한 짝꿍입니다.'),
           NULL
       );

-- Q004. DRAG: 포트폴리오 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS001', 'LV3_CH007_LS001_Q004', 'DRAG',
           '상관관계가 낮은 자산을 섞으면 포트폴리오 전체의 {{blank}}은 유지되거나 상승하면서, {{blank}}은 획기적으로 낮아집니다.',
           JSON_OBJECT('choices', JSON_ARRAY('기대 수익률', '변동성(리스크)', '거래 비용')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '이것을 마코비츠의 "효율적 투자선" 이론이라고 부릅니다.'),
           NULL
       );

-- Q005. LINK: 자산 조합별 분산 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS001', 'LV3_CH007_LS001_Q005', 'LINK',
           '자산 조합과 그에 따른 분산 투자 효과의 수준을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','국내 반도체주 + 국내 자동차주'),
                   JSON_OBJECT('id','L2','text','미국 대형주 + 미국 중소형주'),
                   JSON_OBJECT('id','L3','text','글로벌 주식 + 미국 국채'),
                   JSON_OBJECT('id','L4','text','주식 + 원자재 + 금')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','낮음 (동일 국가/업종 편중)'),
                           JSON_OBJECT('id','R2','text','보통 (동일 자산군 내 분산)'),
                           JSON_OBJECT('id','R3','text','높음 (자산군 간 역상관 활용)'),
                           JSON_OBJECT('id','R4','text','매우 높음 (다양한 매크로 대응)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '자산의 종류와 거주 국가를 넘나드는 분산이 필요합니다.'),
           NULL
       );

-- Q001. CONCEPT: 경제의 사계절과 자산의 궁합 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS002', 'LV3_CH007_LS002_Q001', 'CONCEPT',
           '미래를 예측하지 않고도 이기는 전략, 경제 사계절 매트릭스를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 금리 인상이 끝날지 인플레이션이 계속될지 알 수 없는데 어떻게 포트폴리오를 짜나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 질문이 바로 "올웨더"의 시작점이에요. 우리는 미래를 맞힐 수 없다는 걸 인정해야 합니다. 대신 경제의 날씨를 4가지로 나눌 수는 있죠. "성장"이 예상보다 높거나 낮은 경우, "물가"가 예상보다 높거나 낮은 경우예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '그 4가지 상황마다 잘 나가는 주식이 다른가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주식뿐만 아니라 자산군 자체가 달라요. 성장기가 오면 주식이 폭등하지만, 물가가 미친 듯이 오르는 인플레이션기에는 주식도 힘을 못 써요. 이때는 "금"이나 "원자재"가 주인공이 되죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 불황(성장 하락)이 오면요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그때는 "국채"가 효자 노릇을 합니다. 금리가 낮아지면서 채권 가격이 오르거든요. 결국 이 4가지 방(Quadrant)에 돈을 골고루 나눠두면, 어떤 날씨가 와도 내 계좌의 일부분은 항상 "파티" 중이게 됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 한쪽에서 잃어도 다른 쪽에서 벌어주니 계좌가 늘 평온하겠네요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 예측을 포기하고 모든 가능성에 배팅하는 것, 이것이 자산 배분의 진정한 겸손이자 지혜입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 인플레이션 시기의 강자
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS002', 'LV3_CH007_LS002_Q002', 'SELECT',
           '물가가 예상보다 가파르게 상승하는 "고인플레이션" 국면에서 포트폴리오를 방어해 주는 자산은?',
           JSON_OBJECT('choices', JSON_ARRAY('현금', '물가연동채 및 금/원자재', '장기 국채', '기술주')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '실물 자산과 물가에 연동된 채권은 화폐 가치 하락 시 가치가 상승합니다.'),
           NULL
       );

-- Q003. MATCH: 경제 국면별 자산 매칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS002', 'LV3_CH007_LS002_Q003', 'MATCH',
           '경제가 예상보다 빠르게 성장하고 물가가 안정적인 시기에 가장 높은 수익을 주는 자산은 {{blank}}입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('주식', '현금', '금')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '골디락스(적당한 성장과 낮은 물가) 환경은 주식 투자의 황금기입니다.'),
           NULL
       );

-- Q004. DRAG: 경기 침체의 방어막
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS002', 'LV3_CH007_LS002_Q004', 'DRAG',
           '성장이 둔화되는 {{blank}} 시기에는 금리가 하락하며 {{blank}}의 가격이 상승하여 계좌의 하락을 막아줍니다.',
           JSON_OBJECT('choices', JSON_ARRAY('경기 침체', '국채', '원자재')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '불황기에는 안전자산인 국채의 가치가 빛을 발합니다.'),
           NULL
       );

-- Q005. LINK: 4분면 매트릭스 완성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS002', 'LV3_CH007_LS002_Q005', 'LINK',
           '경제 상황(예상 대비)과 그 시기에 가장 유리한 자산군을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','성장 ↑ (호황)'),
                   JSON_OBJECT('id','L2','text','성장 ↓ (불황)'),
                   JSON_OBJECT('id','L3','text','물가 ↑ (인플레)'),
                   JSON_OBJECT('id','L4','text','물가 ↓ (디플레)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','주식, 회사채, 원자재'),
                           JSON_OBJECT('id','R2','text','국채, 물가채'),
                           JSON_OBJECT('id','R3','text','원자재, 금, 물가채'),
                           JSON_OBJECT('id','R4','text','국채, 주식')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '이 배분 모델이 레이 달리오 올웨더 전략의 기초 설계도입니다.'),
           NULL
       );

-- Q001. CONCEPT: 왜 주식은 30%밖에 안 되나요? (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS003', 'LV3_CH007_LS003_Q001', 'CONCEPT',
           '올웨더 전략의 파격적인 비율 뒤에 숨겨진 수학적 비밀을 파헤쳐 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 레이 달리오의 올웨더 포트폴리오를 봤는데 주식이 30%밖에 안 돼요. 수익률이 너무 낮지 않을까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '중요한 건 "금액"이 아니라 "위험"의 비중이에요. 주식은 채권보다 변동성이 3배 이상 큽니다. 만약 주식 50%, 채권 50%를 담으면, 실제 계좌의 변동성(위험)은 주식이 90%를 결정하게 돼요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 겉보기엔 반반인데 실제 리스크는 주식에 몰빵한 거나 다름없군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그렇죠. 그래서 올웨더는 주식 비중을 확 줄이고, 변동성이 낮은 채권 비중을 대폭 높여서 "위험의 크기"를 서로 맞춘 거예요. 여기에 인플레이션을 방어할 금과 원자재를 15% 섞죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '수익률은 주식 100%보다 낮겠지만, 하락장에서는 정말 무적이겠어요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞습니다. 지난 40년간 올웨더는 연평균 7~9% 수익을 내면서도, 최악의 하락폭(MDD)은 주식의 3분의 1 수준에 불과했어요. 밤에 잠을 편하게 잘 수 있는 "마음 편한 투자"의 정점이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 오래 살아남는 자가 복리의 결실을 다 가져간다는 철학이 담겨있네요.')
           ), NULL, NULL
       );

-- Q002. SELECT: 올웨더의 가장 큰 비중
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH003_LS003', 'LV3_CH007_LS003_Q002', 'SELECT',
           '레이 달리오가 제시한 올웨더 포트폴리오에서 가장 높은 비중(약 40%)을 차지하는 자산군은?',
           JSON_OBJECT('choices', JSON_ARRAY('신흥국 주식', '미국 장기 국채', '금(Gold)', '비트코인')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '변동성이 낮은 장기 국채를 높은 비중으로 가져가 전체 리스크의 균형을 맞춥니다.'),
           NULL
       );

-- Q003. MATCH: 인플레이션의 헤지
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS003', 'LV3_CH007_LS003_Q003', 'MATCH',
           '올웨더에서 주식과 채권이 동시에 하락하는 스태그플레이션에 대비해 담는 자산은 {{blank}}와 {{blank}}입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('금', '원자재', '현금')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '금과 원자재는 인플레이션 충격을 상쇄하는 보험 역할을 합니다.'),
           NULL
       );

-- Q004. DRAG: 올웨더의 핵심 철학
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS003', 'LV3_CH007_LS003_Q004', 'DRAG',
           '올웨더는 시장을 {{blank}}하기보다 모든 시나리오에 {{blank}}하여 안정적인 장기 복리 수익을 추구합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('예측', '대응', '추종')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '맞히는 투자가 아니라 틀리지 않는 투자를 지향합니다.'),
           NULL
       );

-- Q005. LINK: 올웨더 자산 배분 구성 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS003', 'LV3_CH007_LS003_Q005', 'LINK',
           '올웨더 포트폴리오의 자산별 표준 비중과 그 이유를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id', 'L1', 'text', '주식 (30%)'),
                   JSON_OBJECT('id', 'L2', 'text', '장기채권 (40%)'),
                   JSON_OBJECT('id', 'L3', 'text', '중기채권 (15%)'),
                   JSON_OBJECT('id', 'L4', 'text', '금/원자재 (15%)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id', 'R1', 'text', '높은 변동성으로 인해 낮은 비중으로 수익 견인'),
                           JSON_OBJECT('id', 'R2', 'text', '주식 하락을 방어하는 핵심 안전판'),
                           JSON_OBJECT('id', 'R3', 'text', '안정적인 이자 수익 및 유동성 확보'),
                           JSON_OBJECT('id', 'R4', 'text', '고물가 및 화폐 가치 하락에 대비한 보험')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '이 조화로운 비율이 40년 무패의 신화를 만들었습니다.'),
           NULL
       );

-- Q001. CONCEPT: 금액 비중의 함정과 위험의 균형 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS004', 'LV3_CH007_LS004_Q001', 'CONCEPT',
           '금액을 50:50으로 나누는 것이 왜 위험한지, 리스크 패리티의 원리를 상세히 파헤쳐 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주식 500만 원, 채권 500만 원씩 샀어요. 반반이니까 위험도 딱 절반으로 나뉜 거 맞죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '안타깝게도 전혀 그렇지 않아요. 그건 "금액"만 반반일 뿐 "위험"은 주식에 90% 이상 쏠려있는 상태예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '네? 똑같이 500만 원씩 샀는데 왜 위험은 주식이 다 가져가나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '자산마다 날뛰는 정도(변동성)가 다르기 때문이죠. 주식은 하루에 3~5%씩 움직이기도 하지만, 채권은 0.5%도 안 움직일 때가 많아요. 폭풍우가 칠 때 주식은 배가 뒤집히는데 채권은 잔잔하다면, 전체 계좌의 흔들림은 결국 주식이 결정하게 되는 거죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 그럼 채권을 훨씬 더 많이 사야 위험의 크기가 비슷해지겠네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다! 그게 바로 "리스크 패리티($Risk$ $Parity$)"의 핵심이에요. 각 자산이 전체 포트폴리오의 위험에 기여하는 정도를 똑같이 맞추는 거죠. 위험한 자산(주식)은 조금만 담고, 얌전한 자산(채권)은 많이 담아서 어느 쪽이 터지든 계좌에 미치는 충격을 동일하게 만드는 겁니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 수익률이 너무 낮아지지 않을까요? 채권 비중이 너무 높으니까요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '좋은 질문이에요! 그래서 프로들은 채권 비중을 높여 위험을 낮춘 뒤, "레버리지"를 사용해 전체 수익률을 주식 100% 수준으로 끌어올립니다. 그렇게 하면 수익은 주식만큼 내면서도, 하락장의 고통은 훨씬 적은 "꿈의 포트폴리오"가 완성되죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '금액이 아니라 "위험의 무게"를 맞추는 것이 진짜 분산의 기술이군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 리스크 패리티의 핵심 기준
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS004', 'LV3_CH007_LS004_Q002', 'SELECT',
           '리스크 패리티 전략에서 자산의 투자 비중을 결정할 때 가장 핵심적으로 고려하는 지표는?',
           JSON_OBJECT('choices', JSON_ARRAY('자산의 기대 수익률', '자산의 변동성(위험) 크기', '자산의 현재 가격', '기업의 배당 성향')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '리스크 패리티는 각 자산의 변동성을 측정하여 위험 기여도를 균등하게 맞춥니다.'),
           NULL
       );

-- Q003. MATCH: 자산별 비중 조절 원리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS004', 'LV3_CH007_LS004_Q003', 'MATCH',
           '변동성이 큰 암호화폐는 비중을 {{blank}}하고, 변동성이 매우 작은 단기 채권은 비중을 {{blank}}하는 것이 리스크 패리티의 기본입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('축소', '확대', '유지')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '위험한 놈은 적게, 얌전한 놈은 많이 담아 균형을 맞춥니다.'),
           NULL
       );

-- Q004. DRAG: 전략의 실행 단계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS004', 'LV3_CH007_LS004_Q004', 'DRAG',
           '전략 순서: 자산별 변동성 측정 → {{blank}} 기여도 산출 → 역비중 배분 → {{blank}}를 통한 수익률 보강',
           JSON_OBJECT('choices', JSON_ARRAY('위험(리스크)', '레버리지', '기대수익')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '위험의 균형을 먼저 잡고, 모자란 수익은 레버리지로 채우는 것이 정석입니다.'),
           NULL
       );

-- Q005. LINK: 자산 성격과 위험 관리 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS004', 'LV3_CH007_LS004_Q005', 'LINK',
           '자산의 성격에 따른 리스크 패리티 관점의 대응을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','나스닥 (고변동성)'),
                   JSON_OBJECT('id','L2','text','미국 국채 (저변동성)'),
                   JSON_OBJECT('id','L3','text','원자재 (중변동성)'),
                   JSON_OBJECT('id','L4','text','레버리지 활용')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','매우 낮은 비중으로 할당'),
                           JSON_OBJECT('id','R2','text','전체 계좌의 중심축으로 높은 비중 할당'),
                           JSON_OBJECT('id','R3','text','인플레이션 방어 목적으로 적정 비중 유지'),
                           JSON_OBJECT('id','R4','text','저변동성 포트폴리오의 수익성 강화 수단')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '자산의 "날뛰는 정도"를 이해해야 방어력을 높일 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: 팔아야 수익이다, 리밸런싱의 위력 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS005', 'LV3_CH007_LS005_Q001', 'CONCEPT',
           '왜 오르는 주식을 팔고 내리는 자산을 사야 할까요? 리밸런싱의 심오한 원리를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주식이 올라서 기분 좋은데 왜 굳이 이걸 팔아서 수익이 안 나는 채권을 더 사라고 하시나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 인간의 본능을 이기고 "싸게 사서 비싸게 파는" 시스템이기 때문이에요. 주식이 오르면 포트폴리오 내 비중이 커지죠? 이때 일부를 팔아 채권을 사는 건, 고점에서 주식을 "익절"하는 행위예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 자동으로 수익을 확정 짓는 거군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 반대로 주식이 폭락하면 비중이 줄어들겠죠? 이때 채권을 팔아 주식을 더 사는 건, 공포 속에서 "저점 매수"를 하는 셈입니다. 이 과정을 반복하면 계좌는 마법처럼 불어나죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '이 전략이 잘 돌아가는지 어떻게 확인하나요? 단순히 수익률만 보면 되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '고급 투자자는 "샤프 지수($Sharpe$ $Ratio$)"를 봐요. 단순히 수익률이 높은 게 장땡이 아니라, 얼마나 적은 고통(위험)을 겪으며 그 수익을 냈는지 따지는 지표죠. 수익률을 변동성으로 나눈 값인데, 이 숫자가 높을수록 "가성비 좋은 투자"를 하고 있다는 뜻입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '수익도 중요하지만 그 "과정"의 안정성을 숫자로 측정하는 거군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요! 리밸런싱은 샤프 지수를 높여주는 가장 강력한 도구입니다. 감정을 배제하고 숫자에 따라 기계적으로 행동하세요. 그것이 시장을 이기는 유일한 길입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 샤프 지수(Sharpe Ratio)의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS005', 'LV3_CH007_LS005_Q002', 'SELECT',
           '포트폴리오의 효율성을 측정하는 지표로, "위험 한 단위당 초과 수익"을 뜻하는 것은?',
           JSON_OBJECT('choices', JSON_ARRAY('샤프 지수 (Sharpe Ratio)', 'PER', 'MDD', '이동평균선')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '샤프 지수가 높을수록 적은 리스크로 더 높은 수익을 냈다는 의미입니다.'),
           NULL
       );

-- Q003. MATCH: 리밸런싱의 주기
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS005', 'LV3_CH007_LS005_Q003', 'MATCH',
           '정해진 기간(매월, 매분기 등)마다 비중을 조절하는 것을 정기 리밸런싱, 비중이 일정 범위를 벗어날 때 조절하는 것을 {{blank}} 리밸런싱이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('밴드(Band)', '추세', '수동')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '밴드 리밸런싱은 급격한 시장 변화에 더 유연하게 대응할 수 있습니다.'),
           NULL
       );

-- Q004. DRAG: 리밸런싱의 효과 계산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS005', 'LV3_CH007_LS005_Q004', 'DRAG',
           '리밸런싱은 본능적인 {{blank}} 매수를 억제하고, 시스템적인 {{blank}} 매도를 유도하여 장기 성과를 높입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('고가', '저가', '손절')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '인간의 심리와 반대로 행동하게 만드는 강력한 장치입니다.'),
           NULL
       );

-- Q005. LINK: 성과 지표 종합 이해 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH007_LS005', 'LV3_CH007_LS005_Q005', 'LINK',
           '포트폴리오 평가 지표와 투자자가 확인해야 할 핵심 가치를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','CAGR (연평균 수익률)'),
                   JSON_OBJECT('id','L2','text','MDD (최대 낙폭)'),
                   JSON_OBJECT('id','L3','text','Sharpe Ratio (샤프 지수)'),
                   JSON_OBJECT('id','L4','text','Correlation (상관관계)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','내 자산이 매년 평균적으로 성장한 속도'),
                           JSON_OBJECT('id','R2','text','하락장에서 내가 견뎌야 했던 최대 고통'),
                           JSON_OBJECT('id','R3','text','위험 대비 수익의 "가성비"와 효율성'),
                           JSON_OBJECT('id','R4','text','자산들이 서로 얼마나 따로 움직이는지')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '이 네 가지 지표를 관리하는 것이 포트폴리오 운용의 정수입니다.'),
           NULL
       );

-- Q001. CONCEPT: 과거의 폭풍우 속으로 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS001', 'LV3_CH008_LS001_Q001', 'CONCEPT',
           '역사적 위기 상황에서 자산군들이 어떻게 움직였는지 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 제 포트폴리오가 백테스팅 결과 연평균 10% 수익인데, 2008년 같은 위기가 오면 어떻게 되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 고급 투자자가 가장 먼저 확인해야 할 "스트레스 테스트"예요. 2008년 금융위기 당시 코스피는 약 -50%, 나스닥은 -40% 넘게 하락했죠. 만약 주식에 100% 투자했다면 자산의 절반이 사라지는 고통을 겪었을 거예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '생각만 해도 끔찍하네요... 그럼 채권이나 금은 어땠나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '재미있는 현상이 벌어졌죠. 주식이 폭락할 때 안전자산인 국채는 가격이 급등하며 방패 역할을 했어요. 하지만 2020년 팬데믹 초기처럼 모든 자산이 동시에 투매되는 "현금 확보 전쟁" 상황에서는 금조차 일시적으로 하락하기도 했습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '와, 그럼 안전자산도 100% 안전한 건 아니네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 그래서 위기 시나리오별로 "상관관계가 어떻게 변하는지"를 아는 게 중요해요. 평소엔 따로 놀던 자산들이 위기 땐 같이 떨어지는 "상관관계 1로의 수렴" 현상이 발생하거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 역사적 데이터를 통해 내 계좌가 견딜 수 있는 "최악의 고통수치"를 미리 알아야겠군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '빙고! MDD(최대 낙폭)를 확인하고, 그 상황에서도 내가 투자를 포기하지 않을 수 있는지 스스로를 시험해 보는 과정입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 위기 시 상관관계의 변화
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS001', 'LV3_CH008_LS001_Q002', 'SELECT',
           '금융 시장에 극심한 패닉이 발생할 때, 위험 자산들 간의 상관관계(Correlation)는 보통 어떻게 변할까요?',
           JSON_OBJECT('choices', JSON_ARRAY('서로 무관하게 움직임', '1에 가깝게 동조화되어 함께 하락함', '-1에 가깝게 정반대로 움직임', '변동성이 완전히 사라짐')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '위기 시에는 "현금 확보"를 위해 모든 위험 자산을 한꺼번에 매도하므로 상관관계가 급격히 높아집니다.'),
           NULL
       );

-- Q003. MATCH: 회복 탄력성(Resilience)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS001', 'LV3_CH008_LS001_Q003', 'MATCH',
           '폭락장 이후 전고점을 회복할 때까지 걸리는 시간을 {{blank}} 기간이라고 하며, 포트폴리오의 질을 결정하는 요소입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('언더워터(Underwater)', '골든크로스', '리밸런싱')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '언더워터 기간이 짧을수록 자산 운용의 효율성과 심리적 안정감이 높습니다.'),
           NULL
       );

-- Q004. DRAG: 위기 대응 프로세스
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS001', 'LV3_CH008_LS001_Q004', 'DRAG',
           '스트레스 테스트 순서: 과거 위기 데이터 선정 → {{blank}} 측정 → 자산군 간 {{blank}} 변화 분석 → 비상 계획(Contingency Plan) 수립',
           JSON_OBJECT('choices', JSON_ARRAY('예상 MDD', '상관관계', '기대수익률')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '얼마나 깨질지(MDD)와 어떻게 묶여있는지(상관관계)를 아는 것이 먼저입니다.'),
           NULL
       );

-- Q005. LINK: 역사적 위기별 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS001', 'LV3_CH008_LS001_Q005', 'LINK',
           '금융 역사의 주요 위기와 그 당시 시장의 핵심 특징을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','2000년 닷컴 버블'),
                   JSON_OBJECT('id','L2','text','2008년 금융 위기'),
                   JSON_OBJECT('id','L3','text','2020년 코로나 쇼크'),
                   JSON_OBJECT('id','L4','text','2022년 인플레 쇼크')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','기술주 중심의 장기 하락장'),
                           JSON_OBJECT('id','R2','text','금융 시스템 붕괴 및 전 자산 동반 폭락'),
                           JSON_OBJECT('id','R3','text','V자형 급락 후 유동성 파티'),
                           JSON_OBJECT('id','R4','text','금리 급등으로 주식/채권 동반 하락')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '위기의 성격에 따라 방어력이 좋은 자산이 매번 달라집니다.'),
           NULL
       );

-- Q001. CONCEPT: 주식과 채권의 배신 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS002', 'LV3_CH008_LS002_Q001', 'CONCEPT',
           '전통적인 60/40 포트폴리오가 무너지는 최악의 환경, 스태그플레이션을 파헤쳐 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주식이 떨어지면 채권이 올라야 정상인데, 왜 2022년에는 둘 다 같이 떨어졌나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 "스태그플레이션($Stagflation$)"의 무서움 때문이에요. 물가는 치솟는데 경제는 안 좋은 최악의 상황이죠. 연준은 물가를 잡으려고 금리를 미친 듯이 올리고, 그 결과 채권 가격은 폭락하고 경기 침체 우려로 주식까지 같이 빠지는 거예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '방패(채권)가 칼(주식)이랑 같이 부러진 셈이네요. 이럴 땐 어떻게 해야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이 시나리오에서는 "현금"과 "채권"은 쓰레기가 돼요. 오직 가치가 보존되는 "실물 자산"만이 살아남죠. 1970년대 스태그플레이션 당시, 주식과 채권은 10년 동안 제자리걸음이었지만 금(Gold)과 원자재는 수배씩 올랐습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '그래서 올웨더 전략에 금과 원자재가 꼭 들어가는 거군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정답입니다! 물가가 오르는 속도보다 내 자산 가치가 더 빨리 깎이는 상황을 막으려면, 원유, 구리, 농산물 같은 "실물"과 물가에 연동되는 "물가연동채(TIPS)"를 반드시 포함해야 합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '내 포트폴리오의 사각지대가 어딘지 이제야 알 것 같아요.')
           ), NULL, NULL
       );

-- Q002. SELECT: 스태그플레이션의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS002', 'LV3_CH008_LS002_Q002', 'SELECT',
           '경기 침체(Stagnation)와 물가 상승(Inflation)이 동시에 발생하는 경제 현상은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('디플레이션', '스태그플레이션', '하이퍼인플레이션', '골디락스')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '스태그플레이션은 성장이 정체된 상태에서 물가만 올라 투자 환경이 극도로 악화되는 상황입니다.'),
           NULL
       );

-- Q003. MATCH: 고물가 시대의 대안
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS002', 'LV3_CH008_LS002_Q003', 'MATCH',
           '화폐 가치가 하락하는 인플레이션 환경에서 원금의 가치를 물가 상승률만큼 보전해 주는 채권을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('물가연동채 (TIPS)', '정부 국채', '회사채')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'TIPS는 인플레이션 방어의 핵심 병기입니다.'),
           NULL
       );

-- Q004. DRAG: 자산 수익률의 순위
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS002', 'LV3_CH008_LS002_Q004', 'DRAG',
           '스태그플레이션 발생 시 수익률 우위: {{blank}} > 주식 > {{blank}}',
           JSON_OBJECT('choices', JSON_ARRAY('원자재(금)', '채권', '현금')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '현물 가치가 있는 자산이 가장 강하고, 고정 이자를 주는 채권이 가장 약합니다.'),
           NULL
       );

-- Q005. LINK: 경제 상황별 강세 자산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS002', 'LV3_CH008_LS002_Q005', 'LINK',
           '경제 기후와 그 상황에서 가장 잘 버티는 자산을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','고성장 + 저물가'),
                   JSON_OBJECT('id','L2','text','저성장 + 저물가'),
                   JSON_OBJECT('id','L3','text','저성장 + 고물가'),
                   JSON_OBJECT('id','L4','text','고성장 + 고물가')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','주식 (성장주)'),
                           JSON_OBJECT('id','R2','text','국채 (장기채)'),
                           JSON_OBJECT('id','R3','text','원자재, 금, 물가채'),
                           JSON_OBJECT('id','R4','text','원자재, 주식 (가치주)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '기후에 맞는 옷을 미리 준비하는 것이 자산 배분의 정석입니다.'),
           NULL
       );

-- Q001. CONCEPT: 상상할 수 없는 것을 상상하라 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS003', 'LV3_CH008_LS003_Q001', 'CONCEPT',
           '나심 탈레브의 "블랙 스완"이 주식 계좌에 주는 교훈을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 블랙 스완이라는 게 정확히 뭔가요? 그냥 큰 폭락장을 말하는 건가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '단순한 폭락과는 달라요. "과거 데이터로는 절대 예측할 수 없고, 발생하면 파괴적인 영향을 주며, 나중에는 다들 그럴 줄 알았다고 핑계 대는 사건"을 말하죠. 9.11 테러나 2008년 리먼 파산, 코로나19 팬데믹이 대표적이에요.'),
                   JSON_OBJECT('sender', 'user', 'text', '예측이 불가능하다면 어떻게 대비하나요? 어차피 모르는데...'),
                   JSON_OBJECT('sender', 'mentor', 'text', '중요한 건 "사건의 예측"이 아니라 "취약성의 관리"예요. 예를 들어 비행기 사고는 언제 날지 모르지만, 엔진을 2개 달고 낙하산을 준비하면 살아남을 확률이 높아지죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 계좌에 낙하산을 달라는 말씀이군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다! 레버리지를 너무 많이 쓰지 않는 것, 그리고 나중에 배울 "테일 리스크 헤지"를 소량 섞는 것이 블랙 스완 대처법이에요. 통계적으로 99.9% 안전하다고 해도, 0.1%의 블랙 스완이 나타나면 99.9%를 다 깎아 먹을 수 있거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 "살아남는 것"이 수익보다 우선이라는 거군요.')
           ), NULL, NULL
       );

-- Q002. SELECT: 블랙 스완의 특징
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS003', 'LV3_CH008_LS003_Q002', 'SELECT',
           '블랙 스완(Black Swan) 사건의 세 가지 특징에 해당하지 않는 것은?',
           JSON_OBJECT('choices', JSON_ARRAY('극단적인 영향력', '사후적 설명 가능성', '과거 데이터를 통한 정확한 예측 가능성', '발생 확률이 매우 낮음')),
           JSON_OBJECT('correct', JSON_ARRAY(2), 'explanation', '블랙 스완은 과거의 경험으로는 결코 예측할 수 없는 사건을 뜻합니다.'),
           NULL
       );

-- Q003. MATCH: 안티프래질(Antifragile)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS003', 'LV3_CH008_LS003_Q003', 'MATCH',
           '충격과 혼란 속에서 오히려 더 강해지는 성질을 {{blank}}이라고 하며, 블랙 스완에 대비하는 이상적인 상태입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('안티프래질', '리스크 온', '포트폴리오')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '위기 상황에서 남들이 망할 때 이익을 보거나 더 견고해지는 구조를 짜야 합니다.'),
           NULL
       );

-- Q004. DRAG: 블랙 스완 대응 전략
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS003', 'LV3_CH008_LS003_Q004', 'DRAG',
           '예측 불가능한 위기 대응: 과도한 {{blank}} 사용 금지 → 다양한 자산군 분산 → 최악의 경우를 대비한 {{blank}} 자산 보유',
           JSON_OBJECT('choices', JSON_ARRAY('레버리지', '보험성(풋옵션 등)', '수익성')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '빚을 내서 투자하는 것은 블랙 스완을 만났을 때 즉사하는 지름길입니다.'),
           NULL
       );

-- Q005. LINK: 위기 유형별 대응 개념
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS003', 'LV3_CH008_LS003_Q005', 'LINK',
           '위기의 성격과 그에 대응하는 투자 철학을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','통계적 변동성'),
                   JSON_OBJECT('id','L2','text','블랙 스완'),
                   JSON_OBJECT('id','L3','text','회색 코뿔소'),
                   JSON_OBJECT('id','L4','text','안전 마진')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','과거 데이터로 측정 가능한 위험'),
                           JSON_OBJECT('id','R2','text','측정 불가한 극단적 사건'),
                           JSON_OBJECT('id','R3','text','예상되지만 무시되고 있는 위험'),
                           JSON_OBJECT('id','R4','text','가정이 틀려도 버티게 해주는 여유')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '위험의 종류를 명확히 알아야 대응 체력을 기를 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: 복권처럼 사고 보험처럼 쓰는 헤지 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS004', 'LV3_CH008_LS004_Q001', 'CONCEPT',
           '평상시에는 돈을 버리지만, 위기 때는 계좌를 살리는 "테일 리스크 헤지"를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 블랙 스완처럼 예측 불가능한 위험을 막으려면 24시간 내내 선물을 팔고 있어야 하나요? 수익률이 너무 깎일 것 같은데요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '좋은 지적이에요. 모든 하락을 다 막으려 하면 비용이 너무 커지죠. 그래서 고급 투자자들은 "테일 리스크($Tail$ $Risk$)" 헤지를 사용합니다. 발생 확률 1% 미만의 극단적인 폭락만 골라서 막는 거예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '확률이 낮은데 어떻게 효율적으로 막나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '바로 "먼 외가격(OTM) 풋 옵션"을 아주 소량만 사는 방식이죠. 평소에는 휴지조각이 되어 돈을 날리지만, 시장이 -20% 이상 폭락하면 가치가 100배, 1,000배로 튀어 오릅니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 평소엔 적은 보험료를 내다가 대형 사고가 났을 때만 보상을 받는 자동차 보험이랑 똑같네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다! 전체 자산의 1~2% 정도만 이 "보험료"로 지불하는 거죠. 장이 좋을 때는 이 2%가 아깝겠지만, 진짜 위기가 왔을 때 남들이 -50%를 맞을 때 사용자님은 이 옵션 수익으로 손실을 상쇄하거나 오히려 돈을 벌 수도 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '위기 속에서 공격할 자금을 확보하는 신의 한 수가 되겠군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 이 전략의 핵심은 "위기가 오지 않을 때 기꺼이 돈을 버릴 줄 아는 용기"에 있습니다. 대부분의 개미들은 이 비용을 못 견뎌서 결국 위기 때 무방비로 당하거든요.')
           ), NULL, NULL
       );

-- Q002. SELECT: 테일 리스크 헤지의 주된 도구
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS004', 'LV3_CH008_LS004_Q002', 'SELECT',
           '테일 리스크 헤지를 위해 가장 적은 비용으로 극단적 폭락을 방어할 수 있는 수단은?',
           JSON_OBJECT('choices', JSON_ARRAY('외가격(OTM) 풋 옵션 매수', '대형주 추가 매수', '은행 적금 가입', '금 선물 매도')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '현재가보다 훨씬 낮은 가격에 팔 권리(외가격 풋)는 가격이 매우 저렴하여 효율적인 보험이 됩니다.'),
           NULL
       );

-- Q003. MATCH: 헤지 비용의 성격
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS004', 'LV3_CH008_LS004_Q003', 'MATCH',
           '헤지 전략을 유지하기 위해 매달 지불하는 옵션 프리미엄을 투자자들 사이에서는 {{blank}}라고 부르기도 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('보험료(또는 소멸 비용)', '복리 수익', '배당금')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '사건이 발생하지 않으면 사라지는 비용이지만, 생존을 위한 필수 비용으로 간주합니다.'),
           NULL
       );

-- Q004. DRAG: 헤징의 시점과 효과
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS004', 'LV3_CH008_LS004_Q004', 'DRAG',
           '시장이 평온하여 변동성(VIX)이 {{blank}}일 때 보험을 싸게 가입하고, 시장이 공포에 질려 변동성이 {{blank}}할 때 보험금(수익)을 수령합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('낮을 때', '폭등', '높을 때')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '보험은 사고가 나기 전, 모두가 안심할 때 들어야 가장 저렴합니다.'),
           NULL
       );

-- Q005. LINK: 헤징 전략의 장단점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS004', 'LV3_CH008_LS004_Q005', 'LINK',
           '헤징 전략의 특징과 그에 따른 결과를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id', 'L1', 'text', '상시적 테일 헤지 유지'),
                   JSON_OBJECT('id', 'L2', 'text', '헤지 없이 공격적 투자'),
                   JSON_OBJECT('id', 'L3', 'text', '위기 직전 뒤늦은 헤지'),
                   JSON_OBJECT('id', 'L4', 'text', '적절한 리밸런싱 병행')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id', 'R1', 'text', '평상시 수익률은 낮으나 파산 위험 0%'),
                           JSON_OBJECT('id', 'R2', 'text', '강세장 최대 수익이나 블랙 스완 시 파산'),
                           JSON_OBJECT('id', 'R3', 'text', '비싼 보험료만 지불하고 방어 효과 미미'),
                           JSON_OBJECT('id', 'R4', 'text', '헤지 수익으로 저점 매수하는 선순환')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1', 'R1', 'L2', 'R2', 'L3', 'R3', 'L4', 'R4'), 'explanation', '헤지는 기술보다 철학의 영역입니다.'),
           NULL
       );

-- Q001. CONCEPT: 숫자로 마주하는 최악의 공포 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS005', 'LV3_CH008_LS005_Q001', 'CONCEPT',
           '내 계좌가 어디까지 부서질 수 있는지 미리 확인하는 스트레스 테스트 실습을 시작해 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 제 포트폴리오가 완벽하다고 생각했는데, 어제 스트레스 테스트를 해보니 환율이 1,500원 가고 금리가 7% 되면 반토막이 난다는 결과가 나왔어요. 충격적이에요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 스트레스 테스트를 해야 하는 이유예요! 실전에서 그 수치를 처음 마주하면 뇌가 정지되어 아무것도 못 하거든요. 지금 미리 확인했으니 "대응"을 준비할 수 있죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '반토막이 안 나게 종목을 다 바꿔야 할까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '무조건 바꾸는 게 답은 아니에요. 대신 "비상 매뉴얼"을 만드세요. 예를 들어 "계좌 전체 손실이 -20%에 도달하면 무조건 현금 비중을 50%로 늘린다" 같은 기계적인 규칙이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 감정이 개입하기 전에 미리 행동 지침을 정해두는 거군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 그리고 시나리오별로 질문을 던져보세요. "전쟁이 터지면?", "주요 공급망이 끊기면?" 이런 가상의 "What-if" 질문에 내 자산들이 어떻게 반응할지 시뮬레이션해 보는 것만으로도 투자자의 생존 확률은 비약적으로 올라갑니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '계획이 있는 패배는 복구가 가능하지만, 계획 없는 패배는 끝이라는 말씀이 가슴에 와닿네요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다. 이제 사용자님의 계좌에 "최대 허용 손실치(Max Pain)"를 설정하고, 그 선이 무너졌을 때의 행동을 문서화하세요. 그것이 고급 과정의 마지막 숙제입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 스트레스 테스트의 핵심 목적
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS005', 'LV3_CH008_LS005_Q002', 'SELECT',
           '투자자가 정기적으로 스트레스 테스트를 수행해야 하는 가장 큰 이유는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('미래의 수익을 정확히 예측하기 위해', '예상치 못한 위기 상황에서 감정적 대응을 방지하고 생존하기 위해', '더 많은 종목을 매수하기 위해')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '최악의 시나리오를 미리 겪어보는 것만으로도 실전에서의 패닉을 막을 수 있습니다.'),
           NULL
       );

-- Q003. MATCH: 비상 계획(Contingency Plan)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS005', 'LV3_CH008_LS005_Q003', 'MATCH',
           '특정 지표나 손실률이 정해진 수준을 넘어설 때 기계적으로 포지션을 정리하는 규칙을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('데드라인(또는 킬 스위치)', '골든 타임', '윈도우 드레싱')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '자신만의 "킬 스위치"를 가진 투자자만이 시장에서 영원히 생존합니다.'),
           NULL
       );

-- Q004. DRAG: 시나리오 설계 변수
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS005', 'LV3_CH008_LS005_Q004', 'DRAG',
           '스트레스 테스트의 3대 변수: {{blank}} 변동(금리/물가), {{blank}} 위험(부도/신용), {{blank}} 충격(전쟁/재해)',
           JSON_OBJECT('choices', JSON_ARRAY('매크로', '신용', '지정학적')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1, 2), 'explanation', '이 세 가지 축을 중심으로 나만의 최악의 시나리오를 구성해 보세요.'),
           NULL
       );

-- Q005. LINK: 시나리오별 실전 매뉴얼
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH008_LS005', 'LV3_CH008_LS005_Q005', 'LINK',
           '발생 가능한 위기 상황과 그에 따른 미리 정해둔 대응 액션을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id', 'L1', 'text', '계좌 전체 MDD 20% 도달'),
                   JSON_OBJECT('id', 'L2', 'text', '보유 종목 분식회계 뉴스'),
                   JSON_OBJECT('id', 'L3', 'text', '국가 간 전면전 발발'),
                   JSON_OBJECT('id', 'L4', 'text', '기준 금리 예상치 상회 인상')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id', 'R1', 'text', '기계적 비중 50% 축소 및 관망'),
                           JSON_OBJECT('id', 'R2', 'text', '이유 불문 즉시 전량 매도'),
                           JSON_OBJECT('id', 'R3', 'text', '안전자산(금, 달러)으로 즉시 대피'),
                           JSON_OBJECT('id', 'R4', 'text', '성장주 비중 축소 및 가치주 전환')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1', 'R1', 'L2', 'R2', 'L3', 'R3', 'L4', 'R4'), 'explanation', '생각은 평소에 하고, 위기 때는 행동만 해야 합니다.'),
           NULL
       );

-- Q001. CONCEPT: 투자 철학이 왜 모든 것인가? (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS001', 'LV3_CH009_LS001_Q001', 'CONCEPT',
           '투자의 기술보다 철학이 먼저 확립되어야 하는 이유를 심층적으로 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 드디어 모든 기술을 배웠어요! 이제 어떤 종목이든 다 맞힐 수 있겠죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '아니요, 오히려 이제부터가 진짜 시작이에요. 모든 기술을 안다고 해서 모두가 돈을 버는 건 아니거든요. 중요한 건 "사용자님은 어떤 사람인가?"라는 질문에 답하는 거예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '제가 어떤 사람인지가 투자랑 무슨 상관인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '엄청난 상관이 있죠. 예를 들어, 성격이 급한 사람이 10년을 기다려야 하는 "가치 투자"를 하면 고통스러워서 결국 바닥에서 팔게 돼요. 반대로 보수적인 사람이 변동성이 큰 "성장주 데이트레이딩"을 하면 밤잠을 설치며 일상을 망치게 되죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 아무리 좋은 기법이라도 내 성격과 안 맞으면 독이 된다는 말씀이군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. "나는 싼 주식을 사서 기다릴 때 행복한가(가치)?", "폭발적으로 성장하는 기업의 비전을 믿는가(성장)?", "오직 숫자와 통계만 믿는가(퀀트)?" 이 질문들에 확신이 생겨야 흔들리지 않는 "철학"이 생깁니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 철학은 폭풍우가 치는 시장에서 나를 지탱해 줄 "뿌리"와 같은 거네요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞습니다. 남의 철학을 빌려 쓰는 사람은 조정장에 뿌리가 뽑히지만, 자기 철학이 있는 사람은 그 비바람을 이용해 더 큰 나무로 성장합니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 투자 스타일 결정 요인
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS001', 'LV3_CH009_LS001_Q002', 'SELECT',
           '자신만의 투자 스타일을 결정할 때 가장 먼저 고려해야 할 요소는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('유명 유튜버의 최근 추천 종목', '자신의 리스크 감내 수준과 투자 가능 시간', '증권사 리포트의 목표 주가 합계')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '투자는 자신의 생활 패턴과 성격에 부합해야 장기적으로 지속 가능합니다.'),
           NULL
       );

-- Q003. MATCH: 스타일별 핵심 가치
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS001', 'LV3_CH009_LS001_Q003', 'MATCH',
           '기업의 현재 가치보다 저렴한 가격에 집중하는 스타일을 {{blank}}, 미래의 폭발적인 매출 증대에 집중하는 스타일을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('가치 투자', '성장 투자', '모멘텀 투자')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '가치와 성장은 시장을 바라보는 두 가지 대표적인 시각입니다.'),
           NULL
       );

-- Q004. DRAG: 철학 수립의 단계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS001', 'LV3_CH009_LS001_Q004', 'DRAG',
           '철학 정립 과정: {{blank}} 파악 → 적합한 자산군 선정 → 매매 {{blank}} 설정 → 반복을 통한 시스템화',
           JSON_OBJECT('choices', JSON_ARRAY('자기 성향', '원칙과 규칙', '시장 트렌드')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '자신을 아는 것이 모든 승리의 시작입니다.'),
           NULL
       );

-- Q005. LINK: 투자 대가들의 철학 연결
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS001', 'LV3_CH009_LS001_Q005', 'LINK',
           '전설적인 투자자와 그들의 핵심 투자 철학을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','워렌 버핏'),
                   JSON_OBJECT('id','L2','text','조지 소로스'),
                   JSON_OBJECT('id','L3','text','레이 달리오'),
                   JSON_OBJECT('id','L4','text','짐 사이먼스')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','해자가 있는 기업에 대한 영구 보유'),
                           JSON_OBJECT('id','R2','text','재귀성 이론을 통한 거대 추세 포착'),
                           JSON_OBJECT('id','R3','text','올웨더 전략을 통한 원칙 중심 시스템'),
                           JSON_OBJECT('id','R4','text','알고리즘과 통계를 통한 퀀트 매매')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '거장들의 철학 중 자신에게 영감을 주는 요소를 흡수해 보세요.'),
           NULL
       );

-- Q001. CONCEPT: 체크리스트, 뇌동매매의 유일한 해독제 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS002', 'LV3_CH009_LS002_Q001', 'CONCEPT',
           '매수 버튼을 누르기 전, 왜 7번 질문을 던져야 하는지 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 좋은 종목을 보면 마음이 급해져서 일단 사고 보게 돼요. 나중에 분석하면 늦을 것 같거든요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 계좌가 녹아내리는 가장 빠른 길이에요. 주식 시장은 도망가지 않아요. 기회는 매일 오죠. 그래서 필요한 게 "투자 체크리스트"입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '체크리스트에는 어떤 내용이 들어가야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '최소한 7가지는 스스로 확인해야 해요. 1. 비즈니스 모델을 한 문장으로 설명 가능한가? 2. 강력한 해자가 있는가? 3. 경영진은 도덕적인가? 4. 밸류에이션상 안전마진이 있는가? 5. 차트상 추세가 살아있는가? 6. 내가 틀렸을 때의 시나리오(손절가)가 있는가? 7. 이 종목은 내 포트폴리오 비중에 적절한가?'),
                   JSON_OBJECT('sender', 'user', 'text', '우와, 이걸 다 통과하는 종목이 있을까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '드물죠. 하지만 그 드문 종목에만 집중할 때 사용자님의 승률은 비약적으로 올라갑니다. 체크리스트는 사용자님의 "감정"이라는 필터를 제거하고 "이성"으로만 판단하게 만드는 안전장치예요.'),
                   JSON_OBJECT('sender', 'user', 'text', '항공기 조종사들이 이륙 전에 점검표를 확인하는 것과 같군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요! 주식 투자도 내 소중한 자산을 태우고 비행하는 것과 같습니다. 점검 없는 이륙은 곧 추락을 의미합니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 체크리스트의 효용
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS002', 'LV3_CH009_LS002_Q002', 'SELECT',
           '매매 체크리스트를 사용하는 가장 핵심적인 이유는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('남들보다 1초라도 더 빨리 사기 위해', '감정에 휘둘린 즉흥적 매매(뇌동매매)를 방지하기 위해', '더 많은 종목을 담기 위해')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '체크리스트는 투자 결정 과정에서 주관적인 감정을 배제하는 도구입니다.'),
           NULL
       );

-- Q003. MATCH: 핵심 질문의 카테고리
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS002', 'LV3_CH009_LS002_Q003', 'MATCH',
           '기업의 재무 상태와 가치를 따지는 것은 {{blank}} 분석, 주가의 흐름과 수급을 따지는 것은 {{blank}} 분석에 해당합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('기본적', '기술적', '정성적')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '체크리스트에는 두 가지 분석이 모두 포함되어야 합니다.'),
           NULL
       );

-- Q004. DRAG: 매도 체크리스트
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS002', 'LV3_CH009_LS002_Q004', 'DRAG',
           '매도 결정 기준: {{blank}} 훼손 시 → 목표가 도달 시 → 더 좋은 {{blank}} 발견 시',
           JSON_OBJECT('choices', JSON_ARRAY('투자 아이디어', '대안 종목', '단순 주가 하락')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '주가가 내려서가 아니라, 살 때의 이유가 사라졌을 때 파는 것이 정석입니다.'),
           NULL
       );

-- Q005. LINK: 상황별 필터링 결과 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS002', 'LV3_CH009_LS002_Q005', 'LINK',
           '종목 분석 상황과 그에 따른 체크리스트 결과 해석을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','재무는 좋으나 경영진 횡령 의혹'),
                   JSON_OBJECT('id','L2','text','성장성은 높으나 밸류에이션 과다'),
                   JSON_OBJECT('id','L3','text','모든 조건 완벽하나 차트 역배열'),
                   JSON_OBJECT('id','L4','text','투자 아이디어는 유지되나 -10% 하락')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','이유 불문 제외 (질적 결함)'),
                           JSON_OBJECT('id','R2','text','관심 종목 등록 후 조정 기다림'),
                           JSON_OBJECT('id','R3','text','추세 전환 확인 후 매수 시점 조율'),
                           JSON_OBJECT('id','R4','text','원칙에 따른 보유 및 분할 매수 검토')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '체크리스트의 엄격함이 당신의 원금을 지킵니다.'),
           NULL
       );

-- Q001. CONCEPT: 매도, 탐욕과 공포 사이의 균형 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS003', 'LV3_CH009_LS003_Q001', 'CONCEPT',
           '왜 매수보다 매도가 훨씬 어려운지, 그 심리적 장벽을 허무는 법을 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 수익이 20% 나고 있는데, 더 오를까 봐 못 팔겠고 떨어질까 봐 무서워요. 도대체 언제 팔아야 하죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '매도가 어려운 이유는 "후회하고 싶지 않은 마음" 때문이에요. 팔고 나서 더 오르면 배 아플 것 같고, 안 팔았다가 떨어지면 자책할 것 같죠. 그래서 필요한 게 "기계적인 출구 전략"입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '기계적인 전략이요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '네, 매도는 크게 세 가지 상황에서만 합니다. 첫째, 내가 세운 "목표 가격"에 도달했을 때. 둘째, 이 주식을 샀던 "이유(투자 아이디어)"가 깨졌을 때. 셋째, 이 종목보다 훨씬 더 수익률이 기대되는 "강력한 대안"이 나타났을 때.'),
                   JSON_OBJECT('sender', 'user', 'text', '주가가 오르고 내리는 건 기준이 아니군요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 주가는 시장의 소음일 뿐이에요. 특히 "분할 매도"를 활용하세요. 목표가에서 절반을 팔아 수익을 확정 지으면, 나머지 절반은 "공짜 주식"처럼 편안하게 끝까지 추세를 즐길 수 있습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '아! 일부라도 수익을 챙기면 심리적 여유가 생기겠네요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 고수들의 비결입니다. 어깨에서 팔겠다는 마음을 비우세요. 무릎에서 사서 어깨에서 팔 수만 있다면 사용자님은 이미 전 세계 상위 1% 투자자입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 가장 현명한 매도 타이밍
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS003', 'LV3_CH009_LS003_Q002', 'SELECT',
           '장기 투자자 입장에서 주식을 즉시 매도해야 하는 가장 강력한 이유는?',
           JSON_OBJECT('choices', JSON_ARRAY('주변 친구들이 모두 팔라고 말할 때', '회사의 본질적인 해자가 파괴되거나 산업 환경이 변했을 때', '어제 산 가격보다 3% 떨어졌을 때')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '보유 근거가 사라진 주식을 들고 있는 것은 투자가 아니라 희망 고문입니다.'),
           NULL
       );

-- Q003. MATCH: 매도 기법의 종류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS003', 'LV3_CH009_LS003_Q003', 'MATCH',
           '수익을 극대화하기 위해 전 고점을 돌파할 때마다 손절가를 올리는 기법을 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('트레일링 스탑', '패닉 셀링', '물타기')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '트레일링 스탑은 하락 시 수익을 보존하면서 상승은 끝까지 따라가는 기술입니다.'),
           NULL
       );

-- Q004. DRAG: 현금 비중의 의미
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS003', 'LV3_CH009_LS003_Q004', 'DRAG',
           '현금은 아무것도 하지 않는 상태가 아니라, 다음 기회를 잡기 위한 {{blank}}이며 시장이 과열될수록 그 {{blank}}을 높여야 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('공격적인 포지션', '비중', '방어적 수단')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '모두가 흥분할 때 현금을 쥐고 있는 자가 다음 하락장의 승자가 됩니다.'),
           NULL
       );

-- Q005. LINK: 매도 원칙과 실행 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS003', 'LV3_CH009_LS003_Q005', 'LINK',
           '투자 상황에 따른 올바른 매도 대응을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id', 'L1', 'text', '적정 주가 도달 후 과열 신호'),
                   JSON_OBJECT('id', 'L2', 'text', '예상치 못한 분식회계 공시'),
                   JSON_OBJECT('id', 'L3', 'text', '단순 시장 급락으로 인한 공포'),
                   JSON_OBJECT('id', 'L4', 'text', '더 매력적인 종목 발견')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id', 'R1', 'text', '1차 분할 매도 및 수익 확정'),
                           JSON_OBJECT('id', 'R2', 'text', '이유 불문 전량 즉시 손절'),
                           JSON_OBJECT('id', 'R3', 'text', '보유 근거 재점검 후 홀딩 또는 매수'),
                           JSON_OBJECT('id', 'R4', 'text', '교체 매매를 통한 포트 최적화')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '매도는 감정이 아니라 원칙의 실행입니다.'),
           NULL
       );

-- Q001. CONCEPT: 기록은 뇌의 착각을 이기는 유일한 도구 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS004', 'LV3_CH009_LS004_Q001', 'CONCEPT',
           '왜 매매 일지를 쓰는 것이 수익률 향상에 직결되는지 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 매매 일지 쓰는 게 너무 귀찮아요. 수익률은 증권사 앱이 다 계산해 주는데 왜 따로 기록해야 하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '증권사 앱은 "결과"만 알려줄 뿐, 사용자님이 왜 그런 결정을 내렸는지 "이유"는 알려주지 않기 때문이에요. 인간의 뇌는 성공하면 내 실력이라 믿고, 실패하면 운이 나빴다고 기억을 왜곡하거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '맞아요... 가끔 제가 왜 이 주식을 샀는지 기억이 안 날 때가 있어요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 기록이 필요한 이유입니다. 매수 시점의 내 감정(공포, 탐욕, 설렘), 분석한 데이터, 그리고 손절가를 명확히 적어두세요. 나중에 복기할 때 "아, 내가 이 지표를 무시했구나" 혹은 "감정에 휘둘려 뇌동매매했구나"라는 통찰을 얻게 됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '그 통찰이 쌓이면 어떻게 되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '똑같은 실수를 반복하지 않게 되죠. 이걸 일본어로 "카이젠(Kaizen, 개선)"이라고 해요. 매일 1%씩만 내 매매의 오류를 고쳐나간다면, 1년 뒤 사용자님은 시장이 결코 이길 수 없는 강력한 시스템 투자자가 되어 있을 겁니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '기록이 결국 나만의 "성장 엔진"이 되는 거군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확합니다. 기록하지 않는 투자는 도박이고, 기록하는 투자는 경영입니다.')
           ), NULL, NULL
       );

-- Q002. SELECT: 매매 복기의 핵심 요소
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS004', 'LV3_CH009_LS004_Q002', 'SELECT',
           '매매 일지를 작성할 때, 실력 향상을 위해 가장 중요하게 기록해야 할 항목은?',
           JSON_OBJECT('choices', JSON_ARRAY('오늘의 코스피 지수 종가', '매수/매도를 결정한 구체적인 근거와 당시의 감정 상태', '증권사 직원의 친절도')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '자신의 의사결정 과정을 객관화해야 오류를 수정할 수 있습니다.'),
           NULL
       );

-- Q003. MATCH: 지속적 개선(Kaizen)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS004', 'LV3_CH009_LS004_Q003', 'MATCH',
           '실패한 매매를 다시 돌아보며 배울 점을 찾는 과정을 {{blank}}라고 하며, 이는 전문가가 되기 위한 필수 코스입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('복기', '추종', '낙관')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '바둑 기사들이 대국 후 복기를 하듯 투자자도 자신의 매매를 복기해야 합니다.'),
           NULL
       );

-- Q004. DRAG: 성장의 선순환 구조
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS004', 'LV3_CH009_LS004_Q004', 'DRAG',
           '투자 성장 사이클: 전략 수립 → {{blank}} 시행 → 결과 {{blank}} → 전략 보완 및 재실행',
           JSON_ARRAY('원칙 매매', '기록 및 복기', '뉴스 검색'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '이 사이클을 반복할수록 투자자의 내공은 깊어집니다.'),
           NULL
       );

-- Q005. LINK: 실수 유형과 해결책
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS004', 'LV3_CH009_LS004_Q005', 'LINK',
           '매매 일지에서 발견된 문제점과 그에 대한 올바른 피드백을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','급등하는 걸 보고 추격 매수함'),
                   JSON_OBJECT('id','L2','text','손절가를 정하지 않아 방치함'),
                   JSON_OBJECT('id','L3','text','특정 종목에 너무 큰 비중 실음'),
                   JSON_OBJECT('id','L4','text','뉴스가 떴는데도 안 팔고 하락 맞음')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','매수 전 7단계 체크리스트 필수 도입'),
                           JSON_OBJECT('id','R2','text','자동 예약 매도(Stop-loss) 설정'),
                           JSON_OBJECT('id','R3','text','자산 배분 원칙 준수 및 분산 투자'),
                           JSON_OBJECT('id','R4','text','재료 소멸 및 선반영 원리 재학습')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '실수는 반복하지 않을 때 자산이 됩니다.'),
           NULL
       );

-- Q001. CONCEPT: 투자 마스터리의 마지막 열쇠 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS005', 'LV3_CH009_LS005_Q001', 'CONCEPT',
           '모든 과정을 마친 사용자님께 드리는 마지막 조언, 투자의 태도를 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 드디어 모든 챕터를 끝냈어요! 이제 전 완벽한 투자자가 된 걸까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '축하합니다! 사용자님은 이제 시장의 상위 5% 안에 드는 지식을 갖추셨어요. 하지만 마지막으로 명심해야 할 것이 있습니다. 바로 "겸손함"과 "시간"이에요.'),
                   JSON_OBJECT('sender', 'user', 'text', '지식만큼이나 태도가 중요한가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럼요. 시장은 거대한 바다와 같아서 언제든 예측을 빗나가게 할 수 있어요. 고수는 자신의 실력을 믿는 게 아니라, 자신의 "원칙"을 믿습니다. 그리고 복리의 마법이 일어날 수 있도록 시장에서 "오래 살아남는 것"에 집중하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '빨리 부자가 되려는 욕심을 버려야 한다는 말씀이군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 복리 계산식 $Future Value = P \times (1 + r)^n$ 에서 가장 중요한 건 수익률($r$)보다 시간($n$)입니다. 조급함은 투자의 가장 큰 적이에요. 이제 사용자님은 자신만의 배를 만들었고 항해하는 법도 배웠습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '이제 어떤 날씨가 와도 제 원칙대로 나아갈 준비가 되었습니다!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '좋습니다. 투자는 세상을 배우고 자신을 성장시키는 아름다운 여정입니다. 이 여정을 평생 즐기시길 바랍니다. 사용자님의 성공적인 투자를 진심으로 응원합니다!')
           ), NULL, NULL
       );

-- Q002. SELECT: 복리의 마법과 시간
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS005', 'LV3_CH009_LS005_Q002', 'SELECT',
           '장기적으로 막대한 부를 쌓기 위해 복리(Compounding) 공식에서 가장 핵심적인 역할을 하는 변수는?',
           JSON_OBJECT('choices', JSON_ARRAY('단기간의 폭발적인 수익률', '투자를 지속하는 시간(기간)', '가장 유명한 종목 선정')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '수익률이 조금 낮더라도 오랜 기간 유지될 때 자산은 기하급수적으로 늘어납니다.'),
           NULL
       );

-- Q003. MATCH: 마스터리의 경지
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS005', 'LV3_CH009_LS005_Q003', 'MATCH',
           '예측할 수 없는 시장 상황에서도 평정심을 유지하며 자신의 시스템을 고수하는 능력을 투자 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('마스터리(Mastery)', '레버리지', '배당')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '기술을 넘어선 철학의 경지가 마스터리입니다.'),
           NULL
       );

-- Q004. DRAG: 성공 투자의 3요소
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS005', 'LV3_CH009_LS005_Q004', 'DRAG',
           '지속 가능한 성공의 공식: 흔들리지 않는 {{blank}} + 수학적 {{blank}} + 시간의 인내',
           JSON_ARRAY('투자 철학', '자산 배분', '운'),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '이 세 가지가 결합될 때 비로소 경제적 자유가 찾아옵니다.'),
           NULL
       );

-- Q005. LINK: 투자자의 성장 단계
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH009_LS005', 'LV3_CH009_LS005_Q005', 'LINK',
           '투자자가 성장하며 겪게 되는 단계와 그 특징을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','초기 단계 (Lv1)'),
                   JSON_OBJECT('id','L2','text','중기 단계 (Lv2)'),
                   JSON_OBJECT('id','L3','text','숙련 단계 (Lv3)'),
                   JSON_OBJECT('id','L4','text','마스터 단계')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','기초 용어 학습 및 묻지마 매매 탈출'),
                           JSON_OBJECT('id','R2','text','재무 및 차트 분석을 통한 종목 선정'),
                           JSON_OBJECT('id','R3','text','자산 배분 및 거시 경제적 관점 확립'),
                           JSON_OBJECT('id','R4','text','자신만의 철학으로 시장을 즐기는 경지')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '사용자님은 이제 모든 단계를 통과하셨습니다!'),
           NULL
       );

-- Q001. CONCEPT: 건물을 주식처럼 사고파는 마법, 리츠(REITs) (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS001', 'LV3_CH0010_LS001_Q001', 'CONCEPT',
           '전통 자산의 한계를 넘는 대체 투자의 세계를 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주식과 채권만으로 포트폴리오를 짜기엔 뭔가 부족한 것 같아요. 더 단단한 자산은 없나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그게 바로 "대체 자산($Alternative$ $Assets$)"이 필요한 이유예요. 가장 대표적인 게 부동산이죠. 하지만 건물 한 채를 통째로 사려면 돈이 너무 많이 들잖아요?'),
                   JSON_OBJECT('sender', 'user', 'text', '네, 그래서 부동산 투자는 엄두가 안 나요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럴 때 "리츠($REITs$)"를 활용하면 돼요. 수많은 투자자의 돈을 모아 대형 빌딩이나 물류센터를 사고, 거기서 나오는 임대료를 주식 배당처럼 나눠주는 상품이죠. 주식처럼 거래소에서 언제든 사고팔 수 있어요.'),
                   JSON_OBJECT('sender', 'user', 'text', '오, 그럼 적은 돈으로도 강남 빌딩의 주인이 될 수 있겠네요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '맞아요. 리츠는 주식 시장과 상관관계가 낮을 때가 많아서 포트폴리오의 안정성을 크게 높여줍니다. 인플레이션이 오면 임대료도 같이 오르니 물가 방어에도 탁월하죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '부동산 외에 다른 대체 자산은 무엇이 있나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '금, 원유, 구리 같은 "원자재"나 교량, 항만 같은 "인프라" 자산도 있어요. 이런 대체 자산들은 경기 사이클의 각 단계에서 주식과는 또 다른 수익 기회를 제공합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 자산의 종류를 다각화하는 것이 진정한 "무적의 포트폴리오"군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 리츠(REITs)의 수익 원천
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS001', 'LV3_CH0010_LS001_Q002', 'SELECT',
           '리츠(REITs) 투자자가 받는 배당금의 가장 주된 원천은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('보유 부동산의 임대 수익', '건물 매각을 통한 시세 차익만', '주식 발행을 통한 현금 유입', '은행 대출 이자')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '리츠는 임대 수익의 대부분을 주주에게 의무적으로 배당해야 합니다.'),
           NULL
       );

-- Q003. MATCH: 인플레이션 헤지 자산
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS001', 'LV3_CH0010_LS001_Q003', 'MATCH',
           '물가가 상승할 때 화폐 가치 하락을 방어하기 위해 투자하는 금, 구리 등의 자산을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('원자재', '채권', '파생상품')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '실물 자산은 물가 상승기에 가치가 동반 상승하는 경향이 있습니다.'),
           NULL
       );

-- Q004. DRAG: 대체 투자의 장단점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS001', 'LV3_CH0010_LS001_Q004', 'DRAG',
           '대체 투자는 전통 자산과의 {{blank}}가 낮아 분산 효과가 크지만, 일반 주식보다 {{blank}}이 낮을 수 있다는 단점이 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('상관관계', '유동성(환금성)', '수익성')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '자산이 현금화되는 속도를 고려하여 비중을 조절해야 합니다.'),
           NULL
       );

-- Q005. LINK: 대체 자산별 투자 테마
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS001', 'LV3_CH0010_LS001_Q005', 'LINK',
           '대체 자산의 종류와 그 투자 목적을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','데이터센터 리츠'),
                   JSON_OBJECT('id','L2','text','금 (Gold)'),
                   JSON_OBJECT('id','L3','text','원유 및 에너지'),
                   JSON_OBJECT('id','L4','text','사회기반시설(인프라)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','AI 성장에 따른 물리적 인프라 선점'),
                           JSON_OBJECT('id','R2','text','경제 위기 시 최후의 안전 자산'),
                           JSON_OBJECT('id','R3','text','경기 회복 및 에너지 인플레 대응'),
                           JSON_OBJECT('id','R4','text','장기적이고 안정적인 통행료 수익')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '세상의 모든 것이 투자 자산이 될 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: 비트코인, 사기인가 새로운 혁명인가? (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS002', 'LV3_CH0010_LS002_Q001', 'CONCEPT',
           '가상자산이 포트폴리오에서 갖는 의미를 심층적으로 파헤쳐 봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 비트코인은 실체도 없는데 왜 이렇게 비싸게 거래되나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그 질문은 "금은 왜 비싼가?"라는 질문과 비슷해요. 금도 산업적 용도는 적지만, 전 세계가 "희소성"과 "가치 저장 수단"으로 인정했기 때문에 가치가 생기죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, 비트코인도 2,100만 개로 한정되어 있어서 희소성이 있다는 거군요.'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 그래서 "디지털 금"이라고 불립니다. 특히 최근에는 비트코인 현물 ETF가 승인되면서 블랙록 같은 거대 자산운용사들도 투자를 시작했어요. 이제는 단순한 투기를 넘어 제도권 자산의 하나로 인정받고 있죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '이더리움은 비트코인과 무엇이 다른가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '이더리움은 "디지털 석유"에 가까워요. 스스로 계약을 실행하는 "스마트 컨트랙트" 기능을 통해 그 위에서 수많은 앱(DApp)과 NFT가 돌아가게 하는 인프라거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 저도 자산의 100%를 코인에 투자해야 할까요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '절대 안 돼요! 가상자산은 변동성이 주식의 5~10배에 달합니다. 하지만 전체 자산의 1~5% 정도를 담는다면, 포트폴리오의 전체 수익률(Alpha)을 극적으로 높이면서도 리스크는 관리 가능한 수준으로 유지할 수 있습니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '새로운 기술을 포트폴리오의 "양념"으로 활용하라는 말씀이군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 비트코인의 핵심 속성
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS002', 'LV3_CH0010_LS002_Q002', 'SELECT',
           '비트코인이 "디지털 금"으로 불리며 가치 저장 수단으로 주목받는 가장 결정적인 이유는 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('중앙은행이 무제한으로 발행할 수 있어서', '총 발행량이 2,100만 개로 한정되어 있어서', '주식 시장과 항상 똑같이 움직여서')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '공급량이 제한된 희소성은 가상자산의 가치를 지탱하는 핵심 원리입니다.'),
           NULL
       );

-- Q003. MATCH: 스마트 컨트랙트(Smart Contract)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS002', 'LV3_CH0010_LS002_Q003', 'MATCH',
           '중앙 관리자 없이 코드에 의해 자동으로 계약이 체결되는 기술을 {{blank}}라고 하며, 이더리움의 핵심 기능입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('스마트 컨트랙트', '작업 증명', '분산 원장')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '이 기술은 금융, 유통 등 다양한 산업에 혁신을 가져오고 있습니다.'),
           NULL
       );

-- Q004. DRAG: 가상자산의 포지션
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS002', 'LV3_CH0010_LS002_Q004', 'DRAG',
           '가상자산은 포트폴리오에서 {{blank}}을(를) 높이는 역할을 하지만, {{blank}} 또한 매우 크므로 소량만 배분하는 것이 정석입니다.',
           JSON_OBJECT('choices', JSON_ARRAY('기대 수익률', '변동성 리스크', '유동성')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '고위험 고수익 자산은 비중 관리가 생명입니다.'),
           NULL
       );

-- Q005. LINK: 크립토 시장의 주요 개념
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH0010_LS002', 'LV3_CH0010_LS002_Q005', 'LINK',
           '가상자산 관련 용어와 그 의미를 올바르게 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','Halving (반감기)'),
                   JSON_OBJECT('id','L2','text','DeFi (탈중앙화 금융)'),
                   JSON_OBJECT('id','L3','text','NFT (대체불가토큰)'),
                   JSON_OBJECT('id','L4','text','Stablecoin (스테이블코인)')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','채굴 보상이 절반으로 줄어 공급이 감소하는 이벤트'),
                           JSON_OBJECT('id','R2','text','블록체인 상에서 중개자 없이 이뤄지는 금융 서비스'),
                           JSON_OBJECT('id','R3','text','디지털 자산의 유일한 소유권을 증명하는 기술'),
                           JSON_OBJECT('id','R4','text','달러 등 법정화폐 가치와 연동된 가상자산')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '디지털 경제의 기본 문법을 익혀야 새로운 기회를 잡을 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: 상장 전의 기회, 비상장 주식 (심층 대화)
INSERT INTO learning_question
(lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES
    (
        'LV3_CH010_LS003',
        'LV3_CH010_LS003_Q001',
        'CONCEPT',
        '남들보다 한발 앞서 미래의 거물을 선점하는 비상장 투자의 세계를 알아봅시다.',

        JSON_ARRAY(
                JSON_OBJECT('sender', 'user', 'text', '멘토님, 쿠팡이나 토스 같은 기업들은 상장하기 전에도 주식이 있었나요? 그때 샀으면 대박이었을 텐데 말이죠.'),
                JSON_OBJECT('sender', 'mentor', 'text', '맞아요! 그걸 "비상장 주식"이라고 해요. 기업이 공개(IPO)되기 전에 투자하는 건데, 위험은 크지만 성공하면 상장 후 수십, 수백 배의 수익을 주기도 하죠.'),
                JSON_OBJECT('sender', 'user', 'text', '저 같은 개인도 그런 주식을 살 수 있나요?'),
                JSON_OBJECT('sender', 'mentor', 'text', '예전엔 기관들만의 잔치였지만, 요즘은 비상장 거래 플랫폼이 많아져서 개인도 참여할 수 있어요. 하지만 "유니콘(기업가치 1조 원 이상의 비상장사)"을 찾는 건 모래사장에서 바늘 찾기만큼 어려워요.'),
                JSON_OBJECT('sender', 'user', 'text', '그럼 사모펀드(PEF)는 무엇인가요?'),
                JSON_OBJECT('sender', 'mentor', 'text', '사모펀드(Private Equity Fund)는 소수의 고액 투자자로부터 돈을 모아 기업을 아예 통째로 인수한 뒤, 기업 가치를 높여서 되팔아 큰 수익을 남기는 "기업 사냥꾼이자 해결사"예요.'),
                JSON_OBJECT('sender', 'user', 'text', '비상장 투자의 가장 큰 주의점은 무엇인가요?'),
                JSON_OBJECT('sender', 'mentor', 'text', '가장 큰 문제는 "환금성"이에요. 주식 시장처럼 언제든 팔 수 있는 게 아니라서, 상장될 때까지 몇 년 동안 돈이 묶일 수 있죠. "하이 리스크 하이 리턴"의 정석이라 할 수 있습니다.'),
                JSON_OBJECT('sender', 'user', 'text', '결국 인내심과 안목이 동시에 필요한 영역이군요!')
        ),

        NULL,
        NULL
    );

-- Q002. SELECT: 유니콘 기업의 정의
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS003', 'LV3_CH010_LS003_Q002', 'SELECT',
           '비상장 스타트업 중 기업 가치가 10억 달러(약 1조 원) 이상인 기업을 부르는 용어는?',
           JSON_OBJECT('choices', JSON_ARRAY('유니콘(Unicorn)', '데카콘(Decacorn)', '블루칩', '가젤')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '유니콘은 상장 전 희귀하고 거대한 가치를 지닌 기업을 상징합니다.'),
           NULL
       );

-- Q003. MATCH: 회수 전략(Exit)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS003', 'LV3_CH010_LS003_Q003', 'MATCH',
           '비상장 투자자가 수익을 실현하기 위해 기업을 주식 시장에 공개하는 것을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('IPO (기업공개)', 'M&A (인수합병)', 'LBO (차입인수)')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'IPO는 비상장 투자자가 가장 크게 수익을 내는 보편적인 엑시트 방법입니다.'),
           NULL
       );

-- Q004. DRAG: 투자의 단계별 명칭
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS003', 'LV3_CH010_LS003_Q004', 'DRAG',
           '초기 창업 단계 투자는 {{blank}}, 어느 정도 성장한 기업에 대한 거대 자본 투자는 {{blank}}가 담당합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('엔젤 투자/VC', '사모펀드(PEF)', '공모펀드')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '기업의 성장 단계에 따라 투자의 성격과 규모가 달라집니다.'),
           NULL
       );

-- Q005. LINK: 비상장 투자의 핵심 지표 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS003', 'LV3_CH010_LS003_Q005', 'LINK',
           '비상장 기업 분석 시 사용하는 용어와 그 의미를 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','Burn Rate'),
                   JSON_OBJECT('id','L2','text','Post-money Valuation'),
                   JSON_OBJECT('id','L3','text','Series A'),
                   JSON_OBJECT('id','L4','text','Lock-up')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','매달 현금이 소진되는 속도'),
                           JSON_OBJECT('id','R2','text','투자 유치 직후의 기업 가치'),
                           JSON_OBJECT('id','R3','text','본격적인 시장 진출을 위한 첫 대규모 투자 단계'),
                           JSON_OBJECT('id','R4','text','상장 후 일정 기간 주식을 팔지 못하게 묶는 조치')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '이 용어들을 알아야 비상장 리포트를 해독할 수 있습니다.'),
           NULL
       );

-- Q001. CONCEPT: 숫자를 넘어 데이터를 읽는 AI (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS004', 'LV3_CH0010_LS004_Q001', 'CONCEPT',
           '전통적 분석의 한계를 깨는 "대안 데이터"의 위력을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 요즘 월스트리트에서는 위성 사진으로 주가를 예측한다는데 사실인가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '그럼요! 그걸 "대안 데이터($Alternative$ $Data$)"라고 해요. 예를 들어 월마트 주차장의 위성 사진을 분석해서 차가 많으면 실적이 잘 나오겠다고 미리 판단해 주식을 사는 식이죠.'),
                   JSON_OBJECT('sender', 'user', 'text', '와, 재무제표가 나오기도 전에 실적을 맞히는 거네요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '정확해요. 뉴스 기사 수백만 개를 AI가 초 단위로 읽어서 시장의 분위기를 파악하는 "감성 분석", 카드 결제 내역을 분석해 특정 브랜드의 유행을 알아내는 것 등이 모두 포함돼요.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 개미들은 AI에게 무조건 지는 거 아닌가요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '꼭 그렇진 않아요. AI는 데이터를 분석하지만, "왜" 그런 일이 일어나는지에 대한 통찰력은 인간이 더 뛰어나거든요. 이제는 "AI를 도구로 쓰는 투자자"가 "전통적 투자자"를 이기는 시대입니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '결국 데이터의 홍수 속에서 의미 있는 신호를 찾아내는 게 핵심이군요!')
           ), NULL, NULL
       );

-- Q002. SELECT: 대안 데이터의 종류
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS004', 'LV3_CH010_LS004_Q002', 'SELECT',
           '금융 시장에서 "대안 데이터(Alternative Data)"에 해당하지 않는 것은 무엇일까요?',
           JSON_OBJECT('choices', JSON_ARRAY('기업의 분기별 정기 재무제표', '소셜 미디어의 감성 분석 데이터', '주요 항만의 선박 물동량 데이터', '실시간 신용카드 소비 데이터')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '재무제표는 모두에게 공개된 "전통적 데이터"입니다.'),
           NULL
       );

-- Q003. MATCH: 자연어 처리(NLP)의 역할
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS004', 'LV3_CH010_LS004_Q003', 'MATCH',
           'AI가 뉴스나 보고서 같은 텍스트 데이터를 읽고 긍정/부정 수치를 계산하는 기술을 {{blank}}라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('NLP (자연어 처리)', '블록체인', '양자 컴퓨팅')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', 'NLP를 통해 수만 건의 텍스트에서 투자 힌트를 즉각 추출할 수 있습니다.'),
           NULL
       );

-- Q004. DRAG: AI 투자의 장단점
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS004', 'LV3_CH010_LS004_Q004', 'DRAG',
           'AI는 대량의 데이터를 {{blank}}하게 처리하는 데 강점이 있지만, 과거에 없던 {{blank}} 상황에서는 오류를 범할 수 있습니다.',
           JSON_OBJECT('choices', JSON_ARRAY('객관적/신속', '블랙 스완', '반복적')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', 'AI는 만능이 아니며 인간의 최종 판단이 필요합니다.'),
           NULL
       );

-- Q005. LINK: 데이터와 투자 인사이트 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS004', 'LV3_CH010_LS004_Q005', 'LINK',
           '특정 대안 데이터가 어떤 투자 힌트를 주는지 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','공장 지대의 야간 불빛'),
                   JSON_OBJECT('id','L2','text','특정 앱의 다운로드 수'),
                   JSON_OBJECT('id','L3','text','구인 사이트의 채용 공고'),
                   JSON_OBJECT('id','L4','text','항공기 운항 트래픽')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','제조업 가동률 및 생산 지표 예측'),
                           JSON_OBJECT('id','R2','text','플랫폼 기업의 사용자 성장세 파악'),
                           JSON_OBJECT('id','R3','text','회사의 사업 확장 및 미래 투자 의지'),
                           JSON_OBJECT('id','R4','text','글로벌 여행 수요 및 경기 회복 판단')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', '남들이 보지 않는 데이터에서 진짜 수익이 나옵니다.'),
           NULL
       );

-- Q001. CONCEPT: 착한 기업이 수익률도 높은 이유 (심층 대화)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS005', 'LV3_CH0010_LS005_Q001', 'CONCEPT',
           '금융의 새로운 문법, ESG 투자의 본질을 상세히 알아봅시다.',
           JSON_ARRAY(
                   JSON_OBJECT('sender', 'user', 'text', '멘토님, 주식 투자는 돈만 잘 벌면 장땡 아닌가요? 왜 요즘 ESG 타령이죠?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '예전엔 그랬죠. 하지만 이제는 환경을 파괴하거나 부도덕한 기업은 "거대한 리스크"를 안고 있는 기업으로 간주해요. 갑작스러운 규제나 불매운동으로 한순간에 망할 수 있거든요.'),
                   JSON_OBJECT('sender', 'user', 'text', '아, ESG가 단순한 도덕 공부가 아니라 "리스크 관리"군요!'),
                   JSON_OBJECT('sender', 'mentor', 'text', '빙고! 블랙록 같은 거대 자산운용사들은 ESG 점수가 낮은 기업에는 아예 투자를 안 하겠다고 선언했어요. 큰돈이 안 들어오니 주가가 오르기 힘들겠죠. 반면 지배구조(G)가 투명한 기업은 코리아 디스카운트를 해소하며 정당한 평가를 받게 됩니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '그럼 ESG만 보고 투자하면 무조건 성공하나요?'),
                   JSON_OBJECT('sender', 'mentor', 'text', '주의할 점도 있어요. 겉으로만 착한 척하는 "그린워싱($Greenwashing$)"을 조심해야 하죠. 실체 없이 마케팅으로만 ESG를 외치는 기업을 걸러내는 눈이 필요합니다.'),
                   JSON_OBJECT('sender', 'user', 'text', '이제는 재무제표의 숫자 너머에 있는 기업의 "태도"까지 봐야 하는 시대군요.')
           ), NULL, NULL
       );

-- Q002. SELECT: ESG의 핵심 요소
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS005', 'LV3_CH010_LS005_Q002', 'SELECT',
           'ESG 투자에서 "G(Governance)"가 의미하는 가장 중요한 항목은?',
           JSON_OBJECT('choices', JSON_ARRAY('기업의 탄소 배출량', '투명한 이사회 운영과 주주 권익 보호', '임직원들의 봉사 활동 시간', '친환경 제품 생산 비중')),
           JSON_OBJECT('correct', JSON_ARRAY(1), 'explanation', '지배구조(G)는 기업이 얼마나 공정하고 투명하게 의사결정을 내리는지를 뜻합니다.'),
           NULL
       );

-- Q003. MATCH: 그린워싱(Greenwashing)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS005', 'LV3_CH010_LS005_Q003', 'MATCH',
           '실제로는 친환경적이지 않으면서 광고나 마케팅을 통해 친환경 이미지로 위장하는 행위를 {{blank}}이라고 합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('그린워싱', '백워싱', '화이트워싱')),
           JSON_OBJECT('correct', JSON_ARRAY(0), 'explanation', '투자자는 기업의 공시를 통해 ESG의 실체를 확인해야 합니다.'),
           NULL
       );

-- Q004. DRAG: 투자의 패러다임 변화
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS005', 'LV3_CH010_LS005_Q004', 'DRAG',
           '과거 투자가 {{blank}} 지표에만 집중했다면, 미래 투자는 ESG와 같은 {{blank}} 지표를 결합하여 기업의 지속 가능성을 평가합니다.',
           JSON_OBJECT('choices', JSON_ARRAY('재무적', '비재무적', '정량적')),
           JSON_OBJECT('correct', JSON_ARRAY(0, 1), 'explanation', '숫자와 가치가 결합될 때 더 안전한 수익이 만들어집니다.'),
           NULL
       );

-- Q005. LINK: ESG 실전 사례 연결 (4개 선지)
INSERT INTO learning_question (lesson_id, question_id, question_type, question_text, options, answer, image)
VALUES (
           'LV3_CH010_LS005', 'LV3_CH010_LS005_Q005', 'LINK',
           'ESG 관련 사건과 그로 인한 투자 위험을 연결하세요.',
           JSON_OBJECT(
                   'left', JSON_ARRAY(
                   JSON_OBJECT('id','L1','text','탄소 국경세 도입'),
                   JSON_OBJECT('id','L2','text','직장 내 갑질 및 인권 침해'),
                   JSON_OBJECT('id','L3','text','최대주주의 횡령 및 배임'),
                   JSON_OBJECT('id','L4','text','재생 에너지 투자 확대')
                           ),
                   'right', JSON_ARRAY(
                           JSON_OBJECT('id','R1','text','수출 기업의 원가 상승 및 이익 감소 (E)'),
                           JSON_OBJECT('id','R2','text','브랜드 이미지 실추 및 불매 운동 (S)'),
                           JSON_OBJECT('id','R3','text','상장 폐지 위험 및 투자 심리 붕괴 (G)'),
                           JSON_OBJECT('id','R4','text','장기적 성장 동력 확보 및 자금 유입 (호재)')
                            )
           ),
           JSON_OBJECT('correct', JSON_OBJECT('L1','R1', 'L2','R2', 'L3','R3', 'L4','R4'), 'explanation', 'ESG는 이제 피할 수 없는 실전 투자 전략입니다.'),
           NULL
       );
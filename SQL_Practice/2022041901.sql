2022-0419-01)
형 변환 함수
 - 함수가 사용된 위치에서 데이터타입의 형을 변환시킴
 - TO_CHAR, TO_DATE, TO_NUMBER, CAST 제공
 1) CAST(expr AS type명)
  - 'column'의 데이터타입을 'type'으로 변환
 (사용예) SELECT '홍길동',
                CAST('홍길동' AS CHAR(20)),
                CAST('20200418' AS DATE)
           FROM DUAL;
           
        SELECT MAX(CAST(CART_NO AS NUMBER))+1
           FROM CART
          WHERE CART_NO LIKE '20200507%';
          
 2) TO_CHAR(c), TO_CHAR(d | n[,fmt])
  - 주어진 문자열을 문자열로 변환
    (단, c의 타입이 CHAT or CLOB인 경우 VARCHAR2로 변환하는 경우만 허용)
  - 주어진 날짜(d) 또는 숫자(n)을 정의된 형식(fmt)으로 변환
------------------------------------------------------------------------------
  FORMAT문자          의미                        사용예
------------------------------------------------------------------------------
    AD, BC           서기         SELECT TO_CHAR(SYSDATE, 'AD') FROM DUAL;--현재 데이터를 기준으로 반환(기원후이므로 BC를 써도 서기를 반환)
   CC, YEAR        세기,년도       SELECT TO_CHAR(SYSDATE, 'CC YEAR') FROM DUAL;--CC: 21세기, YEAR:영어로 년도 표기
YYYY,YYY,YY,Y        년도         SELECT TO_CHAR(SYSDATE, 'YYYY YYY YY Y') FROM DUAL;
      Q              분기         SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;
   MM, RM            월           SELECT TO_CHAR(SYSDATE, 'YY:MM:RM') FROM DUAL; --MM:월, RM:로만식표기
  MONTH, MON         월           SELECT TO_CHAR(SYSDATE, 'YY:MONTH MON') FROM DUAL;--mm월로 표기
  W, WW, IW          주차         SELECT TO_CHAR(SYSDATE, 'W WW IW') FROM DUAL;--W:그 달의 주차, WW, IW:그 해의 주차
  DD, DDD, J         일차         SELECT TO_CHAR(SYSDATE, 'DD DDD J') FROM DUAL;--DD:그 달의 몇일 째,DDD: 그 해의 몇일 째,J: 율리우스력 몇일 째
  DAY, DY, D         요일         SELECT TO_CHAR(SYSDATE, 'DAY DY D') FROM DUAL;--DAY:화요일, DY:화, D:요일의 인덱스값(화요일 > 3, 일요일 > 1)
    AM, PM         오전/오후       SELECT TO_CHAR(SYSDATE, 'AM') FROM DUAL;--현재데이터를 기준으로 반환(오후에는 AM을 써도 오후를 반환)
   A.M, P.M          ''          SELECT TO_CHAR(SYSDATE, 'A.M.') FROM DUAL;
HH, HH12, HH24       시간         SELECT TO_CHAR(SYSDATE, 'HH HH12 HH24') FROM DUAL;--HH,HH12: 12시간형태, HH24:24시간형태
      MI             분           SELECT TO_CHAR(SYSDATE, 'HH24:MI') FROM DUAL;--분을 반환
   SS, SSSSS         초           SELECT TO_CHAR(SYSDATE, 'SS SSSSS') FROM DUAL;--SS:현재 초, SSSSS:1일 중 현재 초
    "문자열"   사용자정의형식문자열    SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') FROM DUAL;
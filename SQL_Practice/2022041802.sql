2022-0418-02)
형 변환 함수
 - 함수가 사용된 위치에서 데이터타입의 형을 변환시킴
 - TO_CHAR, TO_DATE, TO_NUMBER, CAST 제공
 1) CAST(expr AS type명)
  . 'column'의 데이터타입을 'type'으로 변환
 (사용예) SELECT '홍길동',
                CAST('홍길동' AS CHAR(20)),
                CAST('20200418' AS DATE)
           FROM DUAL;
           
        SELECT MAX(CAST(CART_NO AS NUMBER)))+1
           FROM CART
          WHERE CART_NO LIKE '20200507%';
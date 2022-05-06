2022-0506-01)
PL/SQL(절차적인 언어로써의 구조화된 질의 언어)
Procedure Language/Structure Query Language

PUSTA
- Package(패키지)
- User Function(사용자 정의 함수)
- Stored Procedure(저장 프로시져)
- Trigger(트리거)
- Anonymous Block(익명 블록)

1.커서(CURSOR)
 (사용형식)
    CURSOR 커서명 IS
      SELECT문
    OPEN 커서명;
    FETCH 커서명 INTO 변수명[,변수명,...];
    CLOSE 커서명;
    
 (사용예) 2020년 상품별 총 입고 수량을 출력하는 커서
SET SERVEROUTPUT ON;
    DECLARE
      V_BPROD BUYPROD.BUY_PROD%TYPE; 
      V_QTY BUYPROD.BUY_QTY%TYPE;
      CURSOR CUR_BP IS
        SELECT BUY_PROD, SUM(BUY_QTY)
          FROM BUYPROD
         WHERE BUY_DATE LIKE '2020%'
         GROUP BY BUY_PROD
         ORDER BY BUY_PROD;
    BEGIN
      OPEN CUR_BP; --커서를 메모리에 할당(바인드)
      FETCH CUR_BP INTO V_BPROD, V_QTY; -- 다음 행으로 이동, 행이 존재하는지 체크
      WHILE CUR_BP%FOUND LOOP -- 값이 존재하는지 따짐(FOUND : 데이터 존재?/NOTFOUND : 데이터 없지?/ROWCOUNT:행의 수)
        DBMS_OUTPUT.PUT_LINE(CUR_BP%ROWCOUNT || '번째 상품ID= ' || V_BPROD || ' 입고수량= ' || V_QTY); --출력
        FETCH CUR_BP INTO V_BPROD, V_QTY; -- 다음 행으로 이동, 행이 존재하는지 체크
      END LOOP;
      CLOSE CUR_BP; --사용중인 메모리를 반환(필드)
    END;
 (사용예)회원테이블에서 회원명과 마일리지를 출력하시오
        단, 직업이 '주부'인 회원만 출력하고 회원명으로 오름차순 정렬
        CUR_MEM 커서를 정의, 익명블록으로 표현 
        --CURSOR에 매개변수 사용
    DECLARE 
    V_MNAME MEMBER.MEM_NAME%TYPE; --REFERENCE 변수
    V_MILEAGE NUMBER(10); --SCALAR 변수
      CURSOR CUR_MEM(V_JOB VARCHAR2) IS --매개변수 사용
        SELECT MEM_NAME, MEM_MILEAGE
          FROM MEMBER
         WHERE MEM_JOB = V_JOB
         ORDER BY 1;
    BEGIN
      OPEN CUR_MEM('학생');
      LOOP
        FETCH CUR_MEM INTO V_MNAME, V_MILEAGE; --페치
        EXIT WHEN CUR_MEM%NOTFOUND; --따지고
        DBMS_OUTPUT.PUT_LINE(CUR_MEM%ROWCOUNT||'. 이름: ' || V_MNAME || ', 마일리지: ' ||V_MILEAGE); --출력
      END LOOP;  
      CLOSE CUR_MEM;
    END;
 
 (사용예)직업을 입력받아서 FOR LOOP를 이용하는 CURSOR
        --FOR 문으로 반복하는 동안 커서를 자동으로 OPEN하고
        --모든 행이 처리되면 자동으로 커서를 CLOSE함
    DECLARE 
      CURSOR CUR_MEM(V_JOB VARCHAR2) IS --매개변수 사용
        SELECT MEM_NAME, MEM_MILEAGE
          FROM MEMBER
         WHERE MEM_JOB = V_JOB
         ORDER BY 1;
    BEGIN --REC : 자동선언되는 묵시적 변수
      FOR REC IN CUR_MEM('학생') LOOP
        DBMS_OUTPUT.PUT_LINE(CUR_MEM%ROWCOUNT||'. 이름: ' || REC.MEM_NAME || ', 마일리지: ' ||REC.MEM_MILEAGE); --출력
      END LOOP;
    END;
    
-----------------------------------------------------
    BEGIN --서브쿼리를 사용한 FOR문
      FOR REC IN (SELECT MEM_NAME, MEM_MILEAGE
                    FROM MEMBER
                   WHERE MEM_JOB = '학생'
                   ORDER BY 1)
      LOOP
        DBMS_OUTPUT.PUT_LINE('이름: ' || REC.MEM_NAME || ', 마일리지: ' ||REC.MEM_MILEAGE); --출력
      END LOOP;
    END;
---------------------------------------------------------------
/
        SELECT A.MEM_ID, A.MEM_NAME, SUM(B.PROD_SALE*C.CART_QTY) AS CSUM
          FROM MEMBER A
    INNER JOIN CART C ON(A.MEM_ID = C.CART_MEMBER)
    INNER JOIN PROD B ON(B.PROD_ID = C.CART_PROD)
         WHERE C.CART_NO LIKE '2020%'
         GROUP BY A.MEM_ID, A.MEM_NAME
         ORDER BY 1;
/
--CURSOR문제
2020년도 회원별 판매금액의 합계를 CURSOR와 FOR문을 통해 출력해보자.
ALIAS는 MEM_ID, MEM_NAME, SUM_AMT
/
    DECLARE 
      CURSOR CUR IS --매개변수 사용
        SELECT A.MEM_ID, A.MEM_NAME, SUM(B.PROD_SALE*C.CART_QTY) AS CSUM
          FROM MEMBER A
    INNER JOIN CART C ON(A.MEM_ID = C.CART_MEMBER)
    INNER JOIN PROD B ON(B.PROD_ID = C.CART_PROD)
         WHERE C.CART_NO LIKE '2020%'
         GROUP BY A.MEM_ID, A.MEM_NAME
         ORDER BY 1;
    BEGIN --REC : 자동선언되는 묵시적 변수
      FOR REC IN CUR LOOP
      IF MOD(CUR%ROWCOUNT,2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||'. ID: ' ||
                             REC.MEM_ID || ', 이름: ' ||
                             REC.MEM_NAME||', 구매액: '||
                             REC.CSUM); --출력
      END IF;
      END LOOP;
    END;
/
/
    BEGIN --REC : 자동선언되는 묵시적 변수
      FOR REC IN (SELECT A.MEM_ID, A.MEM_NAME, SUM(B.PROD_SALE*C.CART_QTY) AS CSUM
                    FROM MEMBER A
              INNER JOIN CART C ON(A.MEM_ID = C.CART_MEMBER)
              INNER JOIN PROD B ON(B.PROD_ID = C.CART_PROD)
                   WHERE C.CART_NO LIKE '2020%'
                   GROUP BY A.MEM_ID, A.MEM_NAME
                   ORDER BY 1)
      LOOP
        DBMS_OUTPUT.PUT_LINE('. ID: ' || REC.MEM_ID ||
                             ', 이름: ' ||REC.MEM_NAME||
                             ', 구매액: '||REC.CSUM); --출력
      END LOOP;
    END;
/
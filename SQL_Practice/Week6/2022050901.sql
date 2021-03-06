2022-0509-01)
STORED PROCEDURE
 - 오라클 서버의 캐시공간에 미리 저장된 프로시져
 - 업데이트 셋 웨어
/
    SELECT PROD_ID, PROD_TOTALSTOCK
      FROM PROD
     WHERE PROD_ID = 'P101000001';
/
    CREATE OR REPLACE PROCEDURE USP_PROD_TOTALSTOCK_UPDATE IS 
    BEGIN
      UPDATE PROD
         SET PROD_TOTALSTOCK = PROD_TOTALSTOCK + 10
       WHERE PROD_ID = 'P101000001';
       DBMS_OUTPUT.PUT_LINE('업데이트 성공!');
      COMMIT;
    END; --실행이 아니라 컴파일 된다.
/
    --STORED PROCEDURE 실행--
    EXECUTE USP_PROD_TOTALSTOCK_UPDATE;
    EXEC USP_PROD_TOTALSTOCK_UPDATE;
/
    SELECT PROD_ID, PROD_NAME, PROD_TOTALSTOCK
      FROM PROD
     WHERE PROD_ID = 'P101000001';

    --파라미터(= 바인드 변수 = 매개변수) 사용--
    CREATE OR REPLACE PROCEDURE USP_PROD_TOTALSTOCK_UPDATE
    (P_PROD_ID IN VARCHAR2, P_PROD_TSTOCK IN NUMBER)
    IS 
    BEGIN
      UPDATE PROD
         SET PROD_TOTALSTOCK = PROD_TOTALSTOCK + P_PROD_TSTOCK
       WHERE PROD_ID = P_PROD_ID;
       DBMS_OUTPUT.PUT_LINE('업데이트 성공!');
      COMMIT;
    END; --실행이 아니라 컴파일 된다.
 /   
    EXEC USP_PROD_TOTALSTOCK_UPDATE('P101000001', 20);
    
 (사용예)회원아이디를 입력받아 이름과 취미를 OUT매개변수로 처리해보자.
 /
 --컴파일
    CREATE OR REPLACE PROCEDURE USP_GET_MEMBER
    (P_MID IN VARCHAR2, V_MNAME OUT VARCHAR2, V_MLIKE OUT VARCHAR2)
    IS
    BEGIN
        SELECT MEM_NAME, MEM_LIKE INTO V_MNAME, V_MLIKE
          FROM MEMBER
         WHERE MEM_ID = P_MID;
    END;
/
    --실행
    --VAR : 변수선언, :MEM_NAME -> MEM_NAME 값이 들어온다.
    VAR MEM_NAME VARCHAR2(20)
    VAR MEM_LIKE VARCHAR2(20)
    EXEC USP_GET_MEMBER('c001', :MEM_NAME, :MEM_LIKE)
    PRINT MEM_NAME
    PRINT MEM_LIKE;
/
 (사용예)회원별 구매금액의 합을 구하는 쿼리를 만들어보자
        ALIAS는 MEM_NAME, MEM_AMT
/
    CREATE OR REPLACE PROCEDURE USP_MEM_TOP
    (P_YEAR IN VARCHAR2, P_MEM_NAME OUT VARCHAR2, P_MEM_AMT OUT NUMBER)
    IS
    BEGIN
        SELECT T.MEM_NAME , T.MEM_AMT INTO P_MEM_NAME, P_MEM_AMT
          FROM 
                (SELECT A.MEM_NAME , SUM(B.PROD_SALE*C.CART_QTY) AS MEM_AMT
                   FROM MEMBER A
             INNER JOIN CART C ON(A.MEM_ID = C.CART_MEMBER)
             INNER JOIN PROD B ON(B.PROD_ID = C.CART_PROD)
                  WHERE C.CART_NO LIKE P_YEAR||'%'
                  GROUP BY A.MEM_NAME
                  ORDER BY 2 DESC) T
         WHERE ROWNUM <= 1;
    END;        
/
VAR P_MEM_NAME VARCHAR2(30)
VAR P_MEM_AMT NUMBER
EXEC USP_MEM_TOP('2020', :P_MEM_NAME, :P_MEM_AMT)
PRINT P_MEM_NAME
PRINT P_MEM_AMT;
 
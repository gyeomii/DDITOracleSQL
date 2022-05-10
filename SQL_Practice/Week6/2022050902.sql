2022-0509-02)
월별 입출고를 출력
 (사용예)상품코드와 월을 입력하면 해당 월에 대한 해당 상품의 입고, 출고를 처리해 화면에 출력해보자
        프로시저 명 : USP_PRO_INFO, 월형식 : YYYYMM, 입고 및 출고는 OUT매개변수로 처리
-----------------------------내가 짠 ANSI JOIN-----------------------------------
/
    CREATE OR REPLACE PROCEDURE USP_PRO_INFO
    (P_PROD_ID IN VARCHAR2,P_DATE IN VARCHAR2, P_IN_AMT OUT NUMBER, P_OUT_AMT OUT NUMBER)
    IS
    BEGIN
        SELECT T.BSUM, T.CSUM INTO P_IN_AMT, P_OUT_AMT
          FROM
               (SELECT NVL(SUM(B.BUY_QTY),0) AS BSUM , NVL(SUM(C.CART_QTY),0) AS CSUM
                  FROM PROD P
            LEFT OUTER JOIN BUYPROD B ON(P.PROD_ID = B.BUY_PROD AND P.PROD_ID = P_PROD_ID AND TO_CHAR(B.BUY_DATE, 'YYYYMM') LIKE P_DATE)
            LEFT OUTER JOIN CART C ON(P.PROD_ID = C.CART_PROD AND P.PROD_ID = P_PROD_ID AND C.CART_NO LIKE P_DATE||'%')
                 ORDER BY 1) T;
    END;  
/        
VAR P_IN_AMT NUMBER
VAR P_OUT_AMT NUMBER
EXEC USP_PRO_INFO('P101000001', '202004', :P_IN_AMT, :P_OUT_AMT)
PRINT P_IN_AMT
PRINT P_OUT_AMT;       
------------------------------LEVEL--------------------------------
SELECT TO_DATE('20220501', 'YYYYMMDD') + (ROWNUM-1) AS CAL
FROM DUAL
CONNECT BY LEVEL <= (TO_DATE('20220531', 'YYYYMMDD') - TO_DATE('20220501','YYYYMMDD')+1);
-------------------------------쌤이 짠 일반 조인-----------------------------------
/
    CREATE OR REPLACE PROCEDURE USP_PRO_INFO_SEM
    (P_WOL IN VARCHAR2, P_PROD_ID IN VARCHAR2, P_IN_AMT OUT NUMBER, P_OUT_AMT OUT NUMBER)
    IS
    BEGIN
        SELECT NVL(I.IN_AMT,0), NVL(J.OUT_AMT,0) INTO P_IN_AMT, P_OUT_AMT
          FROM
            (SELECT LEVEL WOL
               FROM DUAL
            CONNECT BY LEVEL <=12
            ) H,
            (SELECT EXTRACT(MONTH FROM B.BUY_DATE) WOL,
                    SUM(B.BUY_QTY) IN_AMT
               FROM PROD P, BUYPROD B 
              WHERE P.PROD_ID = B.BUY_PROD
                AND TO_CHAR(B.BUY_DATE, 'YYYYMM') LIKE P_WOL
                AND P.PROD_ID = P_PROD_ID
              GROUP BY EXTRACT(MONTH FROM B.BUY_DATE)
              ) I,      
            (SELECT TO_NUMBER(SUBSTR(C.CART_NO,5,2)) WOL,
                    SUM(C.CART_QTY) OUT_AMT
               FROM PROD P, CART C 
              WHERE P.PROD_ID = C.CART_PROD
                AND C.CART_NO LIKE P_WOL||'%'
                AND P.PROD_ID = P_PROD_ID
              GROUP BY TO_NUMBER(SUBSTR(C.CART_NO,5,2))
              ) J      
         WHERE H.WOL = I.WOL(+) 
           AND H.WOL = J.WOL(+)
           AND H.WOL = TO_NUMBER(SUBSTR(P_WOL,-2));
    END;
/
VAR P_IN_AMT NUMBER
VAR P_OUT_AMT NUMBER
EXEC USP_PRO_INFO_SEM('202004', 'P101000001', :P_IN_AMT, :P_OUT_AMT)
PRINT P_IN_AMT
PRINT P_OUT_AMT;
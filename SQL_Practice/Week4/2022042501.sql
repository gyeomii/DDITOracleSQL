2022-0425-01)
(사용예)2020년 상반기 거래처별 판매액집계를 구하시오.
         Alias는 거래처코드, 거래처명, 판매액합계
         
     (일반조인)
    SELECT A.BUYER_ID AS 거래처코드, A.BUYER_NAME AS 거래처명, SUM(C.CART_QTY * B.PROD_PRICE) AS 판매액합계
      FROM BUYER A, PROD B, CART C
     WHERE A.BUYER_ID = B.PROD_BUYER AND B.PROD_ID = C.CART_PROD
           AND SUBSTR(C.CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY  A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;
    
     (ANSI조인)
    SELECT A.BUYER_ID AS 거래처코드, A.BUYER_NAME AS 거래처명, SUM(C.CART_QTY * B.PROD_PRICE) AS 판매액합계
      FROM BUYER A
     INNER JOIN PROD B ON(A.BUYER_ID = B.PROD_BUYER)--단가추출
     INNER JOIN CART C ON(B.PROD_ID = C.CART_PROD)--거래처추출
     WHERE SUBSTR(C.CART_NO,1,6) BETWEEN '202001' AND'202006'
     GROUP BY  A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;
     
(사용예)HR계정에서 미국 이외의 국가에 위치한 부서에 근무하는 사원정보를 조회하시오
       Alias는 사원번호, 사원명, 부서명, 직무코드, 주소
       미국의 국가코드는 'US'이다.
    (일반조인)
    SELECT A.EMPLOYEE_ID AS 사원번호, A.EMP_NAME AS 사원명, B.DEPARTMENT_NAME AS 부서명,
           A.JOB_ID AS 직무코드, C.STATE_PROVINCE||' '||C.CITY||', '||C.STREET_ADDRESS AS 주소
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID AND B.LOCATION_ID = C.LOCATION_ID
           AND C.COUNTRY_ID != 'US'
     ORDER BY 1; 
     
    (ANSI조인)
    SELECT A.EMPLOYEE_ID AS 사원번호, A.EMP_NAME AS 사원명, B.DEPARTMENT_NAME AS 부서명,
           A.JOB_ID AS 직무코드, C.STATE_PROVINCE||' '||C.CITY||', '||C.STREET_ADDRESS AS 주소
      FROM HR.EMPLOYEES A
     INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)--부서추출
     INNER JOIN HR.LOCATIONS C ON(B.LOCATION_ID = C.LOCATION_ID)--위치코드, 주소추출
     WHERE C.COUNTRY_ID != 'US'
     ORDER BY 1;
     
(사용예)2020년 4월 거래처별 매입금액을 조회하시오
       Alias는 거래처코드, 거래처명, 매입금액합계
     (일반조인)
    SELECT A.BUYER_ID AS 거래처코드, A.BUYER_NAME AS 거래처명, SUM(C.BUY_COST * C.BUY_QTY) AS 매입금액합계
      FROM BUYER A, PROD B, BUYPROD C
     WHERE A.BUYER_ID = B.PROD_BUYER AND C.BUY_PROD = B.PROD_ID
           AND EXTRACT(MONTH FROM C.BUY_DATE) =4
     GROUP BY A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;
     
     (ANSI조인)
    SELECT A.BUYER_ID AS 거래처코드, A.BUYER_NAME AS 거래처명, SUM(C.BUY_COST * C.BUY_QTY) AS 매입금액합계
      FROM BUYER A
     INNER JOIN PROD B ON(A.BUYER_ID = B.PROD_BUYER)
     INNER JOIN BUYPROD C ON(C.BUY_PROD = B.PROD_ID) AND EXTRACT(MONTH FROM C.BUY_DATE) =4
     GROUP BY A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;
     

(사용예)2020년 4월 거래처별 매출금액을 조회하시오
       Alias는 거래처코드, 거래처명, 매출금액합계
     (일반조인)
    SELECT A.BUYER_ID AS 거래처코드, A.BUYER_NAME AS 거래처명, SUM(B.PROD_PRICE * C.CART_QTY) AS 매출금액합계
      FROM BUYER A, PROD B, CART C
     WHERE A.BUYER_ID = B.PROD_BUYER AND C.CART_PROD = B.PROD_ID
           AND C.CART_NO LIKE '202004%'
     GROUP BY A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;
     
     (ANSI조인)
    SELECT A.BUYER_ID AS 거래처코드, A.BUYER_NAME AS 거래처명, SUM(B.PROD_PRICE * C.CART_QTY) AS 매출금액합계
      FROM BUYER A
     INNER JOIN PROD B ON(A.BUYER_ID = B.PROD_BUYER)
     INNER JOIN CART C ON(C.CART_PROD = B.PROD_ID) AND C.CART_NO LIKE '202004%'
     GROUP BY A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;

(사용예)2020년 4월 거래처별 매입금액, 매출금액을 조회하시오
       Alias는 거래처코드, 거래처명, 매입금액합계, 매출금액합계
     (서브쿼리 + 외부조인)
    SELECT TB.CID AS 거래처코드, TB.CNAME AS 거래처명, NVL(TA.BSUM,0) AS 매입금액합계, NVL(TB.CSUM,0) AS 매출금액합계
      FROM (SELECT B.PROD_BUYER AS BID, SUM(A.BUY_QTY * B.PROD_COST) AS BSUM
              FROM BUYPROD A, PROD B, BUYER C
             WHERE A.BUY_PROD = B.PROD_ID
               AND B.PROD_BUYER = C.BUYER_ID
               AND EXTRACT(MONTH FROM A.BUY_DATE) = 4
             GROUP BY B.PROD_BUYER) TA,
           (SELECT A.BUYER_ID AS CID, A.BUYER_NAME AS CNAME, SUM(B.CART_QTY * C.PROD_PRICE) AS CSUM
              FROM BUYER A, CART B, PROD C
             WHERE B.CART_PROD = C.PROD_ID
               AND C.PROD_BUYER = A.BUYER_ID
               AND B.CART_NO LIKE '202004%'
             GROUP BY A.BUYER_ID, A.BUYER_NAME) TB
     WHERE TA.BID(+) = TB.CID
     ORDER BY 1;
                
             
      (ANSI 조인)--오류있음
     SELECT A.BUYER_ID AS 거래처코드, A.BUYER_NAME AS 거래처명,
            NVL(SUM(C.BUY_COST * C.BUY_QTY),0) AS 매입금액합계,
            NVL(SUM(B.PROD_PRICE * D.CART_QTY),0) AS 매출금액합계
       FROM BUYER A
      INNER JOIN PROD B ON(A.BUYER_ID = B.PROD_BUYER)
 LEFT OUTER JOIN BUYPROD C ON(C.BUY_PROD = B.PROD_ID AND EXTRACT(MONTH FROM C.BUY_DATE) = 4)
      INNER JOIN CART D ON(D.CART_PROD = B.PROD_ID AND D.CART_NO LIKE '202004%')
      GROUP BY A.BUYER_ID, A.BUYER_NAME
      ORDER BY 1;
      
(사용예)사원테이블에서 전체사원의 평균급여보다 더 많은 급여를 받는 사원을 조회하시오.
       Alias는 사원번호, 사원명, 부서코드, 급여
    (NON-Equi 조인)
    SELECT A.EMPLOYEE_ID AS 사원번호, A.EMP_NAME AS 사원명, A.DEPARTMENT_ID AS 부서코드, A.SALARY AS 급여
      FROM HR.employees A,
           (SELECT AVG(SALARY) AS BSAL
              FROM HR.employees) B
     WHERE A.SALARY > B.BSAL
     ORDER BY 3;



2022-0419-02)
집계함수
 - 자료를 그룹화하고 그룹내에서 합계, 자료수, 평균, 최대, 최소 값을 구하는 함수
 - SUM, AVG, COUNT, MAX, MIN 이 제공됨
 - SELECT 절에 그룹함수가 일반 컬럼과 같이 사용된 경우 반드시 GROUP BY 절이 기술되어야 함.
 (사용형식)
    SELECT 컬럼명1, [컬럼명2,...] 집계함수
      FROM 테이블명
    [WHERE 조건]
    [GROUP BY 컬럼명1[,컬럼명2,...]]
   [HAVING 조건]
    [ORDER BY 인덱스|컬럼명 [ASC|DESC][,...]]
    .GROUP BY 절에 사용된 컬럼명은 왼쪽에 기술된 순서대로 대분류, 소분류의 기준 컬럼명
    .HAVING 조건: 집계함수에 조건이 부여된 경우에는 WHERE절이 아닌 HAVING절 사용
 1. SUM(col)
  - 각 그룹내의 'col'컬럼에 저장된 값의 합을 반환
 2. AVG(col)
  - 각 그룹내의 'col'컬럼에 저장된 값의 평균을 반환
 3. COUNT(*|col)
  - 각 그룹내의  행의 수를 반환
  - '*'를 사용하면 NULL값도 하나의 행으로 취급
  - 컬럼명을 기술하면 해당 컬럼의 값이 NULL이 아닌 갯수를 반환
 4. MAX(col), MIN(col)
  - 각 그룹내의 'col'컬럼에 저장된 값 중 최댓값과 최솟값을 구하여 반환
   ***집계함수는 다른 집계함수를 포함할 수 없다***
 (사용예)사원테이블에서 전체사원의 급여합계, 평균급여, 최대급여, 최소급여, 사원수를 구하시오.
    SELECT SUM(SALARY) AS 급여합계, ROUND(AVG(SALARY)) AS 평균급여,
           MAX(SALARY) AS 최대급여, MIN(SALARY) AS 최소급여, COUNT(*) AS 사원수
      FROM HR.employees;
      
 (사용예)사원테이블에서 부서별 급여합계, 평균급여, 최대급여, 최소급여를 구하시오.
    SELECT  DEPARTMENT_ID AS 부서코드, SUM(SALARY) AS 급여합계, ROUND(AVG(SALARY)) AS 평균급여,
            MAX(SALARY) AS 최대급여, MIN(SALARY) AS 최소급여, COUNT(*) AS 사원수
      FROM HR.employees
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;
     
    SELECT B.DEPARTMENT_NAME AS 부서명, A.DEPARTMENT_ID AS 부서코드,
           SUM(A.SALARY) AS 급여합계, ROUND(AVG(A.SALARY)) AS 평균급여,
           MAX(A.SALARY) AS 최대급여, MIN(A.SALARY) AS 최소급여, COUNT(*) AS 사원수
      FROM HR.employees A, HR.departments B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 2;
    
 (사용예)사원테이블에서 부서별 평균급여가 6000이상인 부서를 조회하시오.
    SELECT  DEPARTMENT_ID AS 부서코드, ROUND(AVG(SALARY)) AS 평균급여
      FROM HR.employees
     GROUP BY DEPARTMENT_ID
    HAVING AVG(SALARY)>= 6000 --집계함수에 조건을 부여하면 HAVING절 사용
     ORDER BY 2 DESC;
     
 (사용예)장바구니테이블에서 2020년 5월 회원별 구매수량합계를 조회하시오
    SELECT CART_MEMBER AS 회원번호, SUM(CART_QTY) AS 구매수량합계
      FROM CART
     WHERE CART_NO LIKE '202005%'
     GROUP BY CART_MEMBER
     ORDER BY 1;
     
    SELECT A.CART_MEMBER AS 회원번호, SUM(CART_QTY) AS 구매수량합계, SUM(A.CART_QTY * B.PROD_PRICE) AS 구매금액합계
      FROM CART A, PROD B
     WHERE A.CART_PROD = B.PROD_ID AND CART_NO LIKE '202005%'
     GROUP BY CART_MEMBER
     ORDER BY 2 DESC;
     
  (사용예)매입테이블(BUYPROD)에서 2020년 상반기(1월~6월) 월별, 제품별 매입집계를 조회하시오.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월, BUY_PROD AS 제품코드,
           SUM(BUY_QTY) AS 수량합계, SUM(BUY_QTY * BUY_COST) AS 금액집계 
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY EXTRACT(MONTH FROM BUY_DATE), BUY_PROD
     ORDER BY 1,2;
     
    SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS 월, A.BUY_PROD AS 제품코드, B.PROD_NAME AS 제품명,
           SUM(A.BUY_QTY) AS 수량합계,  SUM(A.BUY_QTY * A.BUY_COST) AS 매입금액합계 
      FROM BUYPROD A, PROD B
     WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630') AND A.BUY_PROD = B.PROD_ID
     GROUP BY EXTRACT(MONTH FROM A.BUY_DATE), A.BUY_PROD, B.PROD_NAME
     ORDER BY 1,2;
  
  (사용예)매입테이블(BUYPROD)에서 2020년 상반기(1월~6월) 월별 매입집계를 조회하되 매입금액이 1억원 이상인 월만 조회하시오.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월,
           SUM(BUY_QTY) AS 수량합계, SUM(BUY_QTY * BUY_COST) AS 매입금액합계
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    HAVING SUM(BUY_COST * BUY_QTY) >= 100000000
     ORDER BY 1,2;
  
  (사용예)매입테이블(BUYPROD)에서 2020년 상반기(1월~6월) 제품별 매입집계를 조회하되 금액 기준 상위 5개 제품만 조회하시오.
    SELECT A.BID AS 제품코드, A.QSUM AS 수량합계, A.CSUM AS 매입금액합계
      FROM (SELECT BUY_PROD AS BID, SUM(BUY_QTY) AS QSUM,
                   SUM(BUY_QTY * BUY_COST) AS CSUM
              FROM BUYPROD
             WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
             GROUP BY BUY_PROD
             ORDER BY 3 DESC ) A
     WHERE ROWNUM <= 5; 
     
  (사용예)회원테이블에서 성별 평균 마일리지를 조회하시오.
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR SUBSTR(MEM_REGNO2,1,1)='3' THEN '남성회원'
           ELSE '여성회원' END AS 성별, COUNT(*) AS 회원수, ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
      FROM MEMBER
     GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR SUBSTR(MEM_REGNO2,1,1)='3' THEN '남성회원' ELSE '여성회원' END
     ORDER BY 3 DESC;
    
  (사용예)회원테이블에서 연령별 평균 마일리지를 조회하시오.
    SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) AS 연령대,
           COUNT(*) AS 회원수, ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
      FROM MEMBER
     GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)
     ORDER BY 3 DESC; 
     
  (사용예)회원테이블에서 거주지별 평균 마일리지를 조회하시오.
    SELECT SUBSTR(MEM_ADD1,1,2) AS 거주지, COUNT(*) AS 회원수, ROUND(AVG(MEM_MILEAGE)) AS 마일리지
      FROM MEMBER
     GROUP BY SUBSTR(MEM_ADD1,1,2)
     ORDER BY 3 DESC;
         
  
  
  
  
  
  
  
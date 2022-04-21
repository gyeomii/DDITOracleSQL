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
     
 5. ROLLUP 과 CUBE
  1) ROLLUP
   - GROUP BY 절 안에 사용하여 레벨 별 집계의 결과를 반환
  (사용형식)
   GROUP BY ROLLUP(컬럼명1[,컬럼명2,...,컬럼명n])
    . 컬럼명1,컬럼명2,...,컬럼명n을(가장 하위레벨) 기준으로 그룹 구성하여 그룹함수를 수행한 후
      오른쪽에 기술된 컬럼명을 하나씩 제거한 기준으로 그룹수성, 마지막으로 전체(가장 상위레벨) 합계 반환
    . n개의 컬럼이 사용된 경우 n+1종류의 집계반환
    
  (사용예)장바구니 테이블에서 2020년 월별, 회원별, 제품별 판매수량집계를 조회하시오.
    SELECT SUBSTR(CART_NO,5,2) AS 월, CART_MEMBER AS 회원번호, CART_PROD AS 제품코드, SUM(CART_QTY)판매수량집계
      FROM CART
     WHERE SUBSTR(CART_NO,1,4) = '2020'
     GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD)
     ORDER BY 1;
  
  **부분 ROLLUP
   . 그룹을 분류 기준 컬럼이 ROLLUP절 밖(GRUOP BY 절 안)에 기술된 경우를 부분 ROLLUP 이라고 함
   . EX) GROUP BY 컬럼명1, ROLLUP(컬럼명2, 컬럼명3) 인경우
     -> 컬럼명1, 컬럼명2, 컬럼명3 모두가 적용된 집계
        컬럼명1, 컬럼명2 가 반영된 집계
        컬럼명1 만 반영된 집계
        
   (사용예)부분 ROLLUP
    SELECT SUBSTR(CART_NO,5,2) AS 월, CART_MEMBER AS 회원번호, CART_PROD AS 제품코드, SUM(CART_QTY)판매수량집계
      FROM CART
     WHERE SUBSTR(CART_NO,1,4) = '2020'
     GROUP BY CART_PROD, ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER)
     ORDER BY 1;
    
  2) CUBE
   - GROUP BY 절 안에서 사용(ROLLUP과 동일)
   - 레벨개념이 없음
   - CUBE 내에 기술된 컬럼들의 조합 가능한 경우마다 집계반환
   - n개의 컬럼이 사용된 경우 2^n 종류의 집계반환
  (사용형식)
     GROUP BY CUBE(컬럼명1,컬럼명2,...,컬럼명n);
     
  (사용예)CUBE
     SELECT SUBSTR(CART_NO,5,2) AS 월, CART_MEMBER AS 회원번호, CART_PROD AS 제품코드, SUM(CART_QTY)판매수량집계
      FROM CART
     WHERE SUBSTR(CART_NO,1,4) = '2020'
     GROUP BY CUBE(SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD)
     ORDER BY 1;
2020-0420-02)
6. NULL처리 함수
 - 오라클의 모든 컬럼은 값이 저장되지 않으면 기본적으로 NULL로 초기화 됨
 - 연산에서 NULL자료가 데이터로 사용되면 모든 결과는 NULL이 됨
 - 특정 컬럼이나 수식의 결과가 NULL인지 여부를 판단하기위한 연산자는 IS [NOT] NULL
 - NVL, NVL2, NULLIF 등이 제공
  1) IS [NOT] NULL
   . 특정 컬럼이나 수식의 결과가 NULL인지 여부를 판단('='로는 NULL을 체크하지 못함)
   (사용예)사원테이블에서 영업실적이 NULL이 아니며 영업부(80번 부서)에 속하지 않는 사원을 조회하시오.
          Alias는 사원번호, 사원명, 부서코드, 영업실적
    SELECT EMPLOYEE_ID AS 사원번호, EMP_NAME AS 사원명, DEPARTMENT_ID AS 부서코드, COMMISSION_PCT AS 영업실적
      FROM HR.employees
     WHERE COMMISSION_PCT IS NOT NULL AND DEPARTMENT_ID IS NULL;
   
  2) NVL(expr, val)
   . 'expr'의 값이 NULL이면 'val'을 반환하고, NULL이 아니면 expr 자신의 값을 반환
   . 'expr'과 'val'은 같은 데이터 타입이어야 함
   
   (사용예) 상품테이블에서 상품의 크기(PROD_SIZE)가 NULL이면 '크기정보 없음'을
           크기정보가 있으면 그 값을 출력하시오.
           Alias는 상품코드, 상품명, 매출가격, 상품크기 이다.
    SELECT PROD_ID AS 상품코드, PROD_NAME AS 상품명, PROD_PRICE AS 매출가격,
           NVL(PROD_SIZE, '크기정보 없음') AS 상품크기
      FROM PROD;
      
   (사용예)사원테이블에서 영업실적(COMMISSION_PCT)이 없으면 '보너스 지급대상이 아님'을 비고란에 출력
          영업실적이 있으면 보너스를 계산하여 출력하시오. (보너스 = 영업실적 * 급여의 30%)
          Alias는 사원번호, 사원명, 영업실적
    SELECT EMPLOYEE_ID AS 사원번호, EMP_NAME AS 사원명,
           NVL(TO_CHAR(COMMISSION_PCT,'0.99'),'보너스 지급대상이 아님') AS 영업실적,
           NVL(ROUND(COMMISSION_PCT * SALARY * 0.3), 0) AS 보너스
      FROM HR.employees;
      
   (사용예)2020년 6월 모든 상품별 판매집계를 조회하시오
          Alias는 상품코드, 상품명, 판매수량합계, 판매수량집계이다.
    SELECT B.PROD_ID AS 상품코드, B.PROD_NAME AS 상품명, 
           NVL(SUM(A.CART_QTY), 0) AS 판매수량합계, NVL(SUM(A.CART_QTY*B.PROD_PRICE), 0) AS 판매금액합계
      FROM CART A
           RIGHT OUTER JOIN PROD B ON (A.CART_PROD=B.PROD_ID AND A.CART_NO LIKE '202006%')
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1; --OUTER JOIN
     
     SELECT B.PROD_ID AS 상품코드, B.PROD_NAME AS 상품명,
           SUM(A.CART_QTY) AS 판매수량합계, SUM(A.CART_QTY * B.PROD_PRICE) AS 판매금액합계
      FROM CART A, PROD B
     WHERE A.CART_PROD = B.PROD_ID AND CART_NO LIKE '202006%'
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
          
      
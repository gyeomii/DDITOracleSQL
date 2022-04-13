  (3) ALL 연산자
   - ALL다음에 기술된 값 들 모두를 만족시킬때만 참(true)을 반환(AND연산)
   
  (사용형식)
   expr 관계연산자 ALL(값1,...,값n)
   
  (사용예)회원테이블에서 직업이 공무원인 회원 중 가장 많은 마일리지를 보유한 회원보다
         많은 마일리지를 보유한 회원들을 조회하시오.
        Alias는 회원번호, 회원명, 직업, 마일리지
    SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업, MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE MEM_MILEAGE >ALL(SELECT MEM_MILEAGE
                              FROM MEMBER
                             WHERE MEM_JOB = '공무원')
     ORDER BY 4;
  
  (4) BETWEEN 연산자 -- DATE타입을 사용할때는 TO_DATE('날짜')로 사용
   - 제시된 자료의 범위를 지정할 때 사용
   - AND 연산자와 같은 기능
   - 모든 데이터 타입에 사용 가능
  (사용형식)
   expr BETWEEN 하한값 AND 상한값
   . '하한값'과 '상한값'의 타입은 동일해야 함
   --ID 상품코드 NAEM 상품명 LGU 분류코드 BUYER 거래처 COST 매입가 PRICE 판매가 SALE 할인가
  (사용예)상품테이블에서 매입가격이 10만원 ~ 20만원 사이의 상품을 조회하시오
         Alias는 상품코드, 상품명, 매입가, 판매가 이며, 매입가순으로 출력
    SELECT PROD_ID AS 상품코드, PROD_NAME AS 상품명, PROD_COST AS 매입가, PROD_PRICE AS 판매가
      FROM PROD
     WHERE PROD_COST BETWEEN 100000 AND 200000 -- PROD_COST>=10000 AND PROD_COST<=200000
     ORDER BY 3;
   --EMPLOYEE_ID 사원번호 EMP_NAME 사원이름 HIRE_DATE 입사일 JOB_ID 직무코드 SALARY 급여 COMMISION_PCT 영업식적(%) MANAGER_ID 책임자 코드 DEPARTMENT_ID 부서코드
  (사용예)사원테이블에서 2006년 ~ 2007년사이에 입사한 사원들을 조회하시오.
         Alias는 사원번호, 사원명, 입사일, 부서코드이며, 입사일 순으로 출력
    SELECT EMPLOYEE_ID AS 사원번호, EMP_NAME AS 사원명, HIRE_DATE AS 입사일, DEPARTMENT_ID AS 부서코드
      FROM HR.employees
     WHERE HIRE_DATE BETWEEN TO_DATE('20060101') AND TO_DATE('20071231')
     ORDER BY 3;
         
    -- ID 거래처코드 NAME 거래처명 LGU 분류코드 BANK 거래은행 BANKNO 계좌번호 BANKNAME 계좌주 CHARGER 담당자     
  (사용예)상품의 분류코드가 'P100'번대('P100' ~ 'P199')인 상품을 거래하는 거래처정보를 조회하시오.
         Alias는 거래처코드, 거래처명, 주소, 분류코드이며, 
    SELECT BUYER_ID AS 거래처코드, BUYER_NAME AS 거래처명, (BUYER_ADD1||' '||BUYER_ADD2) AS 주소, BUYER_LGU AS 분류코드
      FROM BUYER
     WHERE BUYER_LGU BETWEEN 'P100' AND 'P199'
  
  (5)LIKE 연산자 -- 문자열에만 사용가능, 큰 데이터에서 사용하면 효율이 떨어짐(많은 데이터가 추출됨)
   - 패턴을 비교하는 연산자
   - 와일드카드(패턴비교문자열) : '%'와 '_'이 사용되어 패턴을 구성함
  (사용형식)
  expr LIKE '패턴문자열'
   1) '%' : '%'이 사용된 위치에서 이후의 모든 문자열을 허용 -- %위치에 데이터가 없거나 길어도 상관없음
    ex) SNAME LIKE '김%' => SNAME의 값이 '김'으로 시작하는 모든 값과 대응됨 --'김'도 대응됨
        SNAME LIKE '%김%' => SNAME의 값 중에 '김'이 있는 모든 값과 대응됨 --'김'도 대응됨
        SNAME LIKE '%김' => SNAME의 값이 '김'으로 끝나는 모든 값과 대응됨 --'김'도 대응됨
   2) '_' : '_'이 사용된 위치에서 하나의 문자와 대응 -- _위치에 데이터가 있어야 함
    ex) SNAME LIKE '김_' => SNAME의 값이 2글자이며 '김'으로 시작하는 문자열과 대응됨
        SNAME LIKE '_김_' => SNAME의 값 중에 3글자이며 중간의 글자가 '김'인 문자열과 대응됨
        SNAME LIKE '_김' => SNAME의 값이 2글자이며 '김'으로 끝나는 문자열과 대응됨
    --CART_MEMBER 구매자, CART_NO 구매번호, CART_PROD, 구매상품 CART_QTY 구매수량
  (사용예)장바구니 테이블(CART)에서 2020년 6월에 판매된 자료를 조회하시오.
         Alias는 판매일자, 상품코드, 판매수량이며 판매일 순으로 출력하시오.
    SELECT SUBSTR(CART_NO,1,8) AS 판매일자, CART_PROD AS 상품코드, CART_QTY AS 판매수량
      FROM CART
     WHERE CART_NO LIKE '202006%'
     ORDER BY 1;
     
  (사용예)매입테이블(BUYPROD)에서 2020년 6월에 매입된 자료를 조회하시오.
         Alias는 매입일자, 상품코드, 매입수량, 매입금액이며 매입일 순으로 출력하시오.
    SELECT BUY_DATE AS 구매일자, BUY_PROD AS 상품코드, BUY_QTY AS 구매수량, BUY_COST*BUY_QTY AS 구매금액
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') -- TO_DATE를 사용해서 문자열을 날짜타입으로 바꿔줘야한다
     ORDER BY 1;
     
  (사용예)회원테이블(MEMBER)에서 충남에 거주하는 회원을 조회하시오.
         Alias는 회원번호, 회원명, 주소, 마일리지이며 회원번호 순으로 출력하시오.
    SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_ADD1||' '||MEM_ADD2 AS 주소, MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE MEM_ADD1 LIKE '충남%'
     ORDER BY 1;
    
 
    
    
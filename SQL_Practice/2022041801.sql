2022-0418-01)
 6) WIDTH_BUCKET(n, min, max, b)
   - min에서 max값의 범위를 b개의 구간으로 나누고 주어진 값 n이 속한 구간의 인덱스 값을 반환
   - max 값은 구간에 포함되지 않으며, min보다 작은 n값은 0구간 max보다 큰 값은 b+1구간 인덱스를 반환함
 사용예)
    SELECT WIDTH_BUCKET(60, 20, 80, 4) AS COL1,
           WIDTH_BUCKET(80, 20, 80, 4) AS COL1,
           WIDTH_BUCKET(20, 20, 80, 4) AS COL1,
           WIDTH_BUCKET(10, 20, 80, 4) AS COL1,
           WIDTH_BUCKET(100, 20, 80, 4) AS COL1
      FROM DUAL;
 사용예)회원테이블에서 1000~6000 마일리지를 6개의 구간으로 나누었을 때 각 회원들의 마일리지에 따른 등급을 구하여 출력하시오
       Alias는 회원번호, 회원명, 마일리지 등급이다.
       단, 등급은 마일리지가 6000초과한 회원부터 1등급에서 마지막등급으로 분류하시오
    SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_MILEAGE AS 마일리지,
           8 - WIDTH_BUCKET(MEM_MILEAGE, 1000, 6000, 6) AS 등급1,
           WIDTH_BUCKET(MEM_MILEAGE, 6000,1000, 6) + 1 AS 등급2
      FROM MEMBER;
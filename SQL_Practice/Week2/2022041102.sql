2022-0411-02)
데이터 검색문(SELECT 문)
 - SQL명령 중 가장 많이 사용되는 명령
 - 자료 검색을 위한 명령
  (사용형식)
   SELECT *|[DISTINCT] 컬럼명 [AS 별칭][,] --DISTINCT : 중복배제, 한 컬럼앞에 사용하면 뒤에도 전부 배제
        컬럼명 [AS 별칭][,] --별칭에 특수문자 또는 명령문과 동일한 이름을 사용한다면 " "로 묶어줘야한다.
              :           --한 컬럼이 끝나면 ','를 반드시 찍어줘야한다.
        컬럼명 [AS 별칭]
     FROM 테이블명 --FROM 다음엔 테이블과 뷰 가 올 수 있다.
   [WHERE 조건] --행(ROW)을 제어, 전체조회시 생략
     [GROUP BY 컬럼명[,컬럼명,...]] -- 집계함술ㄹ 제외한 모든 컬럼을 적어야한다.
   [HAVING 조건] --ORDER BY: 순서화 [ASCENDING(오름차순), DESCENDING(내림차순)] DEFAULT는 ASC
     [ORDER BY 컬럼인덱스|컬럼명 [ASC|DESC][,컬럼인덱스|컬럼명 [ASC|DESC],...]]];
  
  (사용예) 회원테이블에서 회원번호, 회원명, 주소를 조회하시오.
   SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_ADD1||' '||MEM_ADD2 AS "주 소"
     FROM MEMBER;
     -- ||는 자바에서 + 와 동일한 기능
  (사용예) 회원테이블에서 '대전'에 거주하는 회원번호, 회원명, 주소를 조회하시오.
   SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_ADD1||' '||MEM_ADD2 AS 주소
     FROM MEMBER
     WHERE MEM_ADD1 LIKE '대전%'; -- LIKE: 패턴분석, 대전%: 대전으로 시작하고, 뒤에 아무거나 와도된다.
  
  (사용예) 회원테이블에서 '대전'에 거주하는 여성회원의 회원번호, 회원명, 주소를 조회하시오.
   SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_ADD1||' '||MEM_ADD2 AS 주소
     FROM MEMBER
     WHERE MEM_ADD1 LIKE '대전%'
     AND SUBSTR(MEM_REGNO2,1,1) IN ('2','4'); --SUBSTR(컬럼명,글자위치,글자수) : 부분문자열추출
     
  (사용예) 회원테이블에서 회원들의 거주지역(광역시도)을 조회하시오.
   SELECT DISTINCT SUBSTR(MEM_ADD1,1,2)거주지
    FROM MEMBER;
  
 
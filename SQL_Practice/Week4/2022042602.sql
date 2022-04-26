2022-0426-02)
집합연산자
 - SQL연산의 결과를 데이터집합(set)이라고도 함
 - 이런 집합들 사이의 연산을 수행하기 위한 연산자를 집합연산자라고 함
 - UNION, UNION ALL, INTERSECT, MINUS 가 제공
 - 집합연산자로 연결되는 각 SELECT문의 SELECT절의 컬럼의 갯수, 순서, 타입이 일치해야함
 - ORDER BY 절은 마지막 SELECT문에만 사용 가능
 - 출력은 첫 번째 SELECT문의 SELECT절이 기준이 됨
 (사용형식)
    SELECT 컬럼list
      FROM 테이블명
    [WHERE 조건]
    UNION|UNION ALL|INTERSECT|MINUS
    SELECT 컬럼list
      FROM 테이블명
    [WHERE 조건]
        :
    UNION|UNION ALL|INTERSECT|MINUS
    SELECT 컬럼list
      FROM 테이블명
    [WHERE 조건]
    [ORDER BY 컬럼명|컬럼index [ASC|DESC],...];
1.UNION
 - 중복을 허락하지 않은 합집합의 결과를 반환
 - 각 SELECT문의 결과를 모두 포함
 (사용예)회원테이블에서 20대 여성회원과 충남거주회원의 회원번호, 회원명, 직업, 마일리지를 조회하시오.
    SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업,
           SUBSTR(MEM_ADD1,1,2) AS 거주지, MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) = 20 
       AND SUBSTR(MEM_REGNO2,1,1) IN('2','4')
     UNION
    SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업,
           SUBSTR(MEM_ADD1,1,2) AS 거주지, MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE MEM_ADD1 LIKE '충남%'
     ORDER BY 1;

2.INTERSECT
 - 교집합(공통부분)의 결고 반환
 (사용예)회원테이블에서 20대 여성회원과 충남거주회원 중 마일리지가 2000이상인 회원의 회원번호, 회원명, 직업, 마일리지를 조회하시오.
     SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업,
            SUBSTR(MEM_ADD1,1,2) AS 거주지, MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) = 20 
       AND SUBSTR(MEM_REGNO2,1,1) IN('2','4')
     UNION
    SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업,
           SUBSTR(MEM_ADD1,1,2) AS 거주지, MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE MEM_ADD1 LIKE '충남%'
 INTERSECT
    SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업,
           SUBSTR(MEM_ADD1,1,2) AS 거주지, MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE MEM_MILEAGE >= 2000
     ORDER BY 1;
    
3.UNION ALL
 - 중복을 허락하여 합집합의 결과를 반환
 - 각 SELECT문의 결과를 모두 포함(중복 포함)
 (사용예)DEPTS테이블에서 PARENT_ID가 NULL인 자료의 부서코드, 부서명, 상위부서코드, 레벨을 조회하시오.
        단, 상위부서코드는 0이고 레벨은 1이다.      
    SELECT DEPARTMENT_ID AS 부서코드,
           DEPARTMENT_NAME AS 부서명,
           0 AS PARENT_ID, 1 AS LEVELS
      FROM HR.DEPTS
     WHERE PARENT_ID IS NULL;
 (사용예)DEPTS테이블에서 NULL인 상위부서코드의 부서코드와 같은 부서코드를 가진
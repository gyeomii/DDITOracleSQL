2022-0502-02)
2.SEQUENCE
 - 연속적으로 증가(또는 감소) 되는 값을 반환하는 객체
 - 특정 테이블에 종속되지 않음
 - 기본키로 설정할 특정 항목이 없는 경우 주로 사용
 (사용형식)
    CREATE SEQUENCE 시퀀스명
      [START WITH n] --n부터 생성, n이 생략되면 MINVALUE가 들어감
      [INCREMENT BY n] --증가 감소값(n),n이 양수면 증가, 음수면 감소
      [MAXVALUE n|NOMAXVALUE] --최종값 설정, 기본은 NOMAXVALUE이며 10^27까지
      [MINVALUE n|NOMINVALUE] --최소값 설정, 기본은 NOMINVALUE이며 값은 1
      [CYCLE|NOCYCLE] -- 최종/최소 값까지 도달한 후 다시 생성할지 여부(기본은 NOCYCLE)
      [CACHE n|NOCACHE] -- 생성된 순서값을 캐쉬메모리에 저장할 것인지 여부
                        -- 기본은 CACHE 20
      [ORDER|NOORDER] -- 정의된대로 생성할지의 보증여부, 기본은 NOORDER

 **시퀀스 사용이 제한되는 곳
 . SELECT, UPDATE, DELETE 문의 SUBQUERY
 . VIEW 를 대상으로하는 QUERY
 . DISTINCT 가 사용된 SELECT 문
 . GROUP BY, ORDER BY 절이 사용된 SELECT 문
 . 집합연산자가 사용된 SELECT 문
 . SELECT 문의 WHERE 절
 
 **시퀀스에 사용되는 의사컬럼
  시퀀스명.CURRVAL : 시퀀스객체의 현재값
  시퀀스명.NEXTVAL : 시퀀스객체의 다음값
 **시퀀스가 생성되고 첫 번째 수행해야할 명령은 반드시 NEXTVALUE가 되어야함
 (사용예)분류테이블에 사용할 시퀀스를 생성하시오.
        시작값은 10이고 1씩 증가해야함
    CREATE SEQUENCE SEQ_LPROD
      START WITH 10;
      
    SELECT SEQ_LPROD.NEXTVAL FROM DUAL;  
    SELECT SEQ_LPROD.CURRVAL FROM DUAL;
    DROP SEQUENCE SEQ_LPROD;
    
 (사용예)다음 자료를 분류테이블에 저장하시오.
 [자료]
  LPROD_ID  LPROD_GU  LPROD_NM
----------------------------------
  시퀀스사용    P501     농산물
  시퀀스사용    P502     수산물
  시퀀스사용    P503     임산물
  
    INSERT INTO LPROD
      VALUES(SEQ_LPROD.NEXTVAL, 'P501', '농산물');
    INSERT INTO LPROD
      VALUES(SEQ_LPROD.NEXTVAL, 'P502', '수산물');
    INSERT INTO LPROD
      VALUES(SEQ_LPROD.NEXTVAL, 'P503', '임산물');
      
3.SYNONYM(동의어)
 - 오라클에서 사용되는 객체에 부여한 또 다른 이름
 - 긴 객체명이나 사용하기 어려운 객체명을 사용하기 쉽고 기억하기 쉬운 이름으로 사용
 (사용형식)
    CREATE OR REPLACE SYNONYM 별칭 FOR 객체명;
    . '객체명'을 '별칭'으로 또 다른 이름부여
    
 (사용예)HR계정의 사원테이블과 부서테이블을 EMP, DEPT로 별칭(동의어)을 부여하시오.
    CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;
    SELECT * FROM EMP;
    CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;
    SELECT * FROM DEPT;

4.INDEX
 - 테이블에 저장된 자료를 효율적으로 검색하기 위한 기술
 - 오라클 서버는 사용자로부터 검색명령이 입력되면
   전체를 대상으로 검색(FULL SCAN)할지 또는 인덱스 스캔(INDEX SCAN)할지 결정함
 - 인덱스가 필요한 컬럼
   . 자주 검색하는 컬럼
   . WHERE 절에서 '='연산자에 의해 자료를 검색하는 경우
   . 기본키
   . SORT(ORDER BY)나 JOIN 연산자에 자주 사용되는 컬럼
 - 인덱스의 종류
   . Unique / Non-unique -- 중복불가 / 중복허용
   . Single / Composite -- 대상컬럼이 1개 / 대상컬럼이 2개이상
   . Normal / Bitmap / Function-Based -- B-tree이용(기본) / 이진수 매핑 / 함수를 매개변수로 적용 
 (사용형식)
    CREATE [UNIQUE|BITMAP] INDEX 인덱스명 --[...]생략시에 기본은 NORMAL
      ON 테이블(컬럼명[,컬럼명,...] [ASC|DESC]);
     . 'ASC|DESC' : 오름차순 또는 내림차순으로 인덱스 생성, 기본은 ASC
     
 (사용예)
    CREATE INDEX IDX_MEM_NAME
      ON MEMBER(MEM_NAME);
    
    SELECT *
      FROM MEMBER
     WHERE MEM_NAME = '육평회';
     
    DROP INDEX IDX_MEM_NAME;
     
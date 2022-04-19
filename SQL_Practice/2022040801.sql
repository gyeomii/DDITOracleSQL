2022-0408-01)

4.DELETE 명령
 - 불필요한 자료를 테이블에서 삭제
 --부모테이블은 삭제할 수 없음, 자식테이블을 삭제한 후 실행해야함
 (사용형식)
 DELETE FROM 테이블명
 [WHERE 조건]
 
 사용예)
 DELETE FROM CART;
 
5. 오라클 데이터타입
 - 오라클에 문자 데이터 타입은 존재하지않음
 - 문자열, 숫자, 날짜, 2진 데이터타입 제공
  1) 문자열 자료형
  - 오라클의 문자열 자료는 ' '에 기술
  - 문자열 자료형은 CHAR, VARCHAR, VARCHAR2, NVARCHAR, NVARCHAR2,
    LONG, CLOB, NCLOB등이 제공 -- LONG의 개선판 -> CLOB
   (1) CHAR
    . 고정길이 문자열 자료 저장
    . 최대 2000byte 까지 저장가능
    . 기억공간이 남으면 오른쪽 공간에 공백이 padding, 기억공간이 작으면 error
    . 기본키나 고정된 자료(주민번호 등) 저장에 주로 사용
    (사용형식)
      컬럼명 CHAR(크기[byte|char])
      . '크기[byte|char]': '크기'로 지정된 값이 byte 인지, char(글자수)인지 결정.
        생략하면 byte 로 간주.
      . 한글 한 글자는 3byte 에 저장되며 CHAR(2000CHAR)로 선언되었다 할지라도
        전체공간은 2000byte 를 초과할 수 없음
    (사용예)
        CREATE TABLE TEMP01(
          COL1 CHAR(20),
          COL2 CHAR(20 BYTE),
          COL3 CHAR(20 CHAR));
        INSERT INTO TEMP01 VALUES('대전시 중구', '대전시 중구', '대전시 중구');
        INSERT INTO TEMP01 VALUES('대전시 중구 계룡로 846', '대전시 중구', '대전시 중구');
       
        SELECT * FROM TEMP01;
        SELECT LENGTHB(COL1),
              LENGTHB(COL2),
              LENGTHB(COL3)
         FROM TEMP01;
   (2)VARCHAR2
    . 가변길이 문자열 자료를 저장 (데이터의 길이만큼 사용하고 남은공간 반환)
    . 최대 4000byte 까지 저장가능
    . VARCHAR 와 동일기능
    . NVARCHAR 및 NVARCHAR2는 국제 표준코드인 UTF-8, UTF-16방식으로 데이터를 인코딩하여 저장
    (사용형식)
      컬럼명 VARCHAR2(크기[BYTE|CHAR])
    (사용예)
      CREATE TABLE TEMP02(
        COL1 VARCHAR2(100),
        COL2 VARCHAR2(100 BYTE),
        COL3 VARCHAR2(100 CHAR),
        COL4 CHAR(100));
        
      INSERT INTO TEMP02
        VALUES('IL POSTINO', 'IL POSTINO', 'IL POSTINO', 'IL POSTINO');
    
      SELECT * FROM TEMP02;
   (3)LONG
    . 가변길이 데이터 저장
    . 최대 2GB 까지 저장 가능
    . 한 테이블에 하나의 LONG타입 컬럼만 사용 --기능개선이 중단된 이유
    . CLOB(Character Large OBjects)로 기능 업그레이드 됨
    . SELECT문의 SELECT절, UPDATE문의 SET절, INSERT문의 VALUES절에서 사용 가능
    . 일부 함수에서는 사용될 수 없음
    (사용형식)
      컬럼명 LONG
    (사용예)
      CREATE TABLE TEMP03(
        COL1 LONG,
        COL2 VARCHAR2(4000));
        
      INSERT INTO TEMP03 VALUES('BANNA APPLE PERSIMMON','BANNA APPLE PERSIMMON');
      
      SELECT * FROM TEMP03
      
      SELECT SUBSTR(COL2,7,5)--COL1은 LONG으로 만들어져서 SUBSTR을 사용할 수 없음
        FROM TEMP03;
   (4)CLOB
    . 가변길이 데이터 저장
    . 최대 4GB까지 처리가능
    . 한 테이블에 여러 개의 CLOB자료타입의 컬럼 사용가능
    . 일부 기능은 DBMS_LOB API의 지원을 받아야 사용가능
    (사용형식)
      컬럼명 CLOB;
    (사용예)
      CREATE TABLE TEMP04(
      COL1 LONG,
      COL2 CLOB,
      COL3 CLOB,
      COL4 VARCHAR2(4000));
      
      INSERT INTO TEMP04
        VALUES('', '대전시 중구 계룡로 846', '대전시 중구 계룡로 846', '대전시 중구 계룡로 846');
      SELECT * FROM TEMP04;
      
      SELECT DBMS_LOB.GETLENGTH(COL2),
             DBMS_LOB.GETLENGTH(COL3),
             LENGTHB(COL4)
        FROM TEMP04;
        
      SELECT SUBSTR(COL2,5,2), --SUBSTR(컬럼명, 글자위치, 글자수)
             DBMS_LOB.SUBSTR(COL2,2,5), --DBMS_LOB.SUBSTR(컬럼명, 글자수, 글자위치)
             SUBSTR(COL4,5,2)
        FROM TEMP04;
  
2022-0411-01)

4. 날짜 타입
 - 날짜 및 시간에 관한 자료 저장(년, 월, 일, 시, 분, 초)
 - 덧셈과 뺄셈의 대상이 될 수 있음
 - DATE, TIMESTAMP 타입이 제공됨
  (1)DATE 타입
   . 표준 날짜 타입
   (사용형식)
    컬럼명 DATE --크기를 지정하지 않음
   (사용예)
   CREATE TABLE TEMP05(
    COL1 DATE,
    COL2 DATE,
    COL3 DATE);
   ** SYSDATE 함수 : 시스템이 제공하는 날짜자료 제공
   ** TO_DATE 함수 : YYYYMMDD형식의 정수를 DATE형으로 변환
    INSERT INTO TEMP05 VALUES(SYSDATE, SYSDATE-30, TO_DATE('20190411')+365);
    SELECT * FROM TEMP05;
    
    SELECT TO_CHAR(COL1, 'YYYYMMDD HH24:MI:SS') AS 컬럼1,
           TO_CHAR(COL2, 'YYYYMMDD HH24:MI:SS') AS 컬럼2,
           TO_CHAR(COL3, 'YYYYMMDD HH24:MI:SS') AS 컬럼3
     FROM TEMP05
    
   ** 날짜자료 - 날짜경과 => 경과된 일 수 출력
   ** TRUNC 함수 : 자리 밑으로 절삭
   ** MOD 함수 : 나머지를 구하는 함수
    SELECT MOD((TRUNC(SYSDATE) - TO_DATE('00010101')-1),7)
      FROM DUAL; -- SELECT문에서 SELECT와 FROM은 생략할 수 없기 때문에 DUAL이란 가상테이블을 사용
      
  (2)TIMESTAMP 타입
   . 시간대역(TIME ZONE 정보)정보제공
   . 아주 정교한 시간정보(10분의 1초)제공
   (사용형식)
   컬럼명 TIMESTAMP --시간대역 정보 없음
   컬럼명 TIMESTAMP WITH TIME ZONE --시간대역 정보 포함
   컬럼명 TIMESTAMP WITH LOCAL TIME ZONE -- 로컬서버가 설치된 시간대역정보로 
                                        -- TIMESTAMP와 같이 시간대역 정보 없음
   (사용예)
    CREATE TABLE TEMP06(
        COL1 TIMESTAMP,
        COL2 TIMESTAMP WITH TIME ZONE,
        COL3 TIMESTAMP WITH LOCAL TIME ZONE);
        
    INSERT INTO TEMP06 VALUES(SYSDATE,SYSDATE,SYSDATE);
    SELECT *FROM TEMP06;

5. 이진자료 타입
 - BLOB, BFILE, RAW 등이 제공됨
  
  (1)RAW
   . 비교적 작은 규모의 이진자료 저장
   . 인덱스 처리 가능
   . 오라클에서 데이터 해석이나 변환을 제공하지 않음
   . 최대 2000BYTE까지 저장 가능
   . 16진수와 2진수 저장 가능
   (사용형식)
    컬럼명 RAW(크기)
   (사용예)
    CREATE TABLE TEMP07(
     COL1 RAW(1000),
     COL2 RAW(1000));
    
    INSERT INTO TEMP07
      VALUES(HEXTORAW('A5FC'),'1010010111111100');
    SELECT * FROM TEMP07;
    
  (2)BFILE  
   . 이진자료 저장
   . 원본파일은 데이터베이스 밖에 저장하고 데이터베이스에는 경로(Path)만 저장
   . 경로 객체(DIRECTORY)가 필요
   . 4GB까지 저장가능
   (사용형식)
    컬럼명 BFILE
     - 디렉토리 객체의 별칭(Alias)는 30BYTE, 파일명은 256BYTE까지 가능
    ** 그림파일 저장순서
     0)테이블 생성
      CREATE TABLE TEMP08(
         COL1 BFILE);
     1)그림파일 저장
     2)디렉토리객체 생성
      예) CREATE DIRECTORY 디렉토리별칭 AS '절대경로'
      CREATE DIRECTORY TEST_DIR AS 'D:\WORK\oracle';
     3)데이터 삽입
      INSERT INTO TEMP08
        VALUES(BFILENAME('TEST_DIR', 'SAMPLE.jpg'));
      SELECT * FROM TEMP08;
  (3)BLOB
   . 이진자료 저장
   . 원본 이진자료를 데이터테이블안에 저장
   . 4GB까지 저장가능
   (사용형식)
    컬럼명 BLOB
    ** 그림파일 저장순서
     0)테이블 생성
      CREATE TABLE TEMP09(
        COL1 BLOB);
     1)익명블록(PL/SQL)작성
      DECLARE
        L_DIR VARCHAR2(20):= 'TEST_DIR';
        L_FILE VARCHAR2(30):= 'SAMPLE.jpg';
        L_BFILE BFILE;
        L_BLOB BLOB;
      BEGIN
        INSERT INTO TEMP09(COL1) VALUES(EMPTY_BLOB())
            RETURN COL1 INTO L_BLOB;
            
        L_BFILE:=BFILENAME(L_DIR,L_FILE);
        DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
        DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
        DBMS_LOB.FILECLOSE(L_BFILE);
        
        COMMIT;
      END;
      
      SELECT * FROM TEMP09;
      
DROP TABLE TEMP01;
DROP TABLE TEMP02;
DROP TABLE TEMP03;
DROP TABLE TEMP04;
DROP TABLE TEMP05;
DROP TABLE TEMP06;
DROP TABLE TEMP07;
DROP TABLE TEMP08;
DROP TABLE TEMP09;

DROP TABLE GOOD_ORDERS;
DROP TABLE ORDERS;
DROP TABLE CUSTS;
DROP TABLE GOODS;

COMMIT;
  
  
  
  
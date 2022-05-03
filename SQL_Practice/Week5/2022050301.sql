2022-0503-01)
PL/SQL(Procedual Language SQL)
 - 표준 SQL을 확장
 - 절차적 언어의 특징을 포함(비교, 반복, 변수, 상수 등)
 - 미리 구성된 모듈을 컴파일하여 서버에 저장하고 필요시 호출실행
 - 모듈화/캡슐화
 - Anonymous Block, Stored Procedure, User Defined Function, Trigger, Package 등이 제공됨
   -- Function : 리턴값 있음(SELECT, WHERE 사용가능), Procedure : 리턴값 없음(독립실행)

1. Anonymous Block
 - 가장 기본적인 PL/SQL구조 제공
 - 선언영역과 실행영역으로 구분
 - 저장되지 않음
 (사용형식)
    DECLARE 
     선언부(변수, 상수, 커서(=뷰) 선언);
    BEGIN
     실행부(비즈니스 로직 처리를 위한 SQL문);
     [EXCEPTION
      예외처리부;]
    END;
 (사용예)충남에 거주하는 회원들이 2020년 5월 구매실적을 조회하시오.
    DECLARE --V_@@@ : 변수 선언
     V_MID MEMBER.MEM_ID%TYPE; --회원번호
     V_MNAME MEMBER.MEM_NAME%TYPE; --회원명
     V_AMT NUMBER:=0; --구매금액합계
     CURSOR CUR_MEM IS --CURSOR : SELECT문 결과의 집합
      SELECT MEM_ID, MEM_NAME
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '충남%';
    BEGIN -- CURSOR는 BEGIN, END 블록에서 사용
     OPEN CUR_MEM; -- OPEN 커서명 : 커서를 열기
     LOOP --반복문
      FETCH CUR_MEM INTO V_MID, V_MNAME; -- FETCH 커서명 INTO 변수명 : CURSOR의 내용을 읽어와서 변수에 저장
      EXIT WHEN CUR_MEM%NOTFOUND; -- EXIT WHEN : LOOP 종료조건(읽어올 자료가 없을 때 까지)
      SELECT SUM(B.PROD_PRICE * A.CART_QTY) INTO V_AMT -- SELECT 함수 INTO 변수명 : 읽어온 자료를 변수의 저장 
        FROM CART A, PROD B
       WHERE A.CART_PROD = B.PROD_ID
         AND A.CART_NO LIKE '202005%';
      DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID); --DBMS 출력
      DBMS_OUTPUT.PUT_LINE('회원명 : '||V_MNAME);
      DBMS_OUTPUT.PUT_LINE('구매합계 : '||V_AMT);
      DBMS_OUTPUT.PUT_LINE('----------------------');
     END LOOP;
    CLOSE CUR_MEM;
    END;
    
 1)변수와 상수
  - BEGIN ~ END 블록에서 사용할 변수 및 상수 선언
  (선언형식)-- '=' -> Equal, ':=' -> 할당연산자
  변수명 [CONSTANT] 데이터타입|참조타입 [:= 초기값];
  - 변수의 종류
   . SCALAR 변수 : 하나의 값을 저장하는 일반적 변수
   . 참조형 변수 : 해당 테이블의 행(ROW)나 열(COLUMN)의 타입과 크기를 참조하는 변수
   . BIND 변수 : 파라미터로 넘겨지는 값을 전달하기 위한 변수
  - 상수 선언은 CONSTANT 예약어를 사용하며 이때 반드시 초깃값을 설정해야 함
  - 데이터타입
   . SQL 에서 사용하는 자료타입
   . PLS_INTEGER, BINARY_INTEGER -> 4byte 정수
   . BOOLEAN 사용 가능 -- TRUE, FALSE, NULL이 저장됨
  - 숫자형 변수는 사용전 반드시 초기화 해야됨
  - 참조형
   . 열참조 : 테이블명.컬럼명%TYPE
   . 행참조 : 테이블명%ROWTYPE
   
  (사용예)키보드로 년도와 월을 입력받아 해당 기간동안 가장 많은 매입금액을 기록한 상품을 조회하시오.
    ACCEPT P_PERIOD PROMPT '기간(YYYYMM)입력 : ' --전부 문자열로 저장됨
    DECLARE
     S_DATE DATE := TO_DATE(&P_PERIOD||'01'); --입력받은 문자열에 시작일을 붙여서 날짜타입으로 변환하여 저장
     E_DATE DATE := LAST_DAY(S_DATE); --날짜타입인 S_DATE의 마지막 일을 저장
     V_PID PROD.PROD_ID%TYPE;
     V_PNAME PROD.PROD_NAME%TYPE;
     V_AMT NUMBER := 0; --숫자형변수는 반드시 초기화해야함
    BEGIN
     SELECT TA.BID, TA.BNAME, TA.BSUM
       INTO V_PID, V_PNAME, V_AMT
       FROM (SELECT B.BUY_PROD AS BID,
                    A.PROD_NAME AS BNAME,
                    SUM(A.PROD_COST * B.BUY_QTY) AS BSUM
               FROM PROD A, BUYPROD B
              WHERE B.BUY_DATE BETWEEN S_DATE AND E_DATE
                AND A.PROD_ID = B.BUY_PROD
              GROUP BY B.BUY_PROD, A.PROD_NAME
              ORDER BY 3 DESC) TA
      WHERE ROWNUM=1;
     DBMS_OUTPUT.PUT_LINE('제품코드 : '||V_PID);
     DBMS_OUTPUT.PUT_LINE('제품명 : '||V_PNAME);
     DBMS_OUTPUT.PUT_LINE('매입금액합계 : '||V_AMT);
    END;
  
  (사용예)임의의 부서코드를 선택하여 해당부서에 가장 먼저 입사한 사원정보를 조회하시오.
         Alias는 사원번호, 사원명, 부서명, 직무코드, 입사일
    --내가 작성한 SQL
    DECLARE
    V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
    V_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    V_JOBID HR.EMPLOYEES.JOB_ID%TYPE;
    V_HDATE DATE;
    BEGIN
     SELECT TA.EID, TA.ENAME, TA.DNAME, TA.JID, TA.HDATE
       INTO V_EID, V_ENAME, V_DNAME, V_JOBID, V_HDATE
       FROM (SELECT A.EMPLOYEE_ID AS EID,
                    A.EMP_NAME AS ENAME,
                    B.DEPARTMENT_NAME AS DNAME,
                    A.JOB_ID AS JID,
                    A.HIRE_DATE AS HDATE
               FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
              WHERE TRUNC(DBMS_RANDOM.VALUE(10,110),-1) = A.DEPARTMENT_ID
                AND A.DEPARTMENT_ID = B.DEPARTMENT_ID
              ORDER BY 5)TA
      WHERE ROWNUM=1;
     DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_EID);
     DBMS_OUTPUT.PUT_LINE('사원명 : '||V_ENAME);
     DBMS_OUTPUT.PUT_LINE('부서명 : '||V_DNAME);
     DBMS_OUTPUT.PUT_LINE('직무코드 : '||V_JOBID);
     DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
    END;
    
    TRUNC(DBMS_RANDOM.VALUE(10,110),-1) -- 10부터 110까지의 무작위 정수를 생성한 후 1의자리를 버림
    
    --선생님이 작성한 SQL
    DECLARE
    V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
    V_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    V_JOBID HR.EMPLOYEES.JOB_ID%TYPE;
    V_HDATE DATE;
    V_DID HR.EMPLOYEES.DEPARTMENT_ID%TYPE := TRUNC(DBMS_RANDOM.VALUE(10,110),-1);
    BEGIN
     SELECT TA.EID, TA.ENAME, TA.DNAME, TA.JID, TA.HDATE
       INTO V_EID, V_ENAME, V_DNAME, V_JOBID, V_HDATE
       FROM (SELECT A.EMPLOYEE_ID AS EID,
                    A.EMP_NAME AS ENAME,
                    B.DEPARTMENT_NAME AS DNAME,
                    A.JOB_ID AS JID,
                    A.HIRE_DATE AS HDATE
               FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
              WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND A.DEPARTMENT_ID = V_DID
              ORDER BY 5)TA
      WHERE ROWNUM=1;
     DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_EID);
     DBMS_OUTPUT.PUT_LINE('사원명 : '||V_ENAME);
     DBMS_OUTPUT.PUT_LINE('부서명 : '||V_DNAME);
     DBMS_OUTPUT.PUT_LINE('직무명 : '||V_JOBID);
     DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
    END;
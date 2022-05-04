2022-0504-02)
2.반복문
 - LOOP, WHILE, FOR 문이 제공됨
 - 주로 커서를 사용하기 위하여 반복문이 필요
 1)LOOP -- 조건이 참일 때 EXIT
  . 기본적인반복문으로 무한루프 재공
  (사용형식)
    LOOP
      반복처리문;
     [EXIT WHEN 조건;]
    END LOOP;
  . '조건'이 참일때 반복문을 벗어남(END LOOP 다음 명령 수행)
 (사용예)구구단의 6단을 출력하시오.
    DECLARE
      V_CNT NUMBER:=1;
    BEGIN
      LOOP
        DBMS_OUTPUT.PUT_LINE('6 * '||V_CNT||' = '||(6 * V_CNT));
        EXIT WHEN V_CNT >= 9;
        V_CNT := V_CNT + 1; -- 할당연산자 명심
      END LOOP;    
    END;
 (사용예)사원테이블에서 직무코드가 'SA_MAN'인 사원 정보를 익명블록을 사용하여 출력하시오.
        출력할 내용은 사원번호, 사원명, 입사일이다.
    DECLARE
      V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
      V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
      V_HDATE DATE;
      CURSOR CUR_EMP01 IS 
        SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE
          FROM HR.EMPLOYEES
         WHERE JOB_ID = 'SA_MAN';
    BEGIN
      OPEN CUR_EMP01;
    LOOP
      FETCH CUR_EMP01 INTO V_EID, V_ENAME, V_HDATE;
      EXIT WHEN CUR_EMP01%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_EID);
      DBMS_OUTPUT.PUT_LINE('사원명 : '||V_ENAME);
      DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
      DBMS_OUTPUT.PUT_LINE('-------------------------');
    END LOOP;
    CLOSE CUR_EMP01;
    END;
        
 2)WHILE 문
  . 조건을 판단하여 반복을 진행할지 여부를 판단하는 반복문
  (사용형식)
    WHILE 조건 LOOP
      반복처리문(들);
    END LOOP;
  . '조건'이 참이면 반복을 수행, '조건'이 거짓이면 반복문을 벗어남
  (사용예)구구단의 6단을 출력하시오(WHILE 문 사용)
    DECLARE 
      V_CNT NUMBER := 1;
    BEGIN
      WHILE V_CNT <=9 LOOP
        DBMS_OUTPUT.PUT_LINE('6 * '||V_CNT||' = '||(6 * V_CNT));
        V_CNT := V_CNT + 1;
      END LOOP;
    END;
    
 (사용예)사원테이블에서 직무코드가 'SA_MAN'인 사원 정보를 익명블록을 사용하여 출력하시오.
        출력할 내용은 사원번호, 사원명, 입사일이다.
    DECLARE
      V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
      V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
      V_HDATE DATE;
      CURSOR CUR_EMP02 IS
        SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE
          FROM HR.EMPLOYEES
         WHERE JOB_ID = 'SA_MAN';
    BEGIN
      OPEN CUR_EMP02;
      FETCH CUR_EMP02 INTO V_EID, V_ENAME, V_HDATE; --첫번째 데이터가 존재하는 걸 확인하고 가져오고
      WHILE CUR_EMP02%FOUND LOOP                    --데이터가 존재하므로 WHILE문이 동작하고
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_EID);
        DBMS_OUTPUT.PUT_LINE('사원명 : '||V_ENAME);
        DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
        FETCH CUR_EMP02 INTO V_EID, V_ENAME, V_HDATE; --WHILE문 안에서 두번째 데이터를 가져온다
      END LOOP;
      CLOSE CUR_EMP02;
    END;
 
 3)FOR 문
  . 수행횟수가 중요하거나 횟수를 아는 경우 사용
  . 인덱스는 시스템에서 자동 생성
  . REVERSE 는 출력값을 역순으로 출력함
  . 초기값..최종값까지 1씩 증가('..'을 반드시 기술)
  . 최종값까지 도달하면 알아서 반복문을 벗어남
  
 (일반적 FOR문 사용형식)
    FOR 인덱스 IN [REVERSE] 초기값..최종값 LOOP
      반복처리명령문(들);
    END LOOP;
 (사용예) 구구단 6단 출력
    DECLARE
    BEGIN
     FOR I IN 1..9 LOOP
       DBMS_OUTPUT.PUT_LINE('6 * '||I||' = '||I * 6);
     END LOOP;
    END;
    
 (REVERSE사용)
    DECLARE
    BEGIN
     FOR I IN REVERSE 1..9 LOOP
       DBMS_OUTPUT.PUT_LINE('6 * '||I||' = '||I * 6);
     END LOOP;
    END;
    
 (커서용 FOR문 사용형식)
    FOR 레코드명 IN 커서명|커서용SELECT문 LOOP
      커서처리문;
    END LOOP;
   . '커서명|커서용SELECT문' : 커서를 선언부에서 선언한 경우 커서명을 기술,
      in-line 형식으로 커서의 SELECT 문을 직접 기술 가능
   . OPEN, FETCH, CLOSE문을 사용하지 않음
   . 커서 내의 컬럼의 참조는 '레코드명.커서컬럼명' 형식으로 참조함
   
 (사용예)사원테이블에서 직무코드가 'SA_MAN'인 사원 정보를 익명블록을 사용하여 출력하시오.
        출력할 내용은 사원번호, 사원명, 입사일이다.
        
   (선언부에 커서를 선언)
    DECLARE
      CURSOR CUR_EMP03 IS
        SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE
          FROM HR.EMPLOYEES
         WHERE JOB_ID = 'SA_MAN';
    BEGIN
      FOR REC IN CUR_EMP03 LOOP
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||REC.EMPLOYEE_ID);
        DBMS_OUTPUT.PUT_LINE('사원명 : '||REC.EMP_NAME);
        DBMS_OUTPUT.PUT_LINE('입사일 : '||REC.HIRE_DATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
      END LOOP;
    END;
    
  (FOR문에 커서용 SELECT문을 선언)   
    DECLARE
    BEGIN
      FOR REC IN (SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE
                    FROM HR.EMPLOYEES
                   WHERE JOB_ID = 'SA_MAN')
      LOOP
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||REC.EMPLOYEE_ID);
        DBMS_OUTPUT.PUT_LINE('사원명 : '||REC.EMP_NAME);
        DBMS_OUTPUT.PUT_LINE('입사일 : '||REC.HIRE_DATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
      END LOOP;
    END;    

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
        V_CNT := V_CNT + 1;
      END LOOP;    
    END;
 (사용예)사원테이블에서 직무코드가 'SA_REP'인 사원 정보를 익명블록을 사용하여 출력하시오.
        출력할 내용은 사원번호, 사원명, 입사일이다.
    DECLARE
      V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
      V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
      V_HDATE DATE;
      CURSOR CUR_EMP01 IS 
        SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE
          FROM HR.EMPLOYEES
         WHERE JOB_ID = 'SA_REP';
    BEGIN
      
    END;
        
        
        
        
        
        
        
  2)
    
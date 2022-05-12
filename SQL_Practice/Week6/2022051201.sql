2022-0512-01)
트리거(TRIGGER)
 - 특정 이벤트가 발생되기 전 혹은 발생된 후 자동적으로 호출되어 실행되는 일종의 프로시져
 (사용형식)
    CREATE OR REPLACE TRIGGER 트리거명
      BEFORE|AFTER [event]INSERT|UPDATE|DELETE ON 테이블명
       [FOR EACH ROW]
       [WHEN 조건]
    [DECLARE]
      변수, 상수, 커서 선언
    BEGIN
      트리거 본문(TRIGGER BODY)
    END;
 . 'BEFORE|AFTER' : 트리거의 본문이 실행되는 시점(이벤트 발생을 기준으로)
 . 'INSERT|UPDATE|DELETE' : 트리거의 발생 원인, 조합사용할 수 있음
 . ON 다음에 기술된 '테이블명' 은 트리거 본문에서 사용될 수 없다.(사용되면 사이클이 발생)
 . 'FOR EACH ROW' : 행단위 트리거인 경우 기술. 생략되면 문장단위 트리거
 . 'WHEN 조건' : 트리거가 실행되면서 지켜야 할 조건(조건에 맞는 데이터만 트리거 실행)
 
 (사용예)다음 조건에 맞는 사원테이블(EMPT)을 HR계정의 사원테이블로부터 구조와 데이터를 가져와 생성하시오
        컬럼: 사원번호(EID), 사원명(ENAME), 급여(SAL), 부서코드(DEPTID),영업실적(COM_PCT)
        조건: 급여가 6000이하인 사원
    CREATE TABLE EMPT(EID, ENAME, SAL, DEPTID, COM_PCT) AS
      SELECT EMPLOYEE_ID, EMP_NAME, SALARY, DEPARTMENT_ID, COMMISSION_PCT
        FROM HR.EMPLOYEES
       WHERE SALARY <= 6000;
       
 (트리거 사용예) 다음데이터를 EMPT테이블에 저장하고 저장이 끝난 후 
               '새로운 사원정보가 추가되었습니다.'라는 메세지를 출력하는 트리거를 생성하시오
               [자료] 
               사원명  급여   부서코드   영업실적코드
               --------------------------------
               홍길동  5500     80       0.25
               --------------------------------
SET SERVEROUTPUT ON;
/
    CREATE OR REPLACE TRIGGER TG_EMP_INSERT
      AFTER INSERT ON EMPT
    BEGIN
      DBMS_OUTPUT.PUT_LINE('새로운 사원정보가 추가되었습니다.');
    END;
 /
    INSERT INTO EMPT      
      SELECT MAX(EID)+1, '홍길동', 5500, 80, 0.25 FROM EMPT;
/
    INSERT INTO EMPT      
      SELECT MAX(EID)+1, '강감찬', 5800, 50, NULL FROM EMPT;
/
 (사용예)퇴직자테이블(EM_RETIRE)
/

/
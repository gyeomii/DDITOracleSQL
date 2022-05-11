2022-0511-01)
1.SCHEDULER
 - 특정한 시간이 되면 자동적으로 질의(query)명령이 실행되도록 하는 방법
-------------------프로시저------------------------
    SELECT MEM_ID, MEM_MILEAGE 
      FROM MEMBER
     WHERE MEM_ID = 'a001';
     
    EXEC USP_UP_MEMBER_MIL;
/
    CREATE OR REPLACE PROCEDURE USP_UP_MEMBER_MIL
    IS
    BEGIN
        UPDATE MEMBER
           SET MEM_MILEAGE = MEM_MILEAGE + 10
         WHERE MEM_ID = 'a001';
         
         COMMIT;
     END;
/
-------------------스케쥴러------------------------
/
    DECLARE
        --스케쥴 JOB의 고유 아이디. 임의의 숫자
        V_JOB NUMBER(5);
    BEGIN
        DBMS_JOB.SUBMIT(
            V_JOB, --JOB의 아이디
            'USP_UP_MEMBER_MIL;',--실행 할 프로시저 작업
            SYSDATE, --최초 작업을 실행할 시간
            'SYSDATE + (1/1440)', --1분마다
            FALSE --파싱(구문분석, 의미분석)여부
        );
        DBMS_OUTPUT.PUT_LINE('JOB IS'||TO_CHAR(V_JOB));
        COMMIT;
    END;
/
--스케쥴러에 등록된 작업을 조회
    SELECT * FROM USER_JOBS;
--스케쥴러에서 작업을 삭제
    BEGIN
        DBMS_JOB.REMOVE(1);
    END;
/
    SELECT SYSDATE
         , TO_CHAR(SYSDATE + (1/1440), 'YYYY-MM-DD HH24:MI:SS') --일분 뒤
         , TO_CHAR(SYSDATE + (1/24), 'YYYY-MM-DD HH24:MI:SS') --한시간 뒤
         , TO_CHAR(SYSDATE + 1, 'YYYY-MM-DD HH24:MI:SS') --일일 뒤
      FROM DUAL;
/
2. EXCEPTION
 - PL/SQL 에서 ERROR가 발생하면 EXCEPTION이 발생되고
   해당 블록을 중지하며 예외처리 부분으로 이동함
 - 예외 유형
   1) 정의된 예외
    . PL/SQL 에서 자주 발생하는 ERROR 를 미리 정의함
      선언할 필요가 없고 서버에서 암시적으로 발생함
    . NO_DATA_FOUND: 결과 없음
    . TOO_MANY_ROWS: 여러행 반환
    . DUP_VAL_NO_INDEX: 데이터 중복오류(P.K./U.K.)
    . VALUE_ERROR: 값 할당 및 변환시 오류
    . INVALIED_NUMBER : 숫자로 변환이 안됨 
    . NOT_LOGGED_ON : DB에 접속이 안되었는데 실행
    . LOGIN_DENIED : 잘못된 사용자 / 잘못된 비밀번호
    . ZERO_DIVIED : 0으로 나눔
    . INVALIED_CURSOR : 열리지 않은 커서에 접근
   2) 정의되지 않은 예외 : 기타 표준 ERROR
                        선언을 해야하며 서버에서 암시적으로 발생
   
   3) 사용자 정의 예외 : 프로그래머가 정한 조건에 만족하지 않을 경우 발생
                      선언을 해야 하고, 명시적으로 RAISE문을 사용하여 발생
---------------------예제----------------------
SET SERVEROUTPUT ON;
/
    DECLARE
        V_NAME VARCHAR2(20);
    BEGIN
        SELECT LPROD_NM+10 INTO V_NAME
          FROM LPROD
         WHERE LPROD_GU = 'P201';
         DBMS_OUTPUT.PUT_LINE('분류명: '|| V_NAME);
         
         EXCEPTION
            WHEN NO_DATA_FOUND THEN --ORA-01403
                DBMS_OUTPUT.PUT_LINE('해당 정보가 없습니다.');
            WHEN TOO_MANY_ROWS THEN --ORA-01422
                DBMS_OUTPUT.PUT_LINE('한 개 이상의 값이 나왔습니다.');
            WHEN OTHERS THEN --아몰랑
                DBMS_OUTPUT.PUT_LINE('기타 에러: '||SQLERRM);
    END;
/
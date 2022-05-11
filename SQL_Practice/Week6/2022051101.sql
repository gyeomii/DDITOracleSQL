2022-0511-01)
1.스케쥴러
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
2022-0511-02)
 (사용예)DEPARTMENT 테이블에 학과코드를 '컴공',
        학과명을 '컴퓨터공학과',
        전화번호를 '765-4100'으로 INSERT해보자
        
/
    DECLARE
    BEGIN
        INSERT INTO DEPARTMENT(DEPT_ID, DEPT_NAME, DEPT_TEL)
        VALUES ('컴공', '컴퓨터공학과', '765-4100');
        DBMS_OUTPUT.PUT_LINE('인덱스 추가 성공');
        COMMIT;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('<중복된 인덱스 예외 발생>');
            WHEN OTHERS THEN
                NULL;
    END;
/
 (사용예)COURSE 테이블의 과목코드가 'L1031'에 대하여
        추가 수강료(COURSE_FEES)를 '삼만원' 으로 수정해보자
/
    DECLARE
    BEGIN
        UPDATE COURSE
           SET COURSE_FEES = '삼만원'
         WHERE COURSE_ID = 'L1031';
        COMMIT;
        EXCEPTION
            WHEN INVALID_NUMBER THEN
            DBMS_OUTPUT.PUT_LINE('[잘못된 숫자 예외 발생]');
            WHEN OTHERS THEN
                NULL;
    END;
/
 (사용예)SG_SCORES 테이블에 저장된 SCORE 컬럼의 점수가
        100점이 초과되는 값이 있는지 조사하는 블록을 작성해보자
        단,100점이 초과시 OVER_SCORE예외를 선언해보자
/
    DECLARE
        exp_over_score EXCEPTION;
        V_SCORE SG_SCORES.SCORE%TYPE;
    BEGIN
        FOR V_ROW IN (SELECT SCORE FROM SG_SCORES)
        LOOP
        V_SCORE := V_ROW.SCORE;
            IF V_ROW.SCORE > 100 THEN
            RAISE exp_over_score;
            END IF;
        END LOOP;
        INSERT INTO SG_SCORES(STUDENT_ID, COURSE_ID, SCORE, SCORE_ASSIGNED)
        VALUES ('A1701', 'L0013', 107, '2010/12/29');
        COMMIT;
         EXCEPTION
            WHEN exp_over_score THEN
                DBMS_OUTPUT.PUT_LINE(V_SCORE||'점 으로 100점을 초과합니다');
    END;
/
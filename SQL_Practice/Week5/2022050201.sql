2022-0502-01)
1.VIEW
 - 테이블과 유사한 객체
 - 기존의 테이블이나 뷰에 대한 SELECT문의 결과 집합에 이름을 부여한 객체
 - 필요한 정보가 여러 테이블에 분산 되어 있는 경우
 - 테이블의 모든 자료를 제공하지 않고 특정 결과만 제공하는 경우(보안)
 (사용형식)
    CREATE [OR REPLACE] VIEW 뷰이름[(컬럼list)]
    AS
      SELECT 문
      [WITH READ ONLY]
      [WITH CHECK OPTION];
 . 'REPLACE' : 이미 존재하는 뷰인 경우 대체
 . '컬럼list' : 뷰에 사용될 컬럼의 이름, 컬럼명을 생략하면 원본SELECT문의 별칭이 컬럼명이됨,
               별칭이 사용되지 않으면 원본 컬럼명이 컬럼명이 됨
 . 'WITH READ ONLY' : 읽기전용 뷰 생성(적지 않고 뷰를 수정하면 원본테이블 데이터도 변경됨)(DML실행 금지)
 . 'WITH CHECK OPTION' : 뷰를 생성하는 SELECT문의 조건을 위배하는 DML명령을 뷰에 실행할 때 오류 발생
                         (DML이 수행되어질때 조건을 위배하는 변경을  금지)
 . 'WITH READ ONLY'와 'WITH CHECK OPTION'은 같이 사용 불가
 (사용예)회원테이블에서 마일리지가 3000이상인 회원의 회원번호, 회원명, 직업, 마일리지로 구성된 뷰를 생성하시오.
    CREATE OR REPLACE VIEW V_MEM01(MID, MNAME, MJOB, MILE)
    AS
      SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
        FROM MEMBER
       WHERE MEM_MILEAGE >= 3000;
(사용예)회원테이블에서 마일리지가 3000이상인 회원의 회원번호, 회원명, 직업, 마일리지로 구성된 뷰를 읽기전용으로 생성하시오.
    CREATE OR REPLACE VIEW V_MEM01
    AS
      SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
        FROM MEMBER
       WHERE MEM_MILEAGE >= 3000
        WITH READ ONLY;
        
    SELECT * FROM V_MEM01;
    
 (사용예)생성된 뷰(V_MEM01)에서 'g001'회원(송경희)의 마일리지를 800으로 변경    
    UPDATE V_MEM01
       SET MEM_MILEAGE = 800
     WHERE MEM_ID = 'g001';
     
     (원본테이블 변경)
    UPDATE MEMBER
       SET MEM_MILEAGE = 800
     WHERE MEM_ID = 'g001';
     
 (사용예)회원테이블에서 마일리지가 3000이상인 회원의 회원번호, 회원명, 직업, 마일리지로
        구성된 뷰를 WITH CHECK OPTION 을 사용하여 생성하시오.
    CREATE OR REPLACE VIEW V_MEM01
    AS
      SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
        FROM MEMBER
       WHERE MEM_MILEAGE >= 3000
        WITH CHECK OPTION;
 (사용예)생성된 뷰에서 이혜나회원('e001')의 마일리지를 2500으로 변경
    UPDATE V_MEM01
       SET MEM_MILEAGE = 2500
     WHERE MEM_ID = 'e001';
     
 (사용예)신용환회원('c001')마일리지를 MEMBER테이블에서 3500으로 변경
    UPDATE MEMBER
       SET MEM_MILEAGE = 3500
     WHERE MEM_ID = 'c001';
     
 (사용예)오철희회원('k001')마일리지를 뷰에서 4700으로 변경
    UPDATE V_MEM01
       SET MEM_MILEAGE = 4700
     WHERE MEM_ID = 'k001';
     
 (사용예)오철희회원('k001')마일리지를 MEMBER테이블에서 2500으로 변경
    UPDATE MEMBER
       SET MEM_MILEAGE = 2500
     WHERE MEM_ID = 'k001';
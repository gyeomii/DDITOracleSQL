2022-0428-02)
--테이블 생성 방법--
--본인계정 테이블 우클릭 > 새 테이블 > 이름 : REMAIN > 1번컬럼 : 기본키 체크,REMAIN_YEAR, CHAR, 4, NO, 
-->2번컬럼 : 기본키 체크, PROD_ID, VARCHAR2, 10, NO > 3번: REMAIN_J_00, NUMBER, 5, YES, 0
-->4번: REMAIN_I, NUMBER, 5, YES, 0 > 5번: REMAIN_O, NUMBER, 5, YES, 0 
-->6번: REMAIN_J_99, NUMBER, 5, YES, 0 > 7번: REMAIN_DATE, DATE, , YES, NULL
-->고급 체크 > 제약조건 > 초록색 + 클릭 > 새 외래키제약조건 > 테이블: PROD, 제약조건: PK_PROD_ID > 확인

SUBQUERY와 DML명령
1.INSERT 문에서 서브쿼리 사용
 - INSERT INTO 문에 서브쿼리를 사용하면 VALUES 절이 생략됨
 - 사용되는 서브쿼리는 '( )'를 생략하고 기술함
 (사용형식)
    INSERT INTO 테이블명[(컬럼명[,컬럼명,...])]
        서브쿼리;
   .'테이블명( )'에 기술된 컬럼의 갯수, 순서, 타입과
     서브쿼리 SELECT문의 SELECT절에 사용된 컬럼의 갯수, 순서, 타입은 반드시 일치해야함
 
 (사용예)재고수불테이블의 년도에는 '2020'을 상품코드에는 상품테이블의 모든 상품코드를 입력하시오.
    INSERT INTO REMAIN(REMAIN_YEAR, PROD_ID)
        SELECT '2020', PROD_ID
        FROM PROD;
        
2.UPDATE 문에서 서브쿼리 사용(1)
 (사용형식)
    UPDATE 테이블명 [별칭]
       SET (컬럼명[,컬럼명,...])=(서브쿼리)
    [WHERE 조건];--변경할 데이터를 선택하는 조건
    . SET절과 서브쿼리 SELECT절에 사용된 컬럼의 갯수, 순서, 타입이 일치해야한다.
    . 테이블에 만들어진 모든 기본키를 WHERE절에서 비교를 해줘야 한다.
    
 (사용예)재고수불테이블(REMAIN)에 기초재고를 설정하시오.
        기초재고는 상품테이블이 적정재고량으로 하며 날짜는 2020년 1월 1일로 설정
    UPDATE REMAIN A
       SET (A.REMAIN_J_00, A.REMAIN_J_99, A.REMAIN_DATE)= 
           (SELECT A.REMAIN_J_00 + B.PROD_PROPERSTOCK,
                   A.REMAIN_J_99 + B.PROD_PROPERSTOCK,
                   TO_DATE('20200101')
              FROM PROD B
             WHERE A.PROD_ID = B.PROD_ID)--추가할 데이터를 불러오기위힌 조건
     WHERE A.REMAIN_YEAR='2020';--변경할 데이터를 선택하는 조건
     
     COMMIT;        
             
             
             
2022-0429-01)
2.UPDATE 문에서 서브쿼리 사용(2)
 (사용예)2020년 1월 제품별 매입수량을 조회하여 재고수불테이블을 변경하시오.
    (메인쿼리)
    UPDATE REMAIN A
       SET (A.RAMAIN_I, A.REAMIN_J_99, A.REMAIN_DATE)= --REMAIN에서 변경될 자료
           (서브쿼리1)
     WHERE A.REMAIN_YEAR='2020'
       AND A.PROD_ID IN(서브쿼리2);
       
    (서브쿼리1 : 2020년 1월 제품별 매입수량)
    SELECT BUY_PROD, SUM(BUY_QTY)
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
     GROUP BY BUY_PROD;
     
    (서브쿼리2 : 2020년 1월 매입상품)
    SELECT DISTINCT BUY_PROD
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
    
    (결합)
    UPDATE REMAIN A
       SET (A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_DATE)=
           (SELECT A.REMAIN_I + B.BSUM, A.REMAIN_J_99 + B.BSUM, TO_DATE('20200201')
              FROM (SELECT BUY_PROD AS BID, SUM(BUY_QTY) AS BSUM 
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
                     GROUP BY BUY_PROD) B
             WHERE A.PROD_ID = B.BID) --REMAIN에 추가할 데이터를 찾는 조건
     WHERE A.REMAIN_YEAR='2020' --WHERE절이 없으면 REMAIN의 모든 데이터를 다 변경해버린다.
       AND A.PROD_ID IN(SELECT DISTINCT BUY_PROD
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')); --REMAIN에서 변경할 데이터를 찾는 조건
                         
  (사용예)2020년 2월 ~ 4월 제품별 매입수량을 조회하여 재고수불테이블을 변경하시오.
    UPDATE REMAIN A
       SET (A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_DATE)=
           (SELECT A.REMAIN_I + B.BSUM, A.REMAIN_J_99 + B.BSUM, TO_DATE('20200430')
              FROM (SELECT BUY_PROD AS BID, SUM(BUY_QTY) AS BSUM 
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200430')
                     GROUP BY BUY_PROD) B
             WHERE A.PROD_ID = B.BID) --REMAIN에 추가할 데이터를 찾는 조건
     WHERE A.REMAIN_YEAR='2020' --WHERE절이 없으면 REMAIN의 모든 데이터를 다 변경해버린다.
       AND A.PROD_ID IN(SELECT DISTINCT BUY_PROD
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200430'));
                         
SELECT * FROM REMAIN;
COMMIT;
  
  (사용예)2020년 4월 장바구니테이블에서 판매수량을 조회하여 재고수불테이블을 갱신하시오.
    UPDATE REMAIN A
       SET (A.REMAIN_O, A.REMAIN_J_99, A.REMAIN_DATE)=
           (SELECT A.REMAIN_O + B.BSUM, A.REMAIN_J_99 - B.BSUM, TO_DATE('20200430')
              FROM (SELECT CART_PROD AS BID, SUM(CART_QTY) AS BSUM 
                      FROM CART
                     WHERE CART_NO LIKE '202004%'
                     GROUP BY CART_PROD) B
             WHERE A.PROD_ID = B.BID) 
     WHERE A.REMAIN_YEAR='2020' 
       AND A.PROD_ID IN(SELECT DISTINCT CART_PROD
                          FROM CART
                         WHERECART_NO LIKE '202004%');
commit; 

**재고갱신을 위한 트리거
 - 입고 발생시 자동으로 재고조정
CREATE OR REPLACE TRIGGER TG_INPUT
    AFTER INSERT ON BUYPROD
    FOR EACH ROW
DECLARE
    V_QTY  NUMBER:=0; --변수선언, 초기화
    V_PROD PROD.PROD_ID%TYPE; --참조형 변수선언, 초기화
    V_DATE DATE:=(:NEW.BUY_DATE);
BEGIN
    V_QTY:=(:NEW.BUY_QTY);
    V_PROD:=(:NEW.BUY_PROD);
    
    
    UPDATE REMAIN A
       SET A.REMAIN_I = A.REMAIN_I + V_QTY,
           A.REMAIN_J_99 = A.REMAIN_J_99 + V_QTY,
           A.REMAIN_DATE = V_DATE
     WHERE A.PROD_ID = V_PROD;
 EXCEPTION WHEN OTHERS THEN --예외처리. 사소한 오류가 발생했을 때 프로그램을 중도에 종료하지 않고 끝까지 실행되도록 유도하는 것
           DBMS_OUTPUT.PUT_LINE('예외발생 : '||SQLERRM);
END;

**상품코드 'P101000001' 상품 50개를 오늘날짜에 매입(매입단가는 210000원)
재고 상황
------------------------------------------------
        상품코드    기초 매입 매출 기말  날짜
2020	P101000001	33	38	5	66	2020/04/30
------------------------------------------------
    INSERT INTO BUYPROD
      VALUES(SYSDATE, 'P101000001', 50, 210000);

SELECT * FROM REMAIN;

**서브쿼리를 이용한 테이블 생성
 - CREATE TABLE 명령과 서브쿼리를 사용하여 테이블을 생성하고 해당도는 값을 복사할 수 있음.
 - 제약사항은 복사(생성)되지 않음.
 (사용형식)
    CREATE TABLE 테이블명[(컬럼명[,컬럼명,...])] AS (서브쿼리);
 (사용예)재고수불테이블의 모든 데이터를 포함하여 새로운테이블을 생성하시오. 테이블명은 TEMP_REMAIN이다.
    CREATE TABLE TEMP_REMAIN AS 
      (SELECT * FROM REMAIN);
      
      SELECT * FROM TEMP_REMAIN;
      
3.DELETE 문에서 서브쿼리 사용
 **DELETE문의 사용형식
    DELETE FROM 테이블명
    [WHERE 조건];--DELETE의 처리단위가 행이기 때문에 DELETE와 FROM사이에 아무것도 안온다.
 
 (사용예)TEMP_REMAIN테이블에서 2020년 7월 판매된 상품과 같은 상품코드의 자료를 삭제하시오.
  (서브쿼리: 2020년 7월에 판매된 상품)
    SELECT DISTINCT CART_PROD
      FROM CART
     WHERE CART_NO LIKE '202007%'
     
  (메인쿼리)
    DELETE FROM TEMP_REMAIN A
     WHERE REMAIN_YEAR = '2020'
       AND A.PROD_ID = (서브쿼리)
       -- '='은 단일행 연산자 이기 때문에 복수행 연산자 'IN'을 사용해야 한다.
  (결합)
    DELETE FROM TEMP_REMAIN A
     WHERE REMAIN_YEAR = '2020'
       AND A.PROD_ID IN(SELECT DISTINCT CART_PROD
                          FROM CART
                         WHERE CART_NO LIKE '202007%')
SELECT * FROM TEMP_REMAIN;
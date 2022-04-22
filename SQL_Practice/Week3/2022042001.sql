2022-0420-01)
사용예제
  (사용예)매입테이블(BUYPROD)에서 2020년 상반기(1월~6월) 월별, 제품별 매입집계를 조회하시오.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월, BUY_PROD AS 제품코드,
           SUM(BUY_QTY) AS 수량합계, SUM(BUY_QTY * BUY_COST) AS 금액집계 
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY EXTRACT(MONTH FROM BUY_DATE), BUY_PROD
     ORDER BY 1,2;
     
    SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS 월, A.BUY_PROD AS 제품코드, B.PROD_NAME AS 제품명,
           SUM(A.BUY_QTY) AS 수량합계,  SUM(A.BUY_QTY * A.BUY_COST) AS 매입금액합계 
      FROM BUYPROD A, PROD B
     WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630') AND A.BUY_PROD = B.PROD_ID
     GROUP BY EXTRACT(MONTH FROM A.BUY_DATE), A.BUY_PROD, B.PROD_NAME
     ORDER BY 1,2;
  
  (사용예)매입테이블(BUYPROD)에서 2020년 상반기(1월~6월) 월별 매입집계를 조회하되 매입금액이 1억원 이상인 월만 조회하시오.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월,
           SUM(BUY_QTY) AS 수량합계, SUM(BUY_QTY * BUY_COST) AS 매입금액합계
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    HAVING SUM(BUY_COST * BUY_QTY) >= 100000000
     ORDER BY 1;
  
  (사용예)매입테이블(BUYPROD)에서 2020년 상반기(1월~6월) 제품별 매입집계를 조회하되 금액 기준 상위 5개 제품만 조회하시오.
    SELECT A.BID AS 제품코드, A.QSUM AS 수량합계, A.CSUM AS 매입금액합계
      FROM (SELECT BUY_PROD AS BID, SUM(BUY_QTY) AS QSUM,
                   SUM(BUY_QTY * BUY_COST) AS CSUM
              FROM BUYPROD
             WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
             GROUP BY BUY_PROD
             ORDER BY 3 DESC ) A
     WHERE ROWNUM <= 5; 
     
  (사용예)회원테이블에서 성별 평균 마일리지를 조회하시오.
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR SUBSTR(MEM_REGNO2,1,1)='3' THEN '남성회원'
           ELSE '여성회원' END AS 성별, COUNT(*) AS 회원수, ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
      FROM MEMBER
     GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR SUBSTR(MEM_REGNO2,1,1)='3' THEN '남성회원' ELSE '여성회원' END
     ORDER BY 3 DESC;
    
  (사용예)회원테이블에서 연령대 별 평균 마일리지를 조회하시오.
    SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) AS 연령대,
           COUNT(*) AS 회원수, ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
      FROM MEMBER
     GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)
     ORDER BY 3 DESC; 
     
  (사용예)회원테이블에서 거주지별 평균 마일리지를 조회하시오.
    SELECT SUBSTR(MEM_ADD1,1,2) AS 거주지, COUNT(*) AS 회원수, ROUND(AVG(MEM_MILEAGE)) AS 마일리지
      FROM MEMBER
     GROUP BY SUBSTR(MEM_ADD1,1,2)
     ORDER BY 3 DESC;
         
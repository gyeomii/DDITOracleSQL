2022-0428-01)
  (사용예)2020년 상반기에 구매액 기준 1000만원 이상을 구매한 회원정보를 조회하시오.
         Alias는 회원번호, 회원명, 직업, 구매액, 마일리지
    (메인쿼리 : 회원정보(회원번호, 회원명, 직업, 구매액, 마일리지) 조회)
    SELECT A.MEM_ID AS 회원번호,
           A. MEM_NAME AS 회원명,
           A.MEM_JOB AS 직업,
           B.구매액 AS 구매액,
           A.MEM_MILEAGE AS 마일리지
      FROM MEMBER A,
           (1000만원 이상 구매한 회원) B
     WHERE A.MEM_ID = B.회원번호;
     
    (서브쿼리 : 조건 : 2020년 상반기에 구매액기준 1000만원 이상)
    (SELECT A.CART_MEMBER AS BID,
           SUM(A.CART_QTY * B.PROD_PRICE) AS BSUM
      FROM CART A, PROD B
     WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY A.CART_MEMBER
    HAVING SUM(A.CART_QTY * B.PROD_PRICE) >= 10000000)
    
    (in-line-view결합)
    SELECT A.MEM_ID AS 회원번호,
           A. MEM_NAME AS 회원명,
           A.MEM_JOB AS 직업,
           B.BSUM AS 구매액,
           A.MEM_MILEAGE AS 마일리지
      FROM MEMBER A,
           (SELECT A.CART_MEMBER AS BID,
                   SUM(A.CART_QTY * B.PROD_PRICE) AS BSUM
              FROM CART A, PROD B
             WHERE A.CART_PROD = B.PROD_ID
               AND SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
             GROUP BY A.CART_MEMBER
            HAVING SUM(A.CART_QTY * B.PROD_PRICE) >= 10000000) B
     WHERE A.MEM_ID = B.BID
     ORDER BY 4 DESC;
    
    (중첩서브쿼리 결합)
    SELECT A.MEM_ID AS 회원번호,
           A. MEM_NAME AS 회원명,
           A.MEM_JOB AS 직업,
           --B.BSUM AS 구매액,
           A.MEM_MILEAGE AS 마일리지
      FROM MEMBER A
     WHERE A.MEM_ID IN(SELECT B.BID
                        FROM(SELECT A.CART_MEMBER AS BID,
                                SUM(A.CART_QTY * B.PROD_PRICE) AS BSUM
                               FROM CART A, PROD B
                              WHERE A.CART_PROD = B.PROD_ID
                                AND SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
                              GROUP BY A.CART_MEMBER
                             HAVING SUM(A.CART_QTY * B.PROD_PRICE) >= 10000000) B)
     ORDER BY 4 DESC;
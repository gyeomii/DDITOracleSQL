2022-0427-01)
    SELECT DEPARTMENT_ID AS 부서코드,
           DEPARTMENT_NAME AS 부서명,
           NVL(PARENT_ID,0) AS PARENT_ID,
           1 AS LEVELS,
           PARENT_ID||DEPARTMENT_ID AS TEMP
      FROM HR.DEPTS
     WHERE PARENT_ID IS NULL
     UNION ALL   
    SELECT B.DEPARTMENT_ID AS 부서코드,
           LPAD(' ',4*(2-1))||B.DEPARTMENT_NAME AS DEPARTMENT_NAME,
           B.PARENT_ID AS PARENT_ID, 2 AS LEVELS,
           B.PARENT_ID||B.DEPARTMENT_ID AS TEMP
      FROM HR.DEPTS A, HR.DEPTS B --SELF JOIN
     WHERE A.PARENT_ID IS NULL --A테이블을 상위부서코드가 NULL인 부서코드만 갖도록 하는 조건
       AND B.PARENT_ID=A.DEPARTMENT_ID --A테이블이 갖고있는 부서코드가 B테이블의 상위부터코드가 같은 부서 출력 조건
     UNION ALL
     SELECT C.DEPARTMENT_ID AS 부서코드,
           LPAD(' ',4*(3-1))||C.DEPARTMENT_NAME AS DEPARTMENT_NAME,
           C.PARENT_ID AS PARENT_ID, 3 AS LEVELS,
           B.PARENT_ID||C.PARENT_ID||C.DEPARTMENT_ID AS TEMP --계층쿼리모양을 나타내기위한 컬럼
      FROM HR.DEPTS A, HR.DEPTS B, HR.DEPTS C --SELF JOIN(A = 상위부서코드가 NULL인 테이블,
     WHERE A.PARENT_ID IS NULL                          --B = 상위부서코드가 10인 테이블,
       AND B.PARENT_ID = A.DEPARTMENT_ID                --C = 상위부서코드가 B테이블에 있는 부서인 테이블)
       AND C.PARENT_ID = B.DEPARTMENT_ID
       ORDER BY 5;
       
  (사용예)장바구니테이블에서 4월과 6월에판매된 모든 상품정보를 중복되지 않게 조회하시오.
         Alias는 상품번호, 상품명, 판매수량 이며 상품번호순으로 출력하시오.
    SELECT A.PROD_ID AS 상품번호, A.PROD_NAME AS 상품명, SUM(B.CART_QTY) AS 판매수량,
           SUBSTR(B.CART_NO,5,2) AS 판매월
      FROM PROD A, CART B
     WHERE A.PROD_ID = B.CART_PROD
       AND B.CART_NO LIKE '202004%'
     GROUP BY A.PROD_ID, A.PROD_NAME, SUBSTR(B.CART_NO,5,2)
     UNION
    SELECT A.PROD_ID AS 상품번호, A.PROD_NAME AS 상품명, SUM(B.CART_QTY) AS 판매수량,
           SUBSTR(B.CART_NO,5,2) AS 판매월
      FROM PROD A, CART B
     WHERE A.PROD_ID = B.CART_PROD
       AND B.CART_NO LIKE '202006%'
     GROUP BY A.PROD_ID, A.PROD_NAME, SUBSTR(B.CART_NO,5,2)
     ORDER BY 1;
     
  (사용예)장바구니테이블에서 4월과 6월, 두 달에 모두 판매된 상품정보를 조회하시오.
         Alias는 상품번호, 상품명 이며 상품번호순으로 출력하시오.
    SELECT A.PROD_ID AS 상품번호, A.PROD_NAME AS 상품명
      FROM PROD A, CART B
     WHERE A.PROD_ID = B.CART_PROD
       AND B.CART_NO LIKE '202004%'
     GROUP BY A.PROD_ID, A.PROD_NAME
 INTERSECT
    SELECT A.PROD_ID AS 상품번호, A.PROD_NAME AS 상품명
      FROM PROD A, CART B
     WHERE A.PROD_ID = B.CART_PROD
       AND B.CART_NO LIKE '202006%'
     GROUP BY A.PROD_ID, B.PROD_NAME
     ORDER BY 1;
    
  (사용예)장바구니테이블에서 4월과 6월에 판매된 상품 중 6월에만 판매된 상품정보를 조회하시오.
         Alias는 상품번호, 상품명, 판매수량 이며 상품번호순으로 출력하시오.
    SELECT A.PROD_ID AS 상품번호, A.PROD_NAME AS 상품명, SUM(B.CART_QTY) AS 판매수량
      FROM PROD A, CART B
     WHERE A.PROD_ID = B.CART_PROD
       AND B.CART_NO LIKE '202006%'
     GROUP BY A.PROD_ID, A.PROD_NAME, SUBSTR(B.CART_NO,5,2)
     MINUS
    SELECT A.PROD_ID AS 상품번호, A.PROD_NAME AS 상품명, SUM(B.CART_QTY) AS 판매수량
      FROM PROD A, CART B
     WHERE A.PROD_ID = B.CART_PROD
       AND B.CART_NO LIKE '202004%'
     GROUP BY A.PROD_ID, A.PROD_NAME
     ORDER BY 1;
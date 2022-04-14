2022-0412-02)
 4)기타연산자
  (1)IN 연산자 -- OR를 써야할 때 IN사용하는 연습하기
   - 불연속적이거나 규칙성이 없는 자료를 비교할 때 사용
   - OR 연산자, =ANY, =SOME 연산자로 변환가능 -- SOME과 ANY에는 = 의 기능이 없어서 =을 붙여줘야한다.
   - IN연산자에선 '='기능이 내포됨
   
   (사용형식)
    expr IN(값1, 값2,...,값n)
     -'expr'(수식)을 평가한 결과가 '값1' ~ '값n' 중 어느 하나와 일치하면 전체가 참(true)을 반환
     
   (사용예) 사원테이블에서 20번, 70번, 90번, 110번 부서에 근무하는 사원을 조회하시오.
           Alias는 사원번호, 사원명, 부서번호, 급여이다.
        (OR연산자 사용)
          SELECT EMPLOYEE_ID AS 사원번호, EMP_NAME AS 사원명, DEPARTMENT_ID AS 부서번호, SALARY AS 급여 
            FROM HR.employees
           WHERE DEPARTMENT_ID=20 OR DEPARTMENT_ID=70 OR DEPARTMENT_ID=90 OR DEPARTMENT_ID=110;
           
        (IN연산자 사용)
           SELECT EMPLOYEE_ID AS 사원번호, EMP_NAME AS 사원명, DEPARTMENT_ID AS 부서번호, SALARY AS 급여 
             FROM HR.employees
            WHERE DEPARTMENT_ID IN(20, 70, 90, 110);
            
        (=ANY연산자 사용)
           SELECT EMPLOYEE_ID AS 사원번호, EMP_NAME AS 사원명, DEPARTMENT_ID AS 부서번호, SALARY AS 급여 
             FROM HR.employees
            WHERE DEPARTMENT_ID=ANY(20, 70, 90, 110);
            
        (=SOME연산자 사용)
           SELECT EMPLOYEE_ID AS 사원번호, EMP_NAME AS 사원명, DEPARTMENT_ID AS 부서번호, SALARY AS 급여 
             FROM HR.employees
            WHERE DEPARTMENT_ID=SOME(20, 70, 90, 110);
  
  (2) ANY, SOME 연산자
   - 등호(=)의 기능이 포함되지 않은 IN연산자와 같은 기능 수행
   - ANY안의 값 중에 어떤 하나(ANY)라도 조건을 만족하면 참(true)을 반환 (OR연산)
   
   (사용형식)                            
   expr 관계연산자 ANY(SOME) (값1,...값n) 
   
   (사용예)회원테이블에서 직업이 공무원인 회원들의 마일리지보다 많은 마일리지를 보유한 회원들을 조회하시오.
          Alias는 회원번호, 회원명, 직업, 마일리지
        1)직업이 공무원인 회원의 마일리지
         SELECT MEM_MILEAGE
           FROM MEMBER
          WHERE MEM_JOB = '공무원';
          
          SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업, MEM_MILEAGE AS 마일리지
            FROM MEMBER
           WHERE MEM_MILEAGE >ANY(1700, 900, 2200, 3200) --WHERE절이 참이면 SELECT절을 수행
           ORDER BY 4 ;
           
           --SUB QUERY
           SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_JOB AS 직업, MEM_MILEAGE AS 마일리지
            FROM MEMBER
           WHERE MEM_MILEAGE >ANY(SELECT MEM_MILEAGE
                                    FROM MEMBER
                                   WHERE MEM_JOB = '공무원') --WHERE절이 참이면 SELECT절을 수행
           ORDER BY 4 ;
  

2022-0412-02)
 4)기타연산자
  (1)IN연산자
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
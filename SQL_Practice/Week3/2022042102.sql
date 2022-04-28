2022-0421-02)
**계층형쿼리
 - 계층적 구조를 지닌 테이블의 내용을 출력할 때 사용
 - 트리구조를 이용한 방식
 - (사용형식)
    SELECT 컬럼list
      FROM 테이블명
     START WITH 조건 -- 루트(ROOT)노드 지정
   CONNECT BY NOCYCLE|PRIOR 계층구조 조건 -- 계층구조가 어떤식으로 연결되었는지 설정 NOCYCLE(무한루프방지)
**CONNECT BY PRIOR 자식컬럼 = 부모컬럼 : 부모에서 자식으로 트리구성(TOP DOWN)
  CONNECT BY PRIOR 부모컬럼 = 자식컬럼 : 자식에서 부모로 트리구성(BOTTOM UP)
  
**PRIOR 사용위치에 따른 방향
  CONNECT BY PRIOR 컬럼1 = 컬럼2
          (탐색방향)<-----------
  CONNECT BY 컬럼1 = PRIOR 컬럼2
          (탐색방향)----------->
          
**계층형 쿼리 확장
    CONNECT_BY_ROOT 컬럼명 : 루트노드 찾기
    CONNECT_BY_ISCYCLE : 중복참조값 찾기
    CONNECT_BY_ISLEAF : 단말노드 찾기
    
 SELECT DEPARTMENT_ID AS 부서코드,
        LPAD(' ',4*(LEVEL-1))||DEPARTMENT_NAME AS 부서명,
        LEVEL AS 레벨
   FROM HR.depts
  START WITH PARENT_ID IS NULL
CONNECT BY PRIOR DEPARTMENT_ID = PARENT_ID
  ORDER SIBLINGS BY 1; --형제노드에 한해 부서코드순으로 정렬하겠다.
  
  
 SELECT LEVEL,
        DEPARTMENT_ID AS 부서코드,
        LPAD(' ',4*(LEVEL-1))||DEPARTMENT_NAME AS 부서명,
        PARENT_ID AS 상위부서코드,
        CONNECT_BY_ISLEAF
   FROM HR.depts
  START WITH PARENT_ID IS NULL
CONNECT BY NOCYCLE PRIOR DEPARTMENT_ID = PARENT_ID;
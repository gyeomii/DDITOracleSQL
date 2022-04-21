2022-0416-01)
DDL: 데이터 정의어(Data Definition Language)
 - 테이블이나 관계의 구조를 생성하는 데 사용
 - 구조를 정의하거나 변경, 삭제할 때 사용
 - CREATE, ALTER, DROP, TRUNCATE 문이 있음

DML: 데이터 조작어(Data manipulation Language)
 - 데이터베이스에 저장된 자료들을 입력, 수정, 삭제, 조회하는 언어
 - SELECT, INSERT, UPDATE, DELETE 문이 있음
 - SELECT: 데이터 조회 (SELECT~FROM~WHERE~GROUP BY~HAVING~ORDER BY)
 - INSERT: 데이터 생성 (INSERT INTO~VALUES)
 - UPDATE: 데이터 변경 (UPDATE~SET~WHERE)
 - DELETE: 데이터 삭제 (DELETE FROM~WHERE)

DCL: 데이터 제어어(Data Control Language)
 - 데이터베이스 관리자가 데이터 보안, 무결성 유지, 병행 제어, 회복을 위해 
   DBA가 사용하는 제어용 언어
 - GRANT, REVOKE, [COMMIT, ROLLBACK, SAVEPOINT 는 TCL이라고도 불림]문이 있음
 - GRANT: 권한부여명령어 (GRANT[~ON]~TO)
 - REVOKE: 권한취소명령어 (REVOKE[~ON]~FROM
 
WINDOW FUNCTION:윈도우 함수
 - 집계함수: COUNT, SUM, AVG, MAX, MIN, STDDEV, VARIAN
 - 순위함수: RANK, DENSE_RANK, ROW_NUMBER
 - 행 함수: FIRST_VALUE, LAST_VALUE, LAG, LEAD
 - 그룹내 비율함수: RATIO_TO_REPORT, PERCENT_RANK

GROUP FUNCTION: 그룹함수
 - ROLL UP
 - CUBE
 - GROUPING SETS

2022-0408-02)
 2) 숫자 자료형
  - 정수 및 실수자료 저장
  - NUMBER 타입 제공
  (사용형식)
   컬럼명 NUMBER[(*|정밀도[,스케일])]
    . '*|정밀도': 전체 자리수(1~38)를 설정, '*'를 사용하면 크기를 시스템에 위임
    . 스케일: 소숫점이하의 자리수로 자료 저장시
      '스케일+1'번째 자리에서 반올림하여 스케일자리까지 저장
    . 스케일이 생략되면 0으로 간주(소숫점 첫번째 자리에서 반올림)
    . 스케일의 값이 음수이면 주어진 자료의 정수부분에서 반올림되어 저장
  (저장예)
---------------------------------------------
    입력값         선언           저장되는 값
  1234567.8987  NUMBER         1234567.8987
  1234567.8987  NUMBER(8.2)   (정수자리가 부족하면 오류)
  1234567.8987  NUMBER(8.1)    1234567.9
  1234567.8987  NUMBER(9.2)    1234567.90
  1234567.8987  NUMBER(*.3)    1234567.899
  1234567.8987  NUMBER(8)      1234568
  1234567.8987  NUMBER(-2)     1234600
  
 ** 숫자형 자료의 표현범위 : 1.0E130 ~ 9.99...99E-125
 
 ** 정밀도 < 스케일인 경우
  . 희귀한 경우
  . 정밀도 : 0이 아닌 유효숫자의 갯수 --정수부분에 0이외의 수가 오면 안됌 ex)number(3,5) -> 0.00123
  . 스케일 - 정밀도 : 소숫점 이후에 존재해야할 '0'의 갯수
  사용예)
  ----------------------------------------------------------
  입력값           선언             저장되는 값
  ----------------------------------------------------------
  0.2345        NUMBER(4,5)     (소숫점 이후 0이 없어서 오류)
  1.2345        NUMBER(3,5)     (소숫점 이전에 0이 아니므로 오류)
  0.0345        NUMBER(3,4)     0.0345
  0.0026789     NUMBER(3,5)     0.00268
  ----------------------------------------------------------
  
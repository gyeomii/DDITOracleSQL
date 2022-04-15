2022-0415-01)
 1.������ �Լ�
  -ABS, SIGN, POWER, SQRT���� ������
  1)ABS(n), SIGN(n), SQRT(n), POWER(e, n)
   . ABS(n) : �־��� �� n�� ���밪
   . SIGN(n) : �־��� �� n�� ����̸� 1, �����̸� -1, 0�̸� 0�� ��ȯ
   . SQRT(n) : �־��� �� n�� ���� ��ȯ
   . POWER(e, n) : e�� n��(e�� n�� �ŵ� ���� ��)
  (��뿹)
    SELECT ABS(-2000), ABS(0.0009), ABS(0),
           SIGN(-2000), SIGN(0.0001), SIGN(0),
           SQRT(16), SQRT(3.3), POWER(2,15)
      FROM DUAL;

  2)GREATEST(n1,...,nn), LEAST(n1,...,nn)
   . GREATEST(n1,...,nn) : �־��� �� n1 ~ nn �� ���� ū �� ��ȯ
   . LEAST(n1,...,nn) : �־��� �� n1 ~nn �� ���� ���� �� ��ȯ
  (��뿹)
    SELECT GREATEST('ȫ�浿', '�̼���', 'ȫ���'), -- MAX�� ������ ���õ� COLUMN���� �����͸�, GREAST�� Ⱦ���� ���õ� ���� COLUMN�� �����͸� ó��
           GREATEST('APPLE', 'AMOND', 100),
           LEAST('APPLE', 'AMOND', 100),
           GREATEST('APPLE', 'AMOND', 'BEE'),
           LEAST('APPLE', 'AMOND', 'BEE')
      FROM DUAL;
  (��뿹)ȸ�����̺��� ���ϸ����� ��ȸ�Ͽ� 1000���� ���� ���̸� 1000�� �ο��ϰ� 100���� ũ�� ������ ���� ����Ͻÿ�
         Alias�� ȸ����ȣ, ȸ����, �������ϸ���, ���渶�ϸ����̴�.
    SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_MILEAGE AS �������ϸ���, GREATEST(MEM_MILEAGE,1000) AS ���渶�ϸ���
      FROM MEMBER;

  3)ROUND(n,l), TRUNC(n,l)
   . ROUND�� �ݿø�, TRUNC�� �ڸ������� ����
   . l�� ����̸�
     - ROUND(n,l) : �־����� n���� �Ҽ��� ���� l+1�ڸ����� �ݿø��Ͽ� l�ڸ����� ��ȯ
                    l�� �����ǰų� 0�̸� �Ҽ� ù��° �ڸ����� �ݿø��Ͽ� ���� ��ȯ
     - TRUNC(n,l) : �־����� n���� �Ҽ��� ���� l+1�ڸ����� �ڸ�����
   . l�� �����̸�
     - ROUND(n,l) : �־����� n���� �����κ� l�ڸ����� �ݿø��Ͽ� ��� ��ȯ
     - TRUNC(n,l) : �־����� n���� �����κ� l�ڸ����� �ڸ�����
  (��뿹)ȸ�����̺��� ���ɴ뺰 ���ϸ����հ�� ȸ������ ���Ͻÿ�
         Alias�� ���ɴ�, ȸ����, ���ϸ����հ��̴�.
         
    SELECT TRUNC(TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(MEM_BIR,'YYYY'), -1) AS ���ɴ�,
           COUNT(*) AS ȸ����, SUM(MEM_MILEAGE) AS ���ϸ����հ�
      FROM MEMBER
     GROUP BY TRUNC(TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(MEM_BIR,'YYYY'), -1)
     ORDER BY 2; -- GROUP BY�� �����Լ��� ������ ������ �÷��� �� ��������Ѵ�. -���� �� ��
     
     SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) AS ���ɴ�,
            COUNT(*) AS ȸ����, SUM(MEM_MILEAGE) AS ���ϸ����հ�
       FROM MEMBER
      GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)
      ORDER BY 1; -- �������� �Ͻ� ��
      
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','2') 
                                         THEN 
                                              EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)))
                                         ELSE 
                                              EXTRACT(YEAR FROM SYSDATE) -  (2000 + TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)))
                                          END AS ����
      FROM MEMBER;
      
  4)FLOOR(n), CELL(n)
   - FLOOR(n): n�� ���ų� (n�� �����ΰ��) ���� �� �� ���� ū ����
   - CEIL(n): n�� ���ų� (n�� �����ΰ��) ū �� �� ���� ���� ����
  (��뿹)
    SELECT FLOOR(102.6777), FLOOR(102), FLOOR(-102.6777), CEIL(102.6777), CEIL(102), CEIL(-102.6777)
      FROM DUAL;
  (3) ALL ������
   - ALL������ ����� �� �� ��θ� ������ų���� ��(true)�� ��ȯ(AND����)
   
  (�������)
   expr ���迬���� ALL(��1,...,��n)
   
  (��뿹)ȸ�����̺��� ������ �������� ȸ�� �� ���� ���� ���ϸ����� ������ ȸ������
         ���� ���ϸ����� ������ ȸ������ ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���
    SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_JOB AS ����, MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
     WHERE MEM_MILEAGE >ALL(SELECT MEM_MILEAGE
                              FROM MEMBER
                             WHERE MEM_JOB = '������')
     ORDER BY 4;
  
  (4) BETWEEN ������ -- DATEŸ���� ����Ҷ��� TO_DATE('��¥')�� ���
   - ���õ� �ڷ��� ������ ������ �� ���
   - AND �����ڿ� ���� ���
   - ��� ������ Ÿ�Կ� ��� ����
  (�������)
   expr BETWEEN ���Ѱ� AND ���Ѱ�
   . '���Ѱ�'�� '���Ѱ�'�� Ÿ���� �����ؾ� ��
   --ID ��ǰ�ڵ� NAEM ��ǰ�� LGU �з��ڵ� BUYER �ŷ�ó COST ���԰� PRICE �ǸŰ� SALE ���ΰ�
  (��뿹)��ǰ���̺��� ���԰����� 10���� ~ 20���� ������ ��ǰ�� ��ȸ�Ͻÿ�
         Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰�, �ǸŰ� �̸�, ���԰������� ���
    SELECT PROD_ID AS ��ǰ�ڵ�, PROD_NAME AS ��ǰ��, PROD_COST AS ���԰�, PROD_PRICE AS �ǸŰ�
      FROM PROD
     WHERE PROD_COST BETWEEN 100000 AND 200000 -- PROD_COST>=10000 AND PROD_COST<=200000
     ORDER BY 3;
   --EMPLOYEE_ID �����ȣ EMP_NAME ����̸� HIRE_DATE �Ի��� JOB_ID �����ڵ� SALARY �޿� COMMISION_PCT ��������(%) MANAGER_ID å���� �ڵ� DEPARTMENT_ID �μ��ڵ�
  (��뿹)������̺��� 2006�� ~ 2007����̿� �Ի��� ������� ��ȸ�Ͻÿ�.
         Alias�� �����ȣ, �����, �Ի���, �μ��ڵ��̸�, �Ի��� ������ ���
    SELECT EMPLOYEE_ID AS �����ȣ, EMP_NAME AS �����, HIRE_DATE AS �Ի���, DEPARTMENT_ID AS �μ��ڵ�
      FROM HR.employees
     WHERE HIRE_DATE BETWEEN TO_DATE('20060101') AND TO_DATE('20071231')
     ORDER BY 3;
         
    -- ID �ŷ�ó�ڵ� NAME �ŷ�ó�� LGU �з��ڵ� BANK �ŷ����� BANKNO ���¹�ȣ BANKNAME ������ CHARGER �����     
  (��뿹)��ǰ�� �з��ڵ尡 'P100'����('P100' ~ 'P199')�� ��ǰ�� �ŷ��ϴ� �ŷ�ó������ ��ȸ�Ͻÿ�.
         Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, �ּ�, �з��ڵ��̸�, 
    SELECT BUYER_ID AS �ŷ�ó�ڵ�, BUYER_NAME AS �ŷ�ó��, (BUYER_ADD1||' '||BUYER_ADD2) AS �ּ�, BUYER_LGU AS �з��ڵ�
      FROM BUYER
     WHERE BUYER_LGU BETWEEN 'P100' AND 'P199'
  
  (5)LIKE ������ -- ���ڿ����� ��밡��, ū �����Ϳ��� ����ϸ� ȿ���� ������(���� �����Ͱ� �����)
   - ������ ���ϴ� ������
   - ���ϵ�ī��(���Ϻ񱳹��ڿ�) : '%'�� '_'�� ���Ǿ� ������ ������
  (�������)
  expr LIKE '���Ϲ��ڿ�'
   1) '%' : '%'�� ���� ��ġ���� ������ ��� ���ڿ��� ��� -- %��ġ�� �����Ͱ� ���ų� �� �������
    ex) SNAME LIKE '��%' => SNAME�� ���� '��'���� �����ϴ� ��� ���� ������ --'��'�� ������
        SNAME LIKE '%��%' => SNAME�� �� �߿� '��'�� �ִ� ��� ���� ������ --'��'�� ������
        SNAME LIKE '%��' => SNAME�� ���� '��'���� ������ ��� ���� ������ --'��'�� ������
   2) '_' : '_'�� ���� ��ġ���� �ϳ��� ���ڿ� ���� -- _��ġ�� �����Ͱ� �־�� ��
    ex) SNAME LIKE '��_' => SNAME�� ���� 2�����̸� '��'���� �����ϴ� ���ڿ��� ������
        SNAME LIKE '_��_' => SNAME�� �� �߿� 3�����̸� �߰��� ���ڰ� '��'�� ���ڿ��� ������
        SNAME LIKE '_��' => SNAME�� ���� 2�����̸� '��'���� ������ ���ڿ��� ������
    --CART_MEMBER ������, CART_NO ���Ź�ȣ, CART_PROD, ���Ż�ǰ CART_QTY ���ż���
  (��뿹)��ٱ��� ���̺�(CART)���� 2020�� 6���� �Ǹŵ� �ڷḦ ��ȸ�Ͻÿ�.
         Alias�� �Ǹ�����, ��ǰ�ڵ�, �Ǹż����̸� �Ǹ��� ������ ����Ͻÿ�.
    SELECT SUBSTR(CART_NO,1,8) AS �Ǹ�����, CART_PROD AS ��ǰ�ڵ�, CART_QTY AS �Ǹż���
      FROM CART
     WHERE CART_NO LIKE '202006%'
     ORDER BY 1;
     
  (��뿹)�������̺�(BUYPROD)���� 2020�� 6���� ���Ե� �ڷḦ ��ȸ�Ͻÿ�.
         Alias�� ��������, ��ǰ�ڵ�, ���Լ���, ���Աݾ��̸� ������ ������ ����Ͻÿ�.
    SELECT BUY_DATE AS ��������, BUY_PROD AS ��ǰ�ڵ�, BUY_QTY AS ���ż���, BUY_COST*BUY_QTY AS ���űݾ�
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') -- TO_DATE�� ����ؼ� ���ڿ��� ��¥Ÿ������ �ٲ�����Ѵ�
     ORDER BY 1;
     
  (��뿹)ȸ�����̺�(MEMBER)���� �泲�� �����ϴ� ȸ���� ��ȸ�Ͻÿ�.
         Alias�� ȸ����ȣ, ȸ����, �ּ�, ���ϸ����̸� ȸ����ȣ ������ ����Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_ADD1||' '||MEM_ADD2 AS �ּ�, MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
     WHERE MEM_ADD1 LIKE '�泲%'
     ORDER BY 1;
    
 
    
    
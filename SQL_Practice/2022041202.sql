2022-0412-02)
 4)��Ÿ������
  (1)IN������
   - �ҿ������̰ų� ��Ģ���� ���� �ڷḦ ���� �� ���
   - OR ������, =ANY, =SOME �����ڷ� ��ȯ���� -- SOME�� ANY���� = �� ����� ��� =�� �ٿ�����Ѵ�.
   - IN�����ڿ��� '='����� ������
   (�������)
    expr IN(��1, ��2,...,��n)
     -'expr'(����)�� ���� ����� '��1' ~ '��n' �� ��� �ϳ��� ��ġ�ϸ� ��ü�� ��(true)�� ��ȯ
   (��뿹) ������̺��� 20��, 70��, 90��, 110�� �μ��� �ٹ��ϴ� ����� ��ȸ�Ͻÿ�.
           Alias�� �����ȣ, �����, �μ���ȣ, �޿��̴�.
        (OR������ ���)
          SELECT EMPLOYEE_ID AS �����ȣ, EMP_NAME AS �����, DEPARTMENT_ID AS �μ���ȣ, SALARY AS �޿� 
            FROM HR.employees
           WHERE DEPARTMENT_ID=20 OR DEPARTMENT_ID=70 OR DEPARTMENT_ID=90 OR DEPARTMENT_ID=110;
           
        (IN������ ���)
           SELECT EMPLOYEE_ID AS �����ȣ, EMP_NAME AS �����, DEPARTMENT_ID AS �μ���ȣ, SALARY AS �޿� 
             FROM HR.employees
            WHERE DEPARTMENT_ID IN(20, 70, 90, 110);
            
        (=ANY������ ���)
           SELECT EMPLOYEE_ID AS �����ȣ, EMP_NAME AS �����, DEPARTMENT_ID AS �μ���ȣ, SALARY AS �޿� 
             FROM HR.employees
            WHERE DEPARTMENT_ID=ANY(20, 70, 90, 110);
            
        (=SOME������ ���)
           SELECT EMPLOYEE_ID AS �����ȣ, EMP_NAME AS �����, DEPARTMENT_ID AS �μ���ȣ, SALARY AS �޿� 
             FROM HR.employees
            WHERE DEPARTMENT_ID=SOME(20, 70, 90, 110);
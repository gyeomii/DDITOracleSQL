2022-0412-02)
 4)��Ÿ������
  (1)IN ������ -- OR�� ����� �� IN����ϴ� �����ϱ�
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
  
  (2) ANY, SOME ������
   - ��ȣ(=)�� ����� ���Ե��� ���� IN�����ڿ� ���� ��� ����
   - ANY���� �� �߿� � �ϳ�(ANY)�� ������ �����ϸ� ��(true)�� ��ȯ (OR����)
   
   (�������)                            
   expr ���迬���� ANY(SOME) (��1,...��n) 
   
   (��뿹)ȸ�����̺��� ������ �������� ȸ������ ���ϸ������� ���� ���ϸ����� ������ ȸ������ ��ȸ�Ͻÿ�.
          Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���
        1)������ �������� ȸ���� ���ϸ���
         SELECT MEM_MILEAGE
           FROM MEMBER
          WHERE MEM_JOB = '������';
          
          SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_JOB AS ����, MEM_MILEAGE AS ���ϸ���
            FROM MEMBER
           WHERE MEM_MILEAGE >ANY(1700, 900, 2200, 3200) --WHERE���� ���̸� SELECT���� ����
           ORDER BY 4 ;
           
           --SUB QUERY
           SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_JOB AS ����, MEM_MILEAGE AS ���ϸ���
            FROM MEMBER
           WHERE MEM_MILEAGE >ANY(SELECT MEM_MILEAGE
                                    FROM MEMBER
                                   WHERE MEM_JOB = '������') --WHERE���� ���̸� SELECT���� ����
           ORDER BY 4 ;
  

2022-0406-01)����� ����
- ����Ŭ ����� ����
 (�������)
 CREATE USER ������ IDENTIFIED BY ��ȣ;
 CREATE USER ksg97 IDENTIFIED BY java;
- ���Ѽ���
 GRANT ���� ��[,���� ��,...] TO ������; -- CONNECT, RESOURCE, DBA --
 GRANT CONNECT, RESOURCE, DBA TO KSG97;
 
 - HR���� Ȱ��ȭ
 ALTER USER HR ACCOUNT UNLOCK;
 ALTER USER HR IDENTIFIED BY java;
�⺻Ű -> NOT NULL NO DUPLICATE --�ʼ� �ϱ�
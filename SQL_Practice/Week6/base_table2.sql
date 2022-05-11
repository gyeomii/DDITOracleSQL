/**********************************************************
*  테이블 삭제
***********************************************************/
--DROP TABLE SG_Scores	purge;
--DROP TABLE Student	purge;
--DROP TABLE Course	purge;
--DROP TABLE Professor	purge;
--DROP TABLE Department	purge;
--DROP TABLE T_Course	purge;
--DROP TABLE T_SG_Scores	purge;
--DROP TABLE Score_Grade	purge;

/**********************************************************
*  Department 테이블 생성
***********************************************************/
CREATE TABLE Department (
Dept_ID      VARCHAR2(10)   CONSTRAINT Department_pk PRIMARY KEY,
Dept_Name    VARCHAR2(25),
Dept_Tel     VARCHAR2(12) );

/**********************************************************
*  Student 테이블 생성
***********************************************************/
CREATE TABLE Student (
Dept_ID      VARCHAR2(10),
Year         VARCHAR2(1),
Student_ID   VARCHAR2(7),
Name         VARCHAR2(10)   NOT NULL,
ID_Number    VARCHAR2(14)   NOT NULL CONSTRAINT Student_uk UNIQUE,
Address      VARCHAR2(40),
Telephone    VARCHAR2(13),
Email        VARCHAR2(20),
Status       VARCHAR2(1),
I_Date       DATE,
CONSTRAINT   Student_pk      PRIMARY KEY (Student_ID),
CONSTRAINT   Student_fk      FOREIGN KEY (Dept_ID)
                             REFERENCES Department);

/**********************************************************
*  Professor 테이블 생성
***********************************************************/
CREATE  TABLE  Professor (
Professor_ID   VARCHAR2(3),
Name           VARCHAR2(10)  NOT NULL,
Position       VARCHAR2(10)  NOT NULL CONSTRAINT Professor_ck
        CHECK (Position in ('총장','교수','부교수','조교수','초빙교수')),
Dept_ID        VARCHAR2(10),
Telephone      VARCHAR2(12)  CONSTRAINT Professor_uk UNIQUE,
Email          VARCHAR2(20),
Duty           VARCHAR2(10),
Mgr            VARCHAR2(3), 
CONSTRAINT     Professor_pk  PRIMARY KEY (Professor_ID),
CONSTRAINT     Professor_fk  FOREIGN KEY (Dept_ID)
                             REFERENCES Department);

/**********************************************************
*  Course 테이블 생성
***********************************************************/
CREATE  TABLE  Course (
Course_ID      VARCHAR2(5),
Title          VARCHAR2(60) NOT NULL,
C_Number       NUMBER(1)    NOT NULL,
Professor_ID   VARCHAR2(3),
Course_Fees    NUMBER(7),
CONSTRAINT     Course_pk    PRIMARY KEY (Course_ID),
CONSTRAINT     Course_fk    FOREIGN KEY (Professor_ID)
                            REFERENCES   Professor);

/**********************************************************
*  SG_Scores 테이블 생성
***********************************************************/
CREATE  TABLE  SG_Scores (
Student_ID     VARCHAR2(7),
Course_ID      VARCHAR2(5),
Score          NUMBER(3),
Grade          VARCHAR2(2),
Score_Assigned DATE          DEFAULT  SYSDATE,
CONSTRAINT     SG_Scores_pk  PRIMARY KEY (Student_ID, Course_ID),
CONSTRAINT     SG_Scores_fk1 FOREIGN KEY (Student_ID)
                             REFERENCES   Student,
CONSTRAINT     SG_Scores_fk2 FOREIGN KEY (Course_ID)
                             REFERENCES   Course);


/**********************************************************
* Score_Grade 테이블 생성
***********************************************************/
CREATE TABLE Score_Grade (
LOW    NUMBER(3),
HIGH   NUMBER(3),
GRADE  CHAR(2));

/**********************************************************
*  T_Course 테이블 생성
***********************************************************/
CREATE  TABLE  T_Course 
AS 
   SELECT * 
   FROM   Course
   WHERE  10=20;

/**********************************************************
*  T_SG_Scores 테이블 생성
***********************************************************/
CREATE TABLE T_SG_Scores
AS
   SELECT *
   FROM   SG_Scores
   WHERE  10 = 20;

/**********************************************************
*  테이블명 조회
***********************************************************/
SELECT * FROM USER_CATALOG
/

/**********************************************************
*  Department 테이블 견본 데이터
***********************************************************/
INSERT INTO Department VALUES ('대학','대학본부',      '765-4000');
INSERT INTO Department VALUES ('컴공','컴퓨터공학과',  '765-4100');
INSERT INTO Department VALUES ('정통','정보통신공학과','765-4200');
INSERT INTO Department VALUES ('경영','경영학과',      '765-4400');
INSERT INTO Department VALUES ('행정','세무행정학과',  '765-4500');

/**********************************************************
*  Student 테이블 견본 데이터
***********************************************************/
INSERT INTO Student  VALUES ('컴공','3','C1601','한영삼','000708-3******','부산시 동래구',  '010-7999-0101', 'c1601@cyber.ac.kr', Null,'2016/02/26');
INSERT INTO Student  VALUES ('컴공','3','C1602','서희경','990205-2******','서울시 영등포구','010-4333-0707', 'c1602@cyber.ac.kr', Null,'2016/02/26');
INSERT INTO Student  VALUES ('컴공','2','C1701','이정민','011109-4******','대구시 수성구',  Null,            'c1701@cyber.ac.kr', Null,'2017/03/02');
INSERT INTO Student  VALUES ('컴공','2','C1702','박주영','020917-3******','경남 진해시',   '010-8555-1616',  'c1702@cyber.ac.kr', Null,'2017/03/02');
INSERT INTO Student  VALUES ('정통','2','T1702','이정필','001117-3******','충남 천안시',    Null,            't1702@cyber.ac.kr', Null,'2017/03/02');
INSERT INTO Student  VALUES ('경영','2','B1701','배상문','961225-1******','대전시 동구읍',  Null,            'b1701@cyber.ac.kr', Null,'2017/03/02');
INSERT INTO Student  VALUES ('행정','1','A1701','이미나','001217-4******','전남 광양시',    '010-3888-5050',  Null,               Null,'2017/03/02');
INSERT INTO Student  VALUES ('컴공','1','C1801','김대현','020121-3******','서울시 송파구',  '010-3932-9999', 'c1801@cyber.ac.kr', Null,'2018/02/28');
INSERT INTO Student  VALUES ('컴공','1','C1802','신지애','020521-4******','대전시 대덕구',  '010-6343-8838', 'c1802cyber.ac.kr',  'H', '2018/02/28');
INSERT INTO Student  VALUES ('정통','1','T1801','김병호','991124-1******','대구시 달서구',  '011-1222-0303',  Null,               Null,'2018/02/28');
INSERT INTO Student  VALUES ('경영','1','B1801','김빛나','030422-4******','서울시 은평구',  Null,             Null,               Null,'2018/02/28');

/**********************************************************
*  Professor 테이블 견본 데이터
***********************************************************/
INSERT INTO Professor VALUES ('P00', '서한식', '총장',   '대학','765-4000','hsseo@cyber.ac.kr', '총장',    NULL);
INSERT INTO Professor VALUES ('P11', '신기술', '교수',   '컴공','765-4111','ksshin@cyber.ac.kr','학과장', 'P00');
INSERT INTO Professor VALUES ('P12', '이대호', '부교수', '컴공','765-4112','dhlee@cyber.ac.kr',  Null,    'P11');
INSERT INTO Professor VALUES ('P13', '유소연', '조교수', '컴공','765-4113','syyoo@cyber.ac.kr',  Null,    'P11');
INSERT INTO Professor VALUES ('P21', '박지성', '부교수', '정통','765-4211','jspark@cyber.ac.kr','학과장', 'P00');
INSERT INTO Professor VALUES ('P22', '김하늘', '부교수', '정통','765-4212','hnkim@cyber.ac.kr',  Null,    'P21');
INSERT INTO Professor VALUES ('P23', '이상혁', '조교수', '정통','765-4213','shlee@cyber.ac.kr',  Null,    'P21');
INSERT INTO Professor VALUES ('P24', '최경주', '조교수', '정통','765-4214','kjchoi@cyber.ac.kr', Null,    'P21');
INSERT INTO Professor VALUES ('P41', '안연홍', '부교수', '경영','765-4411','yhahn@cyber.ac.kr', '학과장', 'P00');
INSERT INTO Professor VALUES ('P51', '함영애', '부교수', '행정','765-4511','yaham@cyber.ac.kr', '학과장', 'P00');

/**********************************************************
*  Course 테이블 견본 데이터
***********************************************************/
INSERT INTO Course VALUES ('L0011','TOEIC연구',     2, Null,Null);
INSERT INTO Course VALUES ('L0012','문학과 여행',   2, Null,Null);
INSERT INTO Course VALUES ('L0013','문학개론',      2, Null,Null);
INSERT INTO Course VALUES ('L1011','컴퓨터구조',    2,'P11',Null);
INSERT INTO Course VALUES ('L1012','웹디자인',      2, Null,20000);
INSERT INTO Course VALUES ('L1021','데이터베이스',  2,'P12',Null);
INSERT INTO Course VALUES ('L1022','정보통신개론',  2,'P21',Null);
INSERT INTO Course VALUES ('L1031','SQL',           3,'P12',30000);
INSERT INTO Course VALUES ('L1032','자바프로그래밍',3,'P13',Null);
INSERT INTO Course VALUES ('L1041','컴퓨터네트워크',2,'P21',Null);
INSERT INTO Course VALUES ('L1042','Delphi',        3,'P13',50000);
INSERT INTO Course VALUES ('L1051','웹서버관리',    2,'P11',Null);
INSERT INTO Course VALUES ('L1052','전자상거래',    3,'P22',30000);
INSERT INTO Course VALUES ('L2031','게임이론',      3,'P23',50000);
INSERT INTO Course VALUES ('L2061','스프링프레임워크',3, Null,50000);

/**********************************************************
*  SG_Scores 테이블 견본 데이터
***********************************************************/
INSERT INTO SG_Scores VALUES ('C1601','L1011',  93, Null, '2016/12/27');
INSERT INTO SG_Scores VALUES ('C1601','L1021', 105, Null, '2016/12/27');
INSERT INTO SG_Scores VALUES ('C1601','L0011',  68, Null, '2016/12/27');
INSERT INTO SG_Scores VALUES ('C1601','L1031',  82, Null, '2017/06/29');
INSERT INTO SG_Scores VALUES ('C1601','L1032',  78, Null, '2017/06/29');
INSERT INTO SG_Scores VALUES ('C1601','L1041',  87, Null, '2017/12/23');
INSERT INTO SG_Scores VALUES ('C1601','L1051',  87, Null, '2018/06/28');
INSERT INTO SG_Scores VALUES ('C1602','L0011',  98, Null, '2016/12/27');
INSERT INTO SG_Scores VALUES ('C1602','L1011',  87, Null, '2016/12/27');
INSERT INTO SG_Scores VALUES ('C1602','L1021',  98, Null, '2016/12/27');
INSERT INTO SG_Scores VALUES ('C1602','L1031',  94, Null, '2017/06/29');
INSERT INTO SG_Scores VALUES ('C1602','L1041',  77, Null, '2018/06/28');
INSERT INTO SG_Scores VALUES ('C1602','L1051',  77, Null, '2018/06/28');
INSERT INTO SG_Scores VALUES ('C1701','L1011',  97, Null, '2017/06/29');
INSERT INTO SG_Scores VALUES ('C1701','L1021',  96, Null, '2017/06/29');
INSERT INTO SG_Scores VALUES ('C1701','L1031',  96, Null, '2017/12/23');
INSERT INTO SG_Scores VALUES ('C1701','L1022',  97, Null, '2017/12/23');
INSERT INTO SG_Scores VALUES ('C1701','L1042',  83, Null, '2017/12/23');
INSERT INTO SG_Scores VALUES ('C1701','L1032',  93, Null, '2018/06/28');
INSERT INTO SG_Scores VALUES ('C1701','L1051',  89, Null, '2018/06/29'); 
INSERT INTO SG_Scores VALUES ('C1702','L1011',  89, Null, '2017/06/29');
INSERT INTO SG_Scores VALUES ('C1702','L1021',  96, Null, '2017/06/29');
INSERT INTO SG_Scores VALUES ('C1702','L1031',  86, Null, '2017/12/23');
INSERT INTO SG_Scores VALUES ('C1702','L1022',  87, Null, '2017/12/23');
INSERT INTO SG_Scores VALUES ('C1702','L1042',  98, Null, '2017/12/23');
INSERT INTO SG_Scores VALUES ('C1702','L1032',  97, Null, '2018/06/28');
INSERT INTO SG_Scores VALUES ('C1702','L1051',  84, Null, '2018/06/29'); 
INSERT INTO SG_Scores VALUES ('C1801','L1031',  85, Null, '2018/06/27');
INSERT INTO SG_Scores VALUES ('C1802','L1031',  77, Null, '2018/06/27');
INSERT INTO SG_Scores VALUES ('C1701','L2061',Null, Null, '2018/08/26');
INSERT INTO SG_Scores VALUES ('C1702','L2061',Null, Null, '2018/08/26');
INSERT INTO SG_Scores VALUES ('C1601','L2061',Null, Null, '2018/08/26'); 
INSERT INTO SG_Scores VALUES ('C1602','L2061',Null, Null, '2018/08/26'); 

/**********************************************************
*  T_Course 테이블 견본 데이터
***********************************************************/
INSERT INTO T_Course VALUES ('L1031','SQL응용',       3,'P12',50000);
INSERT INTO T_Course VALUES ('L1032','JAVA',          3,'P13',30000);
INSERT INTO T_Course VALUES ('L1043','JSP프로그래밍', 3, NULL,50000);
INSERT INTO T_Course VALUES ('L2033','게임프로그래밍',3,'P24',40000);
INSERT INTO T_Course VALUES ('L4011','경영정보시스템',3,'P41',30000);
INSERT INTO T_Course VALUES ('L4012','세무행정학',    3,'P51',50000);

/**********************************************************
*  Course_Grade 테이블 견본 데이터
***********************************************************/
INSERT INTO SCORE_GRADE VALUES (95,100,'A+');
INSERT INTO SCORE_GRADE VALUES (90, 94,'A ');
INSERT INTO SCORE_GRADE VALUES (85, 89,'B+');
INSERT INTO SCORE_GRADE VALUES (80, 84,'B ');
INSERT INTO SCORE_GRADE VALUES (75, 79,'C+');
INSERT INTO SCORE_GRADE VALUES (70, 74,'C ');
INSERT INTO SCORE_GRADE VALUES (65, 69,'D+');
INSERT INTO SCORE_GRADE VALUES (60, 64,'D ');
INSERT INTO SCORE_GRADE VALUES ( 0, 59,'F ');

COMMIT;

/**********************************************************
*  학과(Department) 테이블 검색
***********************************************************/
SELECT * FROM Department
/


/**********************************************************
*  연습문제용 테이블 삭제
***********************************************************/
--DROP TABLE EC_Order	purge;
--DROP TABLE EC_Basket	purge;
--DROP TABLE EC_Member	purge;
--DROP TABLE EC_Product	purge;

/**********************************************************
*  EC_Product 테이블 생성
***********************************************************/
CREATE TABLE EC_Product (
Product_Code    VARCHAR2(10),
Product_Name    VARCHAR2(20)  NOT NULL,
Standard        VARCHAR2(20),
Unit            VARCHAR2(10),
Unit_Price      NUMBER(7)     NOT NULL,
Left_Qty        NUMBER(5),
Company         VARCHAR2(20),
ImageName       VARCHAR2(20),
Info            VARCHAR2(80),
Detail_Info     VARCHAR2(255),
CONSTRAINT      EC_Product_pk PRIMARY KEY (Product_Code));

/**********************************************************
*  EC_Member 테이블 생성
***********************************************************/
CREATE TABLE EC_Member (
UserID         VARCHAR2(10)  CONSTRAINT EC_Member_ck
               CHECK (UserID BETWEEN 'a' AND 'z'),
Passwd         VARCHAR2(10)  NOT NULL,
Name           VARCHAR2(10)  NOT NULL,
Regist_No      VARCHAR2(14)  NOT NULL CONSTRAINT EC_Member_uk UNIQUE,
Email          VARCHAR2(20),
Telephone      VARCHAR2(13)  NOT NULL,
Address        VARCHAR2(40),
BuyCash        NUMBER(9)     DEFAULT  0,
Timestamp      DATE          DEFAULT  SYSDATE,
CONSTRAINT     EC_Member_pk  PRIMARY KEY (UserID) );

/**********************************************************
*  EC_Basket 테이블 생성
***********************************************************/
CREATE TABLE EC_Basket (
Order_No      VARCHAR2(10),
Order_ID      VARCHAR2(10)   NOT NULL,
Product_Code  VARCHAR2(10)   NOT NULL,
Order_Qty     NUMBER(3)      NOT NULL,
Order_date    Date           Default    SYSDATE,
CONSTRAINT    EC_Basket_pk   PRIMARY KEY (Order_NO),
CONSTRAINT    EC_Basket_fk1  FOREIGN KEY (Order_ID)
                             REFERENCES   EC_Member,
CONSTRAINT    EC_Basket_fk2  FOREIGN KEY (Product_Code)
                             REFERENCES   EC_Product);

/**********************************************************
*  EC_Order 테이블 생성
***********************************************************/
CREATE TABLE EC_Order (
Order_No      VARCHAR2(10),
Order_ID      VARCHAR2(10)   NOT NULL,
Product_Code  VARCHAR2(10)   NOT NULL,
Order_Qty     NUMBER(3)      NOT NULL,
CSel          VARCHAR2(30),
CMoney        NUMBER(9),
CDate         DATE,
MDate         DATE,
Gubun         VARCHAR2(10),
CONSTRAINT    EC_Order_pk    PRIMARY KEY (Order_NO) );

/**********************************************************
*  테이블명 조회
***********************************************************/
SELECT * FROM USER_CATALOG;

/********************************************************************
*  EC_Product 테이블 견본 데이터
********************************************************************/
INSERT INTO EC_Product VALUES ('NB01', '노트북컴퓨터','GT633',       '대', 930000, 15,'SAMSUNG', 'nb01.jpg', '인텔 i5-460M 2.53GHz: RAM 4GB: HDD 500GB: 15.6" 모니터', Null);
INSERT INTO EC_Product VALUES ('NB02', '노트북컴퓨터','U35JC',       '대', 750000, 10,'SAMSUNG', 'nb02.jpg', '인텔 i5-450M 2.40GHz: RAM 4GB: HDD 500GB: 13.3" 모니터', Null);
INSERT INTO EC_Product VALUES ('NB03', '노트북컴퓨터','DV6',         '대', 665000, 10,'HP',      'nb03.jpg', '인텔 i3-350M 2.66GHz: RAM 2GB: HDD 250GB: 15.6" 모니터', Null);
INSERT INTO EC_Product VALUES ('CM01', '개인용컴퓨터','HPE-340KL',   '대', 747000, 30,'HP',      'cm01.jpg', '인텔 i750 2.66GHz: RAM 4GB: HDD 1TB: GeForce GTX260',    Null);
INSERT INTO EC_Product VALUES ('CM02', '개인용컴퓨터','DM-C200',     '대', 434000, 20,'Samsung', 'cm02.jpg', '인텔 E5700 3.00GHz: RAM 2GB: HDD 320GB: 내장그래픽',     Null);
INSERT INTO EC_Product VALUES ('CM03', '개인용컴퓨터','T30MS',       '대', 740000, 20,'LG전자',  'cm03.jpg', '인텔 E6700 3.20GHz: RAM 2GB: HDD 500GB: GeForce GT220',  Null);
INSERT INTO EC_Product VALUES ('PRT01','프린터',      'CLX-3185WK',  '대', 235000, 10,'SAMSUNG', 'pt01.jpg', '무선컬러레이저복합기: 600DPI: 개인용',                   Null);
INSERT INTO EC_Product VALUES ('PRT02','프린터',      'CLP-325WK',   '대', 860000,  3,'SAMSUNG', 'pt02.jpg', '무선칼러레이저: 1200DPI: 오피스용',                      Null);
INSERT INTO EC_Product VALUES ('PRT03','프린터',      'K8600',       '대', 272000, 10,'HP',      'pt03.jpg', '잉크젯: 1200DPI: 칼러인쇄 10PPM: 개인용',                Null);
INSERT INTO EC_Product VALUES ('PRT04','프린터',      'CP3525DN',    '대', 482000,  5,'HP',      'pt04.jpg', '칼러레이저젯: 30PPM: USB2.0: 양면: 오피스용',            Null);
INSERT INTO EC_Product VALUES ('TV01', 'TV',          'LN46C632M1F', '대',1060000, 10,'SAMSUNG', 'tv01.jpg', 'PAVV LCD 632: 46" 스탠드형',                             Null);
INSERT INTO EC_Product VALUES ('TV02', 'TV',          '47LD452',     '대', 980000, 10,'LG전자',  'tv02.jpg', 'Xcanvas 120Hz Full-HD급 47": 벽결이형(슬림)',            Null);
INSERT INTO EC_Product VALUES ('TV03', 'TV',          'UN46C8000XF', '대',1785000,  5,'samsung', 'tv03.jpg', 'PAVV 3D LED Full HD: 46"',                               Null);
INSERT INTO EC_Product VALUES ('TV04', 'TV',          '47LX9500',    '대',1920000,  5,'LG전자',  'tv04.jpg', '3D Full LED Slim: 47"',                                  Null);
INSERT INTO EC_Product VALUES ('DK01', '책상',        '1200x745x750','개',  53000,100, Null,     'dk01.jpg',  '사무용 컴퓨터 책상',                                    Null);
INSERT INTO EC_Product VALUES ('CH01', '의자',        '회전용',      '개',  70000,100, Null,     'ch01.jpg', '회전의자: 590x640x980',                                  Null);

/********************************************************************
*  EC_Member 테이블 견본 데이터
********************************************************************/
INSERT INTO EC_Member VALUES ('jupark','1234','박지운','951214-1******',Null,'011-8011-2923','서울특별시 영등포구',Null, '2017/07/11');
INSERT INTO EC_Member VALUES ('imjung','1234','정일미','860807-2******',Null,'011-2242-6666','서울특별시 송파구',  Null, '2017/06/01');
INSERT INTO EC_Member VALUES ('shchoi','1234','최상희','630125-2******',Null,'010-2411-5558','광주광역시 동구',    Null, '2017/11/10'); 
INSERT INTO EC_Member VALUES ('uskang','1234','강욱선','810911-2******',Null,'010-7899-6547','경북 경주시',        Null, '2017/02/01');
INSERT INTO EC_Member VALUES ('kcchoi','1234','최광수','690514-1******',Null,'010-5556-9998','인천광역시 서구',    Null, '2017/05/31');
INSERT INTO EC_Member VALUES ('cscho', '1234','조철상','650707-1******',Null,'010-8884-8884','서울특별시 은평구',  Null, '2017/09/15');
INSERT INTO EC_Member VALUES ('hskim', '1234','김혜수','831122-2******',Null,'010-8228-1112','광주광역시 북구',    Null, '2018/01/14');
INSERT INTO EC_Member VALUES ('sbhong','1234','홍서빈','800110-2******',Null,'010-3922-9921','제주도 서귀포시',    Null, '2018/02/01');
INSERT INTO EC_Member VALUES ('mhlee', '1234','이민형','820222-1******',Null,'010-1020-1010','강원도 춘천시',      Null, '2018/03/03');
INSERT INTO EC_Member VALUES ('jskang','1234','강준상','920303-1******',Null,'010-1115-3333','강원도 원주시',      Null, '2018/04/08');
INSERT INTO EC_Member VALUES ('usko',  '1234','고우선','010102-4******',Null,'010-8874-1452','서울특별시 강남구',  Null, '2018/02/01');
INSERT INTO EC_Member VALUES ('supark','1234','박세우','030914-3******',Null,'010-6666-8745','부산광역시 동래구',  Null, '2018/02/01');
INSERT INTO EC_Member VALUES ('mskim', '1234','김미선','020506-4******',Null,'010-8887-3254','대구광역시 달서구',  Null, '2018/07/11');
INSERT INTO EC_Member VALUES ('ujjung','1234','정유진','901225-2******',Null,'011-2833-9383','서울특별시 종로구',  Null, '2018/07/11');
INSERT INTO EC_Member VALUES ('shlee', '1234','이상혁','870709-1******',Null,'011-8766-9876','대전광역시 유성구',  Null, '2018/07/15');
INSERT INTO EC_Member VALUES ('uychoi','1234','최윤영','911010-2******',Null,'010-6669-7777','대구광역시 수성구',  Null, '2018/07/15'); 

/********************************************************************
*  EC_Basket 테이블 견본 데이터
********************************************************************/
INSERT INTO EC_Basket VALUES  ('180711001','usko', 'TV01',1,'2018/07/11');
INSERT INTO EC_Basket VALUES  ('180711002','hskim','CM01',1,'2018/07/11');
INSERT INTO EC_Basket VALUES  ('180711003','mskim','TV01',1,'2018/07/11');
INSERT INTO EC_Basket VALUES  ('180711004','mhlee','NB02',1,'2018/07/11');
INSERT INTO EC_Basket VALUES  ('180711005','mhlee','CM03',1,'2018/07/11');

/********************************************************************
*  EC_Order 테이블 견본 데이터
********************************************************************/
INSERT INTO EC_Order VALUES ('180205001','usko',  'NB01', 1,'신용카드', 930000,'2018/02/15','2018/02/16','배달');
INSERT INTO EC_Order VALUES ('180204001','supark','NB02', 1,'현금입금', 750000,'2018/02/24','2018/02/25','배달');
INSERT INTO EC_Order VALUES ('180311001','supark','PRT01',1,'현금입금', 235000,'2018/03/11','2018/03/12','배달');
INSERT INTO EC_Order VALUES ('180315001','imjung','TV03', 1,'신용카드',1785000,'2018/03/15','2018/03/17','배달');
INSERT INTO EC_Order VALUES ('180403001','uskang','PRT03',1,'현금입금', 272000,'2018/04/03','2018/04/05','배달');
INSERT INTO EC_Order VALUES ('180412001','cscho', 'CM03', 1,'계좌이체', 740000,'2018/04/12','2018/04/15','배달');
INSERT INTO EC_Order VALUES ('180505001','jskang','TV01', 1,'계좌이체',1060000,'2018/05/07',Null,        '취소'); 
INSERT INTO EC_Order VALUES ('180505002','kcchoi','DK01', 1,'신용카드',  53000,'2018/05/07',Null,        '결제');
INSERT INTO EC_Order VALUES ('180505003','kcchoi','CH01', 1,'계좌이체',  70000,'2018/05/07',Null,        '결제');
INSERT INTO EC_Order VALUES ('180707001','jupark','CM01', 5, Null,     3735000, Null,       Null,        Null);
INSERT INTO EC_Order VALUES ('180707002','jupark','PRT02',5, Null,     4300000, Null,       Null,        Null);
INSERT INTO EC_Order VALUES ('180707003','cscho', 'CM01' ,1, Null,      747000, Null,       Null,        Null);

COMMIT;

/********************************************************************
*  주문처리(EC_Order) 테이블 검색
********************************************************************/
SELECT * FROM EC_Order
/
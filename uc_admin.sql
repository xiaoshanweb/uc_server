#vue_app_000 ���ּ�
#vue_server_000 ������
#         db.sql ���ݿ�ָ��

#����һ:�����û���¼�����������
#1:����xz�� 7~16
USE xz;
#2:������ xz_login
#3:��Ӽ��� 14:20
CREATE TABLE xz_login(
   id INT PRIMARY KEY AUTO_INCREMENT,
   uname VARCHAR(50),
   upwd  VARCHAR(32)
);
INSERT INTO xz_login VALUES(null,'tom',md5('123'));
INSERT INTO xz_login VALUES(null,'jerry',md5('123'));


#���ܶ�:�������ﳵ�� 17:32
USE xz;
CREATE TABLE xz_cart(
 id INT PRIMARY KEY AUTO_INCREMENT,
 lid INT,
 count INT,
 lname VARCHAR(255),
 price DECIMAL(10,2)
);
ALTER TABLE xz_cart ADD uid INT;
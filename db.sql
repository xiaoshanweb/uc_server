#vue_app_000 脚手架
#vue_server_000 服务器
#         db.sql 数据库指定

#功能一:创建用户登录表并且添加数据
#1:进入xz库 7~16
USE xz;
#2:创建表 xz_login
#3:添加几列 14:20
CREATE TABLE xz_login(
   id INT PRIMARY KEY AUTO_INCREMENT,
   uname VARCHAR(50),
   upwd  VARCHAR(32)
);
INSERT INTO xz_login VALUES(null,'tom',md5('123'));
INSERT INTO xz_login VALUES(null,'jerry',md5('123'));


#功能二:创建购物车表 17:32
USE xz;
CREATE TABLE xz_cart(
 id INT PRIMARY KEY AUTO_INCREMENT,
 lid INT,
 count INT,
 lname VARCHAR(255),
 price DECIMAL(10,2)
);
ALTER TABLE xz_cart ADD uid INT;
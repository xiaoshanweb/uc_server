SET NAMES UTF8;
DROP DATABASE IF EXISTS uc;
CREATE DATABASE uc CHARSET=UTF8;
USE uc;

CREATE TABLE uc_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),
  avatar VARCHAR(128),        #ͷ��ͼƬ·��
  user_name VARCHAR(32),      #�û���������С��
  gender INT,                  #�Ա�  0-Ů  1-��
  createTime VARCHAR(32),
  openID VARCHAR(32),
  privilegeLists VARCHAR(32)
);


/**��Ʒ��Ϣ**/
CREATE TABLE uc_goods(
  goodsSPU VARCHAR(32) PRIMARY KEY,
  title VARCHAR(32),
  mianTitle VARCHAR(32),
  describle VARCHAR(128),
  unit VARCHAR(32),
  brand VARCHAR(32),
 price VARCHAR(32)
);

/**��ƷͼƬ��Ϣ**/
CREATE TABLE uc_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  picSPU VARCHAR(32),
  mainImage VARCHAR(128),
  detailsImage VARCHAR(128),
  FOREIGN KEY (picSPU) REFERENCES uc_goods(goodsSPU)
);

/**��Ա����**/
CREATE TABLE uc_member(
  delverID VARCHAR(12) PRIMARY KEY,
  memberName VARCHAR(16),
  memberNick VARCHAR(16),
  avator VARCHAR(32),
  mobile VARCHAR(16),
  email VARCHAR(32),
  openID VARCHAR(16),
  createTime VARCHAR(16)
);

/**������Ϣ**/
CREATE TABLE uc_orders(
  orderNo VARCHAR(32) PRIMARY KEY,
  status VARCHAR(10),                #״̬
  receiver VARCHAR(16),       #����������
  province VARCHAR(16),       #ʡ
  city VARCHAR(16),           #��
  county VARCHAR(16),         #��
  address VARCHAR(128),       #��ϸ��ַ
  cellphone VARCHAR(16),      #�ֻ�
  fixedphone VARCHAR(16),     #�̶��绰
  postcode CHAR(6),           #�ʱ�
  pushTime VARCHAR(16),            #�µ�ʱ��
  pay_time BIGINT,        #����ʱ��
  remark VARCHAR(128),
  memberID VARCHAR(16),
  goodsCode VARCHAR(32),
  FOREIGN KEY(memberID) REFERENCES uc_member(delverID),
  FOREIGN KEY(goodsCode) REFERENCES uc_goods(goodsSPU)
);

/**������˾��Ϣ**/
CREATE TABLE logistics_company(
  id INT PRIMARY KEY AUTO_INCREMENT,
  orderCode VARCHAR(32),           #�������
  companyCode  VARCHAR(16),
  companyName VARCHAR(16),
  FOREIGN KEY(orderCode) REFERENCES uc_orders(orderNo)
);

/****������Ϣ****/
CREATE TABLE logistics_message(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  orderCode VARCHAR(32),
  provinceMessage VARCHAR(32),       #ʡ
  cityMessage VARCHAR(32),           #��
  countyMessage VARCHAR(32),         #��
  provinceTime VARCHAR(32),       
  cityTime VARCHAR(32),           
  countyTime VARCHAR(32),         
  FOREIGN KEY(orderCode) REFERENCES uc_orders(orderNo)
);


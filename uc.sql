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
  avatar VARCHAR(128),        #头像图片路径
  user_name VARCHAR(32),      #用户名，如王小明
  gender INT,                  #性别  0-女  1-男
  createTime VARCHAR(32),
  openID VARCHAR(32),
  privilegeLists VARCHAR(32)
);


/**商品信息**/
CREATE TABLE uc_goods(
  goodsSPU VARCHAR(32) PRIMARY KEY,
  title VARCHAR(32),
  mianTitle VARCHAR(32),
  describle VARCHAR(128),
  unit VARCHAR(32),
  brand VARCHAR(32),
 price VARCHAR(32)
);

/**商品图片信息**/
CREATE TABLE uc_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  picSPU VARCHAR(32),
  mainImage VARCHAR(128),
  detailsImage VARCHAR(128),
  FOREIGN KEY (picSPU) REFERENCES uc_goods(goodsSPU)
);

/**会员中心**/
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

/**订单信息**/
CREATE TABLE uc_orders(
  orderNo VARCHAR(32) PRIMARY KEY,
  status VARCHAR(10),                #状态
  receiver VARCHAR(16),       #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  fixedphone VARCHAR(16),     #固定电话
  postcode CHAR(6),           #邮编
  pushTime VARCHAR(16),            #下单时间
  pay_time BIGINT,        #付款时间
  remark VARCHAR(128),
  memberID VARCHAR(16),
  goodsCode VARCHAR(32),
  FOREIGN KEY(memberID) REFERENCES uc_member(delverID),
  FOREIGN KEY(goodsCode) REFERENCES uc_goods(goodsSPU)
);

/**物流公司信息**/
CREATE TABLE logistics_company(
  id INT PRIMARY KEY AUTO_INCREMENT,
  orderCode VARCHAR(32),           #订单编号
  companyCode  VARCHAR(16),
  companyName VARCHAR(16),
  FOREIGN KEY(orderCode) REFERENCES uc_orders(orderNo)
);

/****物流信息****/
CREATE TABLE logistics_message(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  orderCode VARCHAR(32),
  provinceMessage VARCHAR(32),       #省
  cityMessage VARCHAR(32),           #市
  countyMessage VARCHAR(32),         #县
  provinceTime VARCHAR(32),       
  cityTime VARCHAR(32),           
  countyTime VARCHAR(32),         
  FOREIGN KEY(orderCode) REFERENCES uc_orders(orderNo)
);


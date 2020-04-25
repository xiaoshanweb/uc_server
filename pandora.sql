-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2019-10-29 04:30:47
-- 服务器版本： 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pandora`
--

-- --------------------------------------------------------

--
-- 表的结构 `index_product`
--

CREATE TABLE `index_product` (
  `pid` int(11) NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `pic` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `index_product`
--

INSERT INTO `index_product` (`pid`, `title`, `price`, `pic`) VALUES
(1, '璀璨深蓝色串饰', '598.00', 'product1.jpg'),
(2, '神圣捕梦网', '726.00', 'product3.jpg'),
(3, '星海之辰', '398.00', 'product2.jpg'),
(4, '蓝色热气球串饰', '498.00', 'product4.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `product`
--

CREATE TABLE `product` (
  `pid` int(11) NOT NULL,
  `family_id` int(11) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `pic` varchar(128) DEFAULT NULL,
  `pic1` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `product`
--

INSERT INTO `product` (`pid`, `family_id`, `title`, `price`, `pic`, `pic1`) VALUES
(1, 1, '璀璨深蓝色串饰', '598.00', 'img/796358NTB-1.jpg', 'img/product1.jpg'),
(2, 1, '神圣捕梦网', '726.00', 'img/product3.jpg', 'img/product3.jpg'),
(3, 1, '月亮星空吊坠串饰', '398.00', 'img/791993CZ-1.jpg', 'img/791993CZ-2.jpg'),
(4, 1, '蓝色热气球串饰', '498.00', 'img/product4.jpg', 'img/product4.jpg'),
(5, 1, '爱心与蜂耳环', '598.00', 'img/267071-1.jpg', 'img/267071-2.jpg'),
(6, 1, '漫漫桃花串饰', '726.00', 'img/788079CZ-1.jpg', 'img/788099CZ-1.jpg'),
(7, 1, '璀璨抛光小串饰', '498.00', 'img/781388CZ-1.jpg', 'img/781388CZ-2.jpg'),
(8, 1, '小爱神吊饰', '498.00', 'img/767796CZ-1.jpg', 'img/767796CZ-1.jpg'),
(9, 2, '一生所爱', '3008.00', 'img/1-1.jpg', 'img/788079CZ-2.jpg'),
(10, 2, '醉人月夜', '1726.00', 'img/1-2.jpg', NULL),
(11, 2, '繁星童话', '398.00', 'img/1-3.jpg', NULL),
(12, 2, '爱意萌动', '498.00', 'img/2-1.jpg', NULL),
(13, 2, '斑斓之梦', '628.00', 'img/2-2.jpg', 'img/797200-1.jpg'),
(14, 2, '闪烁优雅', '1498.00', 'img/2-3.jpg', 'img/788079CZ-2.jpg'),
(15, 3, '花冠戒指', '898.00', 'img/167119CZ-1.jpg', 'img/167119CZ-2.jpg'),
(16, 3, '璀璨抛光心形开口戒指', '548.00', 'img/186570CZR-1.jpg', 'img/186570CZR-2.jpg'),
(17, 3, '璀璨泪滴形戒指', '548.00', 'img/196251CZ-1.jpg', 'img/196251CZ-2.jpg'),
(18, 3, '闪耀之箭戒指', '548.00', 'img/197830CZ-1.jpg', 'img/197830CZ-2.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `product_family`
--

CREATE TABLE `product_family` (
  `fid` int(11) NOT NULL,
  `name` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `product_family`
--

INSERT INTO `product_family` (`fid`, `name`) VALUES
(1, '串饰'),
(2, '人气'),
(3, '礼物');

-- --------------------------------------------------------

--
-- 表的结构 `product_pic`
--

CREATE TABLE `product_pic` (
  `pcid` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `sm` varchar(128) DEFAULT NULL,
  `md` varchar(128) DEFAULT NULL,
  `lg` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `product_pic`
--

INSERT INTO `product_pic` (`pcid`, `product_id`, `sm`, `md`, `lg`) VALUES
(1, 1, 'img/791725NMB_V2_RGB(1).JPG', 'img/791725NMB_V2_RGB(1).JPG', 'img/image_04.jpg'),
(2, 1, 'img/791725NMB_RGB(2).JPG', 'img/791725NMB_RGB(2).JPG', 'img/791725NMB_RGB(3).JPG'),
(3, 1, 'img/791725NMB_V3_RGB(1).JPG', 'img/791725NMB_V3_RGB(1).JPG', 'img/image_31.jpg'),
(4, 3, 'img/791993CZ_RGB.jpg', 'img/791993CZ-1.jpg', 'img/image_01(1).jpg'),
(5, 3, 'img/791993CZ_V2_RGB.jpg', 'img/791993CZ-2.jpg', 'img/image_15.jpg'),
(6, 3, 'img/791993CZ_V3_RGB.jpg', 'img/791993CZ_V3_RGB (1).jpg', 'img/image_26.jpg'),
(7, 3, 'img/791993CZ_V4_RGB.jpg', 'img/791993CZ_V4_RGB (1).jpg', 'img/791993CZ_V4_RGB (1).jpg'),
(8, 2, 'img/797200_V2_RGB.jpg', 'img/797200_V2_RGB (2).jpg', 'img/797200_V2_RGB (1).jpg'),
(9, 2, 'img/797200_RGB.jpg', 'img/797200_RGB (2).jpg', 'img/797200_RGB (1).jpg'),
(10, 2, 'img/797200_V4_RGB.jpg', 'img/797200_V4_RGB (2).jpg', 'img/797200_V4_RGB (1).jpg'),
(11, 4, 'img/798064NMB_RGB.jpg', 'img/798064NMB_V3_RGB (1).jpg', 'img/798064NMB_V3_RGB.jpg'),
(12, 4, 'img/798064NMB_ABC123_MODEL_ECOM_RGB.jpg', 'img/798064NMB_ABC123_MODEL_ECOM_RGB (3).jpg', 'img/798064NMB_ABC123_MODEL_ECOM_RGB (1).jpg');

-- --------------------------------------------------------

--
-- 表的结构 `shopping_cart`
--

CREATE TABLE `shopping_cart` (
  `Cpid` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `pic` varchar(128) DEFAULT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `shopping_cart`
--

INSERT INTO `shopping_cart` (`Cpid`, `pid`, `title`, `price`, `pic`, `count`) VALUES
(10, 4, '蓝色热气球串饰', '498.00', 'img/product4.jpg', 2),
(11, 3, '月亮星空吊坠串饰', '398.00', 'img/791993CZ-1.jpg', 2),
(12, 1, '璀璨深蓝色串饰', '598.00', 'img/796358NTB-1.jpg', 1);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `uid` int(11) NOT NULL,
  `uname` varchar(32) DEFAULT NULL,
  `upwd` varchar(32) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `user_name` varchar(32) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`uid`, `uname`, `upwd`, `email`, `phone`, `user_name`, `gender`) VALUES
(1, 'mary', '1234', '1234@qq.com', '12345678910', NULL, 0),
(3, '言希', '1234', '3124@qq.com', '34561278910', NULL, 1),
(4, '温衡', '3412', '3142@qq.com', '34560127891', NULL, 0),
(5, '小星星', '123456', '2253684014@qq.com', '15727628108', NULL, NULL),
(8, '蜡笔小新', '1234567', '9533684014@qq.com', '15727628108', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `index_product`
--
ALTER TABLE `index_product`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `family_id` (`family_id`);

--
-- Indexes for table `product_family`
--
ALTER TABLE `product_family`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `product_pic`
--
ALTER TABLE `product_pic`
  ADD PRIMARY KEY (`pcid`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD PRIMARY KEY (`Cpid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `index_product`
--
ALTER TABLE `index_product`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- 使用表AUTO_INCREMENT `product`
--
ALTER TABLE `product`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- 使用表AUTO_INCREMENT `product_family`
--
ALTER TABLE `product_family`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `product_pic`
--
ALTER TABLE `product_pic`
  MODIFY `pcid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- 使用表AUTO_INCREMENT `shopping_cart`
--
ALTER TABLE `shopping_cart`
  MODIFY `Cpid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- 限制导出的表
--

--
-- 限制表 `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`family_id`) REFERENCES `product_family` (`fid`);

--
-- 限制表 `product_pic`
--
ALTER TABLE `product_pic`
  ADD CONSTRAINT `product_pic_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`pid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

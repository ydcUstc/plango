-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2018-02-28 08:43:04
-- 服务器版本： 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u_lesson`
--

DELIMITER $$
--
-- 存储过程
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `lesson_allstudent_info` (IN `lessonId` VARCHAR(10))  select s.id,s_number,name,gender,e_mail,phone,interest
from students s,student_lesson sl,users u
where sl.lesson_id = lessonId 
and s.id = sl.student_id
and s.id = u.id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `assist_lesson`
--

CREATE TABLE `assist_lesson` (
  `lesson_id` varchar(10) NOT NULL,
  `assistant_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `files`
--

CREATE TABLE `files` (
  `file_path` varchar(8) NOT NULL,
  `lesson_id` varchar(10) NOT NULL,
  `file_name` text CHARACTER SET utf8 COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `identification`
--

CREATE TABLE `identification` (
  `e_mail` varchar(30) NOT NULL,
  `checkcode` varchar(6) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `informs`
--

CREATE TABLE `informs` (
  `id` int(10) NOT NULL,
  `lesson_id` varchar(10) NOT NULL,
  `time` date NOT NULL,
  `title` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `type` varchar(20) NOT NULL,
  `ddl_year` int(4) NOT NULL,
  `ddl_month` int(2) NOT NULL,
  `ddl_day` int(2) NOT NULL,
  `file_folder` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `lessons`
--

CREATE TABLE `lessons` (
  `id` varchar(10) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 NOT NULL,
  `founder_id` varchar(10) NOT NULL,
  `founding_date` date NOT NULL,
  `intro` text CHARACTER SET utf8,
  `responsible_person` text CHARACTER SET utf8 COLLATE utf8_bin,
  `email` varchar(50) DEFAULT NULL,
  `phone_num` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `student_lesson`
--

CREATE TABLE `student_lesson` (
  `lesson_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `id` varchar(10) NOT NULL,
  `e_mail` varchar(30) NOT NULL,
  `password` char(32) NOT NULL,
  `name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `stu_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `e_mail`, `password`, `name`, `stu_code`) VALUES
('000000', 'admin@admin.com', '21232f297a57a5a743894a0e4a801fc3', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assist_lesson`
--
ALTER TABLE `assist_lesson`
  ADD PRIMARY KEY (`lesson_id`,`assistant_id`);

--
-- Indexes for table `identification`
--
ALTER TABLE `identification`
  ADD PRIMARY KEY (`e_mail`,`checkcode`);

--
-- Indexes for table `informs`
--
ALTER TABLE `informs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_lesson`
--
ALTER TABLE `student_lesson`
  ADD PRIMARY KEY (`lesson_id`,`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `id_2` (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `informs`
--
ALTER TABLE `informs`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
DELIMITER $$
--
-- 事件
--
CREATE DEFINER=`root`@`localhost` EVENT `delete_expired_checkcode` ON SCHEDULE EVERY 5 MINUTE STARTS '2017-12-15 20:43:10' ON COMPLETION NOT PRESERVE ENABLE DO delete from identification where date < date_sub(CURRENT_TIMESTAMP(),INTERVAL 20 minute)$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

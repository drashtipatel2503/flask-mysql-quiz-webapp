-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2021 at 05:50 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `answer`
--

CREATE TABLE `answer` (
  `id` int(30) NOT NULL,
  `q1` varchar(255) NOT NULL,
  `q2` varchar(255) NOT NULL,
  `q3` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `answer`
--

INSERT INTO `answer` (`id`, `q1`, `q2`, `q3`) VALUES
(6, 'a', 'b', 'c');

-- --------------------------------------------------------

--
-- Table structure for table `answerr`
--

CREATE TABLE `answerr` (
  `qid` int(255) NOT NULL,
  `uid` int(255) NOT NULL,
  `ans` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `paper`
--

CREATE TABLE `paper` (
  `roomid` varchar(255) NOT NULL,
  `qid` varchar(255) NOT NULL,
  `ans` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `paper`
--

INSERT INTO `paper` (`roomid`, `qid`, `ans`) VALUES
('12345', '9', 'b'),
('12345', '10', 'c'),
('12345', '11', 'd'),
('123456', '12', 'b'),
('thisissciencetestmcq', '13', 'a'),
('thisissciencetestmcq', '14', 'c'),
('thisissciencetestmcq', '15', 'd'),
('12334', '16', 'c'),
('12334', '17', 'a'),
('12334', '18', 'a');

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `question` varchar(255) NOT NULL,
  `o1` varchar(255) NOT NULL,
  `o2` varchar(255) NOT NULL,
  `o3` varchar(255) NOT NULL,
  `o4` varchar(255) NOT NULL,
  `qid` int(255) NOT NULL,
  `ans` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`question`, `o1`, `o2`, `o3`, `o4`, `qid`, `ans`) VALUES
('where is taj mahal located', 'abd', 'agra', 'pune', 'surat', 9, 'b'),
('capital of India', 'abd', 'agra', 'delhi', 'surat', 10, 'c'),
('pink city in India', 'abd', 'agra', 'pune', 'jaipur', 11, 'd'),
('where is taj mahal located', 'abd', 'agra', 'delhi', 'surat', 12, 'b'),
('No. of protons in Hydrogen', '1', '2', '3', '4', 13, 'a'),
('Mass of oxygen element', '14', '15', '16', '17', 14, 'c'),
('Symbol for Iron metal', 'I', 'Ir', 'Fs', 'Fe', 15, 'd'),
('Mass of oxygen element', '14', '15', '16', '17', 16, 'c'),
('No. of protons in Hydrogen', '1', '2', '3', '4', 17, 'a'),
('Fe stands for', 'Iron', 'Fossil', 'Fellow', 'Alum', 18, 'a');

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--

CREATE TABLE `scores` (
  `roomid` int(255) NOT NULL,
  `userid` varchar(255) NOT NULL,
  `score` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `scores`
--

INSERT INTO `scores` (`roomid`, `userid`, `score`) VALUES
(12345, '20', 3),
(12345, '11@gmail.com', 1),
(123456, 'sad@asad.com', 1),
(0, 'stu@stu.com', 3),
(12334, 'stu1@stu1.com', 3),
(12334, 'stu2@stu2.com', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `type` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `password`, `type`) VALUES
(14, 'asd', 'asd@asd.com', 'asdasd', 0),
(15, 'jkl', 'jkl@jkl.com', 'jkljkl', 0),
(16, 'tyui', 'tyui@tyui.com', 'tyuityui', 0),
(17, 'hii', 'hii@hii.com', 'hiihii', 0),
(18, 'Drashti', 'mn@mn.com', 'mnmnmn', 0),
(19, 'Drashti', 'abc@abc.com', 'abcabc', 0),
(20, 'Drashti', 'abc1@abc.com', 'abc1abc', 0),
(21, '11', '11@gmail.com', '111111', 0),
(22, 'Drashti', 'sad@asad.com', 'sadasad', 0),
(23, 'ABS', 'stu@stu.com', 'stustu', 0),
(24, 'ASD', 'stu1@stu1.com', 'stu!', 0),
(25, 'ABC', 'stu2@stu2.com', 'stu2stu', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`qid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `qid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

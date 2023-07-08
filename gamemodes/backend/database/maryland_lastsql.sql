-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 08, 2023 at 03:04 PM
-- Server version: 10.6.12-MariaDB-0ubuntu0.22.04.1
-- PHP Version: 8.1.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `s9_maryland`
--

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE IF NOT EXISTS `houses` (
  `SQLID` int(11) NOT NULL AUTO_INCREMENT,
  `OwnerID` int(11) NOT NULL,
  `Address` varchar(35) NOT NULL DEFAULT 'Nema',
  `Price` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `PosA` float NOT NULL,
  `IntX` float NOT NULL,
  `IntY` float NOT NULL,
  `IntZ` float NOT NULL,
  `IntA` float NOT NULL,
  `InteriorID` int(11) NOT NULL,
  `InteriorVw` int(11) NOT NULL,
  `ExteriorInt` int(11) NOT NULL,
  `ExteriorVw` int(11) NOT NULL,
  `Locked` tinyint(1) NOT NULL,
  PRIMARY KEY (`SQLID`),
  UNIQUE KEY `OwnerID` (`OwnerID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`SQLID`, `OwnerID`, `Address`, `Price`, `Type`, `PosX`, `PosY`, `PosZ`, `PosA`, `IntX`, `IntY`, `IntZ`, `IntA`, `InteriorID`, `InteriorVw`, `ExteriorInt`, `ExteriorVw`, `Locked`) VALUES
(1, 1, 'Nema', 527, 2, 1540.27, -2292.97, 13.5469, 109.928, 2317.9, -1025.77, 1050.21, 90, 9, 0, 0, 0, 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

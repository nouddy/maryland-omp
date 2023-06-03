-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2023 at 11:08 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `maryland`
--

-- --------------------------------------------------------

--
-- Table structure for table `faction_police`
--

CREATE TABLE `faction_police` (
  `fPoliceID` int(11) NOT NULL,
  `fPoliceName` varchar(60) CHARACTER SET utf32 COLLATE utf32_general_ci DEFAULT 'Nema',
  `fPoliceShortName` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Nema',
  `fPoliceAdress` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0,Maryland',
  `fPoliceBoss` int(11) NOT NULL DEFAULT 0,
  `fPoliceType` int(11) NOT NULL DEFAULT 0,
  `fPoliceX` float NOT NULL DEFAULT 0,
  `fPoliceY` float NOT NULL DEFAULT 0,
  `fPoliceZ` float NOT NULL DEFAULT 0,
  `fPoliceA` float NOT NULL DEFAULT 0,
  `fPoliceInteriorX` float NOT NULL DEFAULT 0,
  `fPoliceInteriorY` float NOT NULL DEFAULT 0,
  `fPoliceInteriorZ` float NOT NULL DEFAULT 0,
  `fPoliceInteriorA` float NOT NULL DEFAULT 0,
  `fPoliceInt` int(11) NOT NULL DEFAULT 0,
  `fPoliceExt` int(11) NOT NULL DEFAULT 0,
  `fPoliceExtVW` int(11) NOT NULL DEFAULT 0,
  `fPoliceLocked` tinyint(1) NOT NULL DEFAULT 0,
  `fPoliceVault` int(11) NOT NULL DEFAULT 0,
  `fPoliceRank1` varchar(32) NOT NULL DEFAULT 'Nema',
  `fPoliceRank2` varchar(32) NOT NULL DEFAULT 'Nema',
  `fPoliceRank3` varchar(32) NOT NULL DEFAULT 'Nema',
  `fPoliceSkins1` int(11) NOT NULL,
  `fPoliceSkins2` int(11) NOT NULL,
  `fPoliceSkins3` int(11) NOT NULL,
  `fPoliceSkins4` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faction_police`
--

INSERT INTO `faction_police` (`fPoliceID`, `fPoliceName`, `fPoliceShortName`, `fPoliceAdress`, `fPoliceBoss`, `fPoliceType`, `fPoliceX`, `fPoliceY`, `fPoliceZ`, `fPoliceA`, `fPoliceInteriorX`, `fPoliceInteriorY`, `fPoliceInteriorZ`, `fPoliceInteriorA`, `fPoliceInt`, `fPoliceExt`, `fPoliceExtVW`, `fPoliceLocked`, `fPoliceVault`, `fPoliceRank1`, `fPoliceRank2`, `fPoliceRank3`, `fPoliceSkins1`, `fPoliceSkins2`, `fPoliceSkins3`, `fPoliceSkins4`) VALUES
(1, 'Maryland Police', 'MLPD', '0,Maryland Centar', 1, 0, 1553.85, -1675.54, 16.1953, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nema', 'Nema', 'Nema', 0, 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `faction_police`
--
ALTER TABLE `faction_police`
  ADD PRIMARY KEY (`fPoliceID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `faction_police`
--
ALTER TABLE `faction_police`
  MODIFY `fPoliceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

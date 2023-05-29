-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2023 at 02:01 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `insanity`
--

-- --------------------------------------------------------

--
-- Table structure for table `banned`
--

CREATE TABLE `banned` (
  `BannedUserID` int(11) NOT NULL,
  `BannedUser` varchar(50) NOT NULL DEFAULT 'Niko',
  `BannedReason` varchar(50) NOT NULL DEFAULT 'Proseravanje',
  `BannedAdmin` varchar(50) NOT NULL DEFAULT 'Niko',
  `BannedIP` varchar(50) NOT NULL DEFAULT '0.0.0.0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_crypto`
--

CREATE TABLE `player_crypto` (
  `player_id` int(11) NOT NULL,
  `KolicinaBTC` float NOT NULL,
  `KolicinaETH` float NOT NULL,
  `KolicinaLTC` float NOT NULL,
  `KolicinaUSDT` float NOT NULL,
  `KolicinaDOT` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_crypto`
--

INSERT INTO `player_crypto` (`player_id`, `KolicinaBTC`, `KolicinaETH`, `KolicinaLTC`, `KolicinaUSDT`, `KolicinaDOT`) VALUES
(0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_utakmice`
--

CREATE TABLE `player_utakmice` (
  `sqlid` int(11) NOT NULL,
  `parid_1` int(11) NOT NULL DEFAULT -1,
  `parid_2` int(11) NOT NULL DEFAULT -1,
  `parid_3` int(11) NOT NULL DEFAULT -1,
  `parid_4` int(11) NOT NULL DEFAULT -1,
  `parid_5` int(11) NOT NULL DEFAULT -1,
  `Uplaceno` tinyint(1) NOT NULL DEFAULT 0,
  `Zavrseno` tinyint(1) NOT NULL DEFAULT 0,
  `StatusTiketa` tinyint(1) NOT NULL DEFAULT 0,
  `Dobitak` float NOT NULL,
  `Uplata` int(11) NOT NULL DEFAULT 0,
  `Kvota` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `safezones`
--

CREATE TABLE `safezones` (
  `safeSQLID` int(11) NOT NULL,
  `MinX` float NOT NULL,
  `MinY` float NOT NULL,
  `MaxX` float NOT NULL,
  `MaxY` float NOT NULL,
  `Radius` float NOT NULL,
  `Color` int(11) NOT NULL,
  `PickupX` float NOT NULL,
  `PickupY` float NOT NULL,
  `PickupZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `safezones`
--

INSERT INTO `safezones` (`safeSQLID`, `MinX`, `MinY`, `MaxX`, `MaxY`, `Radius`, `Color`, `PickupX`, `PickupY`, `PickupZ`) VALUES
(1, 1113.82, -1755.55, 1166.94, -1729.48, 30, 8840191, 1136.89, -1739.09, 13.4703);

-- --------------------------------------------------------

--
-- Table structure for table `server_settings`
--

CREATE TABLE `server_settings` (
  `ID` int(11) NOT NULL DEFAULT 0,
  `PoseteServera` int(11) NOT NULL DEFAULT 0,
  `Registrovanih` int(11) NOT NULL DEFAULT 0,
  `Banovanih` int(11) NOT NULL DEFAULT 0,
  `Kickovanih` int(11) NOT NULL DEFAULT 0,
  `Registracija` tinyint(1) NOT NULL DEFAULT 1,
  `Report` tinyint(1) NOT NULL DEFAULT 1,
  `Rekord` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `server_settings`
--

INSERT INTO `server_settings` (`ID`, `PoseteServera`, `Registrovanih`, `Banovanih`, `Kickovanih`, `Registracija`, `Report`, `Rekord`) VALUES
(0, 15, 0, 0, 3, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `SQLID` int(11) NOT NULL,
  `Ime_Prezime` varchar(26) NOT NULL DEFAULT 'Niko',
  `Novac` int(11) NOT NULL DEFAULT -1,
  `Lozinka` varchar(255) NOT NULL,
  `Registrovan` int(11) NOT NULL DEFAULT -1,
  `BankaNovac` int(11) NOT NULL DEFAULT -1,
  `IP` varchar(70) NOT NULL,
  `Skin` int(11) NOT NULL DEFAULT -1,
  `Pol` int(11) NOT NULL DEFAULT -1,
  `Drzava` varchar(30) NOT NULL DEFAULT 'Drzava',
  `LastSeen` varchar(70) NOT NULL DEFAULT '00/00:/00 00:00',
  `LoginDatum` varchar(70) NOT NULL DEFAULT '00/00:/00 00:00',
  `Admin` int(11) NOT NULL DEFAULT -1,
  `Godine` int(11) NOT NULL DEFAULT -1,
  `EmailAdresa` varchar(50) NOT NULL,
  `Level` int(11) NOT NULL DEFAULT -1,
  `AdminCode` int(11) NOT NULL DEFAULT -1,
  `SRank` smallint(6) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`SQLID`, `Ime_Prezime`, `Novac`, `Lozinka`, `Registrovan`, `BankaNovac`, `IP`, `Skin`, `Pol`, `Drzava`, `LastSeen`, `LoginDatum`, `Admin`, `Godine`, `EmailAdresa`, `Level`, `AdminCode`, `SRank`) VALUES
(1, 'ogy', 3231, 'D75CA686E1CD8E9D11E56EF1FB6DB6717DD52680D66D2A62860011A408469CE5', 1, -1, '', 29, 1, 'Drzava', '29/05/2023 - 13:36', '11/02/2023 - 01:54', 6, 19, 'dsasd@gmail.com', 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `utakmice`
--

CREATE TABLE `utakmice` (
  `utakmica_id` int(11) NOT NULL,
  `utakmica_domacin` varchar(40) NOT NULL DEFAULT 'Nema',
  `utakmica_gost` varchar(40) NOT NULL DEFAULT 'Nema',
  `utakmica_kvota1` float NOT NULL,
  `utakmica_kvotax` float NOT NULL,
  `utakmica_kvota2` float NOT NULL,
  `utakmica_2plus` float NOT NULL,
  `utakmica_3plus` float NOT NULL,
  `utakmica_vreme` varchar(40) NOT NULL DEFAULT '12-12-1212 12:00',
  `utakmica_uplata` tinyint(1) NOT NULL DEFAULT 0,
  `utakmica_rezultat` varchar(40) NOT NULL DEFAULT '6:0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `player_crypto`
--
ALTER TABLE `player_crypto`
  ADD PRIMARY KEY (`player_id`);

--
-- Indexes for table `player_utakmice`
--
ALTER TABLE `player_utakmice`
  ADD UNIQUE KEY `sqlid` (`sqlid`);

--
-- Indexes for table `safezones`
--
ALTER TABLE `safezones`
  ADD PRIMARY KEY (`safeSQLID`);

--
-- Indexes for table `server_settings`
--
ALTER TABLE `server_settings`
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`SQLID`);

--
-- Indexes for table `utakmice`
--
ALTER TABLE `utakmice`
  ADD PRIMARY KEY (`utakmica_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `safezones`
--
ALTER TABLE `safezones`
  MODIFY `safeSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `SQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `utakmice`
--
ALTER TABLE `utakmice`
  MODIFY `utakmica_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2023 at 09:45 PM
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
CREATE DATABASE IF NOT EXISTS `maryland` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `maryland`;

-- --------------------------------------------------------

--
-- Table structure for table `bankers`
--

DROP TABLE IF EXISTS `bankers`;
CREATE TABLE IF NOT EXISTS `bankers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Skin` smallint(3) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `PosA` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

DROP TABLE IF EXISTS `bank_accounts`;
CREATE TABLE IF NOT EXISTS `bank_accounts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Owner` varchar(24) NOT NULL,
  `Password` varchar(32) NOT NULL,
  `Balance` int(11) NOT NULL,
  `CreatedOn` int(11) NOT NULL,
  `LastAccess` int(11) NOT NULL,
  `Disabled` smallint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_atms`
--

DROP TABLE IF EXISTS `bank_atms`;
CREATE TABLE IF NOT EXISTS `bank_atms` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `RotX` float NOT NULL,
  `RotY` float NOT NULL,
  `RotZ` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_logs`
--

DROP TABLE IF EXISTS `bank_logs`;
CREATE TABLE IF NOT EXISTS `bank_logs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AccountID` int(11) NOT NULL,
  `ToAccountID` int(11) NOT NULL DEFAULT -1,
  `Type` smallint(1) NOT NULL,
  `Player` varchar(24) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Date` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `bank_logs_ibfk_1` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `businesses`
--

DROP TABLE IF EXISTS `businesses`;
CREATE TABLE IF NOT EXISTS `businesses` (
  `bizID` int(11) NOT NULL,
  `bizName` varchar(32) NOT NULL DEFAULT 'Nema',
  `bizOpis` varchar(128) NOT NULL DEFAULT 'Nema',
  `bizAddress` varchar(35) NOT NULL DEFAULT 'Nepoznata',
  `bizOwner` int(11) NOT NULL,
  `bizType` int(11) NOT NULL DEFAULT 0,
  `bizPosX` float NOT NULL DEFAULT 0,
  `bizPosY` float NOT NULL DEFAULT 0,
  `bizPosZ` float NOT NULL DEFAULT 0,
  `bizPosA` float NOT NULL DEFAULT 0,
  `bizIntX` float NOT NULL DEFAULT 0,
  `bizIntY` float NOT NULL DEFAULT 0,
  `bizIntZ` float NOT NULL DEFAULT 0,
  `bizIntA` float NOT NULL DEFAULT 0,
  `bizInterior` int(11) NOT NULL,
  `bizExterior` int(11) NOT NULL,
  `bizExteriorVW` int(11) NOT NULL,
  `bizLocked` tinyint(1) NOT NULL DEFAULT 0,
  `bizVault` int(11) NOT NULL DEFAULT 0,
  `bizProducts` int(11) NOT NULL,
  `bizInvestor` int(11) NOT NULL,
  PRIMARY KEY (`bizID`),
  UNIQUE KEY `bizOwner` (`bizOwner`),
  UNIQUE KEY `bizInvestor` (`bizInvestor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

DROP TABLE IF EXISTS `cars`;
CREATE TABLE IF NOT EXISTS `cars` (
  `carID` int(12) NOT NULL AUTO_INCREMENT,
  `carModel` int(12) DEFAULT 0,
  `carOwner` int(12) DEFAULT 0,
  `carPosX` float DEFAULT 0,
  `carPosY` float DEFAULT 0,
  `carPosZ` float DEFAULT 0,
  `carPosR` float DEFAULT 0,
  `carColor1` int(12) DEFAULT 0,
  `carColor2` int(12) DEFAULT 0,
  `carPaintjob` int(12) DEFAULT -1,
  `carLocked` int(4) DEFAULT 0,
  `carMod1` int(12) DEFAULT 0,
  `carMod2` int(12) DEFAULT 0,
  `carMod3` int(12) DEFAULT 0,
  `carMod4` int(12) DEFAULT 0,
  `carMod5` int(12) DEFAULT 0,
  `carMod6` int(12) DEFAULT 0,
  `carMod7` int(12) DEFAULT 0,
  `carMod8` int(12) DEFAULT 0,
  `carMod9` int(12) DEFAULT 0,
  `carMod10` int(12) DEFAULT 0,
  `carMod11` int(12) DEFAULT 0,
  `carMod12` int(12) DEFAULT 0,
  `carMod13` int(12) DEFAULT 0,
  `carMod14` int(12) DEFAULT 0,
  `carImpounded` int(12) DEFAULT 0,
  `carWeapon1` int(12) DEFAULT 0,
  `carAmmo1` int(12) DEFAULT 0,
  `carWeapon2` int(12) DEFAULT 0,
  `carAmmo2` int(12) DEFAULT 0,
  `carWeapon3` int(12) DEFAULT 0,
  `carAmmo3` int(12) DEFAULT 0,
  `carWeapon4` int(12) DEFAULT 0,
  `carAmmo4` int(12) DEFAULT 0,
  `carWeapon5` int(12) DEFAULT 0,
  `carAmmo5` int(12) DEFAULT 0,
  `carImpoundPrice` int(12) DEFAULT 0,
  `carFaction` int(12) DEFAULT 0,
  PRIMARY KEY (`carID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faction_police`
--

DROP TABLE IF EXISTS `faction_police`;
CREATE TABLE IF NOT EXISTS `faction_police` (
  `fPoliceID` int(11) NOT NULL,
  `fPoliceName` varchar(60) NOT NULL DEFAULT 'Police',
  `fPoliceShortName` varchar(30) NOT NULL DEFAULT 'PD',
  `fPoliceAdress` varchar(35) NOT NULL DEFAULT 'Nepoznata',
  `fPoliceBoss` int(11) NOT NULL,
  `fPoliceType` int(11) NOT NULL DEFAULT 0,
  `fPoliceX` float NOT NULL DEFAULT 0,
  `fPoliceY` float NOT NULL DEFAULT 0,
  `fPoliceZ` float NOT NULL DEFAULT 0,
  `fPoliceA` float NOT NULL DEFAULT 0,
  `fPoliceInteriorX` float NOT NULL DEFAULT 0,
  `fPoliceInteriorY` float NOT NULL DEFAULT 0,
  `fPoliceInteriorZ` float NOT NULL DEFAULT 0,
  `fPoliceInteriorA` float NOT NULL DEFAULT 0,
  `fPoliceInt` int(11) NOT NULL,
  `fPoliceExt` int(11) NOT NULL,
  `fPoliceExtVW` int(11) NOT NULL,
  `fPoliceLocked` tinyint(1) NOT NULL DEFAULT 0,
  `fPoliceVault` int(11) NOT NULL DEFAULT 0,
  `fPoliceRank1` varchar(32) NOT NULL DEFAULT 'Rank',
  `fPoliceRank2` varchar(32) NOT NULL DEFAULT 'Rank',
  `fPoliceRank3` varchar(32) NOT NULL DEFAULT 'Rank',
  `fPoliceSkins1` int(11) NOT NULL,
  `fPoliceSkins2` int(11) NOT NULL,
  `fPoliceSkins3` int(11) NOT NULL,
  `fPoliceSkins4` int(11) NOT NULL,
  PRIMARY KEY (`fPoliceID`),
  UNIQUE KEY `fPoliceBoss` (`fPoliceBoss`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

DROP TABLE IF EXISTS `houses`;
CREATE TABLE IF NOT EXISTS `houses` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Address` varchar(35) DEFAULT '0,Los Santos',
  `Description` varchar(128) DEFAULT 'House',
  `Owner` varchar(25) DEFAULT 'The State',
  `Owned` tinyint(1) DEFAULT 0,
  `Locked` tinyint(1) DEFAULT 0,
  `Price` int(11) DEFAULT 0,
  `InteriorE` int(11) DEFAULT 0,
  `InteriorI` int(11) NOT NULL DEFAULT 0,
  `ExteriorX` float DEFAULT 0,
  `ExteriorY` float DEFAULT 0,
  `ExteriorZ` float DEFAULT 0,
  `InteriorX` float DEFAULT 0,
  `InteriorY` float DEFAULT 0,
  `InteriorZ` float DEFAULT 0,
  `Custom_Interior` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `klupe`
--

DROP TABLE IF EXISTS `klupe`;
CREATE TABLE IF NOT EXISTS `klupe` (
  `seat_ID` int(11) NOT NULL AUTO_INCREMENT,
  `seat_x` float NOT NULL,
  `seat_y` float NOT NULL,
  `seat_z` float NOT NULL,
  `seat_a` float NOT NULL,
  PRIMARY KEY (`seat_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
CREATE TABLE IF NOT EXISTS `players` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(25) NOT NULL DEFAULT 'Ime_Prezime',
  `Password` int(11) NOT NULL,
  `Level` int(11) NOT NULL DEFAULT 1,
  `Novac` int(11) NOT NULL DEFAULT 2000,
  `Skin` int(11) NOT NULL DEFAULT 29,
  `Godine` int(11) NOT NULL,
  `Staff` int(11) NOT NULL DEFAULT 0,
  `LastLogin` varchar(50) NOT NULL DEFAULT 'NEMA',
  `RegisterDate` varchar(50) NOT NULL DEFAULT 'NEMA',
  `Drzava` varchar(50) NOT NULL DEFAULT 'Srbija',
  `Pol` varchar(10) NOT NULL DEFAULT 'Nema',
  `Email` varchar(50) NOT NULL DEFAULT '@gmail.com',
  `Objekat0` tinyint(4) NOT NULL DEFAULT -1,
  `Objekat1` tinyint(4) NOT NULL DEFAULT -1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`ID`, `Username`, `Password`, `Level`, `Novac`, `Skin`, `Godine`, `Staff`, `LastLogin`, `RegisterDate`, `Drzava`, `Pol`, `Email`, `Objekat0`, `Objekat1`) VALUES
(1, 'Vostic', 297206591, 1, 200250, 2, 21, 4, '14/06/2023 - 17:59', 'NEMA', 'Srbija', '0', '@gmail.com', -1, -1),
(3, 'Ogy_', 252642079, 1, 38400, 289, 19, 4, '06/06/2023 - 15:57', '17/05/2023 - 19:57', 'Srbija', '0', '@gmail.com', -1, -1);

-- --------------------------------------------------------

--
-- Table structure for table `player_crypto`
--

DROP TABLE IF EXISTS `player_crypto`;
CREATE TABLE IF NOT EXISTS `player_crypto` (
  `crypto_id` int(11) NOT NULL,
  `KolicinaBTC` float DEFAULT NULL,
  `KolicinaETH` float DEFAULT NULL,
  `KolicinaLTC` float DEFAULT NULL,
  `KolicinaUSDT` float DEFAULT NULL,
  `KolicinaDOT` float DEFAULT NULL,
  UNIQUE KEY `crypto_id` (`crypto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_crypto`
--

INSERT INTO `player_crypto` (`crypto_id`, `KolicinaBTC`, `KolicinaETH`, `KolicinaLTC`, `KolicinaUSDT`, `KolicinaDOT`) VALUES
(1, 0, 0, 0, 0, 0),
(3, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_documents`
--

DROP TABLE IF EXISTS `player_documents`;
CREATE TABLE IF NOT EXISTS `player_documents` (
  `player_id` int(11) NOT NULL,
  `NationalID` int(11) NOT NULL,
  `Passport` int(11) NOT NULL,
  `VoziloLicence` int(11) NOT NULL,
  `MotoLicence` int(11) NOT NULL,
  `BrodLicence` int(11) NOT NULL,
  `OruzjeLicence` int(11) NOT NULL,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_documents`
--

INSERT INTO `player_documents` (`player_id`, `NationalID`, `Passport`, `VoziloLicence`, `MotoLicence`, `BrodLicence`, `OruzjeLicence`) VALUES
(1, 1, 1, 0, 0, 0, 0),
(3, 1, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_electronic`
--

DROP TABLE IF EXISTS `player_electronic`;
CREATE TABLE IF NOT EXISTS `player_electronic` (
  `player_id` int(11) NOT NULL,
  `Dron` tinyint(4) NOT NULL DEFAULT 0,
  `Baterije` int(11) NOT NULL DEFAULT 0,
  `Navigacija` tinyint(4) NOT NULL DEFAULT 0,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_finance`
--

DROP TABLE IF EXISTS `player_finance`;
CREATE TABLE IF NOT EXISTS `player_finance` (
  `finance_id` int(11) NOT NULL,
  `BankAccount` tinyint(4) NOT NULL DEFAULT 0,
  `BankMoney` int(11) NOT NULL DEFAULT 0,
  `BankPin` mediumint(9) NOT NULL DEFAULT 0,
  UNIQUE KEY `finance_id` (`finance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_finance`
--

INSERT INTO `player_finance` (`finance_id`, `BankAccount`, `BankMoney`, `BankPin`) VALUES
(1, 0, 0, 0),
(3, 0, 0, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bank_logs`
--
ALTER TABLE `bank_logs`
  ADD CONSTRAINT `bank_logs_ibfk_1` FOREIGN KEY (`AccountID`) REFERENCES `bank_accounts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

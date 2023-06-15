-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2023 at 07:21 PM
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
-- Database: `maryland`
--
CREATE DATABASE IF NOT EXISTS `maryland` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `maryland`;

-- --------------------------------------------------------

--
-- Table structure for table `bankers`
--
-- Creation: Jun 15, 2023 at 05:19 PM
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

--
-- RELATIONSHIPS FOR TABLE `bankers`:
--

--
-- Truncate table before insert `bankers`
--

TRUNCATE TABLE `bankers`;
-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--
-- Creation: Jun 06, 2023 at 01:10 PM
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

--
-- RELATIONSHIPS FOR TABLE `bank_accounts`:
--

--
-- Truncate table before insert `bank_accounts`
--

TRUNCATE TABLE `bank_accounts`;
-- --------------------------------------------------------

--
-- Table structure for table `bank_atms`
--
-- Creation: Jun 15, 2023 at 05:19 PM
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

--
-- RELATIONSHIPS FOR TABLE `bank_atms`:
--

--
-- Truncate table before insert `bank_atms`
--

TRUNCATE TABLE `bank_atms`;
-- --------------------------------------------------------

--
-- Table structure for table `bank_logs`
--
-- Creation: Jun 15, 2023 at 05:19 PM
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

--
-- RELATIONSHIPS FOR TABLE `bank_logs`:
--   `AccountID`
--       `bank_accounts` -> `ID`
--

--
-- Truncate table before insert `bank_logs`
--

TRUNCATE TABLE `bank_logs`;
-- --------------------------------------------------------

--
-- Table structure for table `businesses`
--
-- Creation: Jun 15, 2023 at 05:19 PM
--

DROP TABLE IF EXISTS `businesses`;
CREATE TABLE IF NOT EXISTS `businesses` (
  `bizID` int(12) NOT NULL AUTO_INCREMENT,
  `bizName` varchar(32) DEFAULT NULL,
  `bizOwner` int(12) DEFAULT 0,
  `bizType` int(12) DEFAULT 0,
  `bizPrice` int(12) DEFAULT 0,
  `bizPosX` float DEFAULT 0,
  `bizPosY` float DEFAULT 0,
  `bizPosZ` float DEFAULT 0,
  `bizPosA` float DEFAULT 0,
  `bizIntX` float DEFAULT 0,
  `bizIntY` float DEFAULT 0,
  `bizIntZ` float DEFAULT 0,
  `bizIntA` float DEFAULT 0,
  `bizInterior` int(12) DEFAULT 0,
  `bizExterior` int(12) DEFAULT 0,
  `bizExteriorVW` int(12) DEFAULT 0,
  `bizLocked` int(4) DEFAULT 0,
  `bizVault` int(12) DEFAULT 0,
  `bizProducts` int(12) DEFAULT 0,
  `bizPrice1` int(12) DEFAULT 0,
  `bizPrice2` int(12) DEFAULT 0,
  `bizPrice3` int(12) DEFAULT 0,
  `bizPrice4` int(12) DEFAULT 0,
  `bizPrice5` int(12) DEFAULT 0,
  `bizPrice6` int(12) DEFAULT 0,
  `bizPrice7` int(12) DEFAULT 0,
  `bizPrice8` int(12) DEFAULT 0,
  `bizPrice9` int(12) DEFAULT 0,
  `bizPrice10` int(12) DEFAULT 0,
  `bizSpawnX` float DEFAULT 0,
  `bizSpawnY` float DEFAULT 0,
  `bizSpawnZ` float DEFAULT 0,
  `bizSpawnA` float DEFAULT 0,
  `bizDeliverX` float DEFAULT 0,
  `bizDeliverY` float DEFAULT 0,
  `bizDeliverZ` float DEFAULT 0,
  `bizMessage` varchar(128) DEFAULT NULL,
  `bizPrice11` int(12) DEFAULT 0,
  `bizPrice12` int(12) DEFAULT 0,
  `bizPrice13` int(12) DEFAULT 0,
  `bizPrice14` int(12) DEFAULT 0,
  `bizPrice15` int(12) DEFAULT 0,
  `bizPrice16` int(12) DEFAULT 0,
  `bizPrice17` int(12) DEFAULT 0,
  `bizPrice18` int(12) DEFAULT 0,
  `bizPrice19` int(12) DEFAULT 0,
  `bizPrice20` int(12) DEFAULT 0,
  `bizShipment` int(4) DEFAULT 0,
  PRIMARY KEY (`bizID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `businesses`:
--

--
-- Truncate table before insert `businesses`
--

TRUNCATE TABLE `businesses`;
-- --------------------------------------------------------

--
-- Table structure for table `cars`
--
-- Creation: Jun 15, 2023 at 05:19 PM
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

--
-- RELATIONSHIPS FOR TABLE `cars`:
--

--
-- Truncate table before insert `cars`
--

TRUNCATE TABLE `cars`;
-- --------------------------------------------------------

--
-- Table structure for table `faction_police`
--
-- Creation: Jun 15, 2023 at 05:19 PM
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

--
-- RELATIONSHIPS FOR TABLE `faction_police`:
--

--
-- Truncate table before insert `faction_police`
--

TRUNCATE TABLE `faction_police`;
-- --------------------------------------------------------

--
-- Table structure for table `houses`
--
-- Creation: Jun 15, 2023 at 05:19 PM
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

--
-- RELATIONSHIPS FOR TABLE `houses`:
--

--
-- Truncate table before insert `houses`
--

TRUNCATE TABLE `houses`;
-- --------------------------------------------------------

--
-- Table structure for table `klupe`
--
-- Creation: Jun 15, 2023 at 05:19 PM
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

--
-- RELATIONSHIPS FOR TABLE `klupe`:
--

--
-- Truncate table before insert `klupe`
--

TRUNCATE TABLE `klupe`;
-- --------------------------------------------------------

--
-- Table structure for table `players`
--
-- Creation: Jun 15, 2023 at 05:19 PM
-- Last update: Jun 15, 2023 at 05:19 PM
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
-- RELATIONSHIPS FOR TABLE `players`:
--

--
-- Truncate table before insert `players`
--

TRUNCATE TABLE `players`;
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
-- Creation: Jun 15, 2023 at 05:19 PM
-- Last update: Jun 15, 2023 at 05:19 PM
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
-- RELATIONSHIPS FOR TABLE `player_crypto`:
--

--
-- Truncate table before insert `player_crypto`
--

TRUNCATE TABLE `player_crypto`;
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
-- Creation: Jun 15, 2023 at 05:19 PM
-- Last update: Jun 15, 2023 at 05:19 PM
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
-- RELATIONSHIPS FOR TABLE `player_documents`:
--

--
-- Truncate table before insert `player_documents`
--

TRUNCATE TABLE `player_documents`;
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
-- Creation: Jun 15, 2023 at 05:19 PM
--

DROP TABLE IF EXISTS `player_electronic`;
CREATE TABLE IF NOT EXISTS `player_electronic` (
  `player_id` int(11) NOT NULL,
  `Dron` tinyint(4) NOT NULL DEFAULT 0,
  `Baterije` int(11) NOT NULL DEFAULT 0,
  `Navigacija` tinyint(4) NOT NULL DEFAULT 0,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `player_electronic`:
--

--
-- Truncate table before insert `player_electronic`
--

TRUNCATE TABLE `player_electronic`;
-- --------------------------------------------------------

--
-- Table structure for table `player_finance`
--
-- Creation: Jun 15, 2023 at 05:19 PM
-- Last update: Jun 15, 2023 at 05:19 PM
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
-- RELATIONSHIPS FOR TABLE `player_finance`:
--

--
-- Truncate table before insert `player_finance`
--

TRUNCATE TABLE `player_finance`;
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

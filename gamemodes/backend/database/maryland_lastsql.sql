-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 12, 2023 at 09:13 AM
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
CREATE DATABASE IF NOT EXISTS `maryland` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `maryland`;

-- --------------------------------------------------------

--
-- Table structure for table `bankers`
--

CREATE TABLE IF NOT EXISTS `bankers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Skin` smallint(3) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `PosA` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

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

CREATE TABLE IF NOT EXISTS `bank_atms` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `RotX` float NOT NULL,
  `RotY` float NOT NULL,
  `RotZ` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_logs`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`carID`, `carModel`, `carOwner`, `carPosX`, `carPosY`, `carPosZ`, `carPosR`, `carColor1`, `carColor2`, `carPaintjob`, `carLocked`, `carMod1`, `carMod2`, `carMod3`, `carMod4`, `carMod5`, `carMod6`, `carMod7`, `carMod8`, `carMod9`, `carMod10`, `carMod11`, `carMod12`, `carMod13`, `carMod14`, `carImpounded`, `carWeapon1`, `carAmmo1`, `carWeapon2`, `carAmmo2`, `carWeapon3`, `carAmmo3`, `carWeapon4`, `carAmmo4`, `carWeapon5`, `carAmmo5`, `carImpoundPrice`, `carFaction`) VALUES
(1, 522, 0, 1554.64, -2322.25, 13.542, 163.885, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `faction_police`
--

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

CREATE TABLE IF NOT EXISTS `houses` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PID` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `Adress` varchar(50) NOT NULL,
  `Locked` tinyint(1) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `Safe` tinyint(1) NOT NULL,
  `Money` int(11) NOT NULL,
  `Weed` int(11) NOT NULL,
  `Cocaine` int(11) NOT NULL,
  `Extazy` int(11) NOT NULL,
  `WardX` float NOT NULL,
  `WardY` float NOT NULL,
  `WardZ` float NOT NULL,
  `FridgeX` float NOT NULL,
  `FridgeY` float NOT NULL,
  `FridgeZ` float NOT NULL,
  `Int` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PID` (`PID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`ID`, `PID`, `Price`, `Type`, `Adress`, `Locked`, `PosX`, `PosY`, `PosZ`, `ExitX`, `ExitY`, `ExitZ`, `Safe`, `Money`, `Weed`, `Cocaine`, `Extazy`, `WardX`, `WardY`, `WardZ`, `FridgeX`, `FridgeY`, `FridgeZ`, `Int`) VALUES
(2, 1, 50000, 1, 'Market, Maryland', 0, 830.025, -1331.26, 13.3969, 224.28, 1289.19, 1082.14, 0, 0, 0, 0, 0, 224.28, 1289.19, 1082.14, 224.28, 1289.19, 1082.14, 1);

-- --------------------------------------------------------

--
-- Table structure for table `klupe`
--

CREATE TABLE IF NOT EXISTS `klupe` (
  `seat_ID` int(11) NOT NULL AUTO_INCREMENT,
  `seat_x` float NOT NULL,
  `seat_y` float NOT NULL,
  `seat_z` float NOT NULL,
  `seat_a` float NOT NULL,
  PRIMARY KEY (`seat_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `klupe`
--

INSERT INTO `klupe` (`seat_ID`, `seat_x`, `seat_y`, `seat_z`, `seat_a`) VALUES
(1, 1204.19, -907.003, 42.8876, 169.787),
(3, 1468.92, -1748.95, 13.5669, 274.739),
(4, 1925.46, -1200.3, 20.0235, 284.166),
(5, 924.495, -1753.68, 13.5469, 80.2901);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`ID`, `Username`, `Password`, `Level`, `Novac`, `Skin`, `Godine`, `Staff`, `LastLogin`, `RegisterDate`, `Drzava`, `Pol`, `Email`, `Objekat0`, `Objekat1`) VALUES
(1, 'Silent', 297206591, 1, 556600, 2, 21, 4, '12/09/2023 - 09:05', 'NEMA', 'Srbija', '0', '@gmail.com', -1, -1),
(3, 'Ogy_', 252642079, 1, 38400, 289, 19, 4, '06/06/2023 - 15:57', '17/05/2023 - 19:57', 'Srbija', '0', '@gmail.com', -1, -1),
(4, 'Andjelkovic', 464192652, 1, 0, 281, 22, 4, '12/07/2023 - 15:15', '26/06/2023 - 14:40', 'Srbija', 'Musko', 'andjelkovic@gmail.com', -1, -1),
(5, 'Ogi', 336986984, 1, 0, 124, 31, 4, '11/07/2023 - 10:44', '26/06/2023 - 16:27', 'Srbija', 'Musko', 'dexterwalton132@gmail.com', -1, -1),
(6, 'Blake_Owens', 70123830, 1, 2000, 250, 20, 0, '29/06/2023 - 17:27', '29/06/2023 - 17:26', 'Srbija', 'Musko', '@gmail.com', 1, 1),
(7, 'Ogishy', 225510090, 1, 2000, 250, 31, 0, '29/06/2023 - 18:22', '29/06/2023 - 18:17', 'Srbija', 'Musko', 'dexterwalton132@gmail.com', -1, -1),
(8, 'Blake_Castiglione', 70123830, 1, 2000, 250, 20, 0, '29/06/2023 - 18:38', '29/06/2023 - 18:36', 'Srbija', 'Musko', '@gmail.com', 1, -1),
(9, 'bino', 141427310, 1, 0, 250, 21, 0, '29/06/2023 - 19:59', '29/06/2023 - 19:48', 'Bosna i Hercegovina', 'Musko', 'idegas@gmail.com', -1, -1),
(10, 'Zlatan_Music', 299172650, 1, 1600, 250, 26, 0, '01/07/2023 - 08:32', '30/06/2023 - 23:38', 'Bosna i Hercegovina', 'Musko', 'zlajaavlija@gmail.com', -1, -1),
(11, 'Bettino_Ricasoli', 190644874, 1, 2000, 250, 23, 0, '02/07/2023 - 07:23', '02/07/2023 - 07:23', 'Srbija', 'Musko', 'spaso@gmail.com', 1, -1),
(12, 'Ronald_Trotero', 219415261, 1, 2000, 250, 30, 0, '02/07/2023 - 12:56', '02/07/2023 - 11:32', 'Bosna i Hercegovina', 'Musko', 'ronaldtrotero65@gmail.com', -1, -1),
(13, 'adis_adis', 242615107, 1, 0, 250, 12, 0, '02/07/2023 - 12:22', '02/07/2023 - 12:22', 'Bosna i Hercegovina', 'Musko', 'adisadis@gmail.cm', -1, -1),
(14, 'Ali_Hadzic', 68944173, 1, 2000, 250, 18, 0, '02/07/2023 - 12:25', '02/07/2023 - 12:24', 'Bosna i Hercegovina', 'Musko', 'dabdjab123@gmail.com', -1, -1),
(15, 'daddyDOT', 96993690, 1, 2000, 250, 19, 0, '02/07/2023 - 12:53', '02/07/2023 - 12:51', 'Bosna i Hercegovina', 'Musko', 'daddy.active@aol.com', -1, -1),
(16, 'Dlittle_Coke', 70123830, 1, 2000, 250, 21, 0, '09/07/2023 - 12:10', '09/07/2023 - 12:10', 'Srbija', 'Musko', '123456@gmail.com', -1, 1),
(17, 'Ferid_Olsun', 422249563, 1, 949922, 250, 16, 4, '10/09/2023 - 20:32', '29/08/2023 - 21:40', 'Bosna i Hercegovina', 'Musko', 'dino@mailler.com', -1, 1),
(18, 'Faruk_Macola', 229245614, 1, 2000, 250, 16, 4, '30/08/2023 - 13:59', '30/08/2023 - 13:58', 'Bosna i Hercegovina', 'Musko', 'faruk1995@gmail.com', -1, -1);

-- --------------------------------------------------------

--
-- Table structure for table `player_crypto`
--

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
(3, 0, 0, 0, 0, 0),
(4, 0, 0, 0, 0, 0),
(5, 0, 0, 0, 0, 0),
(6, 0, 0, 0, 0, 0),
(7, 0, 0, 0, 0, 0),
(8, 0, 0, 0, 0, 0),
(9, 0, 0, 0, 0, 0),
(10, 0, 0, 0, 0, 0),
(11, 0, 0, 0, 0, 0),
(12, 0, 0, 0, 0, 0),
(15, 0, 0, 0, 0, 0),
(17, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_documents`
--

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
(3, 1, 0, 0, 0, 0, 0),
(4, 0, 0, 0, 0, 0, 0),
(5, 0, 0, 0, 0, 0, 0),
(6, 0, 0, 0, 0, 0, 0),
(7, 0, 0, 0, 0, 0, 0),
(8, 0, 0, 0, 0, 0, 0),
(9, 0, 0, 0, 0, 0, 0),
(10, 1, 1, 0, 0, 0, 0),
(11, 0, 0, 0, 0, 0, 0),
(12, 0, 0, 0, 0, 0, 0),
(15, 0, 0, 0, 0, 0, 0),
(17, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_electronic`
--

CREATE TABLE IF NOT EXISTS `player_electronic` (
  `player_id` int(11) NOT NULL,
  `Dron` tinyint(4) NOT NULL DEFAULT 0,
  `Baterije` int(11) NOT NULL DEFAULT 0,
  `Navigacija` tinyint(4) NOT NULL DEFAULT 0,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_electronic`
--

INSERT INTO `player_electronic` (`player_id`, `Dron`, `Baterije`, `Navigacija`) VALUES
(1, 1, 0, 0),
(4, 0, 0, 0),
(5, 0, 0, 0),
(6, 0, 0, 0),
(7, 0, 0, 0),
(8, 0, 0, 0),
(9, 0, 0, 0),
(10, 0, 0, 0),
(11, 0, 0, 0),
(12, 0, 0, 0),
(15, 0, 0, 0),
(17, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `player_finance`
--

CREATE TABLE IF NOT EXISTS `player_finance` (
  `finance_id` int(11) NOT NULL,
  `BankAccount` tinyint(4) NOT NULL DEFAULT 0,
  `BankMoney` int(11) NOT NULL DEFAULT 0,
  `BankPin` int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY `finance_id` (`finance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_finance`
--

INSERT INTO `player_finance` (`finance_id`, `BankAccount`, `BankMoney`, `BankPin`) VALUES
(1, 0, 0, 0),
(4, 0, 0, 0),
(5, 0, 0, 0),
(6, 0, 0, 0),
(7, 0, 0, 0),
(8, 0, 0, 0),
(9, 0, 0, 0),
(10, 0, 0, 0),
(11, 0, 0, 0),
(12, 0, 0, 0),
(15, 0, 0, 0),
(17, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_property`
--

CREATE TABLE IF NOT EXISTS `player_property` (
  `player_id` int(11) NOT NULL,
  `HouseID` int(11) NOT NULL,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_property`
--

INSERT INTO `player_property` (`player_id`, `HouseID`) VALUES
(1, 2),
(17, -1);

-- --------------------------------------------------------

--
-- Table structure for table `safezones`
--

CREATE TABLE IF NOT EXISTS `safezones` (
  `safeSQLID` int(11) NOT NULL AUTO_INCREMENT,
  `MinX` float NOT NULL DEFAULT 0,
  `MinY` float NOT NULL DEFAULT 0,
  `MaxX` float NOT NULL DEFAULT 0,
  `MaxY` float NOT NULL DEFAULT 0,
  `Radius` float NOT NULL DEFAULT 0,
  `Color` int(11) NOT NULL DEFAULT 0,
  `PickupX` float NOT NULL DEFAULT 0,
  `PickupY` float NOT NULL DEFAULT 0,
  `PickupZ` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`safeSQLID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `safezones`
--

INSERT INTO `safezones` (`safeSQLID`, `MinX`, `MinY`, `MaxX`, `MaxY`, `Radius`, `Color`, `PickupX`, `PickupY`, `PickupZ`) VALUES
(4, 1437.3, -1723.03, 1522.43, -1600.28, 30, 10040234, 1479.35, -1659.08, 12.1709);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

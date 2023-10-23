-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2023 at 09:43 PM
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
-- Table structure for table `benches`
--

DROP TABLE IF EXISTS `benches`;
CREATE TABLE IF NOT EXISTS `benches` (
  `seat_ID` int(11) NOT NULL AUTO_INCREMENT,
  `seat_x` float NOT NULL,
  `seat_y` float NOT NULL,
  `seat_z` float NOT NULL,
  `seat_a` float NOT NULL,
  PRIMARY KEY (`seat_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `containers`
--

DROP TABLE IF EXISTS `containers`;
CREATE TABLE IF NOT EXISTS `containers` (
  `conID` int(11) NOT NULL AUTO_INCREMENT,
  `con_x` float DEFAULT 0,
  `con_y` float DEFAULT 0,
  `con_z` float DEFAULT 0,
  `con_rx` float DEFAULT 0,
  `con_ry` float DEFAULT 0,
  `con_rz` float DEFAULT 0,
  `con_jnumber` mediumint(9) DEFAULT 0,
  PRIMARY KEY (`conID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faction_police`
--

DROP TABLE IF EXISTS `faction_police`;
CREATE TABLE IF NOT EXISTS `faction_police` (
  `fPoliceID` int(11) NOT NULL AUTO_INCREMENT,
  `fPoliceName` varchar(60) NOT NULL DEFAULT 'Police',
  `fPoliceShortName` varchar(30) NOT NULL DEFAULT 'PD',
  `fPoliceAdress` varchar(35) NOT NULL DEFAULT 'Nepoznata',
  `fPoliceState` varchar(30) NOT NULL,
  `fPoliceBoss` int(11) NOT NULL,
  `fPoliceType` int(11) NOT NULL DEFAULT 0,
  `fPoliceX` float NOT NULL DEFAULT 0,
  `fPoliceY` float NOT NULL DEFAULT 0,
  `fPoliceZ` float NOT NULL DEFAULT 0,
  `fPoliceExitX` float NOT NULL DEFAULT 246.66,
  `fPoliceExitY` float NOT NULL DEFAULT 65.8,
  `fPoliceExitZ` float NOT NULL DEFAULT 1003.64,
  `fPoliceInt` int(11) NOT NULL DEFAULT 6,
  `fPoliceVault` int(11) NOT NULL DEFAULT 0,
  `fPoliceMoney` int(11) NOT NULL DEFAULT 0,
  `fPoliceDirtMoney` int(11) NOT NULL DEFAULT 0,
  `fConfiscatedDrugs` int(11) NOT NULL DEFAULT 0,
  `fDutyPointX` float NOT NULL DEFAULT 0,
  `fDutyPointY` float NOT NULL DEFAULT 0,
  `fDutyPointZ` float NOT NULL DEFAULT 0,
  `fEquipmentX` float NOT NULL DEFAULT 0,
  `fEquipmentY` float NOT NULL DEFAULT 0,
  `fEquipmentZ` float NOT NULL DEFAULT 0,
  `fPoliceRank1` varchar(32) NOT NULL DEFAULT 'Rank',
  `fPoliceRank2` varchar(32) NOT NULL DEFAULT 'Rank',
  `fPoliceRank3` varchar(32) NOT NULL DEFAULT 'Rank',
  `fPoliceSkins1` int(11) NOT NULL DEFAULT 1,
  `fPoliceSkins2` int(11) NOT NULL DEFAULT 1,
  `fPoliceSkins3` int(11) NOT NULL DEFAULT 1,
  `fPoliceSkins4` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`fPoliceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

DROP TABLE IF EXISTS `houses`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Salary` int(11) NOT NULL,
  `Uniform` int(11) NOT NULL,
  `UniformX` float NOT NULL,
  `UniformY` float NOT NULL,
  `UnifromZ` float NOT NULL,
  `PositionX` float NOT NULL,
  `PositionY` float NOT NULL,
  `PositionZ` float NOT NULL,
  `Interior` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `metros`
--

DROP TABLE IF EXISTS `metros`;
CREATE TABLE IF NOT EXISTS `metros` (
  `metroID` int(11) NOT NULL AUTO_INCREMENT,
  `metroX` float NOT NULL,
  `metroY` float NOT NULL,
  `metroZ` float NOT NULL,
  `MetroRoute` int(11) NOT NULL DEFAULT 1,
  `metroInt` int(11) NOT NULL DEFAULT 0,
  `metroVw` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`metroID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `Money` int(11) NOT NULL DEFAULT 2000,
  `Skin` int(11) NOT NULL DEFAULT 29,
  `Age` int(11) NOT NULL,
  `Staff` int(11) NOT NULL DEFAULT 0,
  `LastLogin` varchar(50) NOT NULL DEFAULT 'NEMA',
  `RegisterDate` varchar(50) NOT NULL DEFAULT 'NEMA',
  `State` varchar(50) NOT NULL DEFAULT 'Srbija',
  `Sex` varchar(10) NOT NULL DEFAULT 'Nema',
  `Email` varchar(50) NOT NULL DEFAULT '@gmail.com',
  `Object0` tinyint(4) NOT NULL DEFAULT -1,
  `Object1` tinyint(4) NOT NULL DEFAULT -1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`ID`, `Username`, `Password`, `Level`, `Money`, `Skin`, `Age`, `Staff`, `LastLogin`, `RegisterDate`, `State`, `Sex`, `Email`, `Object0`, `Object1`) VALUES
(1, 'Silent', 297206591, 1, 7550, 250, 21, 4, '20/10/2023 - 16:08', '16/10/2023 - 18:48', 'Maryland', 'Musko', 'vostic@gmail.com', -1, -1),
(2, 'Silent_Developer', 297206591, 1, 4000, 250, 21, 4, '22/10/2023 - 21:35', '16/10/2023 - 18:55', 'Maryland', 'Musko', 'Vostica@gmail.com', -1, -1),
(3, 'Silent_Developera', 297206591, 1, 2000, 250, 21, 0, 'NEMA', '16/10/2023 - 19:02', 'Maryland', 'Musko', 'Vostica@gmail.com', -1, -1),
(4, 'Silent_Developeraa', 293602177, 1, 2000, 29, 21, 4, '16/10/2023 - 19:07', '16/10/2023 - 19:07', 'Maryland', 'Musko', 'Vostic@gmail.com', 1, -1);

-- --------------------------------------------------------

--
-- Table structure for table `player_crypto`
--

DROP TABLE IF EXISTS `player_crypto`;
CREATE TABLE IF NOT EXISTS `player_crypto` (
  `crypto_id` int(11) NOT NULL,
  `AmountBTC` float DEFAULT NULL,
  `AmountETH` float DEFAULT NULL,
  `AmountLTC` float DEFAULT NULL,
  `AmountUSDT` float DEFAULT NULL,
  `AmountDOT` float DEFAULT NULL,
  UNIQUE KEY `crypto_id` (`crypto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_crypto`
--

INSERT INTO `player_crypto` (`crypto_id`, `AmountBTC`, `AmountETH`, `AmountLTC`, `AmountUSDT`, `AmountDOT`) VALUES
(1, 0, 0, 0, 0, 0),
(2, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_documents`
--

DROP TABLE IF EXISTS `player_documents`;
CREATE TABLE IF NOT EXISTS `player_documents` (
  `player_id` int(11) NOT NULL,
  `NationalID` int(11) NOT NULL,
  `Passport` int(11) NOT NULL,
  `DriveLicense` int(11) NOT NULL,
  `MotoLicense` int(11) NOT NULL,
  `BoatLicense` int(11) NOT NULL,
  `GunLicense` int(11) NOT NULL,
  `LifeInsurance` tinyint(4) NOT NULL DEFAULT -1,
  `LifeInsuranceValidUntil` datetime NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_documents`
--

INSERT INTO `player_documents` (`player_id`, `NationalID`, `Passport`, `DriveLicense`, `MotoLicense`, `BoatLicense`, `GunLicense`, `LifeInsurance`, `LifeInsuranceValidUntil`) VALUES
(1, 0, 0, 0, 0, 0, 0, -1, '2023-10-16 18:54:09'),
(2, 0, 0, 0, 0, 0, 0, -1, '2023-10-22 21:32:38');

-- --------------------------------------------------------

--
-- Table structure for table `player_electronic`
--

DROP TABLE IF EXISTS `player_electronic`;
CREATE TABLE IF NOT EXISTS `player_electronic` (
  `player_id` int(11) NOT NULL,
  `Dron` tinyint(4) NOT NULL DEFAULT 0,
  `Battery` int(11) NOT NULL DEFAULT 0,
  `GPS` tinyint(4) NOT NULL DEFAULT 0,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_electronic`
--

INSERT INTO `player_electronic` (`player_id`, `Dron`, `Battery`, `GPS`) VALUES
(1, 0, 0, 0),
(2, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_finance`
--

DROP TABLE IF EXISTS `player_finance`;
CREATE TABLE IF NOT EXISTS `player_finance` (
  `finance_id` int(11) NOT NULL,
  `BankAccount` tinyint(4) NOT NULL DEFAULT 0,
  `BankMoney` int(11) NOT NULL DEFAULT 0,
  `BankPin` int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY `finance_id` (`finance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_finance`
--

INSERT INTO `player_finance` (`finance_id`, `BankAccount`, `BankMoney`, `BankPin`) VALUES
(1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_property`
--

DROP TABLE IF EXISTS `player_property`;
CREATE TABLE IF NOT EXISTS `player_property` (
  `player_id` int(11) NOT NULL,
  `BCenter` int(11) NOT NULL DEFAULT 0,
  `HouseID` int(11) NOT NULL DEFAULT -1,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_property`
--

INSERT INTO `player_property` (`player_id`, `BCenter`, `HouseID`) VALUES
(1, 0, -1),
(2, 0, -1);

-- --------------------------------------------------------

--
-- Table structure for table `re_business`
--

DROP TABLE IF EXISTS `re_business`;
CREATE TABLE IF NOT EXISTS `re_business` (
  `bID` int(11) NOT NULL AUTO_INCREMENT,
  `bOwner` int(11) NOT NULL DEFAULT 0,
  `bName` varchar(64) NOT NULL DEFAULT 'Undefined',
  `bLocked` int(11) NOT NULL DEFAULT 1,
  `bType` int(11) NOT NULL DEFAULT 1,
  `bPrice` int(11) NOT NULL DEFAULT 250000,
  `bLevel` int(11) NOT NULL DEFAULT 3,
  `bEnterX` float NOT NULL,
  `bEnterY` float NOT NULL,
  `bEnterZ` float NOT NULL,
  `bExitX` float NOT NULL,
  `bExitY` float NOT NULL,
  `bExitZ` float NOT NULL,
  `bInteractX` float NOT NULL DEFAULT 0,
  `bInteractY` float NOT NULL DEFAULT 0,
  `bInteractZ` float NOT NULL DEFAULT 0,
  `bActorSkin` int(11) NOT NULL DEFAULT 24,
  `bActorX` int(11) NOT NULL DEFAULT 0,
  `bActorY` int(11) NOT NULL DEFAULT 0,
  `bActorZ` int(11) NOT NULL DEFAULT 0,
  `bActorA` int(11) NOT NULL DEFAULT 0,
  `bProducts` int(11) NOT NULL DEFAULT 100,
  `bInt` int(11) NOT NULL,
  `bVW` int(11) NOT NULL,
  PRIMARY KEY (`bID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `re_business`
--

INSERT INTO `re_business` (`bID`, `bOwner`, `bName`, `bLocked`, `bType`, `bPrice`, `bLevel`, `bEnterX`, `bEnterY`, `bEnterZ`, `bExitX`, `bExitY`, `bExitZ`, `bInteractX`, `bInteractY`, `bInteractZ`, `bActorSkin`, `bActorX`, `bActorY`, `bActorZ`, `bActorA`, `bProducts`, `bInt`, `bVW`) VALUES
(2, 0, '1', 1, 1, 250000, 1, 823.94, -1333.54, 13.5469, 6.08, -28.89, 1003.54, 0, 0, 0, 24, 0, 0, 0, 0, 100, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `re_centar`
--

DROP TABLE IF EXISTS `re_centar`;
CREATE TABLE IF NOT EXISTS `re_centar` (
  `re_BCenterID` int(11) NOT NULL AUTO_INCREMENT,
  `re_BCenterOwner` int(11) NOT NULL DEFAULT 0,
  `re_BCenterName` varchar(21) NOT NULL DEFAULT 'Nepoznato',
  `re_BCenterInterior` int(11) NOT NULL DEFAULT 0,
  `re_BCenterVirtualWorld` int(11) NOT NULL DEFAULT 0,
  `re_BCenterType` int(11) NOT NULL DEFAULT 0,
  `re_BCenterIntX` float NOT NULL DEFAULT 0,
  `re_BCenterIntY` float NOT NULL DEFAULT 0,
  `re_BCenterIntZ` float NOT NULL DEFAULT 0,
  `re_BCenterLocked` tinyint(4) NOT NULL DEFAULT 0,
  `re_BCenterSafe` tinyint(4) NOT NULL DEFAULT 0,
  `re_BCenterSafePosX` float NOT NULL DEFAULT 0,
  `re_BCenterSafePosY` float NOT NULL DEFAULT 0,
  `re_BCenterSafePosZ` float NOT NULL DEFAULT 0,
  `re_BCenterWardrobe` tinyint(4) NOT NULL DEFAULT 0,
  `re_BCenterWardrobePosX` float NOT NULL DEFAULT 0,
  `re_BCenterWardrobePosY` float NOT NULL DEFAULT 0,
  `re_BCenterWardrobePosZ` float NOT NULL DEFAULT 0,
  `re_BCenterArmory` tinyint(4) NOT NULL DEFAULT 0,
  `re_BCenterArmoryPosX` float NOT NULL DEFAULT 0,
  `re_BCenterArmoryPosY` float NOT NULL DEFAULT 0,
  `re_BCenterArmoryPosZ` float NOT NULL DEFAULT 0,
  `re_BCenterAgentType` int(11) NOT NULL DEFAULT 0,
  `re_AgentPosX` float NOT NULL DEFAULT 0,
  `re_AgentPosY` float NOT NULL DEFAULT 0,
  `re_AgentPosZ` float NOT NULL DEFAULT 0,
  `re_AgentPosA` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`re_BCenterID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `re_centar`
--

INSERT INTO `re_centar` (`re_BCenterID`, `re_BCenterOwner`, `re_BCenterName`, `re_BCenterInterior`, `re_BCenterVirtualWorld`, `re_BCenterType`, `re_BCenterIntX`, `re_BCenterIntY`, `re_BCenterIntZ`, `re_BCenterLocked`, `re_BCenterSafe`, `re_BCenterSafePosX`, `re_BCenterSafePosY`, `re_BCenterSafePosZ`, `re_BCenterWardrobe`, `re_BCenterWardrobePosX`, `re_BCenterWardrobePosY`, `re_BCenterWardrobePosZ`, `re_BCenterArmory`, `re_BCenterArmoryPosX`, `re_BCenterArmoryPosY`, `re_BCenterArmoryPosZ`, `re_BCenterAgentType`, `re_AgentPosX`, `re_AgentPosY`, `re_AgentPosZ`, `re_AgentPosA`) VALUES
(1, 1, 'Ferid420', 4, 1, 1, 1826.06, -1286.32, 131.754, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1827.96, -1302.59, 131.739, 3.5893);

-- --------------------------------------------------------

--
-- Table structure for table `safezones`
--

DROP TABLE IF EXISTS `safezones`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `vID` int(11) NOT NULL AUTO_INCREMENT,
  `vOwner` int(11) NOT NULL DEFAULT 0,
  `vModel` int(11) NOT NULL DEFAULT 0,
  `Color1` int(11) NOT NULL DEFAULT 0,
  `Color2` int(11) NOT NULL DEFAULT 0,
  `vPlate` varchar(32) NOT NULL DEFAULT 'UNREGISTERED-00',
  `vPosX` float NOT NULL,
  `vPosY` float NOT NULL,
  `vPosZ` float NOT NULL,
  `vPosA` float NOT NULL,
  `vRegDate` int(11) NOT NULL DEFAULT 0,
  `vOil` int(11) NOT NULL DEFAULT 100,
  `vRange` int(11) NOT NULL DEFAULT 0,
  `vRangeKM` int(11) NOT NULL DEFAULT 0,
  `vFuel` int(11) NOT NULL DEFAULT 100,
  `vFuelType` int(11) NOT NULL DEFAULT 1,
  `vAlarm` tinyint(4) NOT NULL DEFAULT 0,
  `vXenon` tinyint(4) NOT NULL DEFAULT 0,
  `vLock` tinyint(4) NOT NULL DEFAULT 0,
  `vNitro` tinyint(4) NOT NULL DEFAULT 0,
  `vState` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`vID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `winter_settings`
--

DROP TABLE IF EXISTS `winter_settings`;
CREATE TABLE IF NOT EXISTS `winter_settings` (
  `username` varchar(24) NOT NULL DEFAULT 'Maryland',
  `map` tinyint(4) NOT NULL DEFAULT 0,
  `breath` tinyint(4) NOT NULL DEFAULT 0,
  `fallsnow` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

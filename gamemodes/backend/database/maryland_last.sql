-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 02, 2023 at 04:52 PM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Ime_Prezime',
  `Password` varchar(144) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Staff` int NOT NULL DEFAULT '0',
  `LastLogin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RegisterDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '@gmail.com',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`ID`, `Username`, `Password`, `Staff`, `LastLogin`, `RegisterDate`, `Email`) VALUES
(11, 'Frosty', '123456', 0, '2023-11-29 17:25:33', '2023-11-29 17:25:33', 'fuck@off.com'),
(12, 'Nodislav', 'dino9099', 0, '2023-11-30 18:06:44', '2023-11-30 18:06:44', 'dino@mailer.com'),
(13, 'Nodislav_Aleksienko', 'ferid420', 4, '0000-00-00 00:00:00', '2023-12-01 09:19:52', 'ferid@mailer.com');

-- --------------------------------------------------------

--
-- Table structure for table `benches`
--

DROP TABLE IF EXISTS `benches`;
CREATE TABLE IF NOT EXISTS `benches` (
  `seat_ID` int NOT NULL AUTO_INCREMENT,
  `seat_x` float NOT NULL,
  `seat_y` float NOT NULL,
  `seat_z` float NOT NULL,
  `seat_a` float NOT NULL,
  PRIMARY KEY (`seat_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

DROP TABLE IF EXISTS `cash_registers`;
CREATE TABLE IF NOT EXISTS `cash_registers` (
  `registerID` int NOT NULL AUTO_INCREMENT,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `rotX` float NOT NULL,
  `rotY` float NOT NULL,
  `rotZ` float NOT NULL,
  `Interior` int NOT NULL,
  `VW` int NOT NULL,
  PRIMARY KEY (`registerID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`registerID`, `posX`, `posY`, `posZ`, `rotX`, `rotY`, `rotZ`, `Interior`, `VW`) VALUES
(1, 210.161, -99.4602, 1005.53, 0, 0, 0.000004, 15, 0),
(2, 205.061, -99.3567, 1005.52, 0, 0, -2.99999, 15, 0),
(3, 180.742, -83.6525, 1002.04, 0, 0, -82.4, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `character_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `cName` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cSkin` int NOT NULL,
  `cGender` int NOT NULL DEFAULT '0',
  `cAge` int NOT NULL DEFAULT '18',
  `cJob` int NOT NULL DEFAULT '0',
  `cState` int NOT NULL DEFAULT '0',
  `cMoney` int NOT NULL DEFAULT '0',
  `cLevel` int NOT NULL DEFAULT '0',
  `cLastLogin` int NOT NULL,
  `cLastX` float NOT NULL DEFAULT '0',
  `cLastY` float NOT NULL DEFAULT '0',
  `cLastZ` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`character_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`character_id`, `account_id`, `cName`, `cSkin`, `cGender`, `cAge`, `cJob`, `cState`, `cMoney`, `cLevel`, `cLastLogin`, `cLastX`, `cLastY`, `cLastZ`) VALUES
(2, 13, 'Himzo_Suljagin', 60, 0, 0, 0, 0, 1120403456, 0, 2147483647, 1401.78, 1591.35, 12.0481),
(3, 13, 'Mehmed_Melijekovic', 12, 1, 0, 0, 0, 99000000, 0, 2147483647, 1401.78, 1591.35, 12.0481);

-- --------------------------------------------------------

--
-- Table structure for table `containers`
--

DROP TABLE IF EXISTS `containers`;
CREATE TABLE IF NOT EXISTS `containers` (
  `conID` int NOT NULL AUTO_INCREMENT,
  `con_x` float DEFAULT '0',
  `con_y` float DEFAULT '0',
  `con_z` float DEFAULT '0',
  `con_rx` float DEFAULT '0',
  `con_ry` float DEFAULT '0',
  `con_rz` float DEFAULT '0',
  `con_jnumber` mediumint DEFAULT '0',
  PRIMARY KEY (`conID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `faction_members`
--

DROP TABLE IF EXISTS `faction_members`;
CREATE TABLE IF NOT EXISTS `faction_members` (
  `member_id` int NOT NULL,
  `faction_id` int NOT NULL,
  `faction_rank` int NOT NULL,
  `faction_respekt` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faction_police`
--

DROP TABLE IF EXISTS `faction_police`;
CREATE TABLE IF NOT EXISTS `faction_police` (
  `fPoliceID` int NOT NULL AUTO_INCREMENT,
  `fPoliceName` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Police',
  `fPoliceShortName` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PD',
  `fPoliceAdress` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Nepoznata',
  `fPoliceState` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fPoliceBoss` int NOT NULL,
  `fPoliceType` int NOT NULL DEFAULT '0',
  `fPoliceX` float NOT NULL DEFAULT '0',
  `fPoliceY` float NOT NULL DEFAULT '0',
  `fPoliceZ` float NOT NULL DEFAULT '0',
  `fPoliceExitX` float NOT NULL DEFAULT '246.66',
  `fPoliceExitY` float NOT NULL DEFAULT '65.8',
  `fPoliceExitZ` float NOT NULL DEFAULT '1003.64',
  `fPoliceInt` int NOT NULL DEFAULT '6',
  `fPoliceVault` int NOT NULL DEFAULT '0',
  `fPoliceMoney` int NOT NULL DEFAULT '0',
  `fPoliceDirtMoney` int NOT NULL DEFAULT '0',
  `fConfiscatedDrugs` int NOT NULL DEFAULT '0',
  `fDutyPointX` float NOT NULL DEFAULT '0',
  `fDutyPointY` float NOT NULL DEFAULT '0',
  `fDutyPointZ` float NOT NULL DEFAULT '0',
  `fEquipmentX` float NOT NULL DEFAULT '0',
  `fEquipmentY` float NOT NULL DEFAULT '0',
  `fEquipmentZ` float NOT NULL DEFAULT '0',
  `fPoliceRank1` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Rank',
  `fPoliceRank2` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Rank',
  `fPoliceRank3` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Rank',
  `fPoliceSkins1` int NOT NULL DEFAULT '1',
  `fPoliceSkins2` int NOT NULL DEFAULT '1',
  `fPoliceSkins3` int NOT NULL DEFAULT '1',
  `fPoliceSkins4` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`fPoliceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

DROP TABLE IF EXISTS `houses`;
CREATE TABLE IF NOT EXISTS `houses` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `hOwner` int NOT NULL,
  `Price` int NOT NULL,
  `Type` int NOT NULL,
  `Adress` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Locked` tinyint(1) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `Safe` tinyint(1) NOT NULL,
  `Money` int NOT NULL,
  `Weed` int NOT NULL,
  `Cocaine` int NOT NULL,
  `Extazy` int NOT NULL,
  `WardX` float NOT NULL,
  `WardY` float NOT NULL,
  `WardZ` float NOT NULL,
  `FridgeX` float NOT NULL,
  `FridgeY` float NOT NULL,
  `FridgeZ` float NOT NULL,
  `Int` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `hCharacterID` (`hOwner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Salary` int NOT NULL,
  `Uniform` int NOT NULL,
  `UniformX` float NOT NULL,
  `UniformY` float NOT NULL,
  `UnifromZ` float NOT NULL,
  `PositionX` float NOT NULL,
  `PositionY` float NOT NULL,
  `PositionZ` float NOT NULL,
  `Interior` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `metros`
--

DROP TABLE IF EXISTS `metros`;
CREATE TABLE IF NOT EXISTS `metros` (
  `metroID` int NOT NULL AUTO_INCREMENT,
  `metroX` float NOT NULL,
  `metroY` float NOT NULL,
  `metroZ` float NOT NULL,
  `MetroRoute` int NOT NULL DEFAULT '1',
  `metroInt` int NOT NULL DEFAULT '0',
  `metroVw` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`metroID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_crypto`
--

DROP TABLE IF EXISTS `player_crypto`;
CREATE TABLE IF NOT EXISTS `player_crypto` (
  `character_id` int NOT NULL,
  `AmountBTC` float DEFAULT NULL,
  `AmountETH` float DEFAULT NULL,
  `AmountLTC` float DEFAULT NULL,
  `AmountUSDT` float DEFAULT NULL,
  `AmountDOT` float DEFAULT NULL,
  UNIQUE KEY `crypto_id` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_crypto`
--

INSERT INTO `player_crypto` (`character_id`, `AmountBTC`, `AmountETH`, `AmountLTC`, `AmountUSDT`, `AmountDOT`) VALUES
(3, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_documents`
--

DROP TABLE IF EXISTS `player_documents`;
CREATE TABLE IF NOT EXISTS `player_documents` (
  `character_document` int NOT NULL,
  `NationalID` int NOT NULL,
  `Passport` int NOT NULL,
  `DriveLicense` int NOT NULL,
  `MotoLicense` int NOT NULL,
  `BoatLicense` int NOT NULL,
  `GunLicense` int NOT NULL,
  `LifeInsurance` tinyint NOT NULL DEFAULT '-1',
  `LifeInsuranceValidUntil` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `player_id` (`character_document`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_documents`
--

INSERT INTO `player_documents` (`character_document`, `NationalID`, `Passport`, `DriveLicense`, `MotoLicense`, `BoatLicense`, `GunLicense`, `LifeInsurance`, `LifeInsuranceValidUntil`) VALUES
(3, 0, 0, 0, 0, 0, 0, -1, '2023-12-02 17:46:46');

-- --------------------------------------------------------

--
-- Table structure for table `player_electronic`
--

DROP TABLE IF EXISTS `player_electronic`;
CREATE TABLE IF NOT EXISTS `player_electronic` (
  `character_electronics` int NOT NULL,
  `Dron` tinyint NOT NULL DEFAULT '0',
  `Battery` int NOT NULL DEFAULT '0',
  `GPS` tinyint NOT NULL DEFAULT '0',
  UNIQUE KEY `player_id` (`character_electronics`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_electronic`
--

INSERT INTO `player_electronic` (`character_electronics`, `Dron`, `Battery`, `GPS`) VALUES
(3, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_property`
--

DROP TABLE IF EXISTS `player_property`;
CREATE TABLE IF NOT EXISTS `player_property` (
  `pOwner` int NOT NULL,
  `BCenter` int NOT NULL DEFAULT '0',
  `HouseID` int NOT NULL DEFAULT '-1',
  `BusinessID` int NOT NULL,
  UNIQUE KEY `player_id` (`pOwner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_property`
--

INSERT INTO `player_property` (`pOwner`, `BCenter`, `HouseID`, `BusinessID`) VALUES
(3, 1, -1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `re_business`
--

DROP TABLE IF EXISTS `re_business`;
CREATE TABLE IF NOT EXISTS `re_business` (
  `bID` int NOT NULL AUTO_INCREMENT,
  `bOwner` int NOT NULL DEFAULT '0',
  `bName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Undefined',
  `bLocked` int NOT NULL DEFAULT '1',
  `bType` int NOT NULL DEFAULT '1',
  `bPrice` int NOT NULL DEFAULT '250000',
  `bLevel` int NOT NULL DEFAULT '3',
  `bEnterX` float NOT NULL,
  `bEnterY` float NOT NULL,
  `bEnterZ` float NOT NULL,
  `bExitX` float NOT NULL,
  `bExitY` float NOT NULL,
  `bExitZ` float NOT NULL,
  `bInteractX` float NOT NULL DEFAULT '0',
  `bInteractY` float NOT NULL DEFAULT '0',
  `bInteractZ` float NOT NULL DEFAULT '0',
  `bActorSkin` int NOT NULL DEFAULT '24',
  `bActorX` int NOT NULL DEFAULT '0',
  `bActorY` int NOT NULL DEFAULT '0',
  `bActorZ` int NOT NULL DEFAULT '0',
  `bActorA` int NOT NULL DEFAULT '0',
  `bProducts` int NOT NULL DEFAULT '100',
  `bInt` int NOT NULL,
  `bVW` int NOT NULL,
  PRIMARY KEY (`bID`),
  KEY `bCharacterID` (`bOwner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `re_centar`
--

DROP TABLE IF EXISTS `re_centar`;
CREATE TABLE IF NOT EXISTS `re_centar` (
  `re_BCenterID` int NOT NULL AUTO_INCREMENT,
  `re_BCenterOwner` int NOT NULL DEFAULT '0',
  `re_BCenterName` varchar(21) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Nepoznato',
  `re_BCenterInterior` int NOT NULL DEFAULT '0',
  `re_BCenterVirtualWorld` int NOT NULL DEFAULT '0',
  `re_BCenterType` int NOT NULL DEFAULT '0',
  `re_BCenterIntX` float NOT NULL DEFAULT '0',
  `re_BCenterIntY` float NOT NULL DEFAULT '0',
  `re_BCenterIntZ` float NOT NULL DEFAULT '0',
  `re_BCenterLocked` tinyint NOT NULL DEFAULT '0',
  `re_BCenterSafe` tinyint NOT NULL DEFAULT '0',
  `re_BCenterSafePosX` float NOT NULL DEFAULT '0',
  `re_BCenterSafePosY` float NOT NULL DEFAULT '0',
  `re_BCenterSafePosZ` float NOT NULL DEFAULT '0',
  `re_BCenterWardrobe` tinyint NOT NULL DEFAULT '0',
  `re_BCenterWardrobePosX` float NOT NULL DEFAULT '0',
  `re_BCenterWardrobePosY` float NOT NULL DEFAULT '0',
  `re_BCenterWardrobePosZ` float NOT NULL DEFAULT '0',
  `re_BCenterArmory` tinyint NOT NULL DEFAULT '0',
  `re_BCenterArmoryPosX` float NOT NULL DEFAULT '0',
  `re_BCenterArmoryPosY` float NOT NULL DEFAULT '0',
  `re_BCenterArmoryPosZ` float NOT NULL DEFAULT '0',
  `re_BCenterAgentType` int NOT NULL DEFAULT '0',
  `re_AgentPosX` float NOT NULL DEFAULT '0',
  `re_AgentPosY` float NOT NULL DEFAULT '0',
  `re_AgentPosZ` float NOT NULL DEFAULT '0',
  `re_AgentPosA` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`re_BCenterID`),
  KEY `BCenterCharacter` (`re_BCenterOwner`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `re_centar`
--

INSERT INTO `re_centar` (`re_BCenterID`, `re_BCenterOwner`, `re_BCenterName`, `re_BCenterInterior`, `re_BCenterVirtualWorld`, `re_BCenterType`, `re_BCenterIntX`, `re_BCenterIntY`, `re_BCenterIntZ`, `re_BCenterLocked`, `re_BCenterSafe`, `re_BCenterSafePosX`, `re_BCenterSafePosY`, `re_BCenterSafePosZ`, `re_BCenterWardrobe`, `re_BCenterWardrobePosX`, `re_BCenterWardrobePosY`, `re_BCenterWardrobePosZ`, `re_BCenterArmory`, `re_BCenterArmoryPosX`, `re_BCenterArmoryPosY`, `re_BCenterArmoryPosZ`, `re_BCenterAgentType`, `re_AgentPosX`, `re_AgentPosY`, `re_AgentPosZ`, `re_AgentPosA`) VALUES
(1, 3, 'Nepoznato', 4, 1, 1, 1826.06, -1286.32, 131.754, 0, 1, 0, 0, 0, 1, 2262.13, 2178.29, 103.916, 1, 2295.51, 2176.33, 103.906, 147, 1827.96, -1302.59, 131.739, 3.5893);

-- --------------------------------------------------------

--
-- Table structure for table `safezones`
--

DROP TABLE IF EXISTS `safezones`;
CREATE TABLE IF NOT EXISTS `safezones` (
  `safeSQLID` int NOT NULL AUTO_INCREMENT,
  `MinX` float NOT NULL DEFAULT '0',
  `MinY` float NOT NULL DEFAULT '0',
  `MaxX` float NOT NULL DEFAULT '0',
  `MaxY` float NOT NULL DEFAULT '0',
  `Radius` float NOT NULL DEFAULT '0',
  `Color` int NOT NULL DEFAULT '0',
  `PickupX` float NOT NULL DEFAULT '0',
  `PickupY` float NOT NULL DEFAULT '0',
  `PickupZ` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`safeSQLID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `vID` int NOT NULL AUTO_INCREMENT,
  `vOwner` int NOT NULL DEFAULT '0',
  `vModel` int NOT NULL DEFAULT '0',
  `Color1` int NOT NULL DEFAULT '0',
  `Color2` int NOT NULL DEFAULT '0',
  `vPlate` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UNREGISTERED-00',
  `vPosX` float NOT NULL,
  `vPosY` float NOT NULL,
  `vPosZ` float NOT NULL,
  `vPosA` float NOT NULL,
  `vRegDate` int NOT NULL DEFAULT '0',
  `vOil` int NOT NULL DEFAULT '100',
  `vRange` int NOT NULL DEFAULT '0',
  `vRangeKM` int NOT NULL DEFAULT '0',
  `vFuel` int NOT NULL DEFAULT '100',
  `vFuelType` int NOT NULL DEFAULT '1',
  `vAlarm` tinyint NOT NULL DEFAULT '0',
  `vXenon` tinyint NOT NULL DEFAULT '0',
  `vLock` tinyint NOT NULL DEFAULT '0',
  `vNitro` tinyint NOT NULL DEFAULT '0',
  `vState` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`vID`),
  KEY `vCharacterID` (`vOwner`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `winter_settings`
--

DROP TABLE IF EXISTS `winter_settings`;
CREATE TABLE IF NOT EXISTS `winter_settings` (
  `username` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Maryland',
  `map` tinyint NOT NULL DEFAULT '0',
  `breath` tinyint NOT NULL DEFAULT '0',
  `fallsnow` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `winter_settings`
--

INSERT INTO `winter_settings` (`username`, `map`, `breath`, `fallsnow`) VALUES
('Frosty_Saints', 0, 0, 0),
('Frosty', 0, 0, 0),
('Frosty2', 0, 0, 0),
('Silent', 0, 0, 0),
('Frostyslav', 0, 0, 0),
('Silent_Maryland', 0, 0, 0),
('Frostyslav2', 0, 0, 0),
('Nodislav_Aleksienko', 0, 0, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `houses`
--
ALTER TABLE `houses`
  ADD CONSTRAINT `hCharacterID` FOREIGN KEY (`hOwner`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `player_documents`
--
ALTER TABLE `player_documents`
  ADD CONSTRAINT `dCharacterID` FOREIGN KEY (`character_document`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `player_electronic`
--
ALTER TABLE `player_electronic`
  ADD CONSTRAINT `eCharacterID` FOREIGN KEY (`character_electronics`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `player_property`
--
ALTER TABLE `player_property`
  ADD CONSTRAINT `pCharacterID` FOREIGN KEY (`pOwner`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `re_business`
--
ALTER TABLE `re_business`
  ADD CONSTRAINT `bCharacterID` FOREIGN KEY (`bOwner`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `re_centar`
--
ALTER TABLE `re_centar`
  ADD CONSTRAINT `BCenterCharacter` FOREIGN KEY (`re_BCenterOwner`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vCharacterID` FOREIGN KEY (`vOwner`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

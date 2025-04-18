-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 27, 2024 at 06:52 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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

CREATE TABLE `accounts` (
  `ID` int(11) NOT NULL,
  `Username` varchar(25) NOT NULL DEFAULT 'Ime_Prezime',
  `Password` varchar(144) NOT NULL,
  `Staff` int(11) NOT NULL DEFAULT 0,
  `LastLogin` timestamp NOT NULL DEFAULT current_timestamp(),
  `RegisterDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `Email` varchar(50) NOT NULL DEFAULT '@gmail.com'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`ID`, `Username`, `Password`, `Staff`, `LastLogin`, `RegisterDate`, `Email`) VALUES
(11, 'Frosty', '123456', 4, '2023-11-29 17:25:33', '2023-11-29 17:25:33', 'fuck@off.com'),
(12, 'Nodislav', 'dino9099', 4, '2023-11-30 18:06:44', '2023-11-30 18:06:44', 'dino@mailer.com'),
(13, 'Nodislav_Aleksienko', 'ferid420', 4, '0000-00-00 00:00:00', '2023-12-01 09:19:52', 'ferid@mailer.com'),
(14, 'Vostic', 'Vostica23', 4, '2023-12-02 17:08:50', '2023-12-02 17:08:50', 'silent@gmail.com'),
(15, 'Ogi', 'Aleksic999', 4, '2023-12-02 17:45:56', '2023-12-02 17:45:56', 'dexterwalton132@gmail.com'),
(16, 'Capital_Camora', 'ichbruderman1', 4, '2023-12-02 17:52:35', '2023-12-02 17:52:35', 'capital@samp.com'),
(17, 'Capital_Camoras', '12345678', 0, '2023-12-02 19:27:27', '2023-12-02 19:27:27', 'trake@smail.com'),
(18, 'djasa', '401253', 0, '2023-12-03 12:45:24', '2023-12-03 12:45:24', 'lazarradisavljevic5@gmail.com'),
(19, 'Klaus', 'klaus021', 4, '2023-12-03 13:51:35', '2023-12-03 13:51:35', 'dada@gmail.com'),
(20, 'Darko_Jovanovic', 'durant123', 0, '2023-12-03 16:34:47', '2023-12-03 16:34:47', 'ladjevacpc@gmail.com'),
(21, 'Nodislav_Alksienko', 'ferid420', 0, '2024-06-03 13:32:02', '2024-06-03 13:32:02', 'ferid420@gmail.com'),
(22, 'Casey_Skendy', '123456', 4, '2024-06-03 14:03:00', '2024-06-03 14:03:00', 'macka@gmail.com'),
(23, 'Vostic_Dev', 'Voki23', 0, '2024-10-28 15:42:50', '2024-10-28 15:42:50', 'vostic@gmail.com'),
(24, 'Daco_Delahunt', 'alemrjgh', 0, '2024-12-03 19:06:09', '2024-12-03 19:06:09', 'alem.cokoja@gmail.com'),
(25, 'Eros_Bosandzeros', '123321', 0, '2024-12-03 19:06:10', '2024-12-03 19:06:10', 'dsad@gmail.com'),
(26, 'Silva', '123321', 4, '2024-12-03 19:07:11', '2024-12-03 19:07:11', 'dsag@gmail.com'),
(27, 'Silva_Rose', 'Moosy1312', 0, '2024-12-07 22:46:46', '2024-12-07 22:46:46', 'kurac@gmail.com'),
(28, 'Casey', '123456', 5, '2024-12-07 22:50:11', '2024-12-07 22:50:11', 'caseymacka@whiskas.com'),
(29, 'Leon_Skandy', '123456', 5, '2024-12-07 23:13:21', '2024-12-07 23:13:21', '@.com'),
(30, 'Midori_Smith', '123123', 0, '2024-12-07 23:13:40', '2024-12-07 23:13:40', 'midori123@gmail.com'),
(31, 'Midori_Test', '123123', 0, '2024-12-07 23:16:34', '2024-12-07 23:16:34', 'dasdasd@gmail.com'),
(32, 'Frenkie_Deep', 'Burek12', 0, '2024-12-22 19:48:07', '2024-12-22 19:48:07', 'eldarhrnjictrovo@gmail.com'),
(33, 'Filip_Panic', 'feridKruh', 0, '2024-12-25 16:33:55', '2024-12-25 16:33:55', 'oasndnoasdnoa@massdk'),
(34, 'Gobejla_West', 'kokolo420', 0, '2024-12-26 14:32:38', '2024-12-26 14:32:38', 'ferid@kruh.ba');

-- --------------------------------------------------------

--
-- Table structure for table `bankaccounts`
--

CREATE TABLE `bankaccounts` (
  `AccountID` int(11) NOT NULL,
  `OwnerID` int(11) NOT NULL,
  `OwnerType` enum('Player','Faction','Bussiness','Government') NOT NULL DEFAULT 'Player',
  `Dollar` float NOT NULL DEFAULT 0,
  `Euro` float NOT NULL DEFAULT 0,
  `Pound` float NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bankaccounts`
--

INSERT INTO `bankaccounts` (`AccountID`, `OwnerID`, `OwnerType`, `Dollar`, `Euro`, `Pound`) VALUES
(1, 11, 'Player', 0, 0, 0),
(2, 11, 'Player', 0, 0, 0),
(3, 11, 'Player', 0, 0, 0),
(4, 4, 'Player', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `ban_reason` varchar(255) DEFAULT NULL,
  `ban_date` datetime NOT NULL,
  `ban_expire` datetime DEFAULT NULL,
  `is_permanent` tinyint(1) DEFAULT 0,
  `ban_ip` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bans`
--

INSERT INTO `bans` (`id`, `character_id`, `ban_reason`, `ban_date`, `ban_expire`, `is_permanent`, `ban_ip`) VALUES
(1, 4, 'zato', '2024-10-18 15:07:53', '2024-10-18 15:07:54', 0, NULL),
(2, 4, 'testiram', '2024-10-18 15:09:24', '2024-10-18 15:12:24', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `benches`
--

CREATE TABLE `benches` (
  `seat_ID` int(11) NOT NULL,
  `seat_x` float NOT NULL,
  `seat_y` float NOT NULL,
  `seat_z` float NOT NULL,
  `seat_a` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `registerID` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `rotX` float NOT NULL,
  `rotY` float NOT NULL,
  `rotZ` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `character_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `cName` varchar(24) NOT NULL,
  `cSkin` int(11) NOT NULL,
  `cGender` int(11) NOT NULL DEFAULT 0,
  `cAge` int(11) NOT NULL DEFAULT 18,
  `cJob` int(11) NOT NULL DEFAULT 0,
  `cState` int(11) NOT NULL DEFAULT 0,
  `cDollars` float NOT NULL DEFAULT 0,
  `cEuro` float NOT NULL,
  `cEGPound` float NOT NULL,
  `cLevel` int(11) NOT NULL DEFAULT 0,
  `cLastLogin` datetime NOT NULL,
  `cLastX` float NOT NULL DEFAULT 1401.78,
  `cLastY` float NOT NULL DEFAULT 1591.35,
  `cLastZ` float NOT NULL DEFAULT 12.0481,
  `cVW` int(11) NOT NULL DEFAULT 6,
  `cInt` int(11) NOT NULL DEFAULT 6,
  `cWanted` int(11) NOT NULL DEFAULT 0,
  `XP` int(11) NOT NULL DEFAULT 1,
  `Score` int(11) NOT NULL DEFAULT 0,
  `NeedXP` int(11) NOT NULL DEFAULT 1250
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`character_id`, `account_id`, `cName`, `cSkin`, `cGender`, `cAge`, `cJob`, `cState`, `cDollars`, `cEuro`, `cEGPound`, `cLevel`, `cLastLogin`, `cLastX`, `cLastY`, `cLastZ`, `cVW`, `cInt`, `cWanted`, `XP`, `Score`, `NeedXP`) VALUES
(4, 14, 'Joy_Silence', 2, 0, 0, 0, 0, 18054100, 0, 0, 0, '2024-12-27 18:47:58', 1417.25, 1586.96, 15.1547, 6, 6, 0, 1, 3, 2813),
(11, 13, 'Ferid_Olsun', 20, 0, 0, 0, 0, 8549960, 0, 0, 0, '2024-12-26 20:03:49', 165.478, -91.5456, 1001.8, 3, 0, 0, 1585, 1, 1875),
(24, 32, 'Frenkie_Deep', 5, 0, 0, 0, 0, 899.55, 0, 0, 0, '2024-12-22 20:54:11', 1416.22, 445.523, 1081.5, 2, 18, 0, 120, 0, 1250),
(25, 33, 'Fejda_Olsun', 12, 1, 0, 0, 0, 0, 0, 0, 0, '2024-12-25 17:34:40', 1401.78, 1592.49, 10.8125, 6, 6, 0, 1, 0, 1250),
(26, 34, 'Ferid_Kulusevski', 0, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-26 15:33:12', 831.325, -1341.15, 9.87468, 0, 0, 0, 1, 0, 1250);

-- --------------------------------------------------------

--
-- Table structure for table `character_attachs`
--

CREATE TABLE `character_attachs` (
  `id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `modelid` int(11) NOT NULL,
  `boneid` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rX` float NOT NULL,
  `rY` float NOT NULL,
  `rZ` float NOT NULL,
  `sX` float NOT NULL,
  `sY` float NOT NULL,
  `sZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `character_attachs`
--

INSERT INTO `character_attachs` (`id`, `character_id`, `modelid`, `boneid`, `x`, `y`, `z`, `rX`, `rY`, `rZ`, `sX`, `sY`, `sZ`) VALUES
(0, 11, 3044, 18, -0.064, -0.028, -0.009, 3.5, 1.19999, 75.2, 0.337006, 1, 0.373004),
(1, 11, 339, 1, 0.382999, -0.117, 0.103, 0, -125.6, -2.1, 1, 1, 1),
(2, 11, 339, 1, 0.402, -0.121, -0.108, 0, -67.6001, 171.3, 1, 1, 1),
(3, 11, 19140, 2, 0.099, 0.034, -0.003, 1.3, 91.7997, 87.6998, 1, 1.068, 1),
(4, 11, 19079, 15, 0.101, 0.054, 0.056, 139.4, 89.4002, 36.4, 1, 1, 1),
(0, 4, 19025, 2, 0.067, 0.021, 0.002, 87.6, 70.1, 0, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `character_quests`
--

CREATE TABLE `character_quests` (
  `characterid` int(11) NOT NULL DEFAULT 0,
  `Quest_1` int(11) NOT NULL DEFAULT 0,
  `Quest_2` int(11) NOT NULL DEFAULT 0,
  `Quest_3` int(11) NOT NULL DEFAULT 0,
  `Quest_4` int(11) NOT NULL DEFAULT 0,
  `Quest_5` int(11) NOT NULL DEFAULT 0,
  `Quest_6` int(11) NOT NULL DEFAULT 0,
  `Quest_7` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `character_quests`
--

INSERT INTO `character_quests` (`characterid`, `Quest_1`, `Quest_2`, `Quest_3`, `Quest_4`, `Quest_5`, `Quest_6`, `Quest_7`) VALUES
(4, 1, 1, 0, 1, 1, 0, 1),
(11, 1, 1, 1, 1, 1, 0, 1),
(19, 1, 0, 0, 0, 0, 0, 1),
(24, 0, 0, 0, 0, 0, 0, 1),
(25, 0, 0, 0, 0, 0, 0, 0),
(26, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `character_spawns`
--

CREATE TABLE `character_spawns` (
  `character_id` int(11) NOT NULL,
  `spawnType` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `character_spawns`
--

INSERT INTO `character_spawns` (`character_id`, `spawnType`) VALUES
(4, 1),
(11, 3),
(19, 1),
(25, 1),
(26, 1);

-- --------------------------------------------------------

--
-- Table structure for table `containers`
--

CREATE TABLE `containers` (
  `conID` int(11) NOT NULL,
  `con_x` float DEFAULT 0,
  `con_y` float DEFAULT 0,
  `con_z` float DEFAULT 0,
  `con_rx` float DEFAULT 0,
  `con_ry` float DEFAULT 0,
  `con_rz` float DEFAULT 0,
  `con_jnumber` mediumint(9) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `crypto_wallets`
--

CREATE TABLE `crypto_wallets` (
  `character_id` int(11) NOT NULL,
  `bitcoin` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `ethereum` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `litecoin` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `dogecoin` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `tether` decimal(18,8) NOT NULL DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `crypto_wallets`
--

INSERT INTO `crypto_wallets` (`character_id`, `bitcoin`, `ethereum`, `litecoin`, `dogecoin`, `tether`) VALUES
(4, 0.00000000, 40.00000000, 0.00000000, 0.00000000, 0.00000000),
(11, 3.14285707, 3.14999914, 0.00000000, 26400.00000000, 0.00000000),
(19, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000),
(24, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000),
(25, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000),
(26, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000);

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `factionID` int(11) NOT NULL,
  `factionName` varchar(30) NOT NULL,
  `factionType` int(11) NOT NULL,
  `factionBoss` int(11) NOT NULL,
  `factionRightHand` int(11) NOT NULL,
  `factionAreaX` float NOT NULL DEFAULT 0,
  `factionAreaY` float NOT NULL DEFAULT 0,
  `factionAreaZ` float NOT NULL DEFAULT 0,
  `factionInterior` int(11) NOT NULL DEFAULT 0,
  `factionVirtualWorld` int(11) NOT NULL DEFAULT 0,
  `factionHouseID` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `factions`
--

INSERT INTO `factions` (`factionID`, `factionName`, `factionType`, `factionBoss`, `factionRightHand`, `factionAreaX`, `factionAreaY`, `factionAreaZ`, `factionInterior`, `factionVirtualWorld`, `factionHouseID`) VALUES
(1, 'Niggers Family', 1, 11, 26, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `faction_members`
--

CREATE TABLE `faction_members` (
  `member_id` int(11) NOT NULL,
  `faction_id` int(11) NOT NULL,
  `faction_rank` int(11) NOT NULL,
  `faction_respekt` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faction_members`
--

INSERT INTO `faction_members` (`member_id`, `faction_id`, `faction_rank`, `faction_respekt`) VALUES
(0, 1, 1, 1),
(11, 1, 4, 1),
(19, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `faction_police`
--

CREATE TABLE `faction_police` (
  `fPoliceID` int(11) NOT NULL,
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
  `fPoliceSkins4` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faction_police`
--

INSERT INTO `faction_police` (`fPoliceID`, `fPoliceName`, `fPoliceShortName`, `fPoliceAdress`, `fPoliceState`, `fPoliceBoss`, `fPoliceType`, `fPoliceX`, `fPoliceY`, `fPoliceZ`, `fPoliceExitX`, `fPoliceExitY`, `fPoliceExitZ`, `fPoliceInt`, `fPoliceVault`, `fPoliceMoney`, `fPoliceDirtMoney`, `fConfiscatedDrugs`, `fDutyPointX`, `fDutyPointY`, `fDutyPointZ`, `fEquipmentX`, `fEquipmentY`, `fEquipmentZ`, `fPoliceRank1`, `fPoliceRank2`, `fPoliceRank3`, `fPoliceSkins1`, `fPoliceSkins2`, `fPoliceSkins3`, `fPoliceSkins4`) VALUES
(1, 'Maryland Police Department', 'MLPD', 'Rockville, Maryland', 'Maryland', 0, 2, 327.207, -1515.58, 36.1391, 796.306, 1769.43, -61.9399, 6, 0, 0, 0, 0, 739.103, 1781.27, -61.9399, 741.049, 1763.12, -61.9399, 'Rookie', 'Recruit', 'Officer', 280, 281, 267, 265);

-- --------------------------------------------------------

--
-- Table structure for table `faction_vehicles`
--

CREATE TABLE `faction_vehicles` (
  `ID` int(11) NOT NULL,
  `factionID` int(11) NOT NULL,
  `factionType` int(11) NOT NULL DEFAULT 1,
  `fvModel` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `A` float NOT NULL,
  `fvColor1` int(11) NOT NULL DEFAULT 1,
  `fvColor2` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faction_vehicles`
--

INSERT INTO `faction_vehicles` (`ID`, `factionID`, `factionType`, `fvModel`, `X`, `Y`, `Z`, `A`, `fvColor1`, `fvColor2`) VALUES
(1, 1, 1, 411, 877.317, -1320.31, 13.5567, 278.685, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
  `hOwner` int(11) NOT NULL,
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
  `Int` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`ID`, `hOwner`, `Price`, `Type`, `Adress`, `Locked`, `PosX`, `PosY`, `PosZ`, `ExitX`, `ExitY`, `ExitZ`, `Safe`, `Money`, `Weed`, `Cocaine`, `Extazy`, `WardX`, `WardY`, `WardZ`, `FridgeX`, `FridgeY`, `FridgeZ`, `Int`) VALUES
(2, 0, 300000, 3, 'Brooklyn Park, Maryland', 0, 1000.25, -1334.22, 13.3828, 199.577, 4.8688, 1501.01, 0, 0, 0, 0, 0, 179.477, 15.5518, 1505.19, 224.28, 1289.19, 1082.14, 15),
(3, 0, 120000, 2, 'Brooklyn Park, Maryland', 0, 1000.25, -1334.22, 13.3828, -285.25, 1471.19, 1084.37, 0, 0, 0, 0, 0, 224.28, 1289.19, 1082.14, 224.28, 1289.19, 1082.14, 15),
(4, 11, 50000, 1, 'Jefferson, Maryland', 0, 2209.81, -1239.44, 24.1496, 224.28, 1289.19, 1082.14, 0, 0, 0, 0, 0, 224.28, 1289.19, 1082.14, 224.28, 1289.19, 1082.14, 1);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `PlayerID` int(11) NOT NULL,
  `ItemID` int(11) NOT NULL DEFAULT 50,
  `ItemQuantity` int(11) NOT NULL DEFAULT 10,
  `ItemType` int(11) NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`PlayerID`, `ItemID`, `ItemQuantity`, `ItemType`) VALUES
(19, 54, 3, 4),
(19, 57, 3, 2),
(11, 57, 5, 2),
(11, 55, 5, 4),
(11, 1, 5, 3),
(11, 51, 5, 2),
(11, 56, 5, 2),
(11, 53, 4, 2),
(4, 53, 1, 2),
(4, 54, 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `inv_containers`
--

CREATE TABLE `inv_containers` (
  `ID` int(11) NOT NULL,
  `propID` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `Item` int(11) NOT NULL,
  `ItemType` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_containers`
--

INSERT INTO `inv_containers` (`ID`, `propID`, `Type`, `Item`, `ItemType`, `Quantity`, `Model`, `posX`, `posY`, `posZ`) VALUES
(10, 0, 3, 51, 2, 0, 19564, 922.159, -1325.11, 12.3616),
(12, 0, 3, 53, 2, 1, 19570, 1147.77, -1205.74, 18.1734);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `ID` int(11) NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Salary` int(11) NOT NULL,
  `Uniform` int(11) NOT NULL,
  `UniformX` float NOT NULL,
  `UniformY` float NOT NULL,
  `UnifromZ` float NOT NULL,
  `PositionX` float NOT NULL,
  `PositionY` float NOT NULL,
  `PositionZ` float NOT NULL,
  `Interior` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `life_insurance`
--

CREATE TABLE `life_insurance` (
  `character_id` int(11) NOT NULL,
  `purchase_date` datetime NOT NULL DEFAULT current_timestamp(),
  `expiry` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `life_insurance`
--

INSERT INTO `life_insurance` (`character_id`, `purchase_date`, `expiry`) VALUES
(19, '2024-12-26 19:53:08', '2024-12-26 19:53:08'),
(24, '2024-12-22 20:49:13', '2024-12-22 20:49:13'),
(25, '2024-12-25 17:34:36', '2024-12-25 17:34:36'),
(26, '2024-12-26 15:33:00', '2024-12-26 15:33:00');

-- --------------------------------------------------------

--
-- Table structure for table `log_anticheat`
--

CREATE TABLE `log_anticheat` (
  `log_str` varchar(128) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `log_anticheat`
--

INSERT INTO `log_anticheat` (`log_str`, `date`) VALUES
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-11 18:26:13'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-13 22:23:20'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-15 15:07:29'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-15 15:17:59'),
('ANTICHEAT-LOG:  Vostic se uspjesno prijavio kao RCON | IP: -363438822', '2024-12-15 16:47:16'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-15 17:07:28'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-19 18:52:16'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-20 19:15:04'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-20 19:18:01'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-20 19:19:32'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-21 13:14:49'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-21 13:17:09'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-21 17:15:31'),
('ANTICHEAT-LOG:  Silva se uspjesno prijavio kao RCON | IP: -1532966630', '2024-12-21 19:25:26'),
('ANTICHEAT-LOG:  Silva se uspjesno prijavio kao RCON | IP: -1532966630', '2024-12-21 19:41:14'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-22 09:33:30'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-22 09:40:43'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-22 13:20:41'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-22 15:29:33'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-23 18:51:47'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-23 19:00:05'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-23 19:04:31'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-23 19:13:44'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-23 21:46:46'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-24 14:32:32'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-24 14:34:45'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-24 14:38:52'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se pokusao prijaviti kao RCON | IP: 16777343', '2024-12-24 21:19:45'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-24 21:19:46'),
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-25 12:13:54');

-- --------------------------------------------------------

--
-- Table structure for table `log_commands`
--

CREATE TABLE `log_commands` (
  `log_str` varchar(128) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `log_commands`
--

INSERT INTO `log_commands` (`log_str`, `date`) VALUES
('COMMAND:  Vostic je iskoristio komandu /createrent', '2024-12-09 10:04:48'),
('COMMAND:  Vostic je iskoristio komandu /createrent 522 560 451', '2024-12-09 10:04:55'),
('COMMAND:  Vostic je iskoristio komandu /unrent', '2024-12-09 11:51:06'),
('COMMAND:  Vostic je iskoristio komandu /unrent', '2024-12-09 11:51:09'),
('COMMAND:  Vostic je iskoristio komandu /unrent', '2024-12-09 11:51:11'),
('COMMAND:  Vostic je iskoristio komandu /cc', '2024-12-09 11:51:13'),
('COMMAND:  Vostic je iskoristio komandu /cc', '2024-12-09 11:51:14'),
('COMMAND:  Vostic je iskoristio komandu /unrent', '2024-12-09 11:51:16'),
('COMMAND:  Vostic je iskoristio komandu /unrent', '2024-12-09 12:04:40'),
('COMMAND:  Vostic je iskoristio komandu /unrent', '2024-12-09 12:04:48'),
('COMMAND:  Vostic je iskoristio komandu /unrent', '2024-12-09 12:05:28'),
('COMMAND:  Vostic je iskoristio komandu /cc', '2024-12-09 12:10:00'),
('COMMAND:  Vostic je iskoristio komandu /clear', '2024-12-09 12:10:16'),
('COMMAND:  Vostic je iskoristio komandu /unret', '2024-12-09 12:10:18'),
('COMMAND:  Vostic je iskoristio komandu /unrent', '2024-12-09 12:10:23'),
('COMMAND:  Vostic je iskoristio komandu /cc', '2024-12-09 12:10:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jail', '2024-12-09 21:48:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jail 0 1 10', '2024-12-09 21:48:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 2295.757,-3588.850,-14.594', '2024-12-09 21:51:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 2295.757,-3588.850,-14.594', '2024-12-09 21:51:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 2295.757,-3588.850,20.594', '2024-12-09 21:51:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 0 0', '2024-12-09 21:54:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-09 21:55:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-09 21:55:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /portw', '2024-12-09 21:55:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /portw', '2024-12-09 21:55:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-09 21:55:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-09 21:55:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 20', '2024-12-09 21:56:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1430.018310, 1507.042358, 32.806980', '2024-12-09 21:56:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1430.018310, 1507.042358, 32.806980', '2024-12-09 21:56:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jetpack', '2024-12-09 21:56:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:19:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:19:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:19:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:19:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:19:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-11 18:21:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 0 0', '2024-12-11 18:23:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-11 18:25:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createbusiness', '2024-12-11 18:26:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createbusiness', '2024-12-11 18:26:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createbusiness 7Eleven 1 1 900', '2024-12-11 18:26:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -2257.441894, -1743.539916, 487.737579', '2024-12-11 18:34:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 50.001941, -1528.682739, -0.777544', '2024-12-11 18:35:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 50.001941, -1528.682739, -0.777544', '2024-12-11 18:35:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 50.001941, -1528.682739, 5.777544', '2024-12-11 18:35:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 8', '2024-12-11 18:37:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1358.160400, 1501.470703, 101.226661', '2024-12-11 18:37:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:38:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:38:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:38:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:38:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 20', '2024-12-11 18:39:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:39:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:39:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:39:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 20', '2024-12-11 18:39:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:39:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:39:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 14', '2024-12-11 18:39:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956', '2024-12-11 18:39:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -849.774291, 89.610961, 46.717956w', '2024-12-11 18:39:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -850.774291, 89.610961, 46.717956w', '2024-12-11 18:39:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -850.774291, 89.610961, 46.717956', '2024-12-11 18:39:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 14', '2024-12-11 18:39:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -850.774291, 89.610961, 46.717956', '2024-12-11 18:40:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 2838.814453, 1330.542480, 19.785236', '2024-12-11 18:41:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-11 18:41:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-11 18:41:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1687.083740, -1450.942871, 12.507729', '2024-12-11 18:42:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1687.083740, -1450.942871, 12.507729', '2024-12-11 18:42:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1687.083740, -1460.942871, 12.507729', '2024-12-11 18:42:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1687.083740, -1450.942871, 12.507729', '2024-12-11 18:42:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1687.083740, -1450.942871, 15.507729', '2024-12-11 18:42:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 15', '2024-12-11 18:43:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 4.941112, 1501.662963', '2024-12-11 18:43:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 5.941112, 1501.662963', '2024-12-11 18:43:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 9.941112, 1501.662963', '2024-12-11 18:43:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 4.941112, 1501.662963', '2024-12-11 18:43:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 4.941112, 1521.662963', '2024-12-11 18:43:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 4.941112, 1511.662963', '2024-12-11 18:43:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 4.941112, 1519.662963', '2024-12-11 18:43:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 9.941112, 1519.662963', '2024-12-11 18:43:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 9.941112, 1510.662963', '2024-12-11 18:44:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 200.901672, 9.941112, 1505.662963', '2024-12-11 18:44:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 199.687561, 4.908154, 1504.100097', '2024-12-11 18:44:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 17', '2024-12-11 18:45:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -2139.315673, -1401.012939, 1.974555', '2024-12-11 18:45:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-11 18:46:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney', '2024-12-13 15:24:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 45000 1', '2024-12-13 15:24:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-13 15:25:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 45000 1', '2024-12-13 15:26:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu //q', '2024-12-13 22:09:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-13 22:10:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /prerada', '2024-12-13 22:11:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /prerada', '2024-12-13 22:11:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /slap 0', '2024-12-13 22:15:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1401.7648,-32.3919,10000.0106', '2024-12-13 22:16:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1401.7648,-32.3919,1000.0106', '2024-12-13 22:16:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1401.7648,-32.3919,1005.0106', '2024-12-13 22:16:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /freeze 0', '2024-12-13 22:17:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /freeze 0', '2024-12-13 22:17:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jetpack', '2024-12-13 22:23:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jetpackw', '2024-12-13 22:23:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jetpackw', '2024-12-13 22:23:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jetpack', '2024-12-13 22:23:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spanel', '2024-12-13 22:23:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-13 22:23:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1401.7648,-32.3919,1005.0106', '2024-12-13 22:24:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-14 21:45:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-14 21:54:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-14 21:54:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-14 22:06:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 1 1', '2024-12-15 10:41:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 1 1', '2024-12-15 10:42:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 411 1 1', '2024-12-15 10:42:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /fv', '2024-12-15 10:43:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 10:43:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 10:44:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /winter', '2024-12-15 10:44:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 541', '2024-12-15 10:46:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 541', '2024-12-15 10:46:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitro', '2024-12-15 10:46:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 541', '2024-12-15 10:47:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 10:48:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 541 1 1', '2024-12-15 11:07:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /winter', '2024-12-15 11:08:45'),
('COMMAND:  Vostic je iskoristio komandu /jetpack', '2024-12-15 12:24:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 1', '2024-12-15 12:24:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 0', '2024-12-15 12:24:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /slap 1', '2024-12-15 12:24:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 12:25:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 12:25:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setplayermoney', '2024-12-15 13:04:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setplayermoney 0 1000 1', '2024-12-15 13:04:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 13:06:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 13:06:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 1 1', '2024-12-15 13:07:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-15 13:10:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 13:10:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 13:11:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 13:12:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 13:14:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1285.8971,10.0347,1004.2898', '2024-12-15 13:15:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1285.8971,5.0347,1004.2898', '2024-12-15 13:15:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 13:18:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 13:19:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 -1', '2024-12-15 14:39:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw0 -1', '2024-12-15 14:39:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 -1', '2024-12-15 14:39:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-15 14:40:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-15 14:40:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1220.2867,-2397.0332,10.8593', '2024-12-15 14:40:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mowervehicle', '2024-12-15 14:40:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mowertakejob', '2024-12-15 14:40:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1215.3478,-2369.3628,10.7937', '2024-12-15 14:41:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu //q', '2024-12-15 14:53:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 14:55:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 14:55:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mowervehicle', '2024-12-15 14:55:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mowervehicle', '2024-12-15 14:55:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 14:55:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 14:56:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:02:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:02:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:03:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spanel', '2024-12-15 15:07:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:07:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:07:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:08:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:08:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 15:10:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:11:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:11:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 15:12:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:13:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:13:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:13:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:13:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mowervehicle', '2024-12-15 15:13:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mowervehicle', '2024-12-15 15:13:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:13:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 15:15:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 15:15:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 15:15:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 15:18:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:18:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 15:20:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:21:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mowervehicle', '2024-12-15 15:21:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitro', '2024-12-15 15:21:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitro', '2024-12-15 15:22:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mowervehicle', '2024-12-15 15:23:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:23:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /poort', '2024-12-15 15:38:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 15:38:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /otkaz', '2024-12-15 15:40:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 15:44:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mower', '2024-12-15 15:44:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /poslovi', '2024-12-15 15:46:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gmenu', '2024-12-15 15:51:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /recolorer', '2024-12-15 15:51:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 16:00:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 1 1', '2024-12-15 16:01:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 1 1', '2024-12-15 16:01:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 1', '2024-12-15 16:01:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 2', '2024-12-15 16:01:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 3', '2024-12-15 16:01:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 4', '2024-12-15 16:01:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 5', '2024-12-15 16:01:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 6', '2024-12-15 16:01:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 7', '2024-12-15 16:01:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 8', '2024-12-15 16:01:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 9', '2024-12-15 16:02:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 10', '2024-12-15 16:02:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 11', '2024-12-15 16:02:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 12', '2024-12-15 16:02:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 13', '2024-12-15 16:02:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 14', '2024-12-15 16:02:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 15', '2024-12-15 16:02:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 16', '2024-12-15 16:02:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 17', '2024-12-15 16:02:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 18', '2024-12-15 16:02:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 19', '2024-12-15 16:02:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 20', '2024-12-15 16:02:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 21', '2024-12-15 16:02:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 22', '2024-12-15 16:02:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 23', '2024-12-15 16:02:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 24', '2024-12-15 16:02:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 25', '2024-12-15 16:02:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 26', '2024-12-15 16:02:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 26', '2024-12-15 16:02:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 27', '2024-12-15 16:02:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 28', '2024-12-15 16:02:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 29', '2024-12-15 16:02:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 30', '2024-12-15 16:02:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 31', '2024-12-15 16:02:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 313', '2024-12-15 16:02:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 32', '2024-12-15 16:02:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 34', '2024-12-15 16:02:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 180', '2024-12-15 16:02:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 181', '2024-12-15 16:02:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 182', '2024-12-15 16:02:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 183', '2024-12-15 16:02:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 184', '2024-12-15 16:02:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 185', '2024-12-15 16:02:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 186', '2024-12-15 16:02:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 187', '2024-12-15 16:02:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 188', '2024-12-15 16:02:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 189', '2024-12-15 16:02:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 190', '2024-12-15 16:02:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 191', '2024-12-15 16:02:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 1912', '2024-12-15 16:03:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 192', '2024-12-15 16:03:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 193', '2024-12-15 16:03:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 1934', '2024-12-15 16:03:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 194', '2024-12-15 16:03:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 195', '2024-12-15 16:03:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 196', '2024-12-15 16:03:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 197', '2024-12-15 16:03:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 180', '2024-12-15 16:03:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 16:03:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 16:03:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 16:03:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 16:16:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 16:16:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun', '2024-12-15 16:16:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 16:16:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 1 1', '2024-12-15 16:16:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 1 24 90', '2024-12-15 16:16:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 1 1 90', '2024-12-15 16:17:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 1 3 90', '2024-12-15 16:17:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 1 4 90', '2024-12-15 16:17:06'),
('COMMAND:  Vostic je iskoristio komandu /jetpack', '2024-12-15 16:17:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /freeze 0', '2024-12-15 16:17:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jetpack', '2024-12-15 16:17:51'),
('COMMAND:  Vostic je iskoristio komandu /frezze 0', '2024-12-15 16:17:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /freeze 1', '2024-12-15 16:17:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /freeze 0', '2024-12-15 16:18:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /freeze 0', '2024-12-15 16:18:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /freeze 1', '2024-12-15 16:18:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0w', '2024-12-15 16:18:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0ww', '2024-12-15 16:18:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0www', '2024-12-15 16:18:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0wwww', '2024-12-15 16:18:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0wwwww', '2024-12-15 16:18:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0w', '2024-12-15 16:18:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0ww', '2024-12-15 16:18:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:18:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0w', '2024-12-15 16:18:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0w', '2024-12-15 16:18:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0w', '2024-12-15 16:19:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0w', '2024-12-15 16:19:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0w', '2024-12-15 16:19:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0w', '2024-12-15 16:19:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0w', '2024-12-15 16:19:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:19:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 455 1', '2024-12-15 16:19:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 455 1', '2024-12-15 16:19:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /katana', '2024-12-15 16:19:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /helmet', '2024-12-15 16:19:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /katana', '2024-12-15 16:19:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mask', '2024-12-15 16:19:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mask', '2024-12-15 16:19:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /belt', '2024-12-15 16:19:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /belt', '2024-12-15 16:19:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bucksaw', '2024-12-15 16:20:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cigar', '2024-12-15 16:20:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cigar', '2024-12-15 16:20:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cigar', '2024-12-15 16:20:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /torch', '2024-12-15 16:20:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /torch', '2024-12-15 16:20:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cigar', '2024-12-15 16:20:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:20:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:20:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-15 16:21:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 16:39:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 4 1', '2024-12-15 16:45:29'),
('COMMAND:  Vostic je iskoristio komandu /port', '2024-12-15 16:45:55'),
('COMMAND:  Vostic je iskoristio komandu /setvw 1 0', '2024-12-15 16:46:04'),
('COMMAND:  Vostic je iskoristio komandu /setint 1 0', '2024-12-15 16:46:07'),
('COMMAND:  Vostic je iskoristio komandu /goto 0', '2024-12-15 16:46:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitro', '2024-12-15 16:46:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney', '2024-12-15 16:46:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 1000 1', '2024-12-15 16:47:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitro', '2024-12-15 16:47:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 16:48:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 16:48:17'),
('COMMAND:  Vostic je iskoristio komandu /t 2', '2024-12-15 16:48:18'),
('COMMAND:  Vostic je iskoristio komandu /cc', '2024-12-15 16:48:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney', '2024-12-15 16:48:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 1 1', '2024-12-15 16:48:52'),
('COMMAND:  Vostic je iskoristio komandu /givegun ', '2024-12-15 16:49:01'),
('COMMAND:  Vostic je iskoristio komandu /givegun  0 30 333', '2024-12-15 16:49:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 10', '2024-12-15 16:49:09'),
('COMMAND:  Vostic je iskoristio komandu /cc', '2024-12-15 16:50:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /katana', '2024-12-15 16:50:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mask', '2024-12-15 16:50:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /parrot', '2024-12-15 16:50:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /fstance', '2024-12-15 16:50:53'),
('COMMAND:  Vostic je iskoristio komandu /katana', '2024-12-15 16:50:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /freeze 1', '2024-12-15 16:54:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 1', '2024-12-15 16:54:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /freeze 0', '2024-12-15 16:54:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 411 1 1', '2024-12-15 16:54:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh', '2024-12-15 16:54:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 16:55:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 16:56:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 34 90', '2024-12-15 16:56:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mask', '2024-12-15 16:56:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 16:56:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 16:58:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 17:07:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cameditor', '2024-12-15 17:07:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 17:07:36'),
('COMMAND:  Vostic je iskoristio komandu /goto 0', '2024-12-15 17:08:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /q/q', '2024-12-15 17:10:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /debugui', '2024-12-15 17:11:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 17:11:11'),
('COMMAND:  Vostic je iskoristio komandu /goto 0', '2024-12-15 17:11:51'),
('COMMAND:  Vostic je iskoristio komandu /setint 1 0', '2024-12-15 17:12:18'),
('COMMAND:  Vostic je iskoristio komandu /setvw 1 0', '2024-12-15 17:12:22'),
('COMMAND:  Vostic je iskoristio komandu /mower', '2024-12-15 17:12:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 17:18:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 17:18:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 19:24:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory]', '2024-12-15 19:24:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 19:24:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 19:24:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 19:25:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 19:25:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 19:25:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 19:25:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 19:25:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 1 1', '2024-12-15 19:25:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 19:26:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-15 19:26:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 19:26:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 19:26:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 19:26:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 19:26:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-15 19:28:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-15 19:28:22'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-19 16:19:53'),
('COMMAND:  Silva je iskoristio komandu /setinv si 0', '2024-12-19 16:20:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -776.4226, -1977.0199, 8.7799', '2024-12-19 16:20:04'),
('COMMAND:  Silva je iskoristio komandu /setint si 0', '2024-12-19 16:20:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -776.4226, -1977.0199, 8.7799', '2024-12-19 16:20:05'),
('COMMAND:  Silva je iskoristio komandu /setvw', '2024-12-19 16:20:06'),
('COMMAND:  Silva je iskoristio komandu /setvw 1 0', '2024-12-19 16:20:09'),
('COMMAND:  Silva je iskoristio komandu /setint 1 0', '2024-12-19 16:20:14'),
('COMMAND:  Silva je iskoristio komandu /tod 1', '2024-12-19 16:20:17'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-19 16:20:21'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-19 16:20:22'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-19 16:20:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 3', '2024-12-19 16:20:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -776.4226, -1977.0199, 8.7799', '2024-12-19 16:20:31'),
('COMMAND:  Silva je iskoristio komandu /goto nodi', '2024-12-19 16:20:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 1', '2024-12-19 16:20:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f eee', '2024-12-19 16:20:58'),
('COMMAND:  Silva je iskoristio komandu /f ,', '2024-12-19 16:21:00'),
('COMMAND:  Silva je iskoristio komandu /f a', '2024-12-19 16:21:06'),
('COMMAND:  Silva je iskoristio komandu /f a', '2024-12-19 16:21:12'),
('COMMAND:  Silva je iskoristio komandu /f dasdsa', '2024-12-19 16:21:14'),
('COMMAND:  Silva je iskoristio komandu /f dasdsa', '2024-12-19 16:21:15'),
('COMMAND:  Silva je iskoristio komandu /f dasdsa', '2024-12-19 16:21:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f aa', '2024-12-19 16:21:20'),
('COMMAND:  Silva je iskoristio komandu /f a', '2024-12-19 16:21:36'),
('COMMAND:  Silva je iskoristio komandu /r', '2024-12-19 16:21:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f AAAAAAAAA', '2024-12-19 16:21:41'),
('COMMAND:  Silva je iskoristio komandu /f', '2024-12-19 16:21:42'),
('COMMAND:  Silva je iskoristio komandu /f a', '2024-12-19 16:21:44'),
('COMMAND:  Silva je iskoristio komandu /f fdfds', '2024-12-19 16:21:46'),
('COMMAND:  Silva je iskoristio komandu /f dsadsa ', '2024-12-19 16:21:52'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-19 16:22:38'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-19 16:22:51'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-19 16:23:06'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-19 16:23:19'),
('COMMAND:  Silva je iskoristio komandu /f ?.', '2024-12-19 16:24:35'),
('COMMAND:  Silva je iskoristio komandu /cc', '2024-12-19 16:24:38'),
('COMMAND:  Silva je iskoristio komandu /skate', '2024-12-19 16:25:54'),
('COMMAND:  Silva je iskoristio komandu /cc', '2024-12-19 16:26:00'),
('COMMAND:  Silva je iskoristio komandu /tod 1', '2024-12-19 16:28:37'),
('COMMAND:  Silva je iskoristio komandu /setint 0 3', '2024-12-19 16:29:12'),
('COMMAND:  Silva je iskoristio komandu /xgoto -767.463134 -1977.023803 5.113958', '2024-12-19 16:29:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-19 16:29:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-19 16:29:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-19 16:29:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-19 16:29:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-19 16:29:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-19 16:29:25'),
('COMMAND:  Silva je iskoristio komandu / f.', '2024-12-19 16:29:36'),
('COMMAND:  Silva je iskoristio komandu /f .', '2024-12-19 16:29:39'),
('COMMAND:  Silva je iskoristio komandu /f .', '2024-12-19 16:30:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f e', '2024-12-19 16:30:15'),
('COMMAND:  Silva je iskoristio komandu /f ,', '2024-12-19 16:30:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-19 16:30:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-19 16:30:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 1 0', '2024-12-19 16:30:50'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-19 16:30:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 1 0', '2024-12-19 16:30:52'),
('COMMAND:  Silva je iskoristio komandu /jetpack', '2024-12-19 16:31:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 1 1', '2024-12-19 16:31:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /fv', '2024-12-19 16:33:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-19 16:35:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-19 16:35:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-19 16:36:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1w', '2024-12-19 16:36:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /g alo bre', '2024-12-19 16:40:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidanw', '2024-12-19 17:45:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidanw', '2024-12-19 17:45:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:50:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:50:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:50:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:50:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:52:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:52:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:52:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:53:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /vokisupercharged', '2024-12-19 17:53:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:53:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:55:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:56:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:56:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-19 17:58:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:58:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:58:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:58:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:58:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 17:58:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidanw', '2024-12-19 17:58:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidanww', '2024-12-19 17:58:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:00:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:00:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:00:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:05:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:05:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:05:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:06:07');
INSERT INTO `log_commands` (`log_str`, `date`) VALUES
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:06:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:06:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:06:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /stats', '2024-12-19 18:06:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /stats', '2024-12-19 18:06:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:06:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:07:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:07:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-19 18:07:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /stats', '2024-12-19 18:20:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-19 18:21:16'),
('COMMAND:  Vostic je iskoristio komandu /goto 0', '2024-12-19 18:23:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 1=', '2024-12-19 18:23:37'),
('COMMAND:  Vostic je iskoristio komandu /goto 0', '2024-12-19 18:23:38'),
('COMMAND:  Vostic je iskoristio komandu /goto 0', '2024-12-19 18:23:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 1', '2024-12-19 18:23:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 1', '2024-12-19 18:23:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite', '2024-12-19 18:26:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 1', '2024-12-19 18:26:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 1', '2024-12-19 18:27:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 1', '2024-12-19 18:27:14'),
('COMMAND:  Vostic je iskoristio komandu /sveh 522', '2024-12-19 18:41:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 1', '2024-12-19 18:41:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f ooo', '2024-12-19 18:42:04'),
('COMMAND:  Vostic je iskoristio komandu /f a', '2024-12-19 18:42:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560', '2024-12-19 18:50:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /fv', '2024-12-19 18:50:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 18:51:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 18:51:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spanel', '2024-12-19 18:52:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 18:52:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 20:44:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-19 20:44:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /getint', '2024-12-19 20:44:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 20:45:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /todolist', '2024-12-19 20:45:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /todo', '2024-12-19 20:45:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 20:45:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 20:47:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-19 20:47:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 20:48:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-19 20:48:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoiler', '2024-12-19 20:48:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-19 20:48:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-19 20:49:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-19 20:49:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-19 20:49:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-19 20:49:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 20:52:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-19 20:53:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /todolist', '2024-12-19 20:53:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 20:56:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-19 20:56:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 20:56:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-19 20:56:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 20:57:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-19 20:58:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 20:58:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-19 20:58:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 20:58:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /todolist', '2024-12-19 20:58:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 20:58:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-19 20:59:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 20:59:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-19 20:59:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 20:59:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-19 20:59:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 20:59:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-19 20:59:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:00:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:00:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:00:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-19 21:00:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:00:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 21:04:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-19 21:05:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-19 21:05:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:05:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:05:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-19 21:05:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:05:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:06:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-19 21:06:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:06:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:06:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-19 21:06:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:06:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:06:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 21:09:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-19 21:09:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-19 21:10:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:10:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:10:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-19 21:10:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:10:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:10:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-19 21:10:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:11:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-19 21:11:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:11:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-19 21:11:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:11:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:11:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 1 1', '2024-12-19 21:12:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /stats', '2024-12-19 21:12:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /stats', '2024-12-19 21:12:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-19 21:12:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-19 21:19:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-19 21:19:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:20:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-19 21:20:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:20:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:20:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-19 21:20:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:22:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:22:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-19 21:22:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:22:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:22:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-19 21:22:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:22:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-19 21:22:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:23:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:23:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-19 21:23:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-19 21:23:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-19 21:23:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-19 21:24:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 6', '2024-12-19 22:04:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 6', '2024-12-19 22:04:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 1', '2024-12-19 22:04:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-19 22:04:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-19 22:04:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jail', '2024-12-19 22:04:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jail 1 1 1', '2024-12-19 22:05:14'),
('COMMAND:  Vostic je iskoristio komandu /sveh 522', '2024-12-20 13:29:45'),
('COMMAND:  Vostic je iskoristio komandu /slap 0', '2024-12-20 13:31:17'),
('COMMAND:  Vostic je iskoristio komandu /kill', '2024-12-20 13:31:31'),
('COMMAND:  Vostic je iskoristio komandu /komande', '2024-12-20 13:31:38'),
('COMMAND:  Vostic je iskoristio komandu /komande', '2024-12-20 13:31:45'),
('COMMAND:  Vostic je iskoristio komandu //q', '2024-12-20 13:35:38'),
('COMMAND:  Vostic je iskoristio komandu /setvw 0 10', '2024-12-20 13:46:00'),
('COMMAND:  Vostic je iskoristio komandu /setint 0 0', '2024-12-20 13:46:26'),
('COMMAND:  Vostic je iskoristio komandu /sveh 522', '2024-12-20 13:50:54'),
('COMMAND:  Vostic je iskoristio komandu /sveh 522', '2024-12-20 13:56:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-20 14:17:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-20 14:17:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-20 14:17:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-20 14:17:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 14:18:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 14:18:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 14:18:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-20 14:18:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 14:18:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /champspoilers', '2024-12-20 14:18:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-20 14:18:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-20 14:19:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 14:19:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-20 14:19:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-20 14:19:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 14:19:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 14:20:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /carservice', '2024-12-20 14:20:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 14:35:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 14:35:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /q2', '2024-12-20 14:43:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 14:44:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 14:45:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 14:45:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 14:49:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 14:49:52'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-20 14:51:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 14:51:42'),
('COMMAND:  Silva je iskoristio komandu /setint', '2024-12-20 14:51:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 14:51:48'),
('COMMAND:  Silva je iskoristio komandu /startservis', '2024-12-20 14:52:55'),
('COMMAND:  Silva je iskoristio komandu /startservices', '2024-12-20 14:52:57'),
('COMMAND:  Silva je iskoristio komandu /startservices', '2024-12-20 14:53:02'),
('COMMAND:  Silva je iskoristio komandu /lslist', '2024-12-20 14:53:10'),
('COMMAND:  Silva je iskoristio komandu /lsist', '2024-12-20 14:53:13'),
('COMMAND:  Silva je iskoristio komandu /llist', '2024-12-20 14:53:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 14:55:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 14:55:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 14:59:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 14:59:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 15:02:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-20 15:02:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 15:04:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 15:04:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 15:11:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 15:11:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-20 15:11:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 15:11:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 15:16:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 15:16:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 15:16:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 15:16:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 15:30:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 15:30:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 15:32:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 15:32:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 15:33:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-20 15:33:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 15:33:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-20 15:33:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 15:33:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 15:34:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /notify', '2024-12-20 16:36:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /jedemnudlesvakidan', '2024-12-20 16:36:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-20 16:41:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-20 16:42:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-20 16:42:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-20 16:42:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 1 1 1', '2024-12-20 16:42:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 1 ', '2024-12-20 16:42:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney', '2024-12-20 16:42:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 1 1', '2024-12-20 16:42:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-20 16:42:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-20 19:14:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-20 19:14:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xpdevil', '2024-12-20 19:15:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xpattach', '2024-12-20 19:15:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xattach', '2024-12-20 19:15:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spa', '2024-12-20 19:18:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spa', '2024-12-20 19:19:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-20 19:28:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-20 19:28:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 19:28:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-20 19:28:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 19:28:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-20 19:29:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 19:29:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-20 19:29:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-20 19:29:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 19:29:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 19:30:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 19:30:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 19:30:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 19:32:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-20 19:32:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:27:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:30:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:31:13'),
('COMMAND:  Silva je iskoristio komandu /komande', '2024-12-20 20:31:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:33:03'),
('COMMAND:  Silva je iskoristio komandu /quests', '2024-12-20 20:33:05'),
('COMMAND:  Silva je iskoristio komandu /quests', '2024-12-20 20:33:07'),
('COMMAND:  Silva je iskoristio komandu /komande', '2024-12-20 20:33:26'),
('COMMAND:  Silva je iskoristio komandu /komande', '2024-12-20 20:33:28'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-20 20:33:56'),
('COMMAND:  Silva je iskoristio komandu /buybizcenter', '2024-12-20 20:34:23'),
('COMMAND:  Silva je iskoristio komandu /giveplayermoney', '2024-12-20 20:34:27'),
('COMMAND:  Silva je iskoristio komandu /jetpack', '2024-12-20 20:34:37'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-20 20:37:20'),
('COMMAND:  Silva je iskoristio komandu /dron', '2024-12-20 20:37:34'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-20 20:37:47'),
('COMMAND:  Silva je iskoristio komandu /giveplayermoney', '2024-12-20 20:38:21'),
('COMMAND:  Silva je iskoristio komandu /giveplayermoney 0 100.00 1', '2024-12-20 20:38:27'),
('COMMAND:  Silva je iskoristio komandu /giveplayermoney 0 100.00 1', '2024-12-20 20:38:41'),
('COMMAND:  Silva je iskoristio komandu /giveplayermoney 0 100.00 1', '2024-12-20 20:38:41'),
('COMMAND:  Silva je iskoristio komandu /giveplayermoney 0 100.00 1', '2024-12-20 20:38:41'),
('COMMAND:  Silva je iskoristio komandu /giveplayermoney 0 100.00 1', '2024-12-20 20:38:52'),
('COMMAND:  Silva je iskoristio komandu /jetpack', '2024-12-20 20:39:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-20 20:41:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:41:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:41:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:41:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:41:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-20 20:44:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:44:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /questsw', '2024-12-20 20:44:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /questsw', '2024-12-20 20:44:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:44:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:44:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:45:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:45:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:45:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 20:49:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-20 20:50:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-20 20:50:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 21:09:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-20 21:09:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 08:50:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 08:50:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 08:50:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 08:50:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /c', '2024-12-21 08:51:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 08:51:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-21 08:51:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-21 08:51:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-21 08:51:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-21 08:51:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-21 08:52:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-21 08:52:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsc', '2024-12-21 08:52:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-21 08:52:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-21 08:52:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 08:53:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 08:53:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 08:53:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 08:53:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 08:54:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 08:54:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 08:54:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 10:02:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 10:02:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 10:02:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 10:02:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-21 10:03:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 10:04:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 10:07:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 10:07:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-21 10:33:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 10:33:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gps', '2024-12-21 10:34:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 11:58:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 11:58:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gps', '2024-12-21 11:58:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-21 11:58:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gps', '2024-12-21 11:59:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gps', '2024-12-21 11:59:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gps', '2024-12-21 12:00:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gpsoff', '2024-12-21 12:00:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gpsoff', '2024-12-21 12:00:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gps', '2024-12-21 12:00:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 12:00:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 12:01:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 12', '2024-12-21 12:38:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 170.662719, -82.817192, 1002.156555', '2024-12-21 12:38:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-21 12:39:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 12:41:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 14', '2024-12-21 12:42:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 152.745544, -70.060661, 1001.895690', '2024-12-21 12:42:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 152.745544, -70.060661, 1005.895690', '2024-12-21 12:42:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 152.745544, -70.060661, 1004.895690', '2024-12-21 12:42:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 14', '2024-12-21 12:42:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 1', '2024-12-21 12:43:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 1', '2024-12-21 12:43:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 13', '2024-12-21 12:43:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 14', '2024-12-21 12:43:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 14', '2024-12-21 12:43:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 15', '2024-12-21 12:43:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 15', '2024-12-21 12:43:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 18', '2024-12-21 12:43:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 1', '2024-12-21 12:44:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 19', '2024-12-21 12:44:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 20', '2024-12-21 12:44:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 21', '2024-12-21 12:44:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 21', '2024-12-21 12:44:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 20', '2024-12-21 12:44:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 20', '2024-12-21 12:44:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 18', '2024-12-21 12:44:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 18', '2024-12-21 12:45:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 17', '2024-12-21 12:45:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setivw 0 11', '2024-12-21 12:45:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 11', '2024-12-21 12:45:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 18', '2024-12-21 12:45:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 19', '2024-12-21 12:45:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 19w', '2024-12-21 12:45:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-21 12:45:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:14:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-21 13:14:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:14:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-21 13:14:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spanel', '2024-12-21 13:14:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createbusiness', '2024-12-21 13:15:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createbusiness Levis 1 13 1', '2024-12-21 13:15:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:16:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-21 13:16:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:16:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-21 13:16:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createbusiness', '2024-12-21 13:17:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createbusiness Binco 1 13 1', '2024-12-21 13:17:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:22:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-21 13:22:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:22:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-21 13:22:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:26:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:27:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-21 13:27:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 13:29:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 13:30:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 13:30:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:30:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:35:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-21 13:35:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:35:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:36:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:38:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-21 13:38:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:38:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:38:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:39:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:39:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:39:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:43:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:43:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:43:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:43:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:45:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:46:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testniggers', '2024-12-21 13:49:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:49:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:50:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:50:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:50:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:50:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:50:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:50:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:50:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:50:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:51:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:51:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:51:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:51:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:52:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:52:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:52:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testniggers', '2024-12-21 13:53:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /testnigger', '2024-12-21 13:53:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:57:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 13:57:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 13:57:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 14:53:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 14:53:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 14:53:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 14:56:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 8', '2024-12-21 14:58:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 1298.4663,1560.8510,100.6721', '2024-12-21 14:58:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 15:01:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 15:01:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 15:01:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 15:09:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-21 15:12:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 15:26:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 15:27:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 15:27:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 15:27:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 15:27:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 15:30:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 15:31:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 17:15:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spanel', '2024-12-21 17:15:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-21 17:17:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 17:20:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /burglary', '2024-12-21 17:24:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /burglary', '2024-12-21 17:25:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /burglary', '2024-12-21 17:30:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto 2087.1863, -1557.7731, 12.8787', '2024-12-21 17:34:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /burglary', '2024-12-21 19:10:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-21 19:13:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 19:14:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 19:20:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 19:21:55'),
('COMMAND:  Silva je iskoristio komandu /goto 0', '2024-12-21 19:23:36'),
('COMMAND:  Silva je iskoristio komandu /cc', '2024-12-21 19:23:46'),
('COMMAND:  Silva je iskoristio komandu /bank', '2024-12-21 19:23:51'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-21 19:24:13'),
('COMMAND:  Silva je iskoristio komandu /bank', '2024-12-21 19:25:07'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:25:28'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:25:33'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:25:35'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:25:37'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:25:39'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:25:42'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:25:44'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:25:50'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:25:55'),
('COMMAND:  Silva je iskoristio komandu /cc', '2024-12-21 19:26:01'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:26:03'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:26:17'),
('COMMAND:  Silva je iskoristio komandu /server', '2024-12-21 19:26:31'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:26:33'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:26:50'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:27:09'),
('COMMAND:  Silva je iskoristio komandu /anims', '2024-12-21 19:28:24'),
('COMMAND:  Silva je iskoristio komandu /anim', '2024-12-21 19:28:25'),
('COMMAND:  Silva je iskoristio komandu /jetpack', '2024-12-21 19:28:27'),
('COMMAND:  Silva je iskoristio komandu /jetpack', '2024-12-21 19:29:12'),
('COMMAND:  Silva je iskoristio komandu /spanek', '2024-12-21 19:29:20'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:29:21'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:30:00'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:30:03'),
('COMMAND:  Silva je iskoristio komandu /metro', '2024-12-21 19:30:19'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:30:22'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:30:25'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:30:28'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:30:31'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-21 19:30:47'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:30:51'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:31:05'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:31:11'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:31:17'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:31:21'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:31:21'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:31:25'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:31:30'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-21 19:31:39'),
('COMMAND:  Silva je iskoristio komandu /ainvite', '2024-12-21 19:32:07'),
('COMMAND:  Silva je iskoristio komandu /ubacime', '2024-12-21 19:32:09'),
('COMMAND:  Silva je iskoristio komandu /ubaci', '2024-12-21 19:32:12'),
('COMMAND:  Silva je iskoristio komandu /makelider', '2024-12-21 19:32:17'),
('COMMAND:  Silva je iskoristio komandu /makeleader', '2024-12-21 19:32:19'),
('COMMAND:  Silva je iskoristio komandu /cc', '2024-12-21 19:32:23'),
('COMMAND:  Silva je iskoristio komandu /org', '2024-12-21 19:32:40'),
('COMMAND:  Silva je iskoristio komandu /orginvite', '2024-12-21 19:32:43'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:32:45'),
('COMMAND:  Silva je iskoristio komandu /arrest', '2024-12-21 19:33:17'),
('COMMAND:  Silva je iskoristio komandu /wl', '2024-12-21 19:33:18'),
('COMMAND:  Silva je iskoristio komandu /su', '2024-12-21 19:33:20'),
('COMMAND:  Silva je iskoristio komandu /aubaci', '2024-12-21 19:33:25'),
('COMMAND:  Silva je iskoristio komandu /inviteme', '2024-12-21 19:33:29'),
('COMMAND:  Silva je iskoristio komandu /pd', '2024-12-21 19:33:32'),
('COMMAND:  Silva je iskoristio komandu /police', '2024-12-21 19:33:34'),
('COMMAND:  Silva je iskoristio komandu /f a', '2024-12-21 19:33:41'),
('COMMAND:  Silva je iskoristio komandu /f kuraccc', '2024-12-21 19:33:43'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-21 19:33:44'),
('COMMAND:  Silva je iskoristio komandu /setint 0 3', '2024-12-21 19:35:24'),
('COMMAND:  Silva je iskoristio komandu /xgoto -767.463134 -1977.023803 5.113958', '2024-12-21 19:35:28'),
('COMMAND:  Silva je iskoristio komandu /f a', '2024-12-21 19:36:22'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-21 19:36:23'),
('COMMAND:  Silva je iskoristio komandu /setint 0 0', '2024-12-21 19:36:40'),
('COMMAND:  Silva je iskoristio komandu /setint 0 0', '2024-12-21 19:36:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 19:39:17'),
('COMMAND:  Silva je iskoristio komandu /f silva je tata', '2024-12-21 19:39:59'),
('COMMAND:  Silva je iskoristio komandu /f silva je tata', '2024-12-21 19:40:01'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-21 19:40:02'),
('COMMAND:  Silva je iskoristio komandu /inv', '2024-12-21 19:40:43'),
('COMMAND:  Silva je iskoristio komandu /inventory', '2024-12-21 19:40:46'),
('COMMAND:  Silva je iskoristio komandu /inventory', '2024-12-21 19:40:53'),
('COMMAND:  Silva je iskoristio komandu /inventory', '2024-12-21 19:40:56'),
('COMMAND:  Silva je iskoristio komandu /spec', '2024-12-21 19:41:03'),
('COMMAND:  Silva je iskoristio komandu /sms', '2024-12-21 19:41:06'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:41:16'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:41:17'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:41:32'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:41:36'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:41:49'),
('COMMAND:  Silva je iskoristio komandu /giveplayermoney', '2024-12-21 19:41:59'),
('COMMAND:  Silva je iskoristio komandu /givemoney', '2024-12-21 19:42:05'),
('COMMAND:  Silva je iskoristio komandu /givemoney 1 120000', '2024-12-21 19:42:10'),
('COMMAND:  Silva je iskoristio komandu /sever', '2024-12-21 19:42:11'),
('COMMAND:  Silva je iskoristio komandu /spanel', '2024-12-21 19:42:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 19:43:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 19:44:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 19:56:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-21 19:57:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 20:00:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 20:28:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 20:30:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 20:31:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-21 20:39:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 21:12:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-21 21:12:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 09:13:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:13:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:13:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:14:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:14:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:14:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:14:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 09:16:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-22 09:16:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 19', '2024-12-22 09:16:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -1098.321777, -203.046279, 16.343063', '2024-12-22 09:16:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -1098.321777, -203.046279, 10.343063', '2024-12-22 09:16:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -1098.321777, -203.046279, 10.343063', '2024-12-22 09:16:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /xgoto -1098.321777, -203.046279, 14.343063', '2024-12-22 09:17:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 09:32:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /getint', '2024-12-22 09:32:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createmetro', '2024-12-22 09:33:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:33:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createstation', '2024-12-22 09:33:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createstation', '2024-12-22 09:33:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createstation Voki Supercharged', '2024-12-22 09:33:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createstation Debela Guza', '2024-12-22 09:33:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /stationlist', '2024-12-22 09:34:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /liststations', '2024-12-22 09:34:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:34:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:34:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:35:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:39:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:40:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:40:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:40:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 09:40:31');
INSERT INTO `log_commands` (`log_str`, `date`) VALUES
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /editstation', '2024-12-22 09:40:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /editstation', '2024-12-22 09:40:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /editstation 1 Fjerit Olsun', '2024-12-22 09:40:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:40:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:41:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:41:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /deletestation', '2024-12-22 09:41:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /deletestation 1', '2024-12-22 09:41:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /travel', '2024-12-22 09:41:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:41:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-22 09:41:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 09:45:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:46:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:46:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:46:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:49:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:49:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:49:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:49:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:49:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:50:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:51:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:54:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 09:54:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 10:08:57'),
('COMMAND:  Vostic je iskoristio komandu /goto 0', '2024-12-22 13:21:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 1', '2024-12-22 13:21:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givecrypto', '2024-12-22 13:21:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givecrypto 0 1 100', '2024-12-22 13:21:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /exchange', '2024-12-22 13:21:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /exchangecrypto', '2024-12-22 13:21:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /exchangecrypto 1 0 500', '2024-12-22 13:21:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /exchangecrypto 1 0 50', '2024-12-22 13:21:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /transfercrypto', '2024-12-22 13:22:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /transfer', '2024-12-22 13:22:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sendcrypto', '2024-12-22 13:22:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sendcrypto 1 1 40', '2024-12-22 13:22:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mycrypto', '2024-12-22 13:23:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:41:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:44:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:44:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:44:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:47:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:47:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:48:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:49:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:49:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:49:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:50:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:50:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:53:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:53:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:53:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:53:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:53:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:53:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:53:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:58:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:58:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:58:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 13:59:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 15:28:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-22 15:29:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createsz', '2024-12-22 15:29:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createsz', '2024-12-22 15:29:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 15:30:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /exchangecrypto', '2024-12-22 15:33:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /exchangecrypto 1 3 3', '2024-12-22 15:33:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 15:33:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-22 15:33:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 15:37:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 15:37:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 15:37:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-22 15:39:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-22 15:40:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-22 15:40:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 15:47:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 15:47:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 15:50:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 15:51:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 15:54:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 16:00:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 16:12:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 16:13:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 16:13:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 16:19:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 16:23:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 16:24:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 16:28:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 17:26:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 17:27:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 17:27:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 17:28:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 17:28:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 17:28:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 17:29:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 17:29:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 17:30:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 17:30:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:13:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:17:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:33:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:33:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:39:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:39:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:40:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:54:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:55:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:55:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setplayermoney ', '2024-12-22 18:55:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setplayermoney  0 1000 1', '2024-12-22 18:56:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:56:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /ccc', '2024-12-22 18:56:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 18:56:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setplayermoney 0 1 5000', '2024-12-22 18:56:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setplayermoney 0', '2024-12-22 18:56:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setplayermoney 0 5000 1', '2024-12-22 18:56:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:56:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 18:57:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:57:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 18:58:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 18:59:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 19:00:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-22 19:00:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gps', '2024-12-22 19:00:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 19:01:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 19:01:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 19:02:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 19:02:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quitjob', '2024-12-22 19:02:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 19:03:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-22 19:03:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-22 19:03:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-22 19:03:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-22 19:03:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-22 19:04:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-22 19:04:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-22 19:04:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-22 19:04:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-22 19:05:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quitjob', '2024-12-22 19:06:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-22 19:06:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sethunger', '2024-12-22 19:20:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givehunger', '2024-12-22 19:20:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-22 20:42:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-22 20:42:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-22 20:42:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-22 20:42:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-22 20:43:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-22 20:43:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-22 20:43:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-22 20:43:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-22 20:44:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-22 20:44:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 20:45:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 20:45:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 20:46:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 20:46:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 20:49:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-22 20:49:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 1', '2024-12-22 20:50:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /goto 0', '2024-12-22 20:50:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 0', '2024-12-22 20:50:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney', '2024-12-22 20:51:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 1 1000', '2024-12-22 20:51:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 1000 1', '2024-12-22 20:51:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 14:38:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /g eee', '2024-12-23 14:38:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /g ojsa', '2024-12-23 14:38:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-23 14:38:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-23 14:50:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-23 14:50:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-23 14:51:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-23 15:06:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-23 15:08:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 15:10:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 15:10:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 15:10:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 15:16:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 15:17:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 15:17:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 1 1', '2024-12-23 15:18:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /fv', '2024-12-23 15:25:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-23 15:52:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /pinrandomvehicle', '2024-12-23 15:54:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /pinradnomvehicle', '2024-12-23 15:57:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /pinrandomvehicle', '2024-12-23 15:57:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 520 1 1', '2024-12-23 16:15:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 16:19:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /qw', '2024-12-23 16:25:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:27:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:27:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /portw', '2024-12-23 16:27:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /portw', '2024-12-23 16:27:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:27:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:28:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-23 16:29:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-23 16:29:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:29:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:30:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-23 16:30:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:34:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:34:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:34:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:34:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /refresh', '2024-12-23 16:35:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:35:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /refresh', '2024-12-23 16:35:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:36:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:36:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /refresh', '2024-12-23 16:37:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 16:40:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 16:50:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 16:50:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu //q', '2024-12-23 17:18:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /pinrandomvehicle', '2024-12-23 17:28:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /pinrandomvehicle', '2024-12-23 17:28:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /refresh', '2024-12-23 17:30:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 17:30:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 17:30:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 17:51:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-23 17:51:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-23 17:52:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /refresh', '2024-12-23 17:52:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 17:52:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 17:52:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 17:53:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /askq', '2024-12-23 18:38:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /askq Volim garave', '2024-12-23 18:38:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lp', '2024-12-23 18:38:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /questions', '2024-12-23 18:38:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 18:49:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 18:50:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /refresh', '2024-12-23 18:50:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 18:50:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 18:50:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 18:50:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /refresh', '2024-12-23 18:50:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 18:52:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 18:52:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 18:52:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 18:52:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 18:56:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-23 19:11:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-23 19:11:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 19:13:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createmetro', '2024-12-23 19:13:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-23 19:13:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /kreirajmetro', '2024-12-23 19:13:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createstation', '2024-12-23 19:14:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createstation Maryland - Market Station', '2024-12-23 19:14:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-23 19:14:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 19:14:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createstation', '2024-12-23 19:14:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createstation Maryland - H4RBOR Bank', '2024-12-23 19:14:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-23 19:14:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-23 19:14:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-23 19:56:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 19:57:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 19:57:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 19:57:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-23 19:57:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-23 19:57:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 20:45:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:45:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:45:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /notifyme', '2024-12-23 20:45:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 20:48:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:48:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:49:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /unrent', '2024-12-23 20:49:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 20:49:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 1 1', '2024-12-23 20:49:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:49:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 20:52:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:52:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 20:54:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:54:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:54:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:54:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:55:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-23 20:55:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 20:55:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 20:57:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu //dl', '2024-12-23 20:57:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 20:57:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:57:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /portw', '2024-12-23 20:57:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /portw', '2024-12-23 20:57:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 20:57:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 21:07:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 21:07:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 21:07:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-23 21:19:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /fv', '2024-12-23 21:36:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /katana', '2024-12-23 21:41:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /mask', '2024-12-23 21:41:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 21:41:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 21:41:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /fv', '2024-12-23 21:45:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 21:45:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /help createbusiness', '2024-12-23 21:46:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /help createbusiness', '2024-12-23 21:46:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createbusiness', '2024-12-23 21:46:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createbusiness 7Elven 1 1 450000', '2024-12-23 21:47:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 21:47:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /katana', '2024-12-23 21:59:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /metro', '2024-12-23 22:27:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /medic', '2024-12-23 22:27:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-23 22:27:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /help', '2024-12-23 22:28:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /komande', '2024-12-23 22:28:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /komande', '2024-12-23 22:28:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /komande', '2024-12-23 22:28:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveitem', '2024-12-23 22:29:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveitem 50 1', '2024-12-23 22:29:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-23 22:29:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-23 22:29:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /changespawn', '2024-12-23 22:37:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /changespawn', '2024-12-23 22:39:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spawnchange', '2024-12-23 22:43:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /chagnespawn', '2024-12-23 22:43:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spawn', '2024-12-23 22:43:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /changespawn', '2024-12-23 22:43:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /changespawn', '2024-12-23 22:44:35'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-24 13:25:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite', '2024-12-24 13:27:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 0', '2024-12-24 13:27:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f e', '2024-12-24 13:27:10'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 13:27:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:27:15'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 13:29:10'),
('COMMAND:  Silva je iskoristio komandu /fre', '2024-12-24 13:29:12'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 13:29:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:29:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f e', '2024-12-24 13:29:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f e', '2024-12-24 13:29:23'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-24 13:29:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:29:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f aaa', '2024-12-24 13:31:39'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 13:31:41'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-24 13:31:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:31:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 1', '2024-12-24 13:32:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 1', '2024-12-24 13:32:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:32:23'),
('COMMAND:  Silva je iskoristio komandu /f a', '2024-12-24 13:32:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:32:26'),
('COMMAND:  Silva je iskoristio komandu /f a', '2024-12-24 13:35:24'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-24 13:35:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 1', '2024-12-24 13:35:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f ee', '2024-12-24 13:35:32'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 13:35:33'),
('COMMAND:  Silva je iskoristio komandu /metro', '2024-12-24 13:36:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faciton', '2024-12-24 13:36:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:36:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:37:02'),
('COMMAND:  Silva je iskoristio komandu /stas', '2024-12-24 13:41:26'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-24 13:41:27'),
('COMMAND:  Silva je iskoristio komandu /crypto', '2024-12-24 13:41:30'),
('COMMAND:  Silva je iskoristio komandu /exchangecrypto', '2024-12-24 13:41:35'),
('COMMAND:  Silva je iskoristio komandu /komande', '2024-12-24 13:41:48'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-24 13:43:36'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-24 13:43:37'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-24 13:43:41'),
('COMMAND:  Silva je iskoristio komandu /cc', '2024-12-24 13:48:09'),
('COMMAND:  Silva je iskoristio komandu /cc', '2024-12-24 13:48:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f eee', '2024-12-24 13:54:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 1', '2024-12-24 13:55:02'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 13:55:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f eeee', '2024-12-24 13:55:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:55:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /leader', '2024-12-24 13:55:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:55:33'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-24 13:56:33'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-24 13:56:34'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-24 13:56:36'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-24 13:56:37'),
('COMMAND:  Silva je iskoristio komandu /winter', '2024-12-24 13:56:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 1', '2024-12-24 13:58:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 1', '2024-12-24 13:58:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f ALOOO', '2024-12-24 13:58:27'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 13:58:27'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-24 13:58:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:58:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 13:58:42'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 13:58:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f aa', '2024-12-24 13:59:02'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 13:59:07'),
('COMMAND:  Silva je iskoristio komandu /port', '2024-12-24 14:00:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 0', '2024-12-24 14:00:48'),
('COMMAND:  Silva je iskoristio komandu /setint 0 0', '2024-12-24 14:00:50'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 14:00:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f ee', '2024-12-24 14:00:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 0', '2024-12-24 14:00:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f e', '2024-12-24 14:01:03'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 14:01:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 14:01:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 14:01:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /f alo', '2024-12-24 14:01:22'),
('COMMAND:  Silva je iskoristio komandu /f e', '2024-12-24 14:01:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-24 14:01:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /finvite 0 ', '2024-12-24 14:02:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 14:02:08'),
('COMMAND:  Silva je iskoristio komandu /faction', '2024-12-24 14:02:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 14:02:13'),
('COMMAND:  Silva je iskoristio komandu /faction', '2024-12-24 14:02:29'),
('COMMAND:  Silva je iskoristio komandu /faction', '2024-12-24 14:02:32'),
('COMMAND:  Silva je iskoristio komandu /faction', '2024-12-24 14:02:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 14:04:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-24 14:30:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createfv', '2024-12-24 14:32:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-24 14:32:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createfv', '2024-12-24 14:32:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createfv 1 411 1', '2024-12-24 14:32:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createfv', '2024-12-24 14:35:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createfv', '2024-12-24 14:35:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createfv 1 411 1', '2024-12-24 14:35:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createfv', '2024-12-24 14:38:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /createfv 1 411 1 ', '2024-12-24 14:38:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 14:39:35'),
('COMMAND:  Silva je iskoristio komandu /stats', '2024-12-24 14:40:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /faction', '2024-12-24 14:40:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:47:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:47:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:47:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:50:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:50:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:51:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:51:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:51:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /CC', '2024-12-24 16:51:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:52:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveitem 0 51', '2024-12-24 16:52:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveitem 51 1', '2024-12-24 16:52:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:52:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:52:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:53:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:53:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveitem 1 51', '2024-12-24 16:53:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:53:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveitem 51 1', '2024-12-24 16:53:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:53:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 16:53:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 17:32:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 17:33:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-24 17:33:05'),
('COMMAND:  Vostic je iskoristio komandu /port', '2024-12-24 18:05:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-24 18:05:41'),
('COMMAND:  Vostic je iskoristio komandu /setint', '2024-12-24 18:05:44'),
('COMMAND:  Vostic je iskoristio komandu /buzz 0', '2024-12-24 18:05:58'),
('COMMAND:  Vostic je iskoristio komandu /buzz 1', '2024-12-24 18:06:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /accept', '2024-12-24 18:06:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney', '2024-12-24 18:06:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 9000000 1', '2024-12-24 18:06:26'),
('COMMAND:  Vostic je iskoristio komandu /buybizcenter', '2024-12-24 18:06:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /buzz 0', '2024-12-24 18:07:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /buzz 0', '2024-12-24 18:07:07'),
('COMMAND:  Vostic je iskoristio komandu /accept', '2024-12-24 18:07:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /buybizcenter', '2024-12-24 18:08:30'),
('COMMAND:  Vostic je iskoristio komandu /port', '2024-12-24 18:08:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 9000000 1', '2024-12-24 18:08:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /buybizcenter', '2024-12-24 18:08:44'),
('COMMAND:  Vostic je iskoristio komandu /buybizcenter', '2024-12-24 18:08:50'),
('COMMAND:  Vostic je iskoristio komandu /port', '2024-12-24 18:11:37'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /buybizcenter', '2024-12-24 18:11:57'),
('COMMAND:  Vostic je iskoristio komandu /buybizcenter', '2024-12-24 18:11:58'),
('COMMAND:  Vostic je iskoristio komandu /buzz 0', '2024-12-24 18:12:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /accept', '2024-12-24 18:12:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-24 18:13:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-24 20:36:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 20:36:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-24 20:36:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 20:37:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-24 20:37:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 20:37:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-24 20:37:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 20:38:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-24 20:38:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-24 20:46:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 20:47:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-24 20:47:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 20:48:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-24 20:49:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 20:49:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-24 20:49:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-24 20:49:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-24 20:50:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-24 20:54:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-24 20:54:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 20:54:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-24 20:54:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-24 20:58:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-24 20:58:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-24 20:58:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 20:58:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-24 21:01:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-24 21:01:09'),
('COMMAND:  Vostic je iskoristio komandu /port', '2024-12-24 21:01:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /gethere 1', '2024-12-24 21:01:28'),
('COMMAND:  Vostic je iskoristio komandu /winter', '2024-12-24 21:01:33'),
('COMMAND:  Vostic je iskoristio komandu /winter', '2024-12-24 21:01:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-24 21:01:52'),
('COMMAND:  Vostic je iskoristio komandu /startservice', '2024-12-24 21:01:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 21:01:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-24 21:02:05'),
('COMMAND:  Vostic je iskoristio komandu /bumpers', '2024-12-24 21:02:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:02:21'),
('COMMAND:  Vostic je iskoristio komandu /lsclist', '2024-12-24 21:02:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-24 21:02:27'),
('COMMAND:  Vostic je iskoristio komandu /spoilers', '2024-12-24 21:02:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:02:46'),
('COMMAND:  Vostic je iskoristio komandu /lsclist', '2024-12-24 21:02:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-24 21:02:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:02:55'),
('COMMAND:  Vostic je iskoristio komandu /wheels', '2024-12-24 21:02:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-24 21:03:16'),
('COMMAND:  Vostic je iskoristio komandu /wheels', '2024-12-24 21:03:19'),
('COMMAND:  Vostic je iskoristio komandu /lsclist', '2024-12-24 21:03:21'),
('COMMAND:  Vostic je iskoristio komandu /nitrous', '2024-12-24 21:03:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:03:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-24 21:03:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 21:17:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-24 21:17:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:17:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-24 21:18:03'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:18:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-24 21:18:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:18:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-24 21:18:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 21:19:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-24 21:19:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:19:38'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spa', '2024-12-24 21:19:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:20:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-24 21:25:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 21:25:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-24 21:25:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-24 21:25:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-24 21:26:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:26:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-24 21:26:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:26:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-24 21:27:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:27:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-24 21:27:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:27:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-24 21:27:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:28:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-24 21:28:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:28:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 21:33:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:33:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-24 21:33:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:33:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-24 21:33:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-24 21:33:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:33:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-24 21:34:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-24 21:34:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 21:44:35'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-24 21:52:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-24 21:52:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setvw 0 0', '2024-12-25 10:17:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /startservice', '2024-12-25 10:18:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /refresh', '2024-12-25 10:18:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-25 10:18:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-25 10:19:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-25 10:19:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bumpers', '2024-12-25 10:19:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-25 10:19:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spoilers', '2024-12-25 10:19:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-25 10:20:15'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-25 10:20:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-25 10:20:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /wheels', '2024-12-25 10:20:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-25 10:20:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-25 10:21:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /nitrous', '2024-12-25 10:21:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /lsclist', '2024-12-25 10:21:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-25 10:21:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-25 10:21:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /inventory', '2024-12-25 10:21:50');
INSERT INTO `log_commands` (`log_str`, `date`) VALUES
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 10:27:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /refresh', '2024-12-25 10:28:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /catalogue', '2024-12-25 10:28:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 11', '2024-12-25 10:30:00'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522', '2024-12-25 10:30:13'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 10:39:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-25 10:39:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 11', '2024-12-25 10:40:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 11', '2024-12-25 10:40:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 11:00:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 560 1 1', '2024-12-25 11:00:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 520', '2024-12-25 11:04:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 590 1 1', '2024-12-25 11:42:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 592 1 1', '2024-12-25 11:42:30'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 592 1 1', '2024-12-25 11:42:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 593', '2024-12-25 11:42:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 593', '2024-12-25 11:42:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 593', '2024-12-25 11:42:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 569', '2024-12-25 11:42:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 569', '2024-12-25 11:42:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 569', '2024-12-25 11:42:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 569', '2024-12-25 11:42:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 432', '2024-12-25 11:42:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 12:07:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /hotel', '2024-12-25 12:08:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 12:09:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /hotel', '2024-12-25 12:10:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /changespawn', '2024-12-25 12:10:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-25 12:12:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /getvw', '2024-12-25 12:12:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /getint', '2024-12-25 12:12:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setint 0 0', '2024-12-25 12:12:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-25 12:13:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /spanel', '2024-12-25 12:13:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /buyhouse', '2024-12-25 12:14:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 12:15:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-25 12:15:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /buyhouse', '2024-12-25 12:16:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-25 12:18:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /buyhouse', '2024-12-25 12:18:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 12:43:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /changespawn', '2024-12-25 12:43:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-25 12:44:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-25 12:44:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /changespawn', '2024-12-25 13:22:31'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-25 13:23:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-25 13:28:54'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-25 13:28:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-25 13:29:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-25 13:29:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 21:28:57'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 21:32:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 21:32:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 22:07:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 22:15:02'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-25 22:15:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 22:18:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-25 22:18:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /dodatak1', '2024-12-25 22:28:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 22:29:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /dodatak1', '2024-12-25 22:33:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-25 22:47:46'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 09:53:25'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 09:53:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-26 09:53:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-26 10:08:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /qw', '2024-12-26 10:10:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-26 10:16:41'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-26 10:16:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 10:16:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-26 10:17:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-26 10:17:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 10:21:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-26 10:22:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 10:24:14'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-26 10:24:33'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-26 10:24:44'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-26 10:24:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /bank', '2024-12-26 10:24:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 10:25:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-26 10:25:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:50:50'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 10:50:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /catalogue', '2024-12-26 10:51:06'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:51:20'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:51:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:51:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:51:43'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:51:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:52:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 10:54:05'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:54:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 10:54:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:54:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:54:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:54:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 10:55:22'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 180', '2024-12-26 13:37:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /setskin 0 20', '2024-12-26 13:37:53'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 13:50:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /attachments', '2024-12-26 14:22:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /attachments', '2024-12-26 14:24:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /attachments', '2024-12-26 14:26:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /eo', '2024-12-26 14:27:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-26 14:27:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /attachments', '2024-12-26 14:27:18'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /quests', '2024-12-26 14:29:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 14:30:10'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-26 14:30:24'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-26 14:38:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 14:39:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-26 14:40:56'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /otkaz', '2024-12-26 14:40:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /attachments', '2024-12-26 14:50:51'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /attachments', '2024-12-26 14:51:27'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-26 14:53:19'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-26 14:53:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-26 14:53:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /attachments', '2024-12-26 15:17:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 18:49:04'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 18:49:07'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 18:49:29'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 18:49:34'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 18:49:47'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 18:49:49'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /v', '2024-12-26 18:49:52'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-26 18:53:32'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 18:53:59'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-26 18:54:16'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-26 18:54:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-26 18:54:45'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-26 18:54:48'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-26 18:54:55'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /house', '2024-12-26 18:54:58'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /giveplayermoney 0 1 1', '2024-12-26 18:55:17'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 19:49:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-26 19:49:17'),
('COMMAND:  Silva je iskoristio komandu /sc DOSO SAM SAMO DA KAZEM JEDAN VELIKI RISPEKT NODIJU', '2024-12-26 19:49:22'),
('COMMAND:  Silva je iskoristio komandu /sc DOSO SAM SAMO DA KAZEM JEDAN VELIKI RISPEKT NODIJU', '2024-12-26 19:49:23'),
('COMMAND:  Silva je iskoristio komandu /sc DOSO SAM SAMO DA KAZEM JEDAN VELIKI RISPEKT NODIJU', '2024-12-26 19:49:23'),
('COMMAND:  Silva je iskoristio komandu /jetpack', '2024-12-26 19:53:21'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 19:56:01'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 20:00:08'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-26 20:00:11'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /firma', '2024-12-26 20:00:23'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /firma', '2024-12-26 20:00:26'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /port', '2024-12-26 20:03:09'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /sveh 522 1 1', '2024-12-26 20:03:12'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /firma', '2024-12-26 20:03:28'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /firma', '2024-12-26 20:03:36'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /firma', '2024-12-26 20:03:39'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /firma', '2024-12-26 20:03:40'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /firma', '2024-12-26 20:03:42'),
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /cc', '2024-12-26 20:03:48'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:42:54'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:42:58'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:42:59'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:42:59'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:00'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:00'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:02'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:12'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:13'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:14'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:15'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:15'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:16'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:17'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:18'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:19'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:20'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:21'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:32'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:33'),
('COMMAND:  Vostic je iskoristio komandu /notifytestt', '2024-12-27 17:43:34'),
('COMMAND:  Vostic je iskoristio komandu /notifytestt', '2024-12-27 17:43:35'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:36'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:37'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:38'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:39'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:39'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:43:40'),
('COMMAND:  Vostic je iskoristio komandu /testnotify', '2024-12-27 17:48:16'),
('COMMAND:  Vostic je iskoristio komandu /testnotify', '2024-12-27 17:48:17'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:23'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:24'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:25'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:25'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:26'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:26'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:27'),
('COMMAND:  Vostic je iskoristio komandu /notifytestt', '2024-12-27 17:48:27'),
('COMMAND:  Vostic je iskoristio komandu /notifytestt', '2024-12-27 17:48:33'),
('COMMAND:  Vostic je iskoristio komandu /notifytestt', '2024-12-27 17:48:34'),
('COMMAND:  Vostic je iskoristio komandu /notifytestt', '2024-12-27 17:48:34'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:36'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:37'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:37'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:38'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:38'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:39'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:40'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:42'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:43'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:43'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:44'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:45'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:45'),
('COMMAND:  Vostic je iskoristio komandu /notifytest', '2024-12-27 17:48:46'),
('COMMAND:  Vostic je iskoristio komandu /sveh 522', '2024-12-27 18:13:14'),
('COMMAND:  Vostic je iskoristio komandu /quests', '2024-12-27 18:36:52'),
('COMMAND:  Vostic je iskoristio komandu /startservice', '2024-12-27 18:37:35'),
('COMMAND:  Vostic je iskoristio komandu /bumpers', '2024-12-27 18:37:41'),
('COMMAND:  Vostic je iskoristio komandu /lsclist', '2024-12-27 18:38:01'),
('COMMAND:  Vostic je iskoristio komandu /spoilers', '2024-12-27 18:38:07'),
('COMMAND:  Vostic je iskoristio komandu /lsclist', '2024-12-27 18:38:23'),
('COMMAND:  Vostic je iskoristio komandu /wheels', '2024-12-27 18:38:29'),
('COMMAND:  Vostic je iskoristio komandu /lsclist', '2024-12-27 18:38:47'),
('COMMAND:  Vostic je iskoristio komandu /nitrous', '2024-12-27 18:38:53'),
('COMMAND:  Vostic je iskoristio komandu /quests', '2024-12-27 18:39:20'),
('COMMAND:  Vostic je iskoristio komandu /portr', '2024-12-27 18:39:30'),
('COMMAND:  Vostic je iskoristio komandu /port', '2024-12-27 18:39:32'),
('COMMAND:  Vostic je iskoristio komandu /quitjob', '2024-12-27 18:39:50'),
('COMMAND:  Vostic je iskoristio komandu /otkaz', '2024-12-27 18:39:52'),
('COMMAND:  Vostic je iskoristio komandu /bank', '2024-12-27 18:39:58'),
('COMMAND:  Vostic je iskoristio komandu /bank', '2024-12-27 18:40:16'),
('COMMAND:  Vostic je iskoristio komandu /quests', '2024-12-27 18:40:19'),
('COMMAND:  Vostic je iskoristio komandu /por', '2024-12-27 18:40:26'),
('COMMAND:  Vostic je iskoristio komandu /port', '2024-12-27 18:40:27'),
('COMMAND:  Vostic je iskoristio komandu /setint 0 0', '2024-12-27 18:40:36'),
('COMMAND:  Vostic je iskoristio komandu /setvw 0 0', '2024-12-27 18:40:39'),
('COMMAND:  Vostic je iskoristio komandu /quests', '2024-12-27 18:42:19'),
('COMMAND:  Vostic je iskoristio komandu /port', '2024-12-27 18:42:27'),
('COMMAND:  Vostic je iskoristio komandu /sveh 522', '2024-12-27 18:42:35'),
('COMMAND:  Vostic je iskoristio komandu /quests', '2024-12-27 18:43:01'),
('COMMAND:  Vostic je iskoristio komandu /port', '2024-12-27 18:43:11'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:11'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:13'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:14'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:15'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:41'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:42'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:42'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:43'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:43'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:44'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:44'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:45'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:45'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:46'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:47'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:48'),
('COMMAND:  Vostic je iskoristio komandu /givexpgej', '2024-12-27 18:47:49'),
('COMMAND:  Vostic je iskoristio komandu /q/q', '2024-12-27 18:47:57');

-- --------------------------------------------------------

--
-- Table structure for table `log_connection`
--

CREATE TABLE `log_connection` (
  `log_str` varchar(128) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `log_connection`
--

INSERT INTO `log_connection` (`log_str`, `date`) VALUES
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-09 10:04:14'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-09 11:08:38'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-09 11:32:40'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-09 11:38:10'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-09 11:49:35'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-09 12:04:11'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-09 12:08:57'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-09 21:47:45'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-09 21:50:24'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-11 18:19:10'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-11 18:23:52'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-13 15:24:28'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-13 22:05:51'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-13 22:09:57'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-13 22:13:49'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-13 22:22:38'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-14 21:45:31'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-14 21:54:21'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-14 22:06:14'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 10:35:25'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 10:38:52'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 10:41:02'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-15 12:22:26'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 12:23:18'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 13:01:51'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 13:03:07'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 13:06:58'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 13:10:12'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 13:17:44'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 13:19:24'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 13:22:07'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 13:23:09'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 14:38:49'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 14:53:01'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 14:54:23'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 14:58:26'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:06:52'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:10:41'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:12:33'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:18:14'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:20:44'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:38:16'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:44:00'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:49:44'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:52:46'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 15:59:57'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 16:08:30'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-15 16:15:26'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 16:15:34'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-15 16:16:36'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 16:36:57'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 16:39:15'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 16:44:57'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-15 16:45:24'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 17:06:17'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-15 17:07:19'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 17:10:50'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-15 17:11:28'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-15 19:23:46'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 16:19:21'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-19 16:19:34'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-19 16:28:23'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 16:28:35'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 17:44:37'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 17:49:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 17:51:58'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 17:54:54'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 17:57:51'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 18:00:09'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 18:05:15'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 18:07:13'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 18:20:32'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-19 18:21:49'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-19 18:23:12'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 18:25:39'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-19 18:26:52'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 18:39:29'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-19 18:40:03'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 18:51:02'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 20:44:02'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 20:47:15'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 20:52:34'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 20:55:57'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 20:57:40'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 21:04:24'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 21:09:15'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-19 21:19:15'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 26.57.53.176', '2024-12-19 22:01:07'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 26.57.53.176', '2024-12-19 22:03:55'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-19 22:04:02'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-19 22:13:41'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-19 22:14:42'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-19 22:28:36'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-19 22:33:08'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-19 22:39:27'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 12:49:20'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 12:58:52'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:02:24'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:06:38'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:08:24'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:12:40'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:13:32'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:28:36'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:30:47'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:32:12'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:34:43'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:36:02'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:45:30'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:48:57'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:50:25'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:52:54'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 13:56:10'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-20 14:00:28'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 14:17:22'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 14:34:59'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 14:44:17'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 14:49:12'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-20 14:51:09'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 14:51:10'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 14:54:27'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 14:58:28'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 15:01:33'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 15:04:04'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 15:10:56'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 15:15:46'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 15:19:07'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 15:22:28'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 15:29:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 15:32:01'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 16:36:01'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 16:41:38'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 19:13:47'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 19:17:46'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 19:18:48'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 19:19:07'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 19:27:54'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 19:32:05'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 20:26:47'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 20:30:19'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-20 20:30:57'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-20 20:32:37'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 20:32:46'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 20:41:04'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 20:44:23'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 20:49:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 21:07:00'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-20 21:09:01'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 08:44:06'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 08:46:27'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 08:50:04'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 08:54:33'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 10:01:59'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 10:07:04'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 10:32:30'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 11:57:56'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 12:38:15'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 12:41:32'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 12:43:19'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:13:52'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:16:22'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:22:32'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:25:34'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:26:42'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:29:17'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:35:39'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:37:58'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:39:05'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:43:16'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:45:35'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:49:34'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:52:26'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 13:57:16'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 14:52:51'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 15:01:08'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 15:09:21'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 15:11:47'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 15:26:40'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 15:30:12'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 17:15:00'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 17:23:13'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 17:30:06'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 19:09:54'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 19:14:38'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 19:20:30'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-21 19:23:21'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-21 19:24:48'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 19:39:02'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-21 19:39:41'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 19:42:58'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 19:56:37'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 20:28:07'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 20:30:17'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-21 21:12:15'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 09:13:11'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 09:32:37'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 09:39:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 09:45:29'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 09:49:03'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 09:53:53'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 10:08:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 13:20:26'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-22 13:20:35'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 13:41:19'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 13:43:54'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 13:48:20'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 13:52:48'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 13:58:22'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 15:28:09'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 15:37:02'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 15:47:14'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 15:50:08'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 15:53:49'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 16:12:41'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 16:23:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 16:28:41'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 17:26:23'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 17:29:34'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 18:13:40'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 18:17:08'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 18:33:11'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 18:39:05'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 18:54:21'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 19:20:08'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 20:42:00'),
('CONNECT-LOG:  Frenkie_Deep se konektuje na server | IP : 26.14.197.215', '2024-12-22 20:47:27'),
('CONNECT-LOG:  Frenkie_Deep se konektuje na server | IP : 26.14.197.215', '2024-12-22 20:47:45'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-22 20:47:51'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 14:37:56'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 14:49:47'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 15:05:49'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 15:08:41'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 15:16:08'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 15:52:44'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 15:55:53'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:15:32'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:18:54'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:23:31'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:25:13'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:26:05'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:28:36'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:30:18'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:34:20'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:36:30'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:39:51'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:43:10'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:46:24'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:51:42'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:55:44'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 16:57:42'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 17:13:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 17:19:09'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 17:23:49'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 17:27:57'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 17:50:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 18:37:49'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 18:49:44'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 18:56:36'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 18:58:15'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 19:00:42'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 19:05:31'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 19:08:25'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 19:10:23'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 20:44:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 20:48:23'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 20:51:46'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 20:54:11'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 21:06:54'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 21:15:35'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 21:19:18'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 21:33:45'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 21:41:06'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 21:59:26'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 22:24:14'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 22:26:52'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 22:37:14'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 22:39:30'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 22:43:01'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-23 22:44:07'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-24 13:25:41'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 13:26:46'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-24 13:28:58'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 13:29:01'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 13:31:27'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-24 13:31:27'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 13:34:57'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-24 13:35:03'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 13:54:34'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-24 13:54:38'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 13:57:52'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-24 13:57:57'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-24 14:00:26'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 14:00:31'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 14:32:01'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 14:34:26'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 14:38:32'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-24 14:39:40'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 16:47:24'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 16:50:36'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 17:32:34'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-24 18:05:17'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 18:05:25'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 18:08:11'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-24 18:08:17'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 18:10:30'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 18:11:16'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-24 18:11:21'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 20:36:02'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 20:46:31'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 20:54:11'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 20:58:07'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 21:00:42'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-24 21:01:02'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 21:17:00'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 21:24:47'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 21:32:30'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 21:44:05'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-24 21:51:49'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 10:17:20'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 10:27:27'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 10:39:31'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-25 10:59:35'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 11:00:26'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 11:41:48'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 12:06:50'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 12:09:41'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 12:10:35'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 12:12:13'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 12:15:03'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 12:17:43'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 12:42:25'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 12:43:54'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 13:23:00'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 13:28:37'),
('CONNECT-LOG:  Filip_Panic se konektuje na server | IP : 127.0.0.1', '2024-12-25 17:33:39'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 17:42:03'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 21:28:36'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 21:32:37'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 22:07:24'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 22:14:46'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 22:17:51'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 22:22:58'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 22:27:47'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-25 22:46:12'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 09:53:05'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 10:13:23'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 10:15:25'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 10:21:31'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 10:23:56'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 10:50:28'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 10:53:48'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 13:35:23'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 14:22:28'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 14:24:09'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 14:29:08'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 15:17:31'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 15:18:45'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 15:19:16'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 15:21:29'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 15:21:54'),
('CONNECT-LOG:  Gobejla_West se konektuje na server | IP : 127.0.0.1', '2024-12-26 15:32:21'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 18:48:44'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 19:48:23'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-26 19:49:02'),
('CONNECT-LOG:  Silva se konektuje na server | IP : 26.201.160.164', '2024-12-26 19:52:54'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 19:55:42'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 19:59:49'),
('CONNECT-LOG:  Nodislav_Aleksienko se konektuje na server | IP : 127.0.0.1', '2024-12-26 20:02:55'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-27 17:42:37'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-27 17:47:59'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-27 18:12:39'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-27 18:27:03'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-27 18:35:57'),
('CONNECT-LOG:  Vostic se konektuje na server | IP : 127.0.0.1', '2024-12-27 18:46:55');

-- --------------------------------------------------------

--
-- Table structure for table `log_crecords`
--

CREATE TABLE `log_crecords` (
  `log_str` varchar(128) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `log_crecords`
--

INSERT INTO `log_crecords` (`log_str`, `date`) VALUES
('ROBBERY:  Nodislav_Aleksienko je obio kasu | Iznos novca 159', '2024-12-21 13:17:27'),
('ROBBERY:  Nodislav_Aleksienko je obio kasu | Iznos novca 46', '2024-12-21 13:23:12');

-- --------------------------------------------------------

--
-- Table structure for table `log_faction`
--

CREATE TABLE `log_faction` (
  `log_str` varchar(128) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log_staff`
--

CREATE TABLE `log_staff` (
  `log_str` varchar(128) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `log_staff`
--

INSERT INTO `log_staff` (`log_str`, `date`) VALUES
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-11 18:46:31'),
('STAFF:  Nodislav_Aleksienko je zamrznuo igraca Nodislav_Aleksienko', '2024-12-13 22:17:26'),
('STAFF:  Nodislav_Aleksienko je odmrznuo igraca Nodislav_Aleksienko', '2024-12-13 22:17:28'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-15 10:44:09'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-15 16:00:39'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 1 igracu Vostic', '2024-12-15 16:16:38'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-15 16:16:47'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 1 igracu Nodislav_Aleksienko', '2024-12-15 16:17:01'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 3 igracu Nodislav_Aleksienko', '2024-12-15 16:17:04'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 4 igracu Nodislav_Aleksienko', '2024-12-15 16:17:06'),
('STAFF:  Nodislav_Aleksienko je zamrznuo igraca Vostic', '2024-12-15 16:17:49'),
('STAFF:  Nodislav_Aleksienko je odmrznuo igraca Nodislav_Aleksienko', '2024-12-15 16:17:59'),
('STAFF:  Nodislav_Aleksienko je zamrznuo igraca Vostic', '2024-12-15 16:18:02'),
('STAFF:  Nodislav_Aleksienko je zamrznuo igraca Vostic', '2024-12-15 16:18:04'),
('STAFF:  Nodislav_Aleksienko je odmrznuo igraca Nodislav_Aleksienko', '2024-12-15 16:18:06'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-15 16:39:49'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 4 igracu Nodislav_Aleksienko', '2024-12-15 16:45:29'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-15 16:48:13'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-15 16:48:17'),
('STAFF:  Vostic je dao oruzje id 30 igracu Nodislav_Aleksienko', '2024-12-15 16:49:04'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-15 16:49:09'),
('STAFF:  Nodislav_Aleksienko je zamrznuo igraca Vostic', '2024-12-15 16:54:09'),
('STAFF:  Nodislav_Aleksienko je odmrznuo igraca Nodislav_Aleksienko', '2024-12-15 16:54:14'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 34 igracu Nodislav_Aleksienko', '2024-12-15 16:56:32'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-15 17:18:41'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-19 18:21:16'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-24 18:13:47'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-26 10:08:53'),
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-26 14:53:21');

-- --------------------------------------------------------

--
-- Table structure for table `metro_stations`
--

CREATE TABLE `metro_stations` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `metro_stations`
--

INSERT INTO `metro_stations` (`id`, `name`, `x`, `y`, `z`) VALUES
(1, 'Voki Supercharged', 2004.93, -1452.46, 13.5547),
(3, 'Maryland - Market Station', 827.046, -1333.97, 13.5469),
(4, 'Maryland - H4RBOR Bank', 1007.32, -1154.45, 23.8321);

-- --------------------------------------------------------

--
-- Table structure for table `mowerdata`
--

CREATE TABLE `mowerdata` (
  `storageCapacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mowerdata`
--

INSERT INTO `mowerdata` (`storageCapacity`) VALUES
(266);

-- --------------------------------------------------------

--
-- Table structure for table `player_crypto`
--

CREATE TABLE `player_crypto` (
  `character_id` int(11) NOT NULL,
  `AmountBTC` float DEFAULT NULL,
  `AmountETH` float DEFAULT NULL,
  `AmountLTC` float DEFAULT NULL,
  `AmountUSDT` float DEFAULT NULL,
  `AmountDOT` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_crypto`
--

INSERT INTO `player_crypto` (`character_id`, `AmountBTC`, `AmountETH`, `AmountLTC`, `AmountUSDT`, `AmountDOT`) VALUES
(2, 0, 0, 0, 0, 0),
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
(13, 0, 0, 0, 0, 0),
(14, 0, 0, 0, 0, 0),
(15, 0, 0, 0, 0, 0),
(16, 0, 0, 0, 0, 0),
(17, 0, 0, 0, 0, 0),
(18, 0, 0, 0, 0, 0),
(19, 0, 0, 0, 0, 0),
(20, 0, 0, 0, 0, 0),
(21, 0, 0, 0, 0, 0),
(22, 0, 0, 0, 0, 0),
(23, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_documents`
--

CREATE TABLE `player_documents` (
  `character_document` int(11) NOT NULL,
  `NationalID` int(11) NOT NULL,
  `Passport` int(11) NOT NULL,
  `DriveLicense` int(11) NOT NULL,
  `MotoLicense` int(11) NOT NULL,
  `BoatLicense` int(11) NOT NULL,
  `GunLicense` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_documents`
--

INSERT INTO `player_documents` (`character_document`, `NationalID`, `Passport`, `DriveLicense`, `MotoLicense`, `BoatLicense`, `GunLicense`) VALUES
(4, 0, 0, 1, 0, 0, 0),
(11, 0, 0, 1, 0, 0, 0),
(24, 0, 0, 0, 0, 0, 0),
(25, 0, 0, 0, 0, 0, 0),
(26, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_electronic`
--

CREATE TABLE `player_electronic` (
  `character_electronics` int(11) NOT NULL,
  `Dron` tinyint(4) NOT NULL DEFAULT 0,
  `Battery` int(11) NOT NULL DEFAULT 0,
  `GPS` tinyint(4) NOT NULL DEFAULT 0,
  `phoneModel` int(11) NOT NULL DEFAULT -1,
  `phoneNumber` varchar(16) NOT NULL DEFAULT '0 | 0 | 0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_electronic`
--

INSERT INTO `player_electronic` (`character_electronics`, `Dron`, `Battery`, `GPS`, `phoneModel`, `phoneNumber`) VALUES
(4, 0, 0, 0, 0, '60 | 826 | 245'),
(11, 0, 1, 1, 3, '61 | 179 | 872'),
(24, 0, 0, 0, -1, '0 | 0 | 0'),
(25, 0, 0, 0, -1, '0 | 0 | 0'),
(26, 0, 0, 0, -1, '0 | 0 | 0');

-- --------------------------------------------------------

--
-- Table structure for table `player_jails`
--

CREATE TABLE `player_jails` (
  `character_id` int(11) NOT NULL,
  `jailType` int(11) NOT NULL,
  `jailTime` int(11) NOT NULL,
  `jailedBy` varchar(25) NOT NULL,
  `jailDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_jewlery`
--

CREATE TABLE `player_jewlery` (
  `character_id` int(11) NOT NULL,
  `Gold` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_jewlery`
--

INSERT INTO `player_jewlery` (`character_id`, `Gold`) VALUES
(3, 0),
(4, 0),
(11, 0),
(15, 0),
(16, 0),
(17, 0),
(18, 0),
(19, 0),
(20, 0),
(21, 0),
(22, 0),
(23, 0),
(24, 0),
(25, 0),
(26, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_plants`
--

CREATE TABLE `player_plants` (
  `ID` int(11) NOT NULL,
  `GrowTime` int(11) NOT NULL,
  `RothTime` int(11) NOT NULL,
  `CharacterID` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_prisons`
--

CREATE TABLE `player_prisons` (
  `characterID` int(11) NOT NULL,
  `jailTime` int(11) NOT NULL,
  `jailedBy` varchar(24) NOT NULL,
  `jailDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_property`
--

CREATE TABLE `player_property` (
  `pOwner` int(11) NOT NULL,
  `BCenter` int(11) NOT NULL DEFAULT 0,
  `HouseID` int(11) NOT NULL DEFAULT -1,
  `BusinessID` int(11) NOT NULL,
  `HotelRoom` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_property`
--

INSERT INTO `player_property` (`pOwner`, `BCenter`, `HouseID`, `BusinessID`, `HotelRoom`) VALUES
(4, 1, 1, 0, 0),
(11, 2, 4, 3, 150.99),
(24, 0, -1, 0, 0),
(25, 0, -1, 0, 0),
(26, 0, -1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `police_members`
--

CREATE TABLE `police_members` (
  `police_id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `police_rank` int(11) NOT NULL,
  `arrests` int(11) NOT NULL,
  `joinDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ports`
--

CREATE TABLE `ports` (
  `ID` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Type` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ports`
--

INSERT INTO `ports` (`ID`, `Name`, `Type`, `posX`, `posY`, `posZ`) VALUES
(1, 'Spawn', 1, 815.897, -1332.13, 13.4854),
(2, 'Banka', 1, 996.333, -1157.41, 23.9641),
(3, 'Bolnica', 1, 2029.9, -1421.9, 16.9922),
(4, 'Biro Rada', 1, 1454.16, -1028.46, 23.9278),
(5, 'Hotel', 1, 1792.66, -1280.81, 13.7328),
(6, 'Business {737be1}Centre', 1, 1641.53, -1322.93, 17.5447),
(7, 'Baltimore Opstina', 1, 1482.45, -1806.75, 23.7203),
(8, 'Bus Vozac', 2, 1805.88, -1888.63, 13.5076),
(9, 'Trzni Centar', 1, 1114.87, -931.297, 43.1413),
(10, '{737BE1}Police {FFFFFF}Department', 3, 359.57, -1538.13, 33.6132),
(11, 'Auto Salon', 1, 934.99, -1722.07, 13.646),
(12, 'Maryland Jewelry', 1, 1721.67, -1627.55, 20.2128),
(13, 'Auto Skola', 1, 2515.46, -1510, 24.0991),
(14, 'Teretana', 1, 802.339, -1762.18, 13.6466),
(15, 'Technomedia', 1, 1683.79, -1635.24, 13.6461),
(16, 'Polje Plantaze', 1, 1882.75, 222.158, 29.0836),
(17, 'Black Market', 1, -395.579, 1256.56, 6.98163),
(18, 'Stolar', 2, 117.238, -285.258, 1.57812),
(19, 'Kosac Trave', 2, 1238.6, -2378.38, 10.7937),
(20, 'Mehanicar', 2, 1115.75, -1205.48, 17.7822);

-- --------------------------------------------------------

--
-- Table structure for table `pumps`
--

CREATE TABLE `pumps` (
  `pumpID` int(11) NOT NULL,
  `pumpBusinessID` int(11) NOT NULL,
  `pumpFuel` int(11) NOT NULL DEFAULT 0,
  `pumpFuelType` int(11) NOT NULL DEFAULT 0,
  `pump_X` float NOT NULL DEFAULT 0,
  `pump_Y` float NOT NULL DEFAULT 0,
  `pump_Z` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pumps`
--

INSERT INTO `pumps` (`pumpID`, `pumpBusinessID`, `pumpFuel`, `pumpFuelType`, `pump_X`, `pump_Y`, `pump_Z`) VALUES
(1, 0, 4000, 1, 1761.86, -1815.32, 13.5437);

-- --------------------------------------------------------

--
-- Table structure for table `rent`
--

CREATE TABLE `rent` (
  `rentID` int(11) NOT NULL,
  `fVehModel` int(11) NOT NULL DEFAULT 0,
  `sVehModel` int(11) NOT NULL DEFAULT 0,
  `tVehModel` int(11) NOT NULL DEFAULT 0,
  `rPosX` float NOT NULL DEFAULT 0,
  `rPosY` float NOT NULL DEFAULT 0,
  `rPosZ` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rent`
--

INSERT INTO `rent` (`rentID`, `fVehModel`, `sVehModel`, `tVehModel`, `rPosX`, `rPosY`, `rPosZ`) VALUES
(1, 522, 560, 451, 823.602, -1317.12, 13.5262);

-- --------------------------------------------------------

--
-- Table structure for table `re_business`
--

CREATE TABLE `re_business` (
  `bID` int(11) NOT NULL,
  `bOwner` int(11) NOT NULL DEFAULT 0,
  `bName` varchar(64) NOT NULL DEFAULT 'Undefined',
  `bLocked` int(11) NOT NULL DEFAULT 1,
  `bType` int(11) NOT NULL DEFAULT 1,
  `bPrice` int(11) NOT NULL DEFAULT 250000,
  `bLevel` int(11) NOT NULL DEFAULT 3,
  `bCashRegister` float NOT NULL DEFAULT 0,
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
  `bVW` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `re_business`
--

INSERT INTO `re_business` (`bID`, `bOwner`, `bName`, `bLocked`, `bType`, `bPrice`, `bLevel`, `bCashRegister`, `bEnterX`, `bEnterY`, `bEnterZ`, `bExitX`, `bExitY`, `bExitZ`, `bInteractX`, `bInteractY`, `bInteractZ`, `bActorSkin`, `bActorX`, `bActorY`, `bActorZ`, `bActorA`, `bProducts`, `bInt`, `bVW`) VALUES
(1, 0, 'Ammunation', 0, 11, 250000, 10, 0, 1367.08, -1280.09, 13.6461, 297.14, -109.87, 1001.51, 288.258, -109.782, 1001.52, 179, 288, -112, 1002, 1, 100, 6, 1),
(2, 0, '7Eleven', 0, 1, 250000, 1, 3.4, 973.081, -1288.71, 13.454, 1414.38, 430.507, 1081.5, 1421.31, 432.656, 1081.5, 20, 1423, 433, 1082, 92, 100, 18, 2),
(3, 11, 'Binco', 0, 13, 250000, 1, 650.45, 961.075, -1288.42, 13.454, 161.097, -96.6359, 1001.8, 179.544, -83.1313, 1001.79, 1, 181, -83, 1002, 91, 100, 0, 3),
(4, 0, '7Elven', 0, 1, 250000, 1, 0, 1832.97, -1842.59, 13.5781, 1414.38, 430.507, 1081.5, 1421.31, 432.656, 1081.5, 20, 1423, 433, 1082, 92, 100, 18, 4);

-- --------------------------------------------------------

--
-- Table structure for table `re_centar`
--

CREATE TABLE `re_centar` (
  `re_BCenterID` int(11) NOT NULL,
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
  `re_AgentPosA` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `re_centar`
--

INSERT INTO `re_centar` (`re_BCenterID`, `re_BCenterOwner`, `re_BCenterName`, `re_BCenterInterior`, `re_BCenterVirtualWorld`, `re_BCenterType`, `re_BCenterIntX`, `re_BCenterIntY`, `re_BCenterIntZ`, `re_BCenterLocked`, `re_BCenterSafe`, `re_BCenterSafePosX`, `re_BCenterSafePosY`, `re_BCenterSafePosZ`, `re_BCenterWardrobe`, `re_BCenterWardrobePosX`, `re_BCenterWardrobePosY`, `re_BCenterWardrobePosZ`, `re_BCenterArmory`, `re_BCenterArmoryPosX`, `re_BCenterArmoryPosY`, `re_BCenterArmoryPosZ`, `re_BCenterAgentType`, `re_AgentPosX`, `re_AgentPosY`, `re_AgentPosZ`, `re_AgentPosA`) VALUES
(1, 4, 'Mikica', 9, 1, 2, 2277.15, 2199.62, 103.931, 0, 1, 0, 0, 0, 1, 2262.13, 2178.29, 103.916, 1, 2295.51, 2176.33, 103.906, 147, 2279.2, 2183.56, 103.916, 0.2942),
(2, 11, 'Nepoznato', 9, 2, 2, 2277.15, 2199.62, 103.931, 0, 1, 0, 0, 0, 1, 2262.13, 2178.29, 103.916, 1, 2295.51, 2176.33, 103.906, 150, 2279.2, 2183.56, 103.916, 0.2942);

-- --------------------------------------------------------

--
-- Table structure for table `safezones`
--

CREATE TABLE `safezones` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `min_x` float NOT NULL,
  `min_y` float NOT NULL,
  `max_x` float NOT NULL,
  `max_y` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `safezones`
--

INSERT INTO `safezones` (`id`, `name`, `min_x`, `min_y`, `max_x`, `max_y`) VALUES
(1, 'Maryland Central Park', 1436.85, -1722.31, 1521.03, -1600.54);

-- --------------------------------------------------------

--
-- Table structure for table `staff_questions`
--

CREATE TABLE `staff_questions` (
  `ID` int(11) NOT NULL,
  `PlayerID` int(11) NOT NULL,
  `Question` varchar(246) NOT NULL,
  `Date` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vID` int(11) NOT NULL,
  `vOwner` int(11) NOT NULL DEFAULT 0,
  `vOwnerType` int(11) NOT NULL DEFAULT 0,
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
  `vState` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`vID`, `vOwner`, `vOwnerType`, `vModel`, `Color1`, `Color2`, `vPlate`, `vPosX`, `vPosY`, `vPosZ`, `vPosA`, `vRegDate`, `vOil`, `vRange`, `vRangeKM`, `vFuel`, `vFuelType`, `vAlarm`, `vXenon`, `vLock`, `vNitro`, `vState`) VALUES
(1, 11, 0, 410, 0, 0, 'Nodislav_Aleksienko', 951.187, -1725.6, 13.2143, 88.7097, 1737798672, 100, 0, 0, 100, 0, 0, 0, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `warns`
--

CREATE TABLE `warns` (
  `id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `warn_date` datetime NOT NULL,
  `warn_reason` varchar(255) NOT NULL DEFAULT 'Nema',
  `warn_expire` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `winter_settings`
--

CREATE TABLE `winter_settings` (
  `username` varchar(24) NOT NULL DEFAULT 'Maryland',
  `map` tinyint(4) NOT NULL DEFAULT 0,
  `breath` tinyint(4) NOT NULL DEFAULT 0,
  `fallsnow` tinyint(4) NOT NULL DEFAULT 0
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
('Nodislav_Aleksienko', 0, 0, 0),
('Silentus', 0, 0, 0),
('Ogi', 0, 0, 0),
('Capital_Camora', 0, 0, 0),
('Capital_Camoras', 0, 0, 0),
('djasa', 0, 0, 0),
('Klaus', 0, 0, 0),
('Dickey_Corleone', 0, 0, 0),
('Stojke_Castello', 0, 0, 0),
('Vostic', 0, 0, 0),
('Nodislav_Alksienko', 0, 0, 0),
('Casey_Skendy', 0, 0, 0),
('Darko_Jovanovic', 0, 0, 0),
('Vostic_Dev', 0, 0, 0),
('Nodislav', 0, 0, 0),
('Daco_Delahunt', 1, 0, 1),
('Eros_Bosandzeros', 0, 0, 0),
('Silva', 0, 0, 0),
('Silva_Rose', 1, 1, 1),
('Casey', 0, 0, 0),
('Leon_Skandy', 0, 0, 0),
('Midori_Smith', 0, 0, 0),
('Midori_Test', 0, 0, 0),
('Frenkie_Deep', 0, 0, 0),
('Filip_Panic', 0, 0, 0),
('Gobejla_West', 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bankaccounts`
--
ALTER TABLE `bankaccounts`
  ADD PRIMARY KEY (`AccountID`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `benches`
--
ALTER TABLE `benches`
  ADD PRIMARY KEY (`seat_ID`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`registerID`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`character_id`);

--
-- Indexes for table `character_quests`
--
ALTER TABLE `character_quests`
  ADD UNIQUE KEY `cahracterid` (`characterid`);

--
-- Indexes for table `character_spawns`
--
ALTER TABLE `character_spawns`
  ADD UNIQUE KEY `character_id` (`character_id`);

--
-- Indexes for table `containers`
--
ALTER TABLE `containers`
  ADD PRIMARY KEY (`conID`);

--
-- Indexes for table `crypto_wallets`
--
ALTER TABLE `crypto_wallets`
  ADD UNIQUE KEY `character_id` (`character_id`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`factionID`);

--
-- Indexes for table `faction_members`
--
ALTER TABLE `faction_members`
  ADD UNIQUE KEY `member_id` (`member_id`);

--
-- Indexes for table `faction_police`
--
ALTER TABLE `faction_police`
  ADD PRIMARY KEY (`fPoliceID`);

--
-- Indexes for table `faction_vehicles`
--
ALTER TABLE `faction_vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `hCharacterID` (`hOwner`);

--
-- Indexes for table `inv_containers`
--
ALTER TABLE `inv_containers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `life_insurance`
--
ALTER TABLE `life_insurance`
  ADD UNIQUE KEY `character_id` (`character_id`);

--
-- Indexes for table `metro_stations`
--
ALTER TABLE `metro_stations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_crypto`
--
ALTER TABLE `player_crypto`
  ADD UNIQUE KEY `crypto_id` (`character_id`);

--
-- Indexes for table `player_documents`
--
ALTER TABLE `player_documents`
  ADD UNIQUE KEY `player_id` (`character_document`);

--
-- Indexes for table `player_electronic`
--
ALTER TABLE `player_electronic`
  ADD UNIQUE KEY `player_id` (`character_electronics`);

--
-- Indexes for table `player_jails`
--
ALTER TABLE `player_jails`
  ADD UNIQUE KEY `character_id` (`character_id`);

--
-- Indexes for table `player_jewlery`
--
ALTER TABLE `player_jewlery`
  ADD UNIQUE KEY `character_id` (`character_id`);

--
-- Indexes for table `player_plants`
--
ALTER TABLE `player_plants`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `player_property`
--
ALTER TABLE `player_property`
  ADD UNIQUE KEY `player_id` (`pOwner`);

--
-- Indexes for table `police_members`
--
ALTER TABLE `police_members`
  ADD UNIQUE KEY `character_id` (`character_id`);

--
-- Indexes for table `ports`
--
ALTER TABLE `ports`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pumps`
--
ALTER TABLE `pumps`
  ADD PRIMARY KEY (`pumpID`);

--
-- Indexes for table `rent`
--
ALTER TABLE `rent`
  ADD PRIMARY KEY (`rentID`);

--
-- Indexes for table `re_business`
--
ALTER TABLE `re_business`
  ADD PRIMARY KEY (`bID`);

--
-- Indexes for table `re_centar`
--
ALTER TABLE `re_centar`
  ADD PRIMARY KEY (`re_BCenterID`),
  ADD KEY `BCenterCharacter` (`re_BCenterOwner`);

--
-- Indexes for table `safezones`
--
ALTER TABLE `safezones`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vID`),
  ADD KEY `vCharacterID` (`vOwner`);

--
-- Indexes for table `warns`
--
ALTER TABLE `warns`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `bankaccounts`
--
ALTER TABLE `bankaccounts`
  MODIFY `AccountID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `benches`
--
ALTER TABLE `benches`
  MODIFY `seat_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `registerID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `character_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `containers`
--
ALTER TABLE `containers`
  MODIFY `conID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `factionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `faction_police`
--
ALTER TABLE `faction_police`
  MODIFY `fPoliceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `faction_vehicles`
--
ALTER TABLE `faction_vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inv_containers`
--
ALTER TABLE `inv_containers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metro_stations`
--
ALTER TABLE `metro_stations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `player_plants`
--
ALTER TABLE `player_plants`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ports`
--
ALTER TABLE `ports`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `pumps`
--
ALTER TABLE `pumps`
  MODIFY `pumpID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rent`
--
ALTER TABLE `rent`
  MODIFY `rentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `re_business`
--
ALTER TABLE `re_business`
  MODIFY `bID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `re_centar`
--
ALTER TABLE `re_centar`
  MODIFY `re_BCenterID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `safezones`
--
ALTER TABLE `safezones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `warns`
--
ALTER TABLE `warns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

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

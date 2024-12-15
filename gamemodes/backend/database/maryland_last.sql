-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2024 at 05:24 PM
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
(31, 'Midori_Test', '123123', 0, '2024-12-07 23:16:34', '2024-12-07 23:16:34', 'dasdasd@gmail.com');

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
(12, 7, 'Player', 111, 222, 333),
(13, 7, 'Player', 444, 555, 666),
(14, 2, 'Faction', 123, 456, 789),
(15, 11, 'Player', 123, 456, 789),
(16, 11, 'Player', 213, 21412, 2151),
(17, 1, 'Faction', 213, 4421, 21412400);

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

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`registerID`, `posX`, `posY`, `posZ`, `rotX`, `rotY`, `rotZ`, `Interior`, `VW`) VALUES
(1, 210.161, -99.4602, 1005.53, 0, 0, 0.000004, 15, 0),
(2, 205.061, -99.3567, 1005.52, 0, 0, -2.99999, 15, 0),
(3, 180.742, -83.6525, 1002.04, 0, 0, -82.4, 0, 0),
(4, 1204.49, -914.51, 43.0407, 0, 0, -168.3, 0, 0);

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
  `cLastX` float NOT NULL DEFAULT 0,
  `cLastY` float NOT NULL DEFAULT 0,
  `cLastZ` float NOT NULL DEFAULT 0,
  `cWanted` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`character_id`, `account_id`, `cName`, `cSkin`, `cGender`, `cAge`, `cJob`, `cState`, `cDollars`, `cEuro`, `cEGPound`, `cLevel`, `cLastLogin`, `cLastX`, `cLastY`, `cLastZ`, `cWanted`) VALUES
(3, 13, 'Mehmed_Melijekovic', 12, 1, 0, 0, 0, 99002000, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(4, 14, 'Joy_Silence', 2, 0, 0, 0, 0, 10003500, 0, 0, 0, '2024-12-15 17:19:40', 1401.78, 1591.35, 12.0481, 0),
(5, 15, 'Ogi_Ivanov', 26, 0, 0, 0, 0, 90000, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(6, 16, 'Capital_Camora', 0, 0, 0, 0, 0, 99000000, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(7, 11, 'Frosty_Saints', 60, 0, 0, 0, 0, 1120400000, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(8, 18, 'Tyrone_Rowe', 22, 0, 0, 0, 0, 90000, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(9, 19, 'Klaus_Brt', 22, 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(10, 20, 'Dickey_Corleone', 22, 0, 0, 0, 0, 123, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(11, 13, 'Ferid_Olsun', 180, 0, 0, 0, 0, 2692, 0, 0, 0, '2024-12-15 17:19:58', 1401.78, 1591.35, 12.0481, 0),
(13, 21, 'Ferid_Olsunchek', 12, 1, 0, 0, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(14, 22, 'macka_macic', 22, 0, 0, 0, 0, 100000000, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(15, 23, 'Vostic_Doktor', 0, 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(17, 13, 'Nigger_123', 0, 0, 0, 0, 0, 5700, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(18, 24, 'Daco_Delahunt', 0, 0, 0, 0, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 1401.78, 1591.35, 12.0481, 0),
(19, 26, 'Silva_Rose', 60, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-08 14:37:25', 1401.78, 1591.35, 12.0481, 0),
(20, 27, 'Sila_Rose', 156, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-08 13:55:52', 1401.78, 1591.35, 12.0481, 0),
(21, 28, 'Casey_Skandy', 178, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-08 00:25:31', 1401.78, 1591.35, 12.0481, 0),
(22, 29, 'Leon_Skandy', 177, 0, 0, 0, 0, -1000, 0, 0, 0, '2024-12-08 00:24:43', 1401.78, 1591.35, 12.0481, 0),
(23, 30, 'Midori_Smith', 22, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-08 13:31:15', 1401.78, 1591.35, 12.0481, 0);

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
(1, 'Capital Silent', 1, 1, 14, 0, 0, 0, 0, 0, 0),
(2, 'PICKE PANDURSKE', 1, 1, 14, 0, 0, 0, 0, 0, 0);

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
(6, 0, 7, 1),
(0, 1, 1, 1),
(14, 0, 7, 1),
(0, 2, 1, 1),
(11, 2, 1, 0);

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
(1, 11, 50000, 1, 'Brooklyn Park, Maryland', 0, 834.234, -1333.98, 13.5465, 224.28, 1289.19, 1082.14, 0, 0, 0, 0, 0, 224.28, 1289.19, 1082.14, 224.28, 1289.19, 1082.14, 1);

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
(11, 60, 4, 1),
(11, 50, 4, 2),
(11, 51, 4, 2),
(11, 54, 4, 4),
(11, 55, 4, 4),
(11, 56, 4, 2),
(11, 57, 4, 2);

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
(5, 0, 3, 57, 2, 1, 19811, 1420.82, 439.968, 1080.4);

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
('ANTICHEAT-LOG:  Nodislav_Aleksienko se uspjesno prijavio kao RCON | IP: 16777343', '2024-12-15 17:07:28');

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
('COMMAND:  Nodislav_Aleksienko je iskoristio komandu /givegun 0 24 90', '2024-12-15 17:18:41');

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
('CONNECT-LOG:  Vostic se konektuje na server | IP : 26.93.86.234', '2024-12-15 17:11:28');

-- --------------------------------------------------------

--
-- Table structure for table `log_crecords`
--

CREATE TABLE `log_crecords` (
  `log_str` varchar(128) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
('STAFF:  Nodislav_Aleksienko je dao oruzje id 24 igracu Nodislav_Aleksienko', '2024-12-15 17:18:41');

-- --------------------------------------------------------

--
-- Table structure for table `metros`
--

CREATE TABLE `metros` (
  `metroID` int(11) NOT NULL,
  `metroX` float NOT NULL,
  `metroY` float NOT NULL,
  `metroZ` float NOT NULL,
  `MetroRoute` int(11) NOT NULL DEFAULT 1,
  `metroInt` int(11) NOT NULL DEFAULT 0,
  `metroVw` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `metros`
--

INSERT INTO `metros` (`metroID`, `metroX`, `metroY`, `metroZ`, `MetroRoute`, `metroInt`, `metroVw`) VALUES
(1, 869.928, -1337.28, 13.6469, 1, 0, 0);

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
  `GunLicense` int(11) NOT NULL,
  `LifeInsurance` tinyint(4) NOT NULL DEFAULT -1,
  `LifeInsuranceValidUntil` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_documents`
--

INSERT INTO `player_documents` (`character_document`, `NationalID`, `Passport`, `DriveLicense`, `MotoLicense`, `BoatLicense`, `GunLicense`, `LifeInsurance`, `LifeInsuranceValidUntil`) VALUES
(3, 0, 0, 0, 0, 0, 0, -1, '2023-12-02 17:46:46'),
(4, 0, 0, 0, 0, 0, 0, -1, '2023-12-02 17:09:30'),
(5, 0, 0, 0, 0, 0, 0, -1, '2023-12-02 17:47:36'),
(6, 0, 0, 0, 0, 0, 0, -1, '2023-12-02 17:52:48'),
(7, 0, 0, 0, 0, 0, 0, -1, '2023-12-02 17:57:26'),
(8, 0, 0, 0, 0, 0, 0, -1, '2023-12-03 12:47:58'),
(9, 0, 0, 0, 0, 0, 0, -1, '2023-12-03 13:53:44'),
(10, 0, 0, 0, 0, 0, 0, -1, '2023-12-03 16:38:15'),
(11, 0, 0, 0, 0, 0, 0, -1, '2023-12-10 21:05:19'),
(13, 0, 0, 0, 0, 0, 0, -1, '2024-06-03 15:32:18'),
(14, 0, 0, 0, 0, 0, 0, -1, '2024-06-03 16:03:59'),
(15, 0, 0, 0, 0, 0, 0, -1, '2024-10-28 16:42:58'),
(17, 0, 0, 0, 0, 0, 0, -1, '2024-10-28 18:41:45'),
(18, 0, 0, 0, 0, 0, 0, -1, '2024-12-03 20:06:45'),
(19, 0, 0, 0, 0, 0, 0, -1, '2024-12-03 20:07:29'),
(20, 0, 0, 0, 0, 0, 0, -1, '2024-12-07 23:48:01'),
(21, 0, 0, 0, 0, 0, 0, -1, '2024-12-07 23:51:10'),
(22, 0, 0, 0, 0, 0, 0, -1, '2024-12-08 00:14:21'),
(23, 0, 0, 0, 0, 0, 0, -1, '2024-12-08 13:26:44');

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
(11, 0, 0, 0, 3, '61 | 179 | 872'),
(19, 0, 0, 0, -1, '0 | 0 | 0'),
(20, 0, 0, 0, -1, '0 | 0 | 0'),
(21, 0, 0, 0, -1, '0 | 0 | 0'),
(22, 0, 0, 0, -1, '0 | 0 | 0'),
(23, 0, 0, 0, -1, '0 | 0 | 0');

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
(23, 0);

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
  `BusinessID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_property`
--

INSERT INTO `player_property` (`pOwner`, `BCenter`, `HouseID`, `BusinessID`) VALUES
(3, 0, -1, 0),
(4, 0, 1, 0),
(11, 1, 1, 0),
(15, 0, -1, 0),
(17, 0, -1, 0),
(18, 0, -1, 0),
(19, 0, -1, 0),
(20, 0, -1, 0),
(21, 0, -1, 0),
(22, 0, -1, 0),
(23, 0, -1, 0);

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

--
-- Dumping data for table `police_members`
--

INSERT INTO `police_members` (`police_id`, `character_id`, `police_rank`, `arrests`, `joinDate`) VALUES
(1, 11, 1, 0, '2024-12-07 20:16:26');

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
(19, 'Kosac Trave', 2, 1238.6, -2378.38, 10.7937);

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

INSERT INTO `re_business` (`bID`, `bOwner`, `bName`, `bLocked`, `bType`, `bPrice`, `bLevel`, `bEnterX`, `bEnterY`, `bEnterZ`, `bExitX`, `bExitY`, `bExitZ`, `bInteractX`, `bInteractY`, `bInteractZ`, `bActorSkin`, `bActorX`, `bActorY`, `bActorZ`, `bActorA`, `bProducts`, `bInt`, `bVW`) VALUES
(1, 0, 'Ammunation', 0, 11, 250000, 10, 1367.08, -1280.09, 13.6461, 297.14, -109.87, 1001.51, 288.258, -109.782, 1001.52, 179, 288, -112, 1002, 1, 100, 6, 1),
(2, 0, '7Eleven', 0, 1, 250000, 1, 973.081, -1288.71, 13.454, 1414.38, 430.507, 1081.5, 1421.31, 432.656, 1081.5, 20, 1423, 433, 1082, 92, 100, 18, 2);

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
(1, 11, 'FedjaOlsun', 4, 1, 1, 1826.06, -1286.32, 131.754, 0, 1, 0, 0, 0, 1, 2262.13, 2178.29, 103.916, 1, 2295.51, 2176.33, 103.906, 147, 1827.96, -1302.59, 131.739, 3.5893);

-- --------------------------------------------------------

--
-- Table structure for table `safezones`
--

CREATE TABLE `safezones` (
  `safeSQLID` int(11) NOT NULL,
  `MinX` float NOT NULL DEFAULT 0,
  `MinY` float NOT NULL DEFAULT 0,
  `MaxX` float NOT NULL DEFAULT 0,
  `MaxY` float NOT NULL DEFAULT 0,
  `Radius` float NOT NULL DEFAULT 0,
  `Color` int(11) NOT NULL DEFAULT 0,
  `PickupX` float NOT NULL DEFAULT 0,
  `PickupY` float NOT NULL DEFAULT 0,
  `PickupZ` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(2, 14, 0, 451, 211, 211, 'Casey_Skendy', 950.804, -1759.56, 13.2938, 347.9, 1720016265, 100, 0, 0, 100, 0, 1, 1, 0, 1, 1);

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
('Vostic', 1, 0, 1),
('Nodislav_Alksienko', 0, 0, 0),
('Casey_Skendy', 0, 0, 0),
('Darko_Jovanovic', 0, 0, 0),
('Vostic_Dev', 0, 0, 0),
('Nodislav', 0, 0, 0),
('Daco_Delahunt', 1, 0, 1),
('Eros_Bosandzeros', 0, 0, 0),
('Silva', 1, 1, 1),
('Silva_Rose', 1, 1, 1),
('Casey', 0, 0, 0),
('Leon_Skandy', 0, 0, 0),
('Midori_Smith', 0, 0, 0),
('Midori_Test', 0, 0, 0);

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
-- Indexes for table `containers`
--
ALTER TABLE `containers`
  ADD PRIMARY KEY (`conID`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`factionID`);

--
-- Indexes for table `faction_police`
--
ALTER TABLE `faction_police`
  ADD PRIMARY KEY (`fPoliceID`);

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
-- Indexes for table `metros`
--
ALTER TABLE `metros`
  ADD PRIMARY KEY (`metroID`);

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
  ADD PRIMARY KEY (`safeSQLID`);

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `bankaccounts`
--
ALTER TABLE `bankaccounts`
  MODIFY `AccountID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `benches`
--
ALTER TABLE `benches`
  MODIFY `seat_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `registerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `character_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `containers`
--
ALTER TABLE `containers`
  MODIFY `conID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `factionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `faction_police`
--
ALTER TABLE `faction_police`
  MODIFY `fPoliceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inv_containers`
--
ALTER TABLE `inv_containers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metros`
--
ALTER TABLE `metros`
  MODIFY `metroID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `player_plants`
--
ALTER TABLE `player_plants`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ports`
--
ALTER TABLE `ports`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

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
  MODIFY `bID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `re_centar`
--
ALTER TABLE `re_centar`
  MODIFY `re_BCenterID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `safezones`
--
ALTER TABLE `safezones`
  MODIFY `safeSQLID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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

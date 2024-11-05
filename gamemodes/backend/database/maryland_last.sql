-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2024 at 02:21 PM
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
(24, 'Silva_Rose', '123321', 0, '2024-11-05 12:56:50', '2024-11-05 12:56:50', 'sa@gmail.com');

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
  `cMoney` int(11) NOT NULL DEFAULT 0,
  `cLevel` int(11) NOT NULL DEFAULT 0,
  `cLastLogin` int(11) NOT NULL,
  `cLastX` float NOT NULL DEFAULT 0,
  `cLastY` float NOT NULL DEFAULT 0,
  `cLastZ` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`character_id`, `account_id`, `cName`, `cSkin`, `cGender`, `cAge`, `cJob`, `cState`, `cMoney`, `cLevel`, `cLastLogin`, `cLastX`, `cLastY`, `cLastZ`) VALUES
(3, 13, 'Mehmed_Melijekovic', 12, 1, 0, 0, 0, 99002048, 0, 2147483647, 1401.78, 1591.35, 12.0481),
(4, 14, 'Joy_Silence', 60, 0, 0, 0, 0, 9999849, 0, 1701536970, 1401.78, 1591.35, 12.0481),
(5, 15, 'Ogi_Ivanov', 26, 0, 0, 0, 0, 90000, 0, 1701539256, 1401.78, 1591.35, 12.0481),
(6, 16, 'Capital_Camora', 0, 0, 0, 0, 0, 99000000, 0, 1701539568, 1401.78, 1591.35, 12.0481),
(7, 11, 'Frosty_Saints', 60, 0, 0, 0, 0, 1120403456, 0, 1701539846, 1401.78, 1591.35, 12.0481),
(8, 18, 'Tyrone_Rowe', 22, 0, 0, 0, 0, 90000, 0, 1701607678, 1401.78, 1591.35, 12.0481),
(9, 19, 'Klaus_Brt', 22, 0, 0, 0, 0, 0, 0, 1701611624, 1401.78, 1591.35, 12.0481),
(10, 20, 'Dickey_Corleone', 22, 0, 0, 0, 0, 123, 0, 1701621495, 1401.78, 1591.35, 12.0481),
(11, 13, 'Ferid_Olsun', 60, 0, 0, 0, 0, 676000640, 0, 1702238719, 1401.78, 1591.35, 12.0481),
(13, 21, 'Ferid_Olsunchek', 12, 1, 0, 0, 0, 0, 0, 1717421538, 1401.78, 1591.35, 12.0481),
(14, 22, 'macka_macic', 22, 0, 0, 0, 0, 100000000, 0, 1717423439, 1401.78, 1591.35, 12.0481),
(15, 23, 'Vostic_Doktor', 0, 0, 0, 0, 0, 0, 0, 1730130178, 1401.78, 1591.35, 12.0481),
(17, 13, 'Nigger_123', 0, 0, 0, 0, 0, 5700, 0, 1730137305, 1401.78, 1591.35, 12.0481),
(18, 24, 'Silva_Rose', 22, 0, 0, 0, 0, 0, 0, 1730811439, 1401.78, 1591.35, 12.0481);

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
(11, 60, 3, 1),
(11, 50, 4, 2),
(4, 62, 2, 5);

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
(1, 2, 1, 50, 2, 4, 10, 0, 0, 0),
(2, 1, 2, 51, 2, 2, 10, 0, 0, 0);

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
(18, 0, 0, 0, 0, 0);

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
(18, 0, 0, 0, 0, 0, 0, -1, '2024-11-05 13:57:19');

-- --------------------------------------------------------

--
-- Table structure for table `player_electronic`
--

CREATE TABLE `player_electronic` (
  `character_electronics` int(11) NOT NULL,
  `Dron` tinyint(4) NOT NULL DEFAULT 0,
  `Battery` int(11) NOT NULL DEFAULT 0,
  `GPS` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_electronic`
--

INSERT INTO `player_electronic` (`character_electronics`, `Dron`, `Battery`, `GPS`) VALUES
(3, 0, 0, 0),
(4, 0, 0, 0),
(5, 0, 0, 0),
(6, 0, 0, 0),
(7, 0, 0, 0),
(8, 0, 0, 0),
(9, 0, 0, 0),
(10, 0, 0, 0),
(11, 1, 0, 1),
(13, 0, 0, 0),
(14, 0, 0, 0),
(15, 0, 0, 0),
(17, 0, 0, 0),
(18, 0, 0, 0);

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
(18, 0);

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
(18, 0, -1, 0);

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
(18, '{FCB232}Bunker {FFFFFF}Ulaz', 3, -1590.18, -2575.98, 30.3966);

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
  `fVehModel` int(11) NOT NULL,
  `sVehModel` int(11) NOT NULL,
  `tVehModel` int(11) NOT NULL,
  `rPosX` int(11) NOT NULL,
  `rPosY` int(11) NOT NULL,
  `rPosZ` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rent`
--

INSERT INTO `rent` (`rentID`, `fVehModel`, `sVehModel`, `tVehModel`, `rPosX`, `rPosY`, `rPosZ`) VALUES
(0, 522, 562, 560, 824, -1319, 13);

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
(1, 0, 'Ammunation', 0, 11, 250000, 10, 1367.08, -1280.09, 13.6461, 297.14, -109.87, 1001.51, 288.258, -109.782, 1001.52, 179, 288, -112, 1002, 1, 100, 6, 1);

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
('Vostic', 0, 0, 0),
('Nodislav_Alksienko', 0, 0, 0),
('Casey_Skendy', 0, 0, 0),
('Darko_Jovanovic', 0, 0, 0),
('Vostic_Dev', 0, 0, 0),
('Nodislav', 0, 0, 0),
('Silva_Rose', 0, 0, 0);

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
  MODIFY `character_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
  MODIFY `fPoliceID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inv_containers`
--
ALTER TABLE `inv_containers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `pumps`
--
ALTER TABLE `pumps`
  MODIFY `pumpID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `re_business`
--
ALTER TABLE `re_business`
  MODIFY `bID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 27, 2023 at 03:52 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `bankers`
--

CREATE TABLE `bankers` (
  `ID` int(11) NOT NULL,
  `Skin` smallint(3) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `PosA` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `ID` int(11) NOT NULL,
  `Owner` varchar(24) NOT NULL,
  `Password` varchar(32) NOT NULL,
  `Balance` int(11) NOT NULL,
  `CreatedOn` int(11) NOT NULL,
  `LastAccess` int(11) NOT NULL,
  `Disabled` smallint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_atms`
--

CREATE TABLE `bank_atms` (
  `ID` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `RotX` float NOT NULL,
  `RotY` float NOT NULL,
  `RotZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_logs`
--

CREATE TABLE `bank_logs` (
  `ID` int(11) NOT NULL,
  `AccountID` int(11) NOT NULL,
  `ToAccountID` int(11) NOT NULL DEFAULT -1,
  `Type` smallint(1) NOT NULL,
  `Player` varchar(24) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `businesses`
--

CREATE TABLE `businesses` (
  `bizID` int(12) NOT NULL,
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
  `bizShipment` int(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `containers`
--

INSERT INTO `containers` (`conID`, `con_x`, `con_y`, `con_z`, `con_rx`, `con_ry`, `con_rz`, `con_jnumber`) VALUES
(1, 811.135, -1310.95, 13.1908, 0, 0, -1.43625, 0);

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
(1, 'Maryland Police Department', 'MPD', 'Maryland, ', 'Maryland', 0, 2, 326.158, -1514.57, 36.0325, 246.66, 65.8, 1003.64, 6, 0, 0, 0, 0, 254.418, 77.0467, 1003.64, 0, 0, 0, 'Officer', 'Sarge', 'Major', 287, 286, 300, 303);

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
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
  `Int` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`ID`, `PID`, `Price`, `Type`, `Adress`, `Locked`, `PosX`, `PosY`, `PosZ`, `ExitX`, `ExitY`, `ExitZ`, `Safe`, `Money`, `Weed`, `Cocaine`, `Extazy`, `WardX`, `WardY`, `WardZ`, `FridgeX`, `FridgeY`, `FridgeZ`, `Int`) VALUES
(2, 1, 50000, 1, 'Market, Maryland', 0, 830.025, -1331.26, 13.3969, 224.28, 1289.19, 1082.14, 0, 0, 0, 0, 0, 224.28, 1289.19, 1082.14, 224.28, 1289.19, 1082.14, 1);

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
-- Table structure for table `klupe`
--

CREATE TABLE `klupe` (
  `seat_ID` int(11) NOT NULL,
  `seat_x` float NOT NULL,
  `seat_y` float NOT NULL,
  `seat_z` float NOT NULL,
  `seat_a` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `metros`
--

CREATE TABLE `metros` (
  `metroID` int(11) NOT NULL,
  `metroX` float NOT NULL,
  `metroY` float NOT NULL,
  `metroZ` float NOT NULL,
  `metroRuta` int(11) NOT NULL DEFAULT 1,
  `metroInt` int(11) NOT NULL DEFAULT 0,
  `metroVw` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `metros`
--

INSERT INTO `metros` (`metroID`, `metroX`, `metroY`, `metroZ`, `metroRuta`, `metroInt`, `metroVw`) VALUES
(1, 1076.06, -1076.9, 27.3969, 2, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `ID` int(11) NOT NULL,
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
  `Objekat1` tinyint(4) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`ID`, `Username`, `Password`, `Level`, `Novac`, `Skin`, `Godine`, `Staff`, `LastLogin`, `RegisterDate`, `Drzava`, `Pol`, `Email`, `Objekat0`, `Objekat1`) VALUES
(1, 'feridRIZZLER', 511181984, 1, 2000, 29, 16, 0, '26/09/2023 - 20:45', '26/09/2023 - 20:45', 'Maryland', 'Musko', 'ferid420@mailer.com', 1, -1);

-- --------------------------------------------------------

--
-- Table structure for table `player_crypto`
--

CREATE TABLE `player_crypto` (
  `crypto_id` int(11) NOT NULL,
  `KolicinaBTC` float DEFAULT NULL,
  `KolicinaETH` float DEFAULT NULL,
  `KolicinaLTC` float DEFAULT NULL,
  `KolicinaUSDT` float DEFAULT NULL,
  `KolicinaDOT` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE `player_documents` (
  `player_id` int(11) NOT NULL,
  `NationalID` int(11) NOT NULL,
  `Passport` int(11) NOT NULL,
  `VoziloLicence` int(11) NOT NULL,
  `MotoLicence` int(11) NOT NULL,
  `BrodLicence` int(11) NOT NULL,
  `OruzjeLicence` int(11) NOT NULL,
  `ZivotnoOsiguranje` tinyint(4) NOT NULL,
  `ZivotnoTraje` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_documents`
--

INSERT INTO `player_documents` (`player_id`, `NationalID`, `Passport`, `VoziloLicence`, `MotoLicence`, `BrodLicence`, `OruzjeLicence`, `ZivotnoOsiguranje`, `ZivotnoTraje`) VALUES
(1, 1, 1, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(3, 1, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(4, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(5, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(6, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(7, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(8, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(9, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(10, 1, 1, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(11, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(12, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(15, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19'),
(17, 0, 0, 0, 0, 0, 0, 0, '2023-09-26 20:27:19');

-- --------------------------------------------------------

--
-- Table structure for table `player_electronic`
--

CREATE TABLE `player_electronic` (
  `player_id` int(11) NOT NULL,
  `Dron` tinyint(4) NOT NULL DEFAULT 0,
  `Baterije` int(11) NOT NULL DEFAULT 0,
  `Navigacija` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_electronic`
--

INSERT INTO `player_electronic` (`player_id`, `Dron`, `Baterije`, `Navigacija`) VALUES
(1, 1, 0, 0),
(3, 0, 0, 0),
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

CREATE TABLE `player_finance` (
  `finance_id` int(11) NOT NULL,
  `BankAccount` tinyint(4) NOT NULL DEFAULT 0,
  `BankMoney` int(11) NOT NULL DEFAULT 0,
  `BankPin` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_finance`
--

INSERT INTO `player_finance` (`finance_id`, `BankAccount`, `BankMoney`, `BankPin`) VALUES
(1, 0, 0, 0),
(3, 0, 0, 0),
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

CREATE TABLE `player_property` (
  `player_id` int(11) NOT NULL,
  `HouseID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `player_property`
--

INSERT INTO `player_property` (`player_id`, `HouseID`) VALUES
(1, 2),
(3, -1),
(4, -1),
(5, -1),
(6, -1),
(7, -1),
(17, -1);

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

--
-- Dumping data for table `safezones`
--

INSERT INTO `safezones` (`safeSQLID`, `MinX`, `MinY`, `MaxX`, `MaxY`, `Radius`, `Color`, `PickupX`, `PickupY`, `PickupZ`) VALUES
(4, 1437.3, -1723.03, 1522.43, -1600.28, 30, 10040234, 1479.35, -1659.08, 12.1709);

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vID` int(11) NOT NULL,
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
  `vFuel` int(11) NOT NULL DEFAULT 100,
  `vFuelType` int(11) NOT NULL DEFAULT 1,
  `vAlarm` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`vID`, `vOwner`, `vModel`, `Color1`, `Color2`, `vPlate`, `vPosX`, `vPosY`, `vPosZ`, `vPosA`, `vRegDate`, `vOil`, `vRange`, `vFuel`, `vFuelType`, `vAlarm`) VALUES
(1, 0, 411, 1, 1, 'UNREGISTERED-00', 819.28, -1323.17, 13.469, 105.209, 0, 100, 0, 100, 1, 0),
(2, 0, 562, 1, 1, 'N/A-00-12', 839.961, -1319.57, 13.3927, 265.834, 0, 100, 0, 100, 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bankers`
--
ALTER TABLE `bankers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bank_atms`
--
ALTER TABLE `bank_atms`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bank_logs`
--
ALTER TABLE `bank_logs`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `bank_logs_ibfk_1` (`AccountID`);

--
-- Indexes for table `businesses`
--
ALTER TABLE `businesses`
  ADD PRIMARY KEY (`bizID`);

--
-- Indexes for table `containers`
--
ALTER TABLE `containers`
  ADD PRIMARY KEY (`conID`);

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
  ADD UNIQUE KEY `PID` (`PID`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `klupe`
--
ALTER TABLE `klupe`
  ADD PRIMARY KEY (`seat_ID`);

--
-- Indexes for table `metros`
--
ALTER TABLE `metros`
  ADD PRIMARY KEY (`metroID`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `player_crypto`
--
ALTER TABLE `player_crypto`
  ADD UNIQUE KEY `crypto_id` (`crypto_id`);

--
-- Indexes for table `player_documents`
--
ALTER TABLE `player_documents`
  ADD UNIQUE KEY `player_id` (`player_id`);

--
-- Indexes for table `player_electronic`
--
ALTER TABLE `player_electronic`
  ADD UNIQUE KEY `player_id` (`player_id`);

--
-- Indexes for table `player_finance`
--
ALTER TABLE `player_finance`
  ADD UNIQUE KEY `finance_id` (`finance_id`);

--
-- Indexes for table `player_property`
--
ALTER TABLE `player_property`
  ADD UNIQUE KEY `player_id` (`player_id`);

--
-- Indexes for table `safezones`
--
ALTER TABLE `safezones`
  ADD PRIMARY KEY (`safeSQLID`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bankers`
--
ALTER TABLE `bankers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank_atms`
--
ALTER TABLE `bank_atms`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bank_logs`
--
ALTER TABLE `bank_logs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `businesses`
--
ALTER TABLE `businesses`
  MODIFY `bizID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `containers`
--
ALTER TABLE `containers`
  MODIFY `conID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `faction_police`
--
ALTER TABLE `faction_police`
  MODIFY `fPoliceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `klupe`
--
ALTER TABLE `klupe`
  MODIFY `seat_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `metros`
--
ALTER TABLE `metros`
  MODIFY `metroID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `safezones`
--
ALTER TABLE `safezones`
  MODIFY `safeSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

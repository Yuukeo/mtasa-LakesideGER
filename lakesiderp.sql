-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Erstellungszeit: 24. Nov 2019 um 00:30
-- Server-Version: 10.1.41-MariaDB-0+deb9u1
-- PHP-Version: 7.0.33-0+deb9u6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `lakesiderp`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `allobjects`
--

CREATE TABLE `allobjects` (
  `ID` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `SpawnX` varchar(50) NOT NULL,
  `SpawnY` varchar(50) NOT NULL,
  `SpawnZ` varchar(50) NOT NULL,
  `SpawnROT` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `allobjects`
--

INSERT INTO `allobjects` (`ID`, `Model`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnROT`) VALUES
(1, 2942, '1747.6', '-1863.6', '13.2', '180'),
(2, 2942, '1468.5', '-1751.5', '15.1', '90'),
(3, 2942, '1494', '-1751.5', '15.1', '270'),
(4, 2942, '1000.6', '-921.2', '42', '278'),
(5, 2942, '1196', '-918.6', '42.8', '7'),
(6, 2942, '1095.6', '-1735.3', '13.4', '0'),
(7, 2942, '2130.2', '-1151.3', '23.6', '180'),
(8, 2942, '1928.6', '-1780.2', '13.2', '90'),
(9, 2942, '1367.2', '-1276', '13.2', '270'),
(10, 2942, '1179.6', '-1304.2', '13.9', '90'),
(11, 2942, '1312.6', '-897.8', '39.2', '0'),
(12, 2942, '1361.6', '205.4', '19.2', '156'),
(13, 2942, '1385.5', '-1656.6', '13.2', '270'),
(14, 2942, '1842.8', '-1852.7', '13', '270'),
(15, 2942, '2105', '-1793.4', '13.2', '270'),
(16, 2942, '-55.1', '-1587', '2.5', '238'),
(17, 2942, '921.5', '-1207.4', '16.6', '270'),
(18, 2942, '2478.8', '-1687.9', '13.2', '174'),
(19, 2942, '2222.6', '-1410', '23.6', '270'),
(20, 2942, '2884.8', '-2150.3', '3.7', '256');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `changelogs`
--

CREATE TABLE `changelogs` (
  `SortID` int(11) NOT NULL DEFAULT '0',
  `Version` varchar(11) NOT NULL DEFAULT '0',
  `Changes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `christmas`
--

CREATE TABLE `christmas` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Adventstate1` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate2` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate3` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate4` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate5` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate6` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate7` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate8` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate9` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate10` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate11` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate12` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate13` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate14` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate15` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate16` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate17` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate18` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate19` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate20` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate21` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate22` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate23` mediumint(5) NOT NULL DEFAULT '0',
  `Adventstate24` mediumint(5) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `companydepots`
--

CREATE TABLE `companydepots` (
  `Company` mediumint(5) NOT NULL DEFAULT '0',
  `Money` int(50) NOT NULL DEFAULT '0',
  `Notes` text NOT NULL,
  `Rang0` int(11) NOT NULL DEFAULT '0',
  `Rang1` int(11) NOT NULL DEFAULT '0',
  `Rang2` int(11) NOT NULL DEFAULT '0',
  `Rang3` int(11) NOT NULL DEFAULT '0',
  `Rang4` int(11) NOT NULL DEFAULT '0',
  `Rang5` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `companydepots`
--

INSERT INTO `companydepots` (`Company`, `Money`, `Notes`, `Rang0`, `Rang1`, `Rang2`, `Rang3`, `Rang4`, `Rang5`) VALUES
(1, 0, 'Mech&Tow', 0, 1, 2, 3, 4, 5),
(2, 0, 'Fahrschule', 0, 1, 2, 3, 4, 5),
(3, 0, 'RescueTeam', 0, 1, 2, 3, 4, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `companyvehicles`
--

CREATE TABLE `companyvehicles` (
  `ID` int(11) NOT NULL,
  `Owner` mediumint(5) NOT NULL,
  `VehID` smallint(3) NOT NULL,
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `RotX` varchar(20) NOT NULL,
  `RotY` varchar(20) NOT NULL,
  `RotZ` varchar(20) NOT NULL,
  `Fuel` smallint(3) NOT NULL DEFAULT '100',
  `Plate` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `companyvehicles`
--

INSERT INTO `companyvehicles` (`ID`, `Owner`, `VehID`, `SpawnX`, `SpawnY`, `SpawnZ`, `RotX`, `RotY`, `RotZ`, `Fuel`, `Plate`) VALUES
(1, 1, 525, '872.8', '-1175.1', '16.8', '0', '0', '270', 97, '0'),
(2, 1, 525, '872.8', '-1180.7', '16.8', '0', '0', '270', 100, '0'),
(3, 1, 525, '872.8', '-1186.3', '16.8', '0', '0', '270', 94, '0'),
(4, 1, 525, '872.8', '-1192.0', '16.8', '0', '0', '270', 100, '0'),
(5, 1, 525, '872.8', '-1197.6', '16.8', '0', '0', '270', 36, '0'),
(30, 2, 405, '1361.8', '-1658.9', '13.7', '0', '0', '270', 87, '0'),
(31, 2, 405, '1361.8', '-1651.1', '13.7', '0', '0', '270', 97, '0'),
(32, 2, 405, '1361.8', '-1643.3', '13.7', '0', '0', '270', 100, '0'),
(33, 2, 405, '1361.8', '-1635.6', '13.7', '0', '0', '270', 100, '0'),
(34, 3, 416, '1181.7', '-1338.7', '13.7', '0', '0', '270', 88, '0'),
(35, 3, 416, '1181.7', '-1308.5', '13.7', '0', '0', '270', 100, '0'),
(36, 3, 416, '1145.9', '-1314.8', '13.9', '0', '0', '90', 100, '0'),
(37, 3, 416, '1145.9', '-1310.2', '13.9', '0', '0', '90', 100, '0'),
(38, 3, 416, '1145.9', '-1344.5', '13.9', '0', '0', '90', 100, '0'),
(39, 3, 416, '1145.9', '-1348.9', '13.9', '0', '0', '90', 100, '0');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `factiondepots`
--

CREATE TABLE `factiondepots` (
  `Faction` mediumint(5) NOT NULL DEFAULT '0',
  `Money` int(50) NOT NULL DEFAULT '0',
  `Mats` int(50) NOT NULL DEFAULT '0',
  `Weed` int(50) NOT NULL DEFAULT '0',
  `Kokain` int(50) NOT NULL DEFAULT '0',
  `Notes` text NOT NULL,
  `Rang0` int(11) NOT NULL DEFAULT '0',
  `Rang1` int(11) NOT NULL DEFAULT '0',
  `Rang2` int(11) NOT NULL DEFAULT '0',
  `Rang3` int(11) NOT NULL DEFAULT '0',
  `Rang4` int(11) NOT NULL DEFAULT '0',
  `Rang5` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `factiondepots`
--

INSERT INTO `factiondepots` (`Faction`, `Money`, `Mats`, `Weed`, `Kokain`, `Notes`, `Rang0`, `Rang1`, `Rang2`, `Rang3`, `Rang4`, `Rang5`) VALUES
(1, 0, 0, 0, 0, 'L.S.P.D', 0, 1, 2, 3, 4, 5),
(2, 0, 0, 0, 0, 'F.B.I', 0, 1, 2, 3, 4, 5),
(3, 0, 0, 0, 0, 'Grove', 0, 1, 2, 3, 4, 5),
(4, 0, 0, 0, 0, 'Ballas', 0, 1, 2, 3, 4, 5),
(5, 0, 0, 0, 0, 'Vagos', 0, 1, 2, 3, 4, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `factiontags`
--

CREATE TABLE `factiontags` (
  `ID` int(70) NOT NULL,
  `SpawnX` varchar(50) NOT NULL,
  `SpawnY` varchar(50) NOT NULL,
  `SpawnZ` varchar(50) NOT NULL,
  `SpawnOX` varchar(50) NOT NULL,
  `SpawnOY` varchar(50) NOT NULL,
  `SpawnOZ` varchar(50) NOT NULL,
  `SpawnOROT` varchar(50) NOT NULL,
  `Owner` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `factiontags`
--

INSERT INTO `factiontags` (`ID`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnOX`, `SpawnOY`, `SpawnOZ`, `SpawnOROT`, `Owner`) VALUES
(1, '2258.8', '-1669.5', '14.4', '2258.8', '-1670.3', '15.6', '0', 0),
(2, '2111.5', '-1631.8', '12.4', '2111.5', '-1632.5', '13.4', '0', 0),
(3, '1949.5', '-1574.3', '12.6', '1950.1', '-1574.9', '13.7', '44', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `factionvehicles`
--

CREATE TABLE `factionvehicles` (
  `ID` int(11) NOT NULL,
  `Owner` mediumint(5) NOT NULL,
  `VehID` smallint(3) NOT NULL,
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `RotX` varchar(20) NOT NULL,
  `RotY` varchar(20) NOT NULL,
  `RotZ` varchar(20) NOT NULL,
  `Fuel` smallint(3) NOT NULL DEFAULT '100',
  `Plate` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `factionvehicles`
--

INSERT INTO `factionvehicles` (`ID`, `Owner`, `VehID`, `SpawnX`, `SpawnY`, `SpawnZ`, `RotX`, `RotY`, `RotZ`, `Fuel`, `Plate`) VALUES
(1, 1, 597, '1558.9', '-1710.6', '5.7', '0', '0', '0', 5, 'SAPD 1'),
(2, 1, 597, '1563.1', '-1710.6', '5.7', '0', '0', '0', 87, 'SAPD 2'),
(3, 1, 597, '1566.5', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 3'),
(4, 1, 597, '1570.3', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 4'),
(5, 1, 597, '1574.4', '-1710.6', '5.7', '0', '0', '0', 84, 'SAPD 5'),
(6, 1, 597, '1578.5', '-1710.6', '5.7', '0', '0', '0', 86, 'SAPD 6'),
(7, 1, 597, '1583.4', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 7'),
(8, 1, 597, '1587.4', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 8'),
(9, 1, 597, '1591.4', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 9'),
(10, 1, 597, '1595.4', '-1710.6', '5.7', '0', '0', '0', 88, 'SAPD 10'),
(11, 1, 427, '1538.9', '-1645.3', '6.0', '0', '0', '180', 100, 'SAPD 11'),
(12, 1, 427, '1534.6', '-1645.3', '6.0', '0', '0', '180', 100, 'SAPD 12'),
(13, 1, 427, '1530.6', '-1645.3', '6.0', '0', '0', '180', 100, 'SAPD 13'),
(14, 1, 427, '1526.6', '-1645.3', '6.0', '0', '0', '180', 100, 'SAPD 14'),
(15, 1, 601, '1545.5', '-1651', '5.6', '0', '0', '90', 100, 'SAPD 15'),
(16, 1, 601, '1545.5', '-1655.1', '5.6', '0', '0', '90', 100, 'SAPD 16'),
(17, 1, 601, '1545.711914', '-1659.058594', '5.649404', '0.010986', '0', '90.368042', 47, 'SAPD 17'),
(18, 1, 598, '1601.8', '-1704.0', '5.7', '0', '0', '90', 100, 'SAPD 18'),
(19, 1, 598, '1601.8', '-1700.0', '5.7', '0', '0', '90', 88, 'SAPD 19'),
(20, 1, 598, '1601.8', '-1696.0', '5.7', '0', '0', '90', 100, 'SAPD 20'),
(21, 1, 598, '1601.8', '-1692.0', '5.7', '0', '0', '90', 100, 'SAPD 21'),
(22, 1, 598, '1601.8', '-1688.0', '5.7', '0', '0', '90', 66, 'SAPD 22'),
(23, 1, 598, '1601.8', '-1684.0', '5.7', '0', '0', '90', 69, 'SAPD 23'),
(24, 1, 497, '1562.3', '-1647.9', '28.5', '0', '0', '90', 99, 'SAPD 24'),
(25, 1, 497, '1562.3', '-1660.0', '28.5', '0', '0', '90', 100, 'SAPD 25'),
(26, 1, 497, '1562.299805', '-1691.194336', '28.588392', '0.219727', '359.785767', '89.923096', 100, 'SAPD 26'),
(27, 1, 497, '1562.3', '-1703.3', '28.5', '0', '0', '90', 100, 'SAPD 27'),
(50, 2, 490, '1278.1', '-1797.5', '13.5', '0', '0', '90', 100, 'FBI 1'),
(51, 2, 490, '1278.1', '-1802.5', '13.5', '0', '0', '90', 100, 'FBI 2'),
(52, 2, 490, '1278.1', '-1807.5', '13.5', '0', '0', '90', 100, 'FBI 3'),
(53, 2, 490, '1278.1', '-1812.5', '13.5', '0', '0', '90', 87, 'FBI 4'),
(54, 2, 490, '1278.1', '-1817.5', '13.5', '0', '0', '90', 100, 'FBI 5'),
(55, 2, 528, '1278.3', '-1822.5', '13.4', '0', '0', '90', 100, 'FBI 7'),
(56, 2, 528, '1278.3', '-1827.5', '13.4', '0', '0', '90', 100, 'FBI 8'),
(57, 2, 528, '1278.3', '-1832.5', '13.4', '0', '0', '90', 100, 'FBI 9'),
(58, 2, 597, '1238.538086', '-1814.357422', '13.196437', '359.566040', '0.027466', '239.425049', 74, 'FBI 10'),
(59, 2, 597, '1238.495117', '-1818.934570', '13.189699', '359.560547', '0.021973', '237.238770', 31, 'FBI 11'),
(60, 2, 597, '1238.425781', '-1823.589844', '13.212281', '359.653931', '0.021973', '236.925659', 96, 'FBI 12'),
(61, 2, 601, '1261.5', '-1795.3', '13', '0', '0', '180', 100, 'FBI 13'),
(62, 2, 601, '1266.5', '-1795.3', '13', '0', '0', '180', 100, 'FBI 14'),
(63, 2, 601, '1271.3', '-1795.3', '13', '0', '0', '180', 100, 'FBI 15'),
(64, 2, 497, '1264.6', '-1777.5', '33.7', '0', '0', '180', 100, 'FBI 16'),
(65, 2, 497, '1252.2', '-1777.5', '33.7', '0', '0', '180', 100, 'FBI 17'),
(66, 2, 497, '1228.8', '-1800.1', '33.7', '0', '0', '180', 100, 'FBI 18'),
(76, 2, 497, '1215.2', '-1800.1', '33.7', '0', '0', '180', 100, 'FBI 19'),
(184, 4, 492, '2257.322266', '-1413', '23.691542', '0.010986', '354.017944', '89.620972', 66, '5935'),
(186, 4, 517, '2226.063477', '-1448.472656', '23.769121', '359.994507', '354.506836', '90.582275', 88, '3440'),
(188, 4, 560, '2242.418945', '-1412.992188', '23.615808', '359.868164', '354.435425', '89.994507', 91, '9924'),
(189, 5, 560, '2885.609375', '-2154.544922', '3.753065', '0.175781', '0.867920', '57.952881', 52, '6018'),
(190, 5, 517, '2873.610352', '-2168.768555', '2.971326', '357.907104', '0.296631', '46.790771', 76, '6485'),
(191, 4, 480, '2233.687500', '-1448.446289', '23.686483', '359.736328', '354.512329', '90.192261', 92, '7870'),
(192, 5, 411, '2891.224609', '-2136.918945', '3.262593', '1.994019', '1.625977', '77.047119', 83, '4592'),
(193, 5, 468, '2888.599609', '-2142.510742', '3.417949', '2.065430', '1.477661', '79.552002', 95, '3464'),
(194, 4, 468, '2252.138672', '-1407.257812', '23.669064', '359.851685', '359.994507', '183.768311', 22, '5544'),
(195, 3, 517, '2517.655273', '-1666.006836', '13.969981', '349.925537', '6.811523', '108.731689', 60, '5691'),
(196, 3, 468, '2507.333008', '-1651.829102', '13.352597', '356.077881', '358.851929', '126.348267', 34, '9025'),
(197, 4, 468, '2254.209961', '-1407.083008', '23.668999', '359.851685', '359.994507', '182.741089', 53, '8170'),
(198, 5, 492, '2873.724609', '-2161.864258', '2.740357', '2.949829', '357.324829', '317.927856', 81, '9518'),
(199, 4, 560, '2249.862305', '-1412.867188', '23.615488', '359.868164', '354.429932', '91.049194', 95, '3801'),
(200, 5, 468, '2888.947266', '-2141.171875', '3.378639', '2.043457', '1.505127', '78.771973', 90, '1179');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gangareas`
--

CREATE TABLE `gangareas` (
  `ID` int(2) NOT NULL,
  `X1` varchar(50) NOT NULL,
  `Y1` varchar(50) NOT NULL,
  `X2` varchar(50) NOT NULL,
  `Y2` varchar(50) NOT NULL,
  `X3` varchar(50) NOT NULL,
  `Y3` varchar(50) NOT NULL,
  `Z3` varchar(50) NOT NULL,
  `BesitzerFraktion` int(2) NOT NULL,
  `Einnahmen` int(11) NOT NULL DEFAULT '0',
  `Name` text NOT NULL,
  `Aktiviert` int(1) NOT NULL DEFAULT '1' COMMENT 'Ob es Ingame aktiviert oder deaktiviert ist'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `gangareas`
--

INSERT INTO `gangareas` (`ID`, `X1`, `Y1`, `X2`, `Y2`, `X3`, `Y3`, `Z3`, `BesitzerFraktion`, `Einnahmen`, `Name`, `Aktiviert`) VALUES
(1, '-2758.99', '1310.52', '-2573.75', '1528.54', '-2631.68', '1357.41', '6.75', 3, 200, 'Jizzys', 1),
(2, '743.70001220703', '-1684.5', '862.59997558594', '-1574.4000244141', '786.09997558594', '-1632.4000244141', '13.39999961853', 5, 200, 'Burgershot LS', 1),
(3, '-2201.72', '-280.57', '-2096.76', '-80.93', '-2136.24', '-181.63', '34.96', 5, 200, 'Drogenlabor', 1),
(4, '-2215.40', '-950.06', '-2025', '-700', '-2115.4033203125', '-893.06', '31.67', 3, 200, 'SF Uni', 1),
(5, '-2811.12', '-413.97', '-2634.36', '-261.18', '-2719.86', '-317.43', '7.5', 4, 200, 'Tennisplatz', 1),
(6, '-2293.56', '2226.63', '-2237.42', '2473.87', '-2261.91', '2317.41', '4.46', 5, 200, 'Bayside', 1),
(7, '-87.404563903809', '2420.3674316406', '458.44122314453', '2575.6437988281', '317.39999389648', '2437.6999511719', '16.5', 3, 200, 'Flugzeugfriedhof', 1),
(8, '2558.8000488281', '2242.6999511719', '2677.3000488281', '2474.5', '2606', '2302.8999023438', '10.800000190735', 4, 200, 'Rock Hotel', 1),
(9, '2777.1000976563', '833.29998779297', '2895.1000976563', '1023.299987793', '2862.1999511719', '919.09997558594', '10.800000190735', 5, 200, 'Linden Side', 1),
(10, '111.78970', '1336.29541', '287.11746', '1484.41968', '191.09195', '1434.08276', '10.58594', 3, 200, 'Raffinerie', 1),
(11, '974.55304', '948.50726', '1177.29517', '1166.17798', '1087.21240', '1074.30579', '10.83816', 5, 200, 'LV Uni', 1),
(12, '1577.68152', '943.66669', '1756.69226', '1122.69128', '1667.1455078125', '1013.2158203125', '10.8203125', 5, 200, 'Depot', 1),
(13, '1300.3671875', '2102.9736328125', '1397.1962890625', '2198.951171875', '1358.8984375', '2160.513671875', '11.015625', 3, 200, 'Baseballstadion', 1),
(14, '-624.1655273438', '-564.07165527344', '-467.08432006836', '-467.08432006836', '-485.64794921875', '-505.75033569336', '25.517845153809', 4, 200, 'SF Lagerhalle', 1),
(15, '2437.3999023438', '1083.1999511719', '2597.3999023438', '1183.3000488281', '2527.3999023438', '1137.0999755859', '10.699999809265', 5, 200, 'Streets', 1),
(16, '-593.20001220703', '-200.19999694824', '-422.29998779297', '-31.700000762939', '-511.39999389648', '-85.300003051758', '62.200000762939', 3, 200, 'Holzfaeller', 1),
(17, '1860.7937011719', '-1452.2199707031', '1979.2247314453', '-1350.2930908203', '1918.2982177734', '-1400.6328125', '13.5703125', 5, 200, 'Skaterpark', 1),
(18, '807.40002441406', '-1130.0999755859', '952.59997558594', '-1055.5999755859', '862.70001220703', '-1101.9000244141', '24.299999237061', 5, 200, 'Friedhof', 1),
(19, '2371.8000488281', '1783.1999511719', '2497.3999023438', '1963.1999511719', '2420.3000488281', '1925.6999511719', '6', 3, 200, 'Baustelle', 1),
(20, '2497.1999511719', '2617.1000976563', '2749.1999511719', '2857.6000976563', '2554.8999023438', '2753.3000488281', '10.800000190735', 4, 200, 'Pissgebiet', 1),
(21, '2127.1000976563', '-2345', '2267.8000488281', '-2218.8999023438', '2167.1000976563', '-2274.3999023438', '13.39999961853', 5, 200, 'LS Lagerhalle', 1),
(22, '-2361.49', '-183.31', '-2269.87', '-80.65', '-2308.15', '-123.21', '34.96', 3, 200, 'Burgershot SF', 1),
(23, '-2201.72', '-280.57', '-2096.76', '-80.93', '-2136.24', '-181.63', '34.96', 4, 200, 'Fabrik SF', 1),
(24, '1858.28', '1473.03', '2010.69', '1691', '1908.77', '1518.43', '13.62', 5, 200, 'Piratenschiff', 1),
(25, '-1340.56787', '2464.59717', '-1261.05640', '2564.95508', '-1302.33545', '2512.67139', '87.04205', 3, 200, 'Ruine', 1),
(26, '1046.3127441406', '-1704.1940917969', '1142.6439208984', '-1578.559623828', '1071.7454833984', '-1619.3309326172', '20.458673477173', 4, 200, 'Verona Center', 1),
(27, '-462.16015625', '2169.0122070313', '-339.23330688477', '2290.5751953125', '-404.68014526367', '2233.251953125', '42.4296875', 5, 200, 'Ghosttown', 1),
(28, '1277', '903.09997558594', '1497.4000244141', '1183.5999755859', '1398.4000244141', '1097.1999511719', '10.800000190735', 3, 200, 'LV Lagerhalle', 1),
(29, '1358.9000244141', '-2368.8000488281', '1833.9000244141', '-2204.5', '1682.8000488281', '-2285.1000976563', '13.5', 3, 200, 'LS Airport', 1),
(30, '1856.9000244141', '-1255.8000488281', '2061.8000488281', '-1141', '1969.5999755859', '-1187.5999755859', '25.8', 5, 200, 'Glen Park', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gangdealercars`
--

CREATE TABLE `gangdealercars` (
  `ID` mediumint(5) NOT NULL,
  `VehID` mediumint(5) NOT NULL,
  `Price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `gangdealercars`
--

INSERT INTO `gangdealercars` (`ID`, `VehID`, `Price`) VALUES
(410, 410, 23000),
(411, 411, 250000),
(445, 445, 39000),
(461, 461, 70000),
(468, 468, 35000),
(480, 480, 210000),
(492, 492, 37200),
(496, 496, 42000),
(517, 517, 55000),
(521, 521, 82000),
(549, 549, 10000),
(560, 560, 97000),
(585, 585, 19600);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `globalcounter`
--

CREATE TABLE `globalcounter` (
  `UID` int(70) NOT NULL DEFAULT '1',
  `VID` int(70) NOT NULL DEFAULT '1',
  `FVID` int(70) NOT NULL DEFAULT '1',
  `PID` int(70) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `globalcounter`
--

INSERT INTO `globalcounter` (`UID`, `VID`, `FVID`, `PID`) VALUES
(1, 1, 160, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
  `Owner` varchar(35) NOT NULL,
  `Price` int(11) NOT NULL,
  `Cash` int(50) NOT NULL,
  `Rent` mediumint(5) NOT NULL DEFAULT '0',
  `State` varchar(10) NOT NULL DEFAULT 'false',
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `Interior` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `houses`
--

INSERT INTO `houses` (`ID`, `Owner`, `Price`, `Cash`, `Rent`, `State`, `SpawnX`, `SpawnY`, `SpawnZ`, `Interior`) VALUES
(1, 'none', 45000, 0, 0, 'false', '1854.025391', '-1914.417969', '15.256798', 1),
(2, 'none', 45000, 0, 0, 'false', '1872.220703', '-1911.958008', '15.256798', 1),
(3, 'none', 45000, 0, 0, 'false', '1891.909180', '-1914.589844', '15.256798', 1),
(4, 'none', 45000, 0, 0, 'false', '1913.461914', '-1911.988281', '15.256798', 1),
(5, 'none', 45000, 0, 0, 'false', '1938.510742', '-1911.331055', '15.256798', 1),
(6, 'none', 5000000, 0, 0, 'false', '1298.502930', '-797.986328', '84.140625', 31),
(7, 'none', 35000, 0, 0, 'false', '1245.399414', '-902.840820', '42.882812', 1),
(8, 'none', 35000, 0, 0, 'false', '1252.887695', '-901.855469', '42.882812', 1),
(9, 'none', 35000, 0, 0, 'false', '1253.716797', '-908.135742', '42.882812', 1),
(10, 'none', 35000, 0, 0, 'false', '1246.209961', '-908.989258', '42.882812', 1),
(11, 'none', 35000, 0, 0, 'false', '1252.893555', '-901.881836', '46.593887', 1),
(12, 'none', 35000, 0, 0, 'false', '1245.394531', '-902.796875', '46.593887', 1),
(13, 'none', 35000, 0, 0, 'false', '1253.708984', '-908.082031', '46.601562', 1),
(14, 'none', 35000, 0, 0, 'false', '1246.216797', '-909.045898', '46.601562', 1),
(15, 'none', 35000, 0, 0, 'false', '1283.528320', '-897.813477', '42.875343', 1),
(16, 'none', 35000, 0, 0, 'false', '1291.021484', '-896.879883', '42.882812', 1),
(17, 'none', 35000, 0, 0, 'false', '1284.338867', '-903.967773', '42.882812', 1),
(18, 'none', 35000, 0, 0, 'false', '1291.841797', '-903.071289', '42.882812', 1),
(19, 'none', 35000, 0, 0, 'false', '1284.342773', '-903.990234', '46.632812', 1),
(20, 'none', 35000, 0, 0, 'false', '1291.840820', '-903.067383', '46.632812', 1),
(21, 'none', 35000, 0, 0, 'false', '1283.533203', '-897.843750', '46.625137', 1),
(22, 'none', 35000, 0, 0, 'false', '1291.028320', '-896.905273', '46.625137', 1),
(23, 'none', 35000, 0, 0, 'false', '1242.126953', '-878.276367', '46.640625', 1),
(24, 'none', 35000, 0, 0, 'false', '1249.612305', '-877.328125', '46.640625', 1),
(25, 'none', 35000, 0, 0, 'false', '1241.305664', '-872.063477', '46.632950', 1),
(26, 'none', 35000, 0, 0, 'false', '1248.801758', '-871.155273', '46.632950', 1),
(27, 'none', 35000, 0, 0, 'false', '1248.804688', '-871.174805', '42.882812', 1),
(28, 'none', 35000, 0, 0, 'false', '1241.307617', '-872.084961', '42.882812', 1),
(29, 'none', 35000, 0, 0, 'false', '1249.619141', '-877.364258', '42.882812', 1),
(30, 'none', 35000, 0, 0, 'false', '1242.125977', '-878.310547', '42.875343', 1),
(31, 'none', 95000, 0, 0, 'false', '1325.944336', '-1066.454102', '31.554688', 6),
(32, 'none', 95000, 0, 0, 'false', '1326.261719', '-1091.885742', '27.976562', 6),
(33, 'none', 95000, 0, 0, 'false', '1285.253906', '-1066.021484', '31.671875', 6),
(34, 'none', 95000, 0, 0, 'false', '1285.266602', '-1091.430664', '28.257812', 6),
(35, 'none', 95000, 0, 0, 'false', '1241.946289', '-1075.252930', '31.554688', 6),
(36, 'none', 95000, 0, 0, 'false', '1242.262695', '-1100.715820', '27.976562', 6),
(37, 'none', 35000, 0, 0, 'false', '1227.242188', '-1017.130859', '32.601562', 1),
(38, 'none', 35000, 0, 0, 'false', '1234.738281', '-1016.179688', '32.606651', 1),
(39, 'none', 35000, 0, 0, 'false', '1226.428711', '-1010.950195', '32.601562', 1),
(40, 'none', 35000, 0, 0, 'false', '1233.924805', '-1010.004883', '32.601562', 1),
(41, 'none', 35000, 0, 0, 'false', '1233.920898', '-1010.002930', '36.328262', 1),
(42, 'none', 35000, 0, 0, 'false', '1226.425781', '-1010.897461', '36.328262', 1),
(43, 'none', 35000, 0, 0, 'false', '1234.732422', '-1016.166016', '36.335938', 1),
(44, 'none', 35000, 0, 0, 'false', '1227.238281', '-1017.079102', '36.335938', 1),
(45, 'none', 35000, 0, 0, 'false', '1196.500977', '-1017.117188', '32.546875', 1),
(46, 'none', 35000, 0, 0, 'false', '1189.011719', '-1018.085938', '32.546875', 1),
(47, 'none', 35000, 0, 0, 'false', '1188.185547', '-1011.841797', '32.546875', 1),
(48, 'none', 35000, 0, 0, 'false', '1195.679688', '-1010.885742', '32.553154', 1),
(49, 'none', 35000, 0, 0, 'false', '1195.683594', '-1010.928711', '36.226700', 1),
(50, 'none', 35000, 0, 0, 'false', '1188.185547', '-1011.836914', '36.226700', 1),
(51, 'none', 35000, 0, 0, 'false', '1196.490234', '-1017.041016', '36.234375', 1),
(52, 'none', 35000, 0, 0, 'false', '1189', '-1018', '36.234375', 1),
(53, 'none', 115000, 0, 0, 'false', '1127.984375', '-1021.171875', '34.992188', 6),
(54, 'none', 115000, 0, 0, 'false', '1118.087891', '-1021.341797', '34.992188', 6),
(55, 'none', 115000, 0, 0, 'false', '1050.982422', '-1059.290039', '34.796646', 6),
(56, 'none', 115000, 0, 0, 'false', '993.773438', '-1059.030273', '33.699501', 6),
(57, 'none', 95000, 0, 0, 'false', '1183.469727', '-1074.807617', '31.671875', 6),
(58, 'none', 95000, 0, 0, 'false', '1183.476562', '-1100.200195', '28.257812', 6),
(59, 'none', 95000, 0, 0, 'false', '1141.808594', '-1068.689453', '31.765625', 6),
(60, 'none', 135000, 0, 0, 'false', '827.801758', '-857.987305', '70.330811', 5),
(61, 'none', 165000, 0, 0, 'false', '1034.747070', '-813.208984', '101.851562', 5),
(62, 'none', 900000, 0, 0, 'false', '977.412109', '-771.480469', '112.202629', 5),
(63, 'none', 4200000, 0, 0, 'false', '1332.204102', '-633.168945', '109.134903', 31),
(64, 'none', 550000, 0, 0, 'false', '254.678711', '-1367.025391', '53.109375', 12),
(65, 'none', 600000, 0, 0, 'false', '298.685547', '-1338.434570', '53.441498', 12),
(66, 'none', 140000, 0, 0, 'false', '432.028320', '-1253.731445', '51.580940', 5),
(67, 'none', 150000, 0, 0, 'false', '937.605469', '-848.097656', '93.672958', 7),
(68, 'none', 100000, 0, 0, 'false', '1527.727539', '-772.612305', '80.578125', 11),
(69, 'none', 100000, 0, 0, 'false', '1534.900391', '-800.058594', '72.849457', 11),
(70, 'none', 100000, 0, 0, 'false', '1539.947266', '-851.500977', '64.336060', 11),
(71, 'none', 100000, 0, 0, 'false', '1468.522461', '-905.447266', '54.835938', 11),
(72, 'none', 60000, 0, 0, 'false', '2067.551758', '-1731.634766', '13.876158', 1),
(73, 'none', 60000, 0, 0, 'false', '2066.627930', '-1717.128906', '13.805846', 1),
(74, 'none', 60000, 0, 0, 'false', '2065.405273', '-1703.534180', '14.148438', 1),
(75, 'none', 70000, 0, 0, 'false', '2018.043945', '-1703.341797', '14.234375', 1),
(76, 'none', 60000, 0, 0, 'false', '2015.731445', '-1716.971680', '13.920794', 1),
(77, 'none', 60000, 0, 0, 'false', '2014.868164', '-1732.640625', '14.234375', 1),
(78, 'none', 90000, 0, 0, 'false', '2172.408203', '-1615.125000', '14.291654', 3),
(79, 'none', 90000, 0, 0, 'false', '2178.857422', '-1600.040039', '14.345682', 3),
(80, 'none', 90000, 0, 0, 'false', '2165.410156', '-1590.948242', '14.346070', 3),
(81, 'none', 90000, 0, 0, 'false', '2150.314453', '-1584.073242', '14.336046', 3),
(82, 'none', 90000, 0, 0, 'false', '2151.265625', '-1598.203125', '14.345532', 3),
(83, 'none', 90000, 0, 0, 'false', '2158.197266', '-1611.422852', '14.351273', 3),
(84, 'none', 90000, 0, 0, 'false', '2143.076172', '-1604.897461', '14.351562', 3),
(85, 'none', 90000, 0, 0, 'false', '2141.350586', '-1652.592773', '15.085938', 3),
(86, 'none', 90000, 0, 0, 'false', '2144.148438', '-1663.430664', '15.085938', 3),
(87, 'none', 90000, 0, 0, 'false', '2163.500000', '-1661.105469', '15.085938', 3),
(88, 'none', 60000, 0, 0, 'false', '2067.144531', '-1656.528320', '13.967918', 1),
(89, 'none', 60000, 0, 0, 'false', '2067.849609', '-1643.708008', '13.805846', 1),
(90, 'none', 60000, 0, 0, 'true', '2067.943359', '-1628.908203', '13.876158', 1),
(91, 'none', 20000, 0, 0, 'false', '-40.185547', '-2493.709961', '36.648438', 2),
(92, 'none', 20000, 0, 0, 'false', '-36.179688', '-2490.828125', '36.648438', 2),
(93, 'none', 20000, 0, 0, 'false', '-32.033203', '-2487.894531', '36.648438', 2),
(94, 'none', 20000, 0, 0, 'false', '-27.740234', '-2485.289062', '36.648438', 2),
(95, 'none', 20000, 0, 0, 'false', '-23.925781', '-2482.109375', '36.648438', 2),
(96, 'none', 20000, 0, 0, 'false', '-17.965820', '-2493.143555', '36.648438', 2),
(97, 'none', 20000, 0, 0, 'false', '-15.394531', '-2497.465820', '36.648438', 2),
(98, 'none', 20000, 0, 0, 'false', '-12.797852', '-2501.837891', '36.655464', 2),
(99, 'none', 20000, 0, 0, 'false', '-10.460938', '-2506.084961', '36.655464', 2),
(100, 'none', 20000, 0, 0, 'false', '-7.726562', '-2510.276367', '36.655464', 2),
(101, 'none', 370000, 0, 0, 'false', '-282.770508', '-2174.474609', '28.658747', 7);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `inventory`
--

CREATE TABLE `inventory` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Apfel` int(11) NOT NULL DEFAULT '0',
  `Burger` int(11) NOT NULL DEFAULT '0',
  `Pizza` int(11) NOT NULL DEFAULT '0',
  `Zuckerstange` int(11) NOT NULL DEFAULT '0',
  `Cola` int(11) NOT NULL DEFAULT '0',
  `Ausweis` mediumint(5) NOT NULL DEFAULT '0',
  `ChestWood` int(11) NOT NULL DEFAULT '0',
  `ChestIron` int(11) NOT NULL DEFAULT '0',
  `TicketBronze` int(11) NOT NULL DEFAULT '0',
  `TicketSilver` int(11) NOT NULL DEFAULT '0',
  `TicketGold` int(11) NOT NULL DEFAULT '0',
  `Repairkit` int(11) NOT NULL DEFAULT '0',
  `Kokain` int(11) NOT NULL DEFAULT '0',
  `Weed` int(11) NOT NULL DEFAULT '0',
  `Mats` int(11) NOT NULL DEFAULT '0',
  `Hanfsamen` int(11) NOT NULL DEFAULT '0',
  `Apfelsamen` int(11) NOT NULL DEFAULT '0',
  `Zigarette` int(11) NOT NULL DEFAULT '0',
  `Mobilephone` mediumint(5) NOT NULL DEFAULT '0',
  `Fahrzeugschlüssel` int(11) NOT NULL DEFAULT '0',
  `Weste` int(11) NOT NULL DEFAULT '0',
  `Spitzhacke` int(11) NOT NULL DEFAULT '0',
  `Mondstein` int(11) NOT NULL DEFAULT '0',
  `Geschenk` int(11) NOT NULL DEFAULT '0',
  `Fishingrod` int(11) NOT NULL DEFAULT '0',
  `Fishinghook` int(11) NOT NULL DEFAULT '0',
  `Köder` int(11) NOT NULL DEFAULT '0',
  `Forelle` int(11) NOT NULL DEFAULT '0',
  `Benzinkanister` int(11) NOT NULL DEFAULT '0',
  `Barrikade` int(11) NOT NULL DEFAULT '0',
  `Brechstange` int(11) NOT NULL DEFAULT '0',
  `Tablet` mediumint(5) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lotto`
--

CREATE TABLE `lotto` (
  `Username` varchar(50) NOT NULL,
  `Number1` mediumint(5) NOT NULL,
  `Number2` mediumint(5) NOT NULL,
  `Number3` mediumint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `offlinemessages`
--

CREATE TABLE `offlinemessages` (
  `Username` varchar(35) NOT NULL,
  `Text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userbans`
--

CREATE TABLE `userbans` (
  `Username` varchar(35) NOT NULL,
  `Admin` varchar(35) NOT NULL,
  `Reason` text NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userdata`
--

CREATE TABLE `userdata` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Password` text NOT NULL,
  `Email` text NOT NULL,
  `RegisterDate` text NOT NULL,
  `LastLoginDate` text NOT NULL,
  `BirthDate` varchar(14) NOT NULL DEFAULT '0',
  `Gender` varchar(10) NOT NULL DEFAULT 'Male',
  `AdminLvL` int(11) NOT NULL DEFAULT '0',
  `Faction` int(11) NOT NULL DEFAULT '0',
  `Factionrank` int(11) NOT NULL DEFAULT '0',
  `Company` int(11) NOT NULL DEFAULT '0',
  `Companyrank` int(11) NOT NULL DEFAULT '0',
  `Money` int(50) NOT NULL DEFAULT '0',
  `Bankmoney` int(50) NOT NULL DEFAULT '0',
  `Jobmoney` int(50) NOT NULL DEFAULT '0',
  `Armor` mediumint(3) NOT NULL DEFAULT '0',
  `Health` mediumint(3) NOT NULL DEFAULT '100',
  `Job` varchar(30) NOT NULL DEFAULT 'none',
  `Hunger` mediumint(3) NOT NULL DEFAULT '100',
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `SpawnROT` varchar(20) NOT NULL,
  `SpawnINT` varchar(20) NOT NULL DEFAULT '0',
  `SpawnDIM` varchar(20) NOT NULL DEFAULT '0',
  `SkinID` int(11) NOT NULL DEFAULT '0',
  `Playtime` int(11) NOT NULL DEFAULT '0',
  `Weeklytime` int(11) NOT NULL DEFAULT '0',
  `Mutedtime` int(11) NOT NULL DEFAULT '0',
  `Jailtime` int(11) NOT NULL DEFAULT '0',
  `Vehicleslots` int(11) NOT NULL DEFAULT '2',
  `Housekey` int(50) NOT NULL DEFAULT '0',
  `Task` smallint(2) NOT NULL DEFAULT '1',
  `Bankpin` int(11) NOT NULL DEFAULT '0',
  `Telenr` int(11) NOT NULL DEFAULT '0',
  `Wanteds` int(11) NOT NULL DEFAULT '0',
  `IntroCompleted` tinyint(1) NOT NULL DEFAULT '0',
  `CarLicense` mediumint(5) NOT NULL DEFAULT '0',
  `BikeLicense` mediumint(5) NOT NULL DEFAULT '0',
  `CarLicensePoints` int(11) NOT NULL DEFAULT '0',
  `BikeLicensePoints` int(11) NOT NULL DEFAULT '0',
  `GunLicense` mediumint(5) NOT NULL DEFAULT '0',
  `Note` mediumint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userlevel`
--

CREATE TABLE `userlevel` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Joblevel` int(11) NOT NULL DEFAULT '0',
  `Jobexp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userlogout`
--

CREATE TABLE `userlogout` (
  `UID` int(50) NOT NULL,
  `Weapons` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userplants`
--

CREATE TABLE `userplants` (
  `ID` int(200) NOT NULL,
  `UID` int(70) NOT NULL,
  `Model` int(11) NOT NULL,
  `SpawnX` varchar(50) NOT NULL,
  `SpawnY` varchar(50) NOT NULL,
  `SpawnZ` varchar(50) NOT NULL,
  `RotZ` varchar(20) NOT NULL,
  `Time` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `usersettings`
--

CREATE TABLE `usersettings` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `PhoneModel` int(11) NOT NULL DEFAULT '1',
  `PhoneBackground` int(11) NOT NULL DEFAULT '1',
  `PhoneState` int(11) NOT NULL DEFAULT '1',
  `Autologin` mediumint(5) NOT NULL DEFAULT '1',
  `Radar` mediumint(5) NOT NULL DEFAULT '1',
  `Snowshader` mediumint(5) NOT NULL DEFAULT '1',
  `Blurshader` mediumint(5) NOT NULL DEFAULT '2',
  `Hitglocke` mediumint(5) NOT NULL DEFAULT '1',
  `PhoneRightone` mediumint(5) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userstats`
--

CREATE TABLE `userstats` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Kills` int(11) NOT NULL,
  `Deaths` int(11) NOT NULL,
  `GangwarRounds` int(11) NOT NULL DEFAULT '0',
  `GangwarWins` int(11) NOT NULL DEFAULT '0',
  `GangwarLoses` int(11) NOT NULL DEFAULT '0',
  `GangwarKills` int(11) NOT NULL DEFAULT '0',
  `GangwarDeaths` int(11) NOT NULL DEFAULT '0',
  `GangwarDamageGemacht` int(11) NOT NULL DEFAULT '0',
  `GangwarDamageBekommen` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `uservehicles`
--

CREATE TABLE `uservehicles` (
  `ID` int(70) NOT NULL,
  `UID` int(50) NOT NULL,
  `Owner` varchar(35) NOT NULL,
  `VehID` smallint(3) NOT NULL,
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `RotX` varchar(20) NOT NULL,
  `RotY` varchar(20) NOT NULL,
  `RotZ` varchar(20) NOT NULL,
  `Tunings` varchar(300) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `Sportmotor` smallint(3) NOT NULL DEFAULT '0',
  `Lowering` smallint(3) NOT NULL DEFAULT '0',
  `Color` varchar(50) NOT NULL DEFAULT '0|0|0',
  `Slot` smallint(4) NOT NULL,
  `Totalloss` int(11) NOT NULL DEFAULT '0',
  `Health` int(11) NOT NULL DEFAULT '1000',
  `Fuel` smallint(3) NOT NULL,
  `Plate` varchar(15) NOT NULL,
  `Towed` int(11) NOT NULL DEFAULT '0',
  `Trunk` varchar(500) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `KeyTarget1` varchar(20) NOT NULL DEFAULT 'none',
  `KeyTarget2` varchar(20) NOT NULL DEFAULT 'none',
  `Paintjob` varchar(30) NOT NULL DEFAULT '0',
  `Lights` varchar(30) NOT NULL DEFAULT '0',
  `Fluegeldoors` mediumint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `weaponbox`
--

CREATE TABLE `weaponbox` (
  `ID` int(50) NOT NULL,
  `UID` int(50) NOT NULL,
  `Weapon1` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu1` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon2` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu2` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon3` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu3` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon4` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu4` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon5` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu5` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon6` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu6` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon7` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu7` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon8` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu8` varchar(50) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `whitelist`
--

CREATE TABLE `whitelist` (
  `Username` varchar(50) NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Access` varchar(20) NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `allobjects`
--
ALTER TABLE `allobjects`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `changelogs`
--
ALTER TABLE `changelogs`
  ADD PRIMARY KEY (`SortID`);

--
-- Indizes für die Tabelle `christmas`
--
ALTER TABLE `christmas`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `companydepots`
--
ALTER TABLE `companydepots`
  ADD PRIMARY KEY (`Company`);

--
-- Indizes für die Tabelle `companyvehicles`
--
ALTER TABLE `companyvehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `factiondepots`
--
ALTER TABLE `factiondepots`
  ADD PRIMARY KEY (`Faction`);

--
-- Indizes für die Tabelle `factiontags`
--
ALTER TABLE `factiontags`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `factionvehicles`
--
ALTER TABLE `factionvehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `gangareas`
--
ALTER TABLE `gangareas`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `gangdealercars`
--
ALTER TABLE `gangdealercars`
  ADD PRIMARY KEY (`VehID`);

--
-- Indizes für die Tabelle `globalcounter`
--
ALTER TABLE `globalcounter`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `lotto`
--
ALTER TABLE `lotto`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `userbans`
--
ALTER TABLE `userbans`
  ADD PRIMARY KEY (`Serial`);

--
-- Indizes für die Tabelle `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `userlevel`
--
ALTER TABLE `userlevel`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `userlogout`
--
ALTER TABLE `userlogout`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `userplants`
--
ALTER TABLE `userplants`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `usersettings`
--
ALTER TABLE `usersettings`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `userstats`
--
ALTER TABLE `userstats`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `uservehicles`
--
ALTER TABLE `uservehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `weaponbox`
--
ALTER TABLE `weaponbox`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `whitelist`
--
ALTER TABLE `whitelist`
  ADD PRIMARY KEY (`Serial`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `allobjects`
--
ALTER TABLE `allobjects`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT für Tabelle `companyvehicles`
--
ALTER TABLE `companyvehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT für Tabelle `factiontags`
--
ALTER TABLE `factiontags`
  MODIFY `ID` int(70) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT für Tabelle `factionvehicles`
--
ALTER TABLE `factionvehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;
--
-- AUTO_INCREMENT für Tabelle `gangareas`
--
ALTER TABLE `gangareas`
  MODIFY `ID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT für Tabelle `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;
--
-- AUTO_INCREMENT für Tabelle `weaponbox`
--
ALTER TABLE `weaponbox`
  MODIFY `ID` int(50) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

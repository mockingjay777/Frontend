-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               12.2.2-MariaDB - MariaDB Server
-- Server OS:                    Win64
-- HeidiSQL Version:             12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for hospital
DROP DATABASE IF EXISTS `hospital`;
CREATE DATABASE IF NOT EXISTS `hospital` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `hospital`;

-- Dumping structure for view hospital.clinicalview
DROP VIEW IF EXISTS `clinicalview`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `clinicalview` (
	`Patient_ID` INT(11) NOT NULL,
	`Condition_Name` VARCHAR(1) NULL COLLATE 'utf8mb4_uca1400_ai_ci',
	`Procedure_Name` VARCHAR(1) NULL COLLATE 'utf8mb4_uca1400_ai_ci',
	`Length_of_Stay` INT(11) NULL,
	`Outcome` VARCHAR(1) NULL COLLATE 'utf8mb4_uca1400_ai_ci'
);

-- Dumping structure for table hospital.dashboard
DROP TABLE IF EXISTS `dashboard`;
CREATE TABLE IF NOT EXISTS `dashboard` (
  `Dashboard_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Total_Patients` int(11) DEFAULT NULL,
  `Avg_Length_of_Stay` decimal(5,2) DEFAULT NULL,
  `Avg_Satisfaction` decimal(3,2) DEFAULT NULL,
  `Total_Cost` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`Dashboard_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Dumping data for table hospital.dashboard: ~11 rows (approximately)
DELETE FROM `dashboard`;
INSERT INTO `dashboard` (`Dashboard_ID`, `Total_Patients`, `Avg_Length_of_Stay`, `Avg_Satisfaction`, `Total_Cost`) VALUES
	(1, 10, 5.90, 3.80, 161500.00),
	(2, 10, 5.90, 3.80, 161500.00),
	(3, 10, 5.90, 3.80, 161500.00),
	(4, 10, 5.90, 3.80, 161500.00),
	(5, 10, 5.90, 3.80, 161500.00),
	(6, 10, 5.90, 3.80, 161500.00),
	(7, 10, 5.90, 3.80, 161500.00),
	(8, 10, 5.90, 3.80, 161500.00),
	(9, 10, 5.90, 3.80, 161500.00),
	(10, 10, 5.90, 3.80, 161500.00),
	(11, 10, 5.90, 3.80, 161500.00);

-- Dumping structure for view hospital.dashboardview
DROP VIEW IF EXISTS `dashboardview`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `dashboardview` (
	`Total_Patients` BIGINT(21) NOT NULL,
	`Avg_Length_of_Stay` DECIMAL(14,4) NULL,
	`Avg_Satisfaction` DECIMAL(14,4) NULL,
	`Total_Cost` DECIMAL(32,2) NULL
);

-- Dumping structure for table hospital.departments
DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `Department_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Department_Name` varchar(50) DEFAULT NULL,
  `Condition_Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Department_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Dumping data for table hospital.departments: ~209 rows (approximately)
DELETE FROM `departments`;
INSERT INTO `departments` (`Department_ID`, `Department_Name`, `Condition_Name`) VALUES
	(1, 'Cardiology', 'Heart Disease'),
	(2, 'Cardiology', 'Heart Attack'),
	(3, 'Neurology', 'Stroke'),
	(4, 'Endocrinology', 'Diabetes'),
	(5, 'Orthopedics', 'Fractured Arm'),
	(6, 'Orthopedics', 'Fractured Leg'),
	(7, 'Pulmonology', 'Asthma'),
	(8, 'Urology', 'Kidney Stones'),
	(9, 'General Surgery', 'Appendicitis'),
	(10, 'Oncology', 'Cancer'),
	(11, 'Cardiology', 'Hypertension'),
	(12, 'Cardiology', 'Heart Disease'),
	(13, 'Cardiology', 'Heart Attack'),
	(14, 'Neurology', 'Stroke'),
	(15, 'Endocrinology', 'Diabetes'),
	(16, 'Orthopedics', 'Fractured Arm'),
	(17, 'Orthopedics', 'Fractured Leg'),
	(18, 'Pulmonology', 'Asthma'),
	(19, 'Urology', 'Kidney Stones'),
	(20, 'General Surgery', 'Appendicitis'),
	(21, 'Oncology', 'Cancer'),
	(22, 'Cardiology', 'Hypertension'),
	(23, 'Cardiology', 'Heart Disease'),
	(24, 'Cardiology', 'Heart Attack'),
	(25, 'Neurology', 'Stroke'),
	(26, 'Endocrinology', 'Diabetes'),
	(27, 'Orthopedics', 'Fractured Arm'),
	(28, 'Orthopedics', 'Fractured Leg'),
	(29, 'Pulmonology', 'Asthma'),
	(30, 'Urology', 'Kidney Stones'),
	(31, 'General Surgery', 'Appendicitis'),
	(32, 'Oncology', 'Cancer'),
	(33, 'Cardiology', 'Hypertension'),
	(34, 'Cardiology', 'Heart Disease'),
	(35, 'Cardiology', 'Heart Attack'),
	(36, 'Neurology', 'Stroke'),
	(37, 'Endocrinology', 'Diabetes'),
	(38, 'Orthopedics', 'Fractured Arm'),
	(39, 'Orthopedics', 'Fractured Leg'),
	(40, 'Pulmonology', 'Asthma'),
	(41, 'Urology', 'Kidney Stones'),
	(42, 'General Surgery', 'Appendicitis'),
	(43, 'Oncology', 'Cancer'),
	(44, 'Cardiology', 'Hypertension'),
	(45, 'Cardiology', 'Heart Disease'),
	(46, 'Cardiology', 'Heart Attack'),
	(47, 'Neurology', 'Stroke'),
	(48, 'Endocrinology', 'Diabetes'),
	(49, 'Orthopedics', 'Fractured Arm'),
	(50, 'Orthopedics', 'Fractured Leg'),
	(51, 'Pulmonology', 'Asthma'),
	(52, 'Urology', 'Kidney Stones'),
	(53, 'General Surgery', 'Appendicitis'),
	(54, 'Oncology', 'Cancer'),
	(55, 'Cardiology', 'Hypertension'),
	(56, 'Cardiology', 'Heart Disease'),
	(57, 'Cardiology', 'Heart Attack'),
	(58, 'Neurology', 'Stroke'),
	(59, 'Endocrinology', 'Diabetes'),
	(60, 'Orthopedics', 'Fractured Arm'),
	(61, 'Orthopedics', 'Fractured Leg'),
	(62, 'Pulmonology', 'Asthma'),
	(63, 'Urology', 'Kidney Stones'),
	(64, 'General Surgery', 'Appendicitis'),
	(65, 'Oncology', 'Cancer'),
	(66, 'Cardiology', 'Hypertension'),
	(67, 'Cardiology', 'Heart Disease'),
	(68, 'Cardiology', 'Heart Attack'),
	(69, 'Neurology', 'Stroke'),
	(70, 'Endocrinology', 'Diabetes'),
	(71, 'Orthopedics', 'Fractured Arm'),
	(72, 'Orthopedics', 'Fractured Leg'),
	(73, 'Pulmonology', 'Asthma'),
	(74, 'Urology', 'Kidney Stones'),
	(75, 'General Surgery', 'Appendicitis'),
	(76, 'Oncology', 'Cancer'),
	(77, 'Cardiology', 'Hypertension'),
	(78, 'Cardiology', 'Heart Disease'),
	(79, 'Cardiology', 'Heart Attack'),
	(80, 'Neurology', 'Stroke'),
	(81, 'Endocrinology', 'Diabetes'),
	(82, 'Orthopedics', 'Fractured Arm'),
	(83, 'Orthopedics', 'Fractured Leg'),
	(84, 'Pulmonology', 'Asthma'),
	(85, 'Urology', 'Kidney Stones'),
	(86, 'General Surgery', 'Appendicitis'),
	(87, 'Oncology', 'Cancer'),
	(88, 'Cardiology', 'Hypertension'),
	(89, 'Cardiology', 'Heart Disease'),
	(90, 'Cardiology', 'Heart Attack'),
	(91, 'Neurology', 'Stroke'),
	(92, 'Endocrinology', 'Diabetes'),
	(93, 'Orthopedics', 'Fractured Arm'),
	(94, 'Orthopedics', 'Fractured Leg'),
	(95, 'Pulmonology', 'Asthma'),
	(96, 'Urology', 'Kidney Stones'),
	(97, 'General Surgery', 'Appendicitis'),
	(98, 'Oncology', 'Cancer'),
	(99, 'Cardiology', 'Hypertension'),
	(100, 'Cardiology', 'Heart Disease'),
	(101, 'Cardiology', 'Heart Attack'),
	(102, 'Neurology', 'Stroke'),
	(103, 'Endocrinology', 'Diabetes'),
	(104, 'Orthopedics', 'Fractured Arm'),
	(105, 'Orthopedics', 'Fractured Leg'),
	(106, 'Pulmonology', 'Asthma'),
	(107, 'Urology', 'Kidney Stones'),
	(108, 'General Surgery', 'Appendicitis'),
	(109, 'Oncology', 'Cancer'),
	(110, 'Cardiology', 'Hypertension'),
	(111, 'Cardiology', 'Heart Disease'),
	(112, 'Cardiology', 'Heart Attack'),
	(113, 'Neurology', 'Stroke'),
	(114, 'Endocrinology', 'Diabetes'),
	(115, 'Orthopedics', 'Fractured Arm'),
	(116, 'Orthopedics', 'Fractured Leg'),
	(117, 'Pulmonology', 'Asthma'),
	(118, 'Urology', 'Kidney Stones'),
	(119, 'General Surgery', 'Appendicitis'),
	(120, 'Oncology', 'Cancer'),
	(121, 'Cardiology', 'Hypertension'),
	(122, 'Cardiology', 'Heart Disease'),
	(123, 'Cardiology', 'Heart Attack'),
	(124, 'Neurology', 'Stroke'),
	(125, 'Endocrinology', 'Diabetes'),
	(126, 'Orthopedics', 'Fractured Arm'),
	(127, 'Orthopedics', 'Fractured Leg'),
	(128, 'Pulmonology', 'Asthma'),
	(129, 'Urology', 'Kidney Stones'),
	(130, 'General Surgery', 'Appendicitis'),
	(131, 'Oncology', 'Cancer'),
	(132, 'Cardiology', 'Hypertension'),
	(133, 'Cardiology', 'Heart Disease'),
	(134, 'Cardiology', 'Heart Attack'),
	(135, 'Neurology', 'Stroke'),
	(136, 'Endocrinology', 'Diabetes'),
	(137, 'Orthopedics', 'Fractured Arm'),
	(138, 'Orthopedics', 'Fractured Leg'),
	(139, 'Pulmonology', 'Asthma'),
	(140, 'Urology', 'Kidney Stones'),
	(141, 'General Surgery', 'Appendicitis'),
	(142, 'Oncology', 'Cancer'),
	(143, 'Cardiology', 'Hypertension'),
	(144, 'Cardiology', 'Heart Disease'),
	(145, 'Cardiology', 'Heart Attack'),
	(146, 'Neurology', 'Stroke'),
	(147, 'Endocrinology', 'Diabetes'),
	(148, 'Orthopedics', 'Fractured Arm'),
	(149, 'Orthopedics', 'Fractured Leg'),
	(150, 'Pulmonology', 'Asthma'),
	(151, 'Urology', 'Kidney Stones'),
	(152, 'General Surgery', 'Appendicitis'),
	(153, 'Oncology', 'Cancer'),
	(154, 'Cardiology', 'Hypertension'),
	(155, 'Cardiology', 'Heart Disease'),
	(156, 'Cardiology', 'Heart Attack'),
	(157, 'Neurology', 'Stroke'),
	(158, 'Endocrinology', 'Diabetes'),
	(159, 'Orthopedics', 'Fractured Arm'),
	(160, 'Orthopedics', 'Fractured Leg'),
	(161, 'Pulmonology', 'Asthma'),
	(162, 'Urology', 'Kidney Stones'),
	(163, 'General Surgery', 'Appendicitis'),
	(164, 'Oncology', 'Cancer'),
	(165, 'Cardiology', 'Hypertension'),
	(166, 'Cardiology', 'Heart Disease'),
	(167, 'Cardiology', 'Heart Attack'),
	(168, 'Neurology', 'Stroke'),
	(169, 'Endocrinology', 'Diabetes'),
	(170, 'Orthopedics', 'Fractured Arm'),
	(171, 'Orthopedics', 'Fractured Leg'),
	(172, 'Pulmonology', 'Asthma'),
	(173, 'Urology', 'Kidney Stones'),
	(174, 'General Surgery', 'Appendicitis'),
	(175, 'Oncology', 'Cancer'),
	(176, 'Cardiology', 'Hypertension'),
	(177, 'Cardiology', 'Heart Disease'),
	(178, 'Cardiology', 'Heart Attack'),
	(179, 'Neurology', 'Stroke'),
	(180, 'Endocrinology', 'Diabetes'),
	(181, 'Orthopedics', 'Fractured Arm'),
	(182, 'Orthopedics', 'Fractured Leg'),
	(183, 'Pulmonology', 'Asthma'),
	(184, 'Urology', 'Kidney Stones'),
	(185, 'General Surgery', 'Appendicitis'),
	(186, 'Oncology', 'Cancer'),
	(187, 'Cardiology', 'Hypertension'),
	(188, 'Cardiology', 'Heart Disease'),
	(189, 'Cardiology', 'Heart Attack'),
	(190, 'Neurology', 'Stroke'),
	(191, 'Endocrinology', 'Diabetes'),
	(192, 'Orthopedics', 'Fractured Arm'),
	(193, 'Orthopedics', 'Fractured Leg'),
	(194, 'Pulmonology', 'Asthma'),
	(195, 'Urology', 'Kidney Stones'),
	(196, 'General Surgery', 'Appendicitis'),
	(197, 'Oncology', 'Cancer'),
	(198, 'Cardiology', 'Hypertension'),
	(199, 'Cardiology', 'Heart Disease'),
	(200, 'Cardiology', 'Heart Attack'),
	(201, 'Neurology', 'Stroke'),
	(202, 'Endocrinology', 'Diabetes'),
	(203, 'Orthopedics', 'Fractured Arm'),
	(204, 'Orthopedics', 'Fractured Leg'),
	(205, 'Pulmonology', 'Asthma'),
	(206, 'Urology', 'Kidney Stones'),
	(207, 'General Surgery', 'Appendicitis'),
	(208, 'Oncology', 'Cancer'),
	(209, 'Cardiology', 'Hypertension');

-- Dumping structure for view hospital.departmentsummary
DROP VIEW IF EXISTS `departmentsummary`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `departmentsummary` (
	`Condition_Name` VARCHAR(1) NULL COLLATE 'utf8mb4_uca1400_ai_ci',
	`Total_Patients` BIGINT(21) NOT NULL
);

-- Dumping structure for table hospital.patients
DROP TABLE IF EXISTS `patients`;
CREATE TABLE IF NOT EXISTS `patients` (
  `Patient_ID` int(11) NOT NULL,
  `Age` int(11) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Condition_Name` varchar(100) DEFAULT NULL,
  `Procedure_Name` varchar(100) DEFAULT NULL,
  `Length_of_Stay` int(11) DEFAULT NULL,
  `Readmission` varchar(10) DEFAULT NULL,
  `Outcome` varchar(20) DEFAULT NULL,
  `Satisfaction` int(11) DEFAULT NULL,
  `Cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Dumping data for table hospital.patients: ~10 rows (approximately)
DELETE FROM `patients`;
INSERT INTO `patients` (`Patient_ID`, `Age`, `Gender`, `Condition_Name`, `Procedure_Name`, `Length_of_Stay`, `Readmission`, `Outcome`, `Satisfaction`, `Cost`) VALUES
	(1, 45, 'Female', 'Heart Disease', 'Angioplasty', 7, 'No', 'Recovered', 4, 18000.00),
	(2, 60, 'Male', 'Diabetes', 'Insulin Therapy', 5, 'Yes', 'Stable', 3, 9000.00),
	(3, 32, 'Female', 'Fractured Arm', 'X-Ray and Splint', 2, 'No', 'Recovered', 5, 3500.00),
	(4, 75, 'Male', 'Stroke', 'CT Scan and Medication', 10, 'Yes', 'Stable', 3, 22000.00),
	(5, 50, 'Female', 'Cancer', 'Surgery and Chemotherapy', 15, 'No', 'Recovered', 4, 45000.00),
	(6, 68, 'Male', 'Hypertension', 'Medication and Counseling', 4, 'Yes', 'Stable', 3, 7000.00),
	(7, 28, 'Female', 'Appendicitis', 'Appendectomy', 3, 'No', 'Recovered', 5, 12000.00),
	(8, 55, 'Male', 'Kidney Stones', 'Lithotripsy', 2, 'No', 'Recovered', 4, 10000.00),
	(9, 40, 'Female', 'Asthma', 'Inhalation Therapy', 3, 'Yes', 'Stable', 3, 5000.00),
	(10, 65, 'Male', 'Heart Attack', 'Cardiac Catheterization', 8, 'Yes', 'Recovered', 4, 30000.00);

-- Dumping structure for view hospital.patientsummary
DROP VIEW IF EXISTS `patientsummary`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `patientsummary` (
	`Patient_ID` INT(11) NOT NULL,
	`Age` INT(11) NULL,
	`Gender` VARCHAR(1) NULL COLLATE 'utf8mb4_uca1400_ai_ci',
	`Condition_Name` VARCHAR(1) NULL COLLATE 'utf8mb4_uca1400_ai_ci',
	`Procedure_Name` VARCHAR(1) NULL COLLATE 'utf8mb4_uca1400_ai_ci',
	`Outcome` VARCHAR(1) NULL COLLATE 'utf8mb4_uca1400_ai_ci'
);

-- Dumping structure for view hospital.qualitymetrics
DROP VIEW IF EXISTS `qualitymetrics`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `qualitymetrics` (
	`Avg_Stay` DECIMAL(14,4) NULL,
	`Avg_Satisfaction` DECIMAL(14,4) NULL,
	`Total_Cost` DECIMAL(32,2) NULL
);

-- Dumping structure for table hospital.realtimedata
DROP TABLE IF EXISTS `realtimedata`;
CREATE TABLE IF NOT EXISTS `realtimedata` (
  `Record_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Current_Patients` int(11) DEFAULT NULL,
  `Readmission_Count` int(11) DEFAULT NULL,
  `Last_Updated` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`Record_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Dumping data for table hospital.realtimedata: ~1 rows (approximately)
DELETE FROM `realtimedata`;
INSERT INTO `realtimedata` (`Record_ID`, `Current_Patients`, `Readmission_Count`, `Last_Updated`) VALUES
	(1, 10, 5, '2026-03-16 16:49:23');

-- Dumping structure for view hospital.realtimeview
DROP VIEW IF EXISTS `realtimeview`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `realtimeview` (
	`Current_Patients` BIGINT(21) NOT NULL,
	`Readmission_Count` DECIMAL(22,0) NULL
);

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `clinicalview`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `clinicalview` AS SELECT 
    Patient_ID,
    `Condition_Name`,
    `Procedure_Name`,
    Length_of_Stay,
    Outcome
FROM Patients 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `dashboardview`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `dashboardview` AS SELECT 
COUNT(Patient_ID) AS Total_Patients,
AVG(Length_of_Stay) AS Avg_Length_of_Stay,
AVG(Satisfaction) AS Avg_Satisfaction,
SUM(Cost) AS Total_Cost
FROM patients 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `departmentsummary`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `departmentsummary` AS SELECT 
`Condition_Name`,
COUNT(*) AS Total_Patients
FROM patients
GROUP BY `Condition_Name` 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `patientsummary`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `patientsummary` AS SELECT 
Patient_ID,
Age,
Gender,
`Condition_Name`,
`Procedure_Name`,
Outcome
FROM patients 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `qualitymetrics`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `qualitymetrics` AS SELECT
AVG(Length_of_Stay) AS Avg_Stay,
AVG(Satisfaction) AS Avg_Satisfaction,
SUM(Cost) AS Total_Cost
FROM patients 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `realtimeview`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `realtimeview` AS SELECT 
COUNT(Patient_ID) AS Current_Patients,
SUM(CASE WHEN Readmission='Yes' THEN 1 ELSE 0 END) AS Readmission_Count
FROM patients 
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

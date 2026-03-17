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

-- Trigger to update RealTimeData automatically when a new patient is admitted
DELIMITER //
CREATE TRIGGER After_Patient_Admit
AFTER INSERT ON patients
FOR EACH ROW
BEGIN
    UPDATE realtimedata 
    SET Current_Patients = Current_Patients + 1,
        Last_Updated = CURRENT_TIMESTAMP
    WHERE Record_ID = 1;
END //
DELIMITER ;

-- Procedure to fetch high-risk patients (Length of Stay > 7 days)
DELIMITER //
CREATE PROCEDURE GetHighRiskPatients(IN dept_name VARCHAR(50))
BEGIN
    SELECT p.Patient_ID, p.Condition_Name, p.Length_of_Stay
    FROM patients p
    JOIN departments d ON p.Condition_Name = d.Condition_Name
    WHERE d.Department_Name = dept_name AND p.Length_of_Stay > 7;
END //
DELIMITER ;

-- Indexing frequently joined or filtered columns
CREATE INDEX idx_patient_condition ON patients(Condition_Name);
CREATE INDEX idx_dept_condition ON departments(Condition_Name);
CREATE INDEX idx_outcome ON patients(Outcome);

-- Table to hold "Materialized" data
CREATE TABLE IF NOT EXISTS Cached_Quality_Metrics AS SELECT * FROM qualitymetrics;

INSERT IGNORE INTO realtimedata (Record_ID, Current_Patients, Readmission_Count) VALUES (1, 0, 0);

-- Procedure to refresh the "Materialized View"
DELIMITER //
CREATE PROCEDURE RefreshQualityMetrics()
BEGIN
    TRUNCATE TABLE Cached_Quality_Metrics;
    INSERT INTO Cached_Quality_Metrics SELECT * FROM qualitymetrics;
END //


DELIMITER ;

-- The "Smart Clinical Dashboard Master View" 
-- Joins Demographics (M1 logic), Department (M25 logic), and Outcomes (M43 logic)
CREATE OR REPLACE VIEW MasterClinicalInsight AS
SELECT 
    p.Patient_ID,
    p.Age,
    p.Gender,
    d.Department_Name,
    p.Condition_Name,
    p.Outcome,
    CASE 
        WHEN p.Length_of_Stay > 7 THEN 'High Resource Use'
        WHEN p.Readmission = 'Yes' THEN 'Follow-up Required'
        ELSE 'Standard Care'
    END AS Clinical_Status
FROM patients p
LEFT JOIN departments d ON p.Condition_Name = d.Condition_Name;


/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

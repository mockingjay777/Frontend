-- --------------------------------------------------------
-- CLEANED SCHEMA FOR CROSS-PLATFORM COMPATIBILITY
-- --------------------------------------------------------

SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET NAMES utf8mb4;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';

-- 1. DATABASE RE-CREATION
DROP DATABASE IF EXISTS `hospital`;
CREATE DATABASE IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8mb4;
USE `hospital`;

-- 2. TEMPORARY STRUCTURES FOR VIEWS
DROP VIEW IF EXISTS `clinicalview`;
CREATE TABLE `clinicalview` (
  `Patient_ID` INT(11) NOT NULL,
  `Condition_Name` VARCHAR(100) NULL,
  `Procedure_Name` VARCHAR(100) NULL,
  `Length_of_Stay` INT(11) NULL,
  `Outcome` VARCHAR(20) NULL
);

DROP TABLE IF EXISTS `dashboard`;
CREATE TABLE IF NOT EXISTS `dashboard` (
  `Dashboard_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Total_Patients` int(11) DEFAULT NULL,
  `Avg_Length_of_Stay` decimal(5,2) DEFAULT NULL,
  `Avg_Satisfaction` decimal(3,2) DEFAULT NULL,
  `Total_Cost` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`Dashboard_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP VIEW IF EXISTS `dashboardview`;
CREATE TABLE `dashboardview` (
  `Total_Patients` BIGINT(21) NOT NULL,
  `Avg_Length_of_Stay` DECIMAL(14,4) NULL,
  `Avg_Satisfaction` DECIMAL(14,4) NULL,
  `Total_Cost` DECIMAL(32,2) NULL
);

DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `Department_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Department_Name` varchar(50) DEFAULT NULL,
  `Condition_Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Department_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP VIEW IF EXISTS `departmentsummary`;
CREATE TABLE `departmentsummary` (
  `Condition_Name` VARCHAR(100) NULL,
  `Total_Patients` BIGINT(21) NOT NULL
);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP VIEW IF EXISTS `patientsummary`;
CREATE TABLE `patientsummary` (
  `Patient_ID` INT(11) NOT NULL,
  `Age` INT(11) NULL,
  `Gender` VARCHAR(10) NULL,
  `Condition_Name` VARCHAR(100) NULL,
  `Procedure_Name` VARCHAR(100) NULL,
  `Outcome` VARCHAR(20) NULL
);

DROP VIEW IF EXISTS `qualitymetrics`;
CREATE TABLE `qualitymetrics` (
  `Avg_Stay` DECIMAL(14,4) NULL,
  `Avg_Satisfaction` DECIMAL(14,4) NULL,
  `Total_Cost` DECIMAL(32,2) NULL
);

DROP TABLE IF EXISTS `realtimedata`;
CREATE TABLE IF NOT EXISTS `realtimedata` (
  `Record_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Current_Patients` int(11) DEFAULT NULL,
  `Readmission_Count` int(11) DEFAULT NULL,
  `Last_Updated` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`Record_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP VIEW IF EXISTS `realtimeview`;
CREATE TABLE `realtimeview` (
  `Current_Patients` BIGINT(21) NOT NULL,
  `Readmission_Count` DECIMAL(22,0) NULL
);

-- 3. FINAL VIEW STRUCTURES
DROP TABLE IF EXISTS `clinicalview`;
CREATE VIEW `clinicalview` AS SELECT Patient_ID, Condition_Name, Procedure_Name, Length_of_Stay, Outcome FROM patients;

DROP TABLE IF EXISTS `dashboardview`;
CREATE VIEW `dashboardview` AS SELECT COUNT(Patient_ID) AS Total_Patients, AVG(Length_of_Stay) AS Avg_Length_of_Stay, AVG(Satisfaction) AS Avg_Satisfaction, SUM(Cost) AS Total_Cost FROM patients;

DROP TABLE IF EXISTS `departmentsummary`;
CREATE VIEW `departmentsummary` AS SELECT Condition_Name, COUNT(*) AS Total_Patients FROM patients GROUP BY Condition_Name;

DROP TABLE IF EXISTS `patientsummary`;
CREATE VIEW `patientsummary` AS SELECT Patient_ID, Age, Gender, Condition_Name, Procedure_Name, Outcome FROM patients;

DROP TABLE IF EXISTS `qualitymetrics`;
CREATE VIEW `qualitymetrics` AS SELECT AVG(Length_of_Stay) AS Avg_Stay, AVG(Satisfaction) AS Avg_Satisfaction, SUM(Cost) AS Total_Cost FROM patients;

DROP TABLE IF EXISTS `realtimeview`;
CREATE VIEW `realtimeview` AS SELECT COUNT(Patient_ID) AS Current_Patients, SUM(CASE WHEN Readmission='Yes' THEN 1 ELSE 0 END) AS Readmission_Count FROM patients;

-- 4. PROCEDURES & TRIGGERS
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

CREATE PROCEDURE GetHighRiskPatients(IN dept_name VARCHAR(50))
BEGIN
    SELECT p.Patient_ID, p.Condition_Name, p.Length_of_Stay
    FROM patients p
    JOIN departments d ON p.Condition_Name = d.Condition_Name
    WHERE d.Department_Name = dept_name AND p.Length_of_Stay > 7;
END //

CREATE TABLE IF NOT EXISTS Cached_Quality_Metrics AS SELECT * FROM qualitymetrics;

CREATE PROCEDURE RefreshQualityMetrics()
BEGIN
    TRUNCATE TABLE Cached_Quality_Metrics;
    INSERT INTO Cached_Quality_Metrics SELECT * FROM qualitymetrics;
END //
DELIMITER ;

-- 5. MASTER INTEGRATED VIEW
CREATE OR REPLACE VIEW MasterClinicalInsight AS
SELECT 
    p.Patient_ID, p.Age, p.Gender, d.Department_Name, p.Condition_Name, p.Outcome,
    CASE 
        WHEN p.Length_of_Stay > 7 THEN 'High Resource Use'
        WHEN p.Readmission = 'Yes' THEN 'Follow-up Required'
        ELSE 'Standard Care'
    END AS Clinical_Status
FROM patients p
LEFT JOIN departments d ON p.Condition_Name = d.Condition_Name;

-- 6. INDEXES
CREATE INDEX idx_patient_condition ON patients(Condition_Name);
CREATE INDEX idx_dept_condition ON departments(Condition_Name);
CREATE INDEX idx_outcome ON patients(Outcome);

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
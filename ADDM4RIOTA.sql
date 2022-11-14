CREATE SCHEMA `ADDM4RIOTA`;

CREATE TABLE `ADDM4RIOTA`.`iot_critical_object` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `acronym` varchar(255) UNIQUE
);

CREATE TABLE `ADDM4RIOTA`.`threat_type` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `IoTCriticalObjects` varchar(255),
  `iot_threat_id` varchar(255) UNIQUE,
  `name` varchar(255),
  `description` text,
  `reference` varchar(255),
  `ResilientSolutionIds` varchar(255)
);

CREATE TABLE `ADDM4RIOTA`.`resilient_solution` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `resilient_solution_id` varchar(255) UNIQUE,
  `name` varchar(255),
  `description` text,
  `references` varchar(255)
);

CREATE TABLE `ADDM4RIOTA`.`BRIDGE_iot_critical_object_threat_type` (
  `ICO_acronym` varchar(255),
  `TT_id` varchar(255),
  PRIMARY KEY (`ICO_id`, `TT_id`)
);

CREATE TABLE `ADDM4RIOTA`.`BRIDGE_resilient_solution_threat_type` (
  `RESSOL_id` varchar(255),
  `TT_id` varchar(255),
  PRIMARY KEY (`RESSOL_id`, `TT_id`)
);

CREATE TABLE ADDM4RIOTA.CATEGORICAL_threat_type {
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(255),
    `Acronym` VARCHAR(20),
    `Description` VARCHAR(255)
    };

ALTER TABLE `ADDM4RIOTA`.`BRIDGE_iot_critical_object_threat_type` ADD FOREIGN KEY (ICO_acronym) REFERENCES `ADDM4RIOTA`.`iot_critical_object` (`acronym`);

ALTER TABLE `ADDM4RIOTA`.`BRIDGE_iot_critical_object_threat_type` ADD FOREIGN KEY (`TT_id`) REFERENCES `ADDM4RIOTA`.`threat_type` (`iot_threat_id`);

ALTER TABLE `ADDM4RIOTA`.`BRIDGE_resilient_solution_threat_type` ADD FOREIGN KEY (`RESSOL_id`) REFERENCES `ADDM4RIOTA`.`resilient_solution` (`resilient_solution_id`);

ALTER TABLE `ADDM4RIOTA`.`BRIDGE_resilient_solution_threat_type` ADD FOREIGN KEY (`TT_id`) REFERENCES `ADDM4RIOTA`.`threat_type` (`iot_threat_id`);

delete from ADDM4RIOTA.threat_type where 1=1;
delete from ADDM4RIOTA.iot_critical_object where 1=1;

delete from ADDM4RIOTA.BRIDGE_resilient_solution_threat_type where 1=1;
delete from ADDM4RIOTA.BRIDGE_iot_critical_object_threat_type where 1=1;
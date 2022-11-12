CREATE SCHEMA `ADDM4RIOTA`;

CREATE TABLE `ADDM4RIOTA`.`iot_critical_objects` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `acronym` varchar(255)
);

CREATE TABLE `ADDM4RIOTA`.`threat_type` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `iot_threat_id` varchar(255) UNIQUE,
  `name` varchar(255),
  `description` text,
  `reference` varchar(255),
  `resilient_solutions` int,
  `iot_critical_objects` int
);

CREATE TABLE `ADDM4RIOTA`.`resilient_solution` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `resilient_solution_id` varchar(255) UNIQUE,
  `name` varchar(255),
  `description` text,
  `references` varchar(255)
);

CREATE INDEX threat_type_index_0 ON `ADDM4RIOTA`.`threat_type` (`iot_critical_objects`);

CREATE INDEX threat_type_index_1 ON `ADDM4RIOTA`.`threat_type` (`resilient_solutions`);



CREATE TABLE `ADDM4RIOTA`.`resilient_solution_threat_type` (
  `resilient_solution_resilient_solution_id` varchar(255),
  `threat_type_resilient_solutions` int,
  PRIMARY KEY (`resilient_solution_resilient_solution_id`, `threat_type_resilient_solutions`)
);

ALTER TABLE `ADDM4RIOTA`.`resilient_solution_threat_type` ADD FOREIGN KEY (`resilient_solution_resilient_solution_id`) REFERENCES `ADDM4RIOTA`.`resilient_solution` (`resilient_solution_id`);

ALTER TABLE `ADDM4RIOTA`.`resilient_solution_threat_type` ADD FOREIGN KEY (`threat_type_resilient_solutions`) REFERENCES `ADDM4RIOTA`.`threat_type` (`resilient_solutions`);


CREATE TABLE `ADDM4RIOTA`.`iot_critical_objects_threat_type` (
  `iot_critical_objects_id` int,
  `threat_type_iot_critical_objects` int,
  PRIMARY KEY (`iot_critical_objects_id`, `threat_type_iot_critical_objects`)
);

ALTER TABLE `ADDM4RIOTA`.`iot_critical_objects_threat_type` ADD FOREIGN KEY (`iot_critical_objects_id`) REFERENCES `ADDM4RIOTA`.`iot_critical_objects` (`id`);

ALTER TABLE `ADDM4RIOTA`.`iot_critical_objects_threat_type` ADD FOREIGN KEY (`threat_type_iot_critical_objects`) REFERENCES `ADDM4RIOTA`.`threat_type` (`iot_critical_objects`);


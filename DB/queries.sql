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

-- Buscar todas as resilient solutions de um Threat Type
select * from ADDM4RIOTA.BRIDGE_resilient_solution_threat_type B left join ADDM4RIOTA.resilient_solution res
    on B.RESSOL_id = res.resilient_solution_id
    where B.TT_id = 'NLTT1';

-- Buscar todos as Threat Types relacionadas com um Critical Object
select * from ADDM4RIOTA.BRIDGE_iot_critical_object_threat_type co left join ADDM4RIOTA.threat_type tt
    on co.TT_id = tt.iot_threat_id
    where co.ICO_acronym='DVC';


-- Filtrar IoT threats
select tt.iot_threat_id, tt.name, tt.description from
    ADDM4RIOTA.threat_type_enum tte right join ADDM4RIOTA.threat_type tt
        on tt.threat_type_enum = tte.id
    inner join ADDM4RIOTA.BRIDGE_iot_critical_object_threat_type B_ico_tt
        on B_ico_tt.TT_id = tt.iot_threat_id
    where tte.acronym like ifnull(null, '%') AND
          B_ico_tt.ICO_acronym like ifnull(null, '%');

select tt.* from ADDM4RIOTA.threat_type tt
    where tt.iot_threat_id like CONCAT('%',ifnull(null,''),'%') AND
        tt.IoTCriticalObjects like CONCAT('%',ifnull(null, ''),'%');


select REGEXP_SUBSTR(tt.iot_threat_id,'^[A-Z]+') as rid from threat_type tt group by rid;


CREATE PROCEDURE populate_threat_enum()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE threat_id CHAR(255);
  DECLARE id_int, enum_id INT;
  DECLARE cur1 CURSOR FOR SELECT id,REGEXP_SUBSTR(tt.iot_threat_id,'^[A-Z]+') FROM ADDM4RIOTA.threat_type tt;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP
    FETCH cur1 INTO id_int, threat_id;
    IF done THEN
      LEAVE read_loop;
    END IF;
    select id from ADDM4RIOTA.threat_type_enum te where te.acronym = threat_id into enum_id;
    update ADDM4RIOTA.threat_type tt set tt.threat_type_enum = enum_id where tt.id=id_int;
  END LOOP;

  CLOSE cur1;
END;

call populate_threat_enum();

# Populando resilient solution enum
insert into ADDM4RIOTA.resilient_solution_enum
select null, '',REGEXP_SUBSTR(rs.resilient_solution_id,'[A-Z]+') as rs_enum_id from ADDM4RIOTA.resilient_solution rs group by rs_enum_id;

alter table ADDM4RIOTA.resilient_solution_enum AUTO_INCREMENT = 1;

delete from ADDM4RIOTA.resilient_solution_enum where true;

# Adicionando a coluna que referencia o enum na tabela de soluções
CREATE PROCEDURE populate_resilient_solution_enum()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE solution_acronym CHAR(255);
  DECLARE enum_id, id_solution INT;
  DECLARE cur1 CURSOR FOR SELECT id,REGEXP_SUBSTR(rs.resilient_solution_id,'^[A-Z]+') FROM ADDM4RIOTA.resilient_solution rs;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP
    FETCH cur1 INTO id_solution, solution_acronym;
    IF done THEN
      LEAVE read_loop;
    END IF;
    select id from ADDM4RIOTA.resilient_solution_enum rse where rse.acronym = solution_acronym into enum_id;
    update ADDM4RIOTA.resilient_solution rs set rs.resilient_solution_enum = enum_id where rs.id=id_solution;
  END LOOP;

  CLOSE cur1;
END;

call populate_resilient_solution_enum();

select * from resilient_solution rs where CAST(rs.id as CHAR) like '1';


select rs.* from (ADDM4RIOTA.threat_type_enum B inner join ADDM4RIOTA.resilient_solution rs
            on B.id = rs.resilient_solution_enum ) where
            cast(rs.id as CHAR) like ifnull(NULL,'%') AND
            ( (isnull('RTK') = 1) OR (rs.resilient_solution_id rlike concat('RTK','[0-9]+'))) AND
            rs.name like ifnull(NULL,'%') AND
            rs.description like CONCAT('%',ifnull(NULL,''),'%') AND
            rs.references like CONCAT('%',ifnull(NULL,''),'%') AND
            rs.resilient_solution_enum like CONCAT('%',ifnull(NULL,''),'%') AND
            B.acronym like CONCAT('%',ifnull(NULL,''),'%');

select rs.* from (ADDM4RIOTA.resilient_solution_enum rse inner join ADDM4RIOTA.resilient_solution rs
            on rse.id = rs.resilient_solution_enum ) inner join
            ADDM4RIOTA.BRIDGE_resilient_solution_threat_type rstt
            on rstt.RESSOL_id = rs.resilient_solution_id
            where
            cast(rs.id as CHAR) like ifnull(NULL,'%') AND
            ( (isnull(NULL) = 1) OR rse.acronym like NULL) AND
            rs.name like ifnull(NULL,'%') AND
            rs.description like CONCAT('%',ifnull(NULL,''),'%') AND
            rs.references like CONCAT('%',ifnull(NULL,''),'%') AND
            rs.resilient_solution_enum like CONCAT('%',ifnull(NULL,''),'%') AND
            rstt.TT_id like CONCAT('%',ifnull('NLTT',''),'%')
            group by rs.resilient_solution_id;
package com.addm4riota.backend.domain.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "threat_type")
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class ThreatType {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@EqualsAndHashCode.Include
	private Long id;
	@Column(name = "IoTCriticalObjects")
	private String iotCriticalObjects;
	@Column(name = "iot_threat_id")
	private String iotThreatId;
	private String name;
	private String description;
	private String reference;
	@Column(name = "ResilientSolutionIds")
	private String resilientSolutionIds;
}

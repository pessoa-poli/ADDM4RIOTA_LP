package com.addm4riota.backend.domain.model;

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
@Table(name = "iot_critical_object")
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class IoTCriticalObject {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@EqualsAndHashCode.Include
	// @Column(name = "id")
	private Long id;
	private String name;
	private String acronym;
	
}
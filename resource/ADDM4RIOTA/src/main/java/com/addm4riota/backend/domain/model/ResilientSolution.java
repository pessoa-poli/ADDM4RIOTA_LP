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
@Table(name = "resilient_solution")
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class ResilientSolution {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@EqualsAndHashCode.Include
	private Long id;
	@Column(name = "resilient_solution_id")
	private String resilientSolutionId;
	private String name;
	private String description;
	private String references;	

}

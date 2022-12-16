package com.addm4riota.backend.api.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.addm4riota.backend.domain.model.ResilientSolution;
import com.addm4riota.backend.domain.repository.ResilientSolutionRepository;

@RestController
@RequestMapping("/resilientsolutions")
public class ResilientSolutionController {
	
	@Autowired
	private ResilientSolutionRepository repository;
	
	@GetMapping
	public List<ResilientSolution> buscar() {
		return repository.findAll();
	}
}

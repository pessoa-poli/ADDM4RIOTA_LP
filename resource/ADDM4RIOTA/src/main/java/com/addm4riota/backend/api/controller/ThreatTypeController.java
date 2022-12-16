package com.addm4riota.backend.api.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.addm4riota.backend.domain.model.ThreatType;
import com.addm4riota.backend.domain.repository.ThreatTypeRepository;

@RestController
@RequestMapping("/threattypes")
public class ThreatTypeController {
	
	@Autowired
	private ThreatTypeRepository repository;
	
	@GetMapping
	public List<ThreatType> findall() {
		return repository.findAll();
	}
	
}

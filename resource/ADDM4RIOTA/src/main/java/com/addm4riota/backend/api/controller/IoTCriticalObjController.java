package com.addm4riota.backend.api.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.addm4riota.backend.domain.model.IoTCriticalObject;
import com.addm4riota.backend.domain.repository.IoTCriticalObjectRepository;
		

@RestController	
@RequestMapping("/iotcriticalobjects")
public class IoTCriticalObjController {
	
	//@PersistenceContext
	//private EntityManager manager;
	
	@Autowired
	private IoTCriticalObjectRepository repository;
	
	@GetMapping
	public List<IoTCriticalObject> test() {
		return repository.findAll();
	}

}

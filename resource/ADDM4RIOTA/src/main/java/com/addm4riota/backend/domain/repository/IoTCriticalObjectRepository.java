package com.addm4riota.backend.domain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.addm4riota.backend.domain.model.IoTCriticalObject;

@Repository
public interface IoTCriticalObjectRepository extends JpaRepository<IoTCriticalObject, Long>{
	
}

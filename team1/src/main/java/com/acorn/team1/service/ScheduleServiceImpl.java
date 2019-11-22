package com.acorn.team1.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.ScheduleVO;
import com.acorn.team1.persistence.ScheduleDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ScheduleServiceImpl implements ScheduleService {
	
	@Inject
	private ScheduleDAO dao;

	@Override
	public List<ScheduleVO> listAll(Integer year) throws Exception {
		log.info("ScheduleServiceImpl:: listAll(year) invoked.");
		log.info("\t+ year: " + year);
		
		return dao.listAll(year);
	}

	@Override
	public List<ScheduleVO> listCourse(Integer year, Integer courseCode) throws Exception {
		log.info("ScheduleServiceImpl:: listCourse(year, courseCode) invoked.");
		log.info("\t+ year: " + year);
		log.info("\t+ courseCode: " + courseCode);
		
		return dao.listCourse(year, courseCode);
	}

} // end class

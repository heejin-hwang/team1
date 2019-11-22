package com.acorn.team1.service;

import java.util.List;

import com.acorn.team1.domain.ScheduleVO;

public interface ScheduleService {
	
	public abstract List<ScheduleVO> listAll(Integer year) throws Exception;
	
	public abstract List<ScheduleVO> listCourse(Integer year, Integer courseCode) throws Exception;
	
} // end interface

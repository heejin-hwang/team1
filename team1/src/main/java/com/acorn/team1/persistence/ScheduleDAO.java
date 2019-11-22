package com.acorn.team1.persistence;

import java.util.List;

import com.acorn.team1.domain.ScheduleVO;

public interface ScheduleDAO {
	
	public abstract List<ScheduleVO> listAll(Integer year) throws Exception;
	
	public abstract List<ScheduleVO> listCourse(Integer year, Integer courseCode) throws Exception;
	
} // end interface

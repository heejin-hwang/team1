package com.acorn.team1.service;

import java.util.List;

import com.acorn.team1.domain.AssignmentDTO;
import com.acorn.team1.domain.AssignmentVO;
import com.acorn.team1.domain.GroupVO;
import com.acorn.team1.domain.GroupSubmitVO;

public interface AssignmentService {
	
	public abstract void regist(AssignmentDTO dto) throws Exception;
	
	public abstract AssignmentVO read(Integer id) throws Exception;
	
	public abstract void modify(AssignmentDTO dto) throws Exception;
	
	public abstract void remove(Integer id) throws Exception;
	
	public abstract List<AssignmentVO> listAll(String adminId, Integer currCourseCode) throws Exception;
	
	public abstract List<GroupSubmitVO> listStatus(Integer id) throws Exception;
	
	public abstract List<GroupVO> listGroup(String adminId, Integer courseCode) throws Exception;
	
	public abstract String getCourseName(String adminId) throws Exception;
	
	public abstract Integer getCurrentCourseId(String adminId) throws Exception;

} // end interface

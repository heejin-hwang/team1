package com.acorn.team1.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.AssignmentDTO;
import com.acorn.team1.domain.AssignmentVO;
import com.acorn.team1.domain.GroupVO;
import com.acorn.team1.domain.GroupSubmitVO;
import com.acorn.team1.persistence.AssignmentDAO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AssignmentServiceImpl implements AssignmentService {
	
	@Inject
	private AssignmentDAO dao;

	@Override
	public void regist(AssignmentDTO dto) throws Exception {
		log.info("AssignmentServiceImpl::regist invoked");
		dao.create(dto);
	} // regist

	@Override
	public AssignmentVO read(Integer id) throws Exception {
		return dao.read(id);
	} // read

	@Override
	public void modify(AssignmentDTO dto) throws Exception {
		dao.update(dto);
	} // modify

	@Override
	public void remove(Integer id) throws Exception {
		dao.delete(id);
	} // remove

	@Override
	public List<AssignmentVO> listAll(String adminId, Integer currCourseCode) throws Exception {
		return dao.listAll(adminId, currCourseCode);
	} // listAll

	@Override
	public List<GroupSubmitVO> listStatus(Integer id) throws Exception {
		return dao.listStatus(id);
	} // listStatus

	@Override
	public List<GroupVO> listGroup(String adminId, Integer courseCode) throws Exception {
		return dao.listGroup(adminId, courseCode);
	} // listGroup

	@Override
	public String getCourseName(String adminId) throws Exception {
		return dao.getCourseName(adminId);
	}

	@Override
	public Integer getCurrentCourseId(String adminId) throws Exception {
		return dao.getCurrentCourseId(adminId);
	}

} // end class

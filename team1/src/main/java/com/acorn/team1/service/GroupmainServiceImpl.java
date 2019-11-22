package com.acorn.team1.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.AssignmentSubmitDTO;
import com.acorn.team1.domain.AssignmentSubmitVO;
import com.acorn.team1.domain.CourseAssignmentListVO;
import com.acorn.team1.domain.GroupMemberListVO;
import com.acorn.team1.domain.SubmitVO;
import com.acorn.team1.persistence.GroupmainDAO;

@Service
public class GroupmainServiceImpl implements GroupmainService {
	
	@Inject
	private GroupmainDAO dao;

	@Override
	public List<CourseAssignmentListVO> listAssignmentAll(Integer course_code, Integer group_id) throws Exception {
		return dao.listAssignmentAll(course_code, group_id);
	} // listAll

	@Override
	public List<GroupMemberListVO> listMemberAll(Integer course_code, Integer group_id) throws Exception {
		return dao.listMemberAll(course_code, group_id);
	} // listMemberAll

	@Override
	public List<SubmitVO> listSubmitStatus(Integer course_code, Integer groups_id) throws Exception {
		return dao.listSubmitStatus(course_code, groups_id);
	} // listSubmitStatus

	@Override
	public void submitAssignment(AssignmentSubmitDTO dto) throws Exception {
		dao.insertFileUpload(dto);
	}

	@Override
	public List<AssignmentSubmitVO> checkSubmitStatus(Integer groups_id, Integer assignment_id) throws Exception {
		return dao.checkSubmitStatus(groups_id, assignment_id);
	}

	@Override
	public String getCourseName(Integer course_code) throws Exception {
		return dao.getCourseName(course_code);
	}

	@Override
	public String getGroupName(Integer course_code, Integer group_id) throws Exception {
		return dao.getGroupName(course_code, group_id);
	}

	@Override
	public String getAssignmentName(Integer assignment_id) throws Exception {
		return dao.getAssignmentName(assignment_id);
	}

	@Override
	public Integer getGroupsId(String studentId) throws Exception {
		return dao.getGroupsId(studentId);
	}
} // end class

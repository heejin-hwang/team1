package com.acorn.team1.persistence;

import java.util.List;

import com.acorn.team1.domain.AssignmentSubmitDTO;
import com.acorn.team1.domain.AssignmentSubmitVO;
import com.acorn.team1.domain.CourseAssignmentListVO;
import com.acorn.team1.domain.GroupMemberListVO;
import com.acorn.team1.domain.SubmitVO;

public interface GroupmainDAO {
	
	public abstract List<CourseAssignmentListVO> listAssignmentAll(Integer course_code, Integer group_id) throws Exception;
	
	public abstract List<GroupMemberListVO> listMemberAll(Integer course_code, Integer group_id) throws Exception;

	public abstract List<SubmitVO> listSubmitStatus(Integer course_code, Integer groups_id) throws Exception;
	
	public abstract void insertFileUpload(AssignmentSubmitDTO dto) throws Exception;
	
	public abstract List<AssignmentSubmitVO> checkSubmitStatus(Integer groups_id, Integer assignment_id) throws Exception;
	
	public abstract String getCourseName(Integer course_code) throws Exception;
	
	public abstract String getGroupName(Integer course_code, Integer group_id) throws Exception;
	
	public abstract String getAssignmentName(Integer assignment_id) throws Exception;
	
	public abstract Integer getGroupsId(String studentId) throws Exception;

} // end class

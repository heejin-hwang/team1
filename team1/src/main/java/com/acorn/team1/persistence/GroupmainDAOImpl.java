package com.acorn.team1.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.AssignmentSubmitDTO;
import com.acorn.team1.domain.AssignmentSubmitVO;
import com.acorn.team1.domain.CourseAssignmentListVO;
import com.acorn.team1.domain.GroupMemberListVO;
import com.acorn.team1.domain.SubmitVO;

@Repository
public class GroupmainDAOImpl implements GroupmainDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.acorn.mapper.GroupmainMapper";
	
	@Override
	public List<CourseAssignmentListVO> listAssignmentAll(Integer course_code, Integer group_id) throws Exception {
		
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("course_code", course_code);
		params.put("group_id", group_id);
		
		return session.selectList(namespace + ".listAssignment", params);
	} // listAssignmentAll

	@Override
	public List<GroupMemberListVO> listMemberAll(Integer course_code, Integer group_id) throws Exception {
		
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("course_code", course_code);
		params.put("group_id", group_id);
		
		return session.selectList(namespace + ".listMember", params);
	} // listMemberAll

	@Override
	public List<SubmitVO> listSubmitStatus(Integer course_code, Integer groups_id) throws Exception {
		
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("course_code", course_code);
		params.put("groups_id", groups_id);
		
		return session.selectList(namespace + ".submitStatus", params);
	} // listSubmitStatus
	
	@Override
	public void insertFileUpload(AssignmentSubmitDTO dto) throws Exception {
		
		Map<String, Integer> submit = new HashMap<String, Integer>();
		submit.put("course_code", dto.getCourse_code());
		submit.put("assignment_id", dto.getAssignment_id());
		submit.put("groups_id", dto.getGroups_id());
		
		session.insert(namespace + ".insert_tbl_submit", submit);		
		
		Map<String, String> fileupload = new HashMap<String, String>();
		fileupload.put("name_key", dto.getName_key());
		fileupload.put("name", dto.getName());
		fileupload.put("path", dto.getPath());
		fileupload.put("size", dto.getSize());
		fileupload.put("group_id", Integer.toString(dto.getGroup_id()));
		
		session.insert(namespace + ".insert_tbl_fileupload", fileupload);		
	}

	@Override
	public List<AssignmentSubmitVO> checkSubmitStatus(Integer groups_id, Integer assignment_id) throws Exception {
		
		Map<String, Integer> params = new HashMap<>();
		params.put("id", assignment_id);
		params.put("group_id", groups_id);
		
		return session.selectList(namespace + ".checkSubmit", params);
	}

	@Override
	public String getCourseName(Integer course_code) throws Exception {
		return session.selectOne(namespace + ".getCourseName", course_code);
	}

	@Override
	public String getGroupName(Integer course_code, Integer group_id) throws Exception {
		Map<String, Integer> params = new HashMap<>();
		params.put("course_code", course_code);
		params.put("group_id", group_id);
		
		return session.selectOne(namespace + ".getGroupName", params);
	}

	@Override
	public String getAssignmentName(Integer assignment_id) throws Exception {
		return session.selectOne(namespace + ".getAssignmentName", assignment_id);
	}

	@Override
	public Integer getGroupsId(String studentId) throws Exception {
		return session.selectOne(namespace + ".getGroupsId", studentId);
	}

} // end class

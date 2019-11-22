package com.acorn.team1.service;

import java.util.List;

import com.acorn.team1.domain.GroupCountVO;
import com.acorn.team1.domain.GroupDTO;
import com.acorn.team1.domain.GroupMemberVO;
import com.acorn.team1.domain.GroupPageVO;

public interface GroupService {
	
	public abstract List<GroupPageVO> listAll() throws Exception;
	
	public abstract List<GroupCountVO> countStudent() throws Exception;
	
	public abstract List<GroupPageVO> listAllT(String admin_id) throws Exception;
	
	//public abstract List<GroupPageVO> readCourse(String admin_id) throws Exception;

	public abstract String readCourse(String admin_id) throws Exception;
	
	public abstract List<GroupMemberVO> readEditMemberList(int course_code, int groups_id) throws Exception;
	


	public List<GroupMemberVO> readStudent(int course_code) throws Exception;
	
	public abstract String readGroup(int course_code, int groups_id) throws Exception;
	
	
	public void removeGroup(int groups_id) throws Exception;
	
	public void updateNull(int groups_id) throws Exception;
	
	public void createNewGroup(GroupDTO dto) throws Exception;
	
	public void modifyMember(GroupDTO dto) throws Exception;
	
	public String readCourseCode(String adminId) throws Exception;
	
	public int checkGroupName(String name, Integer course_code) throws Exception;
	
	public void addMember(GroupDTO dto) throws Exception;
	
	
}

package com.acorn.team1.persistence;

import java.util.List;

import com.acorn.team1.domain.GroupCountVO;
import com.acorn.team1.domain.GroupDTO;
import com.acorn.team1.domain.GroupMemberVO;
import com.acorn.team1.domain.GroupNameDTO;
import com.acorn.team1.domain.GroupPageVO;

public interface GroupDAO{
	
	public abstract List<GroupPageVO> listAll() throws Exception;
	
	public abstract List<GroupCountVO> countStudent() throws Exception;
	
	public abstract List<GroupPageVO> listAllT(String admin_id) throws Exception;
	
	public abstract String selectCourse(String admin_id) throws Exception;
	
	public List<GroupMemberVO> readStudent(int course_code) throws Exception;
	
	public List<GroupMemberVO> selectEditMemberList(int course_code, int groups_id) throws Exception;
		
	public abstract String selectGroup(int course_code , int groups_id ) throws Exception;

	
	//조 삭제
	public void deleteGroup(int groups_id) throws Exception;
	
	public void updateNull(int groups_id) throws Exception;
	
	//그룹 새로 만들기
	public abstract void createNewGroup(GroupDTO dto) throws Exception;
	
	//그룹원 수정
	public abstract void editMember(GroupDTO dto) throws Exception;
	
	public abstract String readCourseCode(String adminId) throws Exception;
	
	public abstract int checkGroupName(GroupNameDTO dto) throws Exception;
	
	//그룹원 추가
	public void addMember(GroupDTO dto) throws Exception;
 	
}

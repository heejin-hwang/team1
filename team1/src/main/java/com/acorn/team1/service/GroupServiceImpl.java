package com.acorn.team1.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.GroupCountVO;
import com.acorn.team1.domain.GroupDTO;
import com.acorn.team1.domain.GroupMemberVO;
import com.acorn.team1.domain.GroupNameDTO;
import com.acorn.team1.domain.GroupPageVO;
import com.acorn.team1.persistence.GroupDAO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class GroupServiceImpl implements GroupService {

	@Inject
	private GroupDAO dao;

	@Override
	public List<GroupPageVO> listAll() throws Exception {
		// 관리자용 전체 그룹 출력
		log.info("GroupServiceImpl::listAll() invoked...");
		return dao.listAll();
	}

	@Override
	public List<GroupCountVO> countStudent() throws Exception {
		// 각 그룹당 학생 수 출력
		return dao.countStudent();
	}

	@Override
	public List<GroupPageVO> listAllT(String admin_id) throws Exception {
		// 강사용 전체 그룹 출력
		return dao.listAllT(admin_id);
	}

	/*
	 * @Override public List<GroupPageVO> readCourse(String admin_id) throws
	 * Exception { return dao.selectCourse(admin_id); }
	 */

	@Override
	public String readCourse(String admin_id) throws Exception {
		log.info("GroupServiceImpl::readCourse() invoked...");
		return dao.selectCourse(admin_id);
	}

	@Override
	public List<GroupMemberVO> readStudent(int course_code) throws Exception {
		return dao.readStudent(course_code);
	}

	@Override
	public List<GroupMemberVO> readEditMemberList(int course_code, int groups_id) throws Exception {
		return dao.selectEditMemberList(course_code, groups_id);
	}

	@Override
	public String readGroup(int course_code, int groups_id) throws Exception {
		return dao.selectGroup(course_code, groups_id);
	}
	
	
//------------------------------------------------------------//
//							그룹 삭제							  //
//------------------------------------------------------------//
	@Override
	public void removeGroup(int groups_id) throws Exception {
		dao.deleteGroup(groups_id);
	}
	
	//그룹 삭제 전에 그룹 null값으로 만들기
	@Override
	public void updateNull(int groups_id) throws Exception {
		dao.updateNull(groups_id);
	}
	
//------------------------------------------------------------//
//							그룹  생성							  //
//------------------------------------------------------------//
	@Override
	public void createNewGroup(GroupDTO dto) throws Exception {
		dao.createNewGroup(dto);
	}
	
	

	@Override
	public String readCourseCode(String adminId) throws Exception {
		return dao.readCourseCode(adminId);
	}

	@Override
	public void modifyMember(GroupDTO dto) throws Exception {
		dao.editMember(dto);
	}

	@Override
	public int checkGroupName(String name, Integer course_code) throws Exception {
		GroupNameDTO dto = new GroupNameDTO(name, course_code);
		return dao.checkGroupName(dto);
	}

	
//------------------------------------------------------------//
//							그룹원 추가							  //
//------------------------------------------------------------//

	@Override
	public void addMember(GroupDTO dto) throws Exception {
		dao.addMember(dto);
	}


}

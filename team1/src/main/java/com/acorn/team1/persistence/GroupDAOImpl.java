package com.acorn.team1.persistence;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.GroupCountVO;
import com.acorn.team1.domain.GroupDTO;
import com.acorn.team1.domain.GroupMemberVO;
import com.acorn.team1.domain.GroupNameDTO;
import com.acorn.team1.domain.GroupPageVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class GroupDAOImpl implements GroupDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "com.acorn.mapper.GroupMapper";

	@Override
	public List<GroupPageVO> listAll() throws Exception {
		log.info("GroupDAOImpl::listAll() invoked.");
		return session.selectList(namespace + ".listAll");
	}

	@Override
	public List<GroupCountVO> countStudent() throws Exception {

		// 각 그룹 당 학생 수 출력
		log.info("GroupDAOImpl::countStudent() invoked.");
		return session.selectList(namespace + ".countStudent");
	}

	@Override
	public List<GroupPageVO> listAllT(String admin_id) throws Exception {
		log.info("GroupDAOImpl::listAllT(admin_id) invoked.");
		return session.selectList(namespace + ".listAllT", admin_id);
	}


	@Override
	public String selectCourse(String admin_id) throws Exception {
		log.info("GroupDAOImpl::selectCourse(admin_id) invoked.");
		return session.selectOne(namespace + ".selectCourse", admin_id);
	}

	@Override
	public List<GroupMemberVO> readStudent(int course_code) throws Exception {
		log.info("GroupDAOImpl::readStudent() invoked.");
		return session.selectList(namespace + ".noGroupStudent", course_code);
	}

	@Override
	public List<GroupMemberVO> selectEditMemberList(int course_code, int groups_id) throws Exception {
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("course_code", course_code);
		params.put("groups_id", groups_id);
		return session.selectList(namespace + ".selectEditMemberList", params);
	}

	@Override
	public String selectGroup(int course_code, int groups_id) throws Exception {

		log.info("GroupDAOImpl::selectGroup(course_code, groups_id) invoked.");
		log.info("\t+ course_code" + course_code);
		log.info("\t+ groups_id" + groups_id);

		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("course_code", course_code);
		params.put("groups_id", groups_id);

		return session.selectOne(namespace + ".groupName", params);
	}

	@Override
	public void deleteGroup(int groups_id) throws Exception {

		session.delete(namespace + ".deleteGroup", groups_id);

	}

	@Override
	public void updateNull(int groups_id) throws Exception {
		log.info("GroupDAOImpl::updateNull(course_code, groups_id) invoked.");
//		log.info("\t+ course_code" + course_code);
		log.info("\t+ groups_id" + groups_id);
//		log.info("\t+ student_id"+student_id);

		/*
		 * Map<String, Integer> params = new HashMap<String, Integer>();
		 * params.put("course_code", course_code); params.put("groups_id", groups_id);
		 * params.put("student_id", Integer.parseInt(student_id));
		 */

		session.update(namespace + ".updateNull", groups_id);
	}

	
	@Override
	public void createNewGroup(GroupDTO dto) throws Exception {
		String[] studentId = dto.getRegisterList().split(",");
		log.info("studentId: " + Arrays.toString(studentId));

		Map<String, String> params = new HashMap<>();
		params.put("groupName", dto.getGroupName());
		params.put("courseCode", Integer.toString(dto.getCourseCode()));
		params.put("adminId", dto.getAdminId());

		session.insert(namespace + ".createGroup", params);

		int groupNum = session.selectOne(namespace + ".getNewGroupId", params);

		for (int i = 0; i < studentId.length; i++) {

			Map<String, String> studentInfo = new HashMap<>();

			studentInfo.put("id", studentId[i]);
			studentInfo.put("groupId", Integer.toString(groupNum));

			session.update(namespace + ".updateGroupInfo", studentInfo);
		}

	}

	@Override
	public void editMember(GroupDTO dto) throws Exception {

		String[] studentId = dto.getEditList().split(",");
		log.info("studentId: " + Arrays.toString(studentId));
	
		  Map<String, String> params = new HashMap<>();
		  
		/*
		 * params.put("course_code", Integer.toString(dto.getCourseCode()));
		 * params.put("groups_id", dto.getGroupsId());
		 */
		 
		for (int i = 0; i < studentId.length; i++) {

			params.put("student_id", studentId[i]);
			session.update(namespace + ".updateNullId", params);
			
			//log.info("course_code" + params.get("course_code"));
			//log.info("groups_id" + params.get("groups_id"));
			//log.info("student_id" + params.get("student_id"));

		}
	}

	@Override
	public String readCourseCode(String adminId) throws Exception {
		return session.selectOne(namespace + ".readCourseCode", adminId);
	}

	@Override
	public int checkGroupName(GroupNameDTO dto) throws Exception {
		
		int gnameCount = session.selectOne(namespace + ".gnameExist", dto);
		System.out.println("result :" + gnameCount);
		if (gnameCount != 0) {
			System.out.println("return true");
			return 1;
		} else {
			System.out.println("return false");
			return 0;
		}
		
	}

	@Override
	public void addMember(GroupDTO dto) throws Exception {

		String[] studentId = dto.getAddList().split(",");
		System.out.println(Arrays.toString(studentId));
		log.info("studentId: " + Arrays.toString(studentId));
	
		  Map<String, String> params = new HashMap<>();
		  
		  log.info("dto.getGroupsId(): "+dto.getGroupsId());
		  
		  params.put("groupsid", dto.getGroupsId());
		 
		for (int i = 0; i < studentId.length; i++) {

			params.put("student_id", studentId[i]);
			session.update(namespace + ".addMember", params);

			log.info("groups_id" + params.get("groups_id"));
			log.info("student_id" + params.get("student_id"));

		}
	}



}

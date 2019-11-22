package com.acorn.team1.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.AssignmentDTO;
import com.acorn.team1.domain.AssignmentVO;
import com.acorn.team1.domain.GroupVO;
import com.acorn.team1.domain.GroupSubmitVO;

import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class AssignmentDAOImpl implements AssignmentDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.acorn.mapper.AssignmentMapper";

	@Override
	public void create(AssignmentDTO dto) throws Exception {
		log.info("AssignmentDAOImpl::create invoked.");
		session.insert(namespace + ".create", dto);
	} // create

	@Override
	public AssignmentVO read(Integer id) throws Exception {
		return session.selectOne(namespace + ".read", id);
	} // read

	@Override
	public void update(AssignmentDTO dto) throws Exception {
		session.update(namespace + ".update", dto);
	} // update

	@Override
	public void delete(Integer id) throws Exception {
		session.delete(namespace + ".delete", id);
	} // delete

	@Override
	public List<AssignmentVO> listAll(String adminId, Integer currCourseCode) throws Exception {
		Map<String, String> params = new HashMap<String, String>();
		params.put("adminId", adminId);
		params.put("currCourseCode", Integer.toString(currCourseCode));
		
		return session.selectList(namespace + ".listAll", params);
	} // listAll

	@Override
	public List<GroupSubmitVO> listStatus(Integer id) throws Exception {
		return session.selectList(namespace + ".listSubmit", id);
	} // listStatus

	@Override
	public List<GroupVO> listGroup(String adminId, Integer courseCode) throws Exception {
		Map<String, String> params = new HashMap<String, String>();
		params.put("adminId", adminId);
		params.put("courseCode", Integer.toString(courseCode));
		
		return session.selectList(namespace + ".listGroup", params);
	} // listGroup

	@Override
	public String getCourseName(String adminId) throws Exception {
		return session.selectOne(namespace + ".getCourseName", adminId);
	}

	@Override
	public Integer getCurrentCourseId(String adminId) throws Exception {
		return session.selectOne(namespace + ".getCurrentCourseId", adminId);
	}

} // AssignmentDAOImpl

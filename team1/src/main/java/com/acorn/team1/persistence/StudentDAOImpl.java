package com.acorn.team1.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.controller.Criteria;
import com.acorn.team1.domain.CourseDTO;
import com.acorn.team1.domain.DetailStudentDTO;
import com.acorn.team1.domain.SearchStudentDTO;
import com.acorn.team1.domain.StudentFindDTO;
import com.acorn.team1.domain.StudentListDTO;
import com.acorn.team1.domain.StudentVO;
import com.acorn.team1.domain.UpdateStudentByAdminDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class StudentDAOImpl implements StudentDAO {

	
	@Inject
	private SqlSession sqlSession;
	private final String namespace="com.acorn.mapper.StudentMapper";

	@Override
	public List<CourseDTO> readCourseList() throws Exception{
		
		return sqlSession.selectList(namespace+"."+"readCourseList");
		
	}
	
	@Override
	public List<StudentListDTO> readStudentList() throws Exception { //
		log.info("StudentDAOImpl readStudent invoked");
		
	
		List<StudentListDTO> dto= sqlSession.selectList(namespace+"."+"readStudentList");
		log.info(dto.toString());
		
		return dto;
	}
	@Override
	public List<StudentListDTO> searchStudentList(String type, String value) throws Exception {
		log.info("StudentDAOImpl searchStudent invoked");
		SearchStudentDTO dto = new SearchStudentDTO(type, value);
		List<StudentListDTO> result = sqlSession.selectList(namespace+"."+"searchStudentList", dto);
		
		return result;
	}

	@Override
	public DetailStudentDTO readStudentData(StudentFindDTO dto) throws Exception { 
		log.info("readStudentData invoked");
		DetailStudentDTO dsdto= sqlSession.selectOne(namespace+"."+"readStudentData", dto); 
		
		
		//log.info("getGroups_name");
		//dsdto.setCourse_name(sqlSession.selectOne(namespace+"."+"getCourse_name",dsdto.getCourse_code())); 
		//log.info("getCourse_name");
		return dsdto; //
	}

	@Override
	public int readIdExist(StudentFindDTO dto){ 
		
		int isNull = sqlSession.selectOne(namespace + "." + "idExist", dto);
		System.out.println("result :" + isNull);
		if (isNull != 0) {
			System.out.println("return true");
			return 1;
		} else {
			System.out.println("return false");
			return 0;
		}
	}

	/*
	 * @Override public void deleteStudentData(StudentDTO dto) throws Exception {
	 * log.info("StudentDAOImpl::deleteStudent invoked.");
	 * rsm.deleteStudentData(dto.getid()); }
	 */

	@Override
	public void insertStudentData(StudentVO vo) { //receive vo, insert implement
		
		log.info("insertStudentData invoked : " + vo.getAddress());
		sqlSession.insert(namespace+"."+"insertStudentData", vo);
		log.info("student" + vo.getId() + " is inserted");
	}
	
	@Override
	public void updateStudentByAdmin(UpdateStudentByAdminDTO usdto) {
		log.info("usdto"+usdto.toString());
		sqlSession.update(namespace+"."+"updateStudentDataByAdmin", usdto);
		
	}
	@Override
	public void updateStudentByStudent(UpdateStudentByAdminDTO usdto) {
		log.info("usdto"+usdto.toString());
		sqlSession.update(namespace+"."+"updateStudentDataByStudent", usdto);		
	}
	

	@Override
	public List<StudentVO> listCriteria(Criteria criteria) throws Exception {
		log.info("list criteria type :"+criteria.getType());
		
		if (criteria.getType()==null || criteria.getType() == "") {
			return sqlSession.selectList(namespace + ".listCriteria", criteria);
		}else if(criteria.getType().equals("course_name")) {
		
			return sqlSession.selectList(namespace + ".searchedListCriteriaCourse", criteria);
		}
		else {
			return sqlSession.selectList(namespace + ".searchedListCriteriaStudent", criteria);
			
			
		}
		}
	
	@Override
	public int countPaging(Criteria criteria) throws Exception {
		log.info("count criteria type :"+criteria.getType());
		
		if(criteria.getType()==null || criteria.getType() == "") {	
		return sqlSession.selectOne(namespace + ".countPaging", criteria);
		
		}else if(criteria.getType().equals("course_name")) {
			return sqlSession.selectOne(namespace + ".searchedCountPagingCourse", criteria);
			
		}else {
			return sqlSession.selectOne(namespace + ".searchedCountPagingStudent", criteria);
	}
	

}
}
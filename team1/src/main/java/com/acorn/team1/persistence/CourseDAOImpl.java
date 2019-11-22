package com.acorn.team1.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.CourseVO;

@Repository
public class CourseDAOImpl implements CourseDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private final String namespace = "com.acorn.team1.mapper.CourseMapper";

	/*----------------------------교육 과정 이름 보기--------------------------------------------*/
	@Override
	public List<CourseVO> Course_name(String admin_id) throws Exception {
		
		return sqlSession.selectList(namespace+".courseName",admin_id);
	}

	/*----------------------------이수하는 교육 과정 이름 보기--------------------------------------------*/
	@Override
	public String selectedCourse_name(int course_code) throws Exception {
		
		return sqlSession.selectOne(namespace+".selectedCourseName",course_code);
	}

	/*----------------------------코스 코드 읽어오기--------------------------------------------*/
	@Override
	public int searchCode(String name) throws Exception {
		
		return sqlSession.selectOne(namespace+".selectedCourseCode",name);
	}

}

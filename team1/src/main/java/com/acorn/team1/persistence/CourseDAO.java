package com.acorn.team1.persistence;

import java.util.List;

import com.acorn.team1.domain.CourseVO;

public interface CourseDAO {

	/*----------------------------교육 과정 이름 보기--------------------------------------------*/
	public abstract List<CourseVO> Course_name(String admin_id) throws Exception;
	
	/*----------------------------이수하는 교육 과정 이름 보기--------------------------------------------*/
	public abstract String selectedCourse_name(int course_code) throws Exception;
	
	/*----------------------------코스 코드 읽어오기--------------------------------------------*/
	public abstract int searchCode(String name) throws Exception;
}

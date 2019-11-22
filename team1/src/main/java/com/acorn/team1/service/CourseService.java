package com.acorn.team1.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.acorn.team1.domain.CourseVO;

public interface CourseService {

	/*----------------------------전체교육과정 이름 보기--------------------------------------------*/
	public abstract List<CourseVO> readCourse_name(HttpSession session) throws Exception;

}

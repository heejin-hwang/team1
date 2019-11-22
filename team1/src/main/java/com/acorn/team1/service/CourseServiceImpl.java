package com.acorn.team1.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.CourseVO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.persistence.CourseDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CourseServiceImpl implements CourseService {

	@Inject
	private CourseDAO dao;
	
	
	/*----------------------------전체교육과정 이름 보기--------------------------------------------*/
	@Override
	public List<CourseVO> readCourse_name(HttpSession session) throws Exception {
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		String job_id = vo.getJob_id();
		
		String Admin_id = null;
		//강사라면 강사가 해당되는 교육과정만 보여주기
		if(job_id.equals("2") ) {
			Admin_id = vo.getId();
		}
		return dao.Course_name(Admin_id);
	}

}

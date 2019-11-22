package com.acorn.team1.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.HomeBoardSearchCriteria;
import com.acorn.team1.domain.HomeBoardVO;
import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.ScheduleVO;
import com.acorn.team1.persistence.HomeBoardDAO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class HomeBoardServiceImpl implements HomeBoardService {

	@Inject
	private HomeBoardDAO dao;
	
	
	
	/*----------------------------게시글 목록 보기--------------------------------------------*/
	@Override
	public List<HomeBoardVO> HomeNotice(HomeBoardSearchCriteria cri, HttpSession session) throws Exception {
		
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		String job_id = vo.getJob_id();
		int code = vo.getCourse_code();
		
		if(job_id.equals("2") || job_id.equals("4")) {
			cri.setScourse_code( code );
		}
	
		return dao.HomeNotice(cri);
	} //HomeNotice

	

	/*----------------------------조회수 증가------------------------------------------*/
	@Override
	public void increaseHits(int id) throws Exception {
		dao.increaseHits(id);
	} //increaseHits
	
	
	/*----------------------------마이페이지 관리자 스케줄 ------------------------------------------*/
	@Override
	public List<ScheduleVO> HomeScheduleAll() throws Exception {
		log.info("ScheduleServiceImpl:: listAll(year) invoked.");
		
		
		return dao.HomeScheduleAll();
	}

	/*----------------------------마이페이지 학생 스케줄 ------------------------------------------*/

	@Override
	public List<ScheduleVO>  HomeScheduleCourse(MyPageDTO dto, HttpSession session) throws Exception {
		log.info("ScheduleServiceImpl:: listCourse(year, courseCode) invoked.");
		
		
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		
		int course_code = vo.getCourse_code();
		dto.setCourse_code(course_code);
		log.info("+++++++++++++++++++++++++++++++++++++course_code"+course_code);

		return dao.HomeScheduleCourse(dto);
	
	}
	
	
	
	/*----------------------------마이페이지 관리자 스케줄 ------------------------------------------*/
	@Override
	public List<ScheduleVO> TomorrowHomeScheduleAll() throws Exception {
		log.info("ScheduleServiceImpl:: listAll(year) invoked.");
		
		
		return dao.HomeScheduleAll();
	}

	/*----------------------------마이페이지 학생 스케줄 ------------------------------------------*/

	@Override
	public List<ScheduleVO>  TomorrowHomeScheduleCourse(MyPageDTO dto, HttpSession session) throws Exception {
		log.info("ScheduleServiceImpl:: listCourse(year, courseCode) invoked.");
		
		
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		
		int course_code = vo.getCourse_code();
		dto.setCourse_code(course_code);
		log.info("+++++++++++++++++++++++++++++++++++++course_code"+course_code);

		return dao.HomeScheduleCourse(dto);
	
	}



} // end class


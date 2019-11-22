package com.acorn.team1.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.acorn.team1.domain.HomeBoardSearchCriteria;
import com.acorn.team1.domain.HomeBoardVO;
import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.ScheduleVO;

public interface HomeBoardService {

	/*----------------------------게시글 목록 보기--------------------------------------------*/
	public List<HomeBoardVO> HomeNotice(HomeBoardSearchCriteria cri, HttpSession session) throws Exception;
	

	/*----------------------------조회수 증가------------------------------------------*/
	public void increaseHits(int id) throws Exception;

	
	/*----------------------------마이페이지 관리자 스케줄 ------------------------------------------*/
	public List<ScheduleVO> HomeScheduleAll() throws Exception;
	
	
	/*----------------------------마이페이지 학생 스케줄 ------------------------------------------*/
	public List<ScheduleVO> HomeScheduleCourse(MyPageDTO dto, HttpSession session) throws Exception;
	

	/*----------------------------마이페이지 관리자 스케줄 ------------------------------------------*/
	public List<ScheduleVO> TomorrowHomeScheduleAll() throws Exception;
	

	/*----------------------------마이페이지 학생 스케줄 ------------------------------------------*/
	public List<ScheduleVO>  TomorrowHomeScheduleCourse(MyPageDTO dto, HttpSession session) throws Exception ;
	


	
	

	
	
}

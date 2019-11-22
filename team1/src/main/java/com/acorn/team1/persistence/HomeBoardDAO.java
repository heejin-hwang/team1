package com.acorn.team1.persistence;

import java.util.List;


import com.acorn.team1.domain.HomeBoardSearchCriteria;
import com.acorn.team1.domain.HomeBoardVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.ScheduleVO;

public interface HomeBoardDAO {
	

	/*--------------------------마이페이지 공지사항 최신글 보기--------------------------------------------*/
	public List<HomeBoardVO> HomeNotice(HomeBoardSearchCriteria cri)throws Exception;
	
	
	/*----------------------------조회수 증가------------------------------------------*/
	public void increaseHits(int id) throws Exception;

	
	/*----------------------------마이페이지 오늘 스케줄 ------------------------------------------*/
	public List<ScheduleVO> HomeScheduleAll() throws Exception;
	
	
	/*----------------------------마이페이지 내일 스케줄 ------------------------------------------*/
	public List<ScheduleVO> HomeScheduleCourse(MyPageDTO dto) throws Exception;

	
	/*----------------------------마이페이지 관리자 스케줄 ------------------------------------------*/
	public List<ScheduleVO> TomorrowHomeScheduleAll() throws Exception;

	
	/*----------------------------마이페이지 학생 스케줄 ------------------------------------------*/
	public List<ScheduleVO> TomorrowHomeScheduleCourse(MyPageDTO dto) throws Exception;


	
	

	
} // end interface

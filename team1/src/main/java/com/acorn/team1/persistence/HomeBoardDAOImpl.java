package com.acorn.team1.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.HomeBoardSearchCriteria;
import com.acorn.team1.domain.HomeBoardVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.ScheduleVO;

import lombok.extern.log4j.Log4j;


@Log4j
@Repository
public class HomeBoardDAOImpl implements HomeBoardDAO {
	
	@Inject
	private SqlSession session;
	
	private final String namespace = "com.acorn.team1.mapper.HomeBoardMapper";
	
	
	/*----------------------------마이페이지 공지사항 최신글 보기--------------------------------------------*/
	@Override
	public List<HomeBoardVO> HomeNotice(HomeBoardSearchCriteria cri) throws Exception {
		
		return session.selectList(namespace+".HomeNotice", cri);
	}


	/*----------------------------조회수 증가------------------------------------------*/
	@Override
	public void increaseHits(int id) 
			throws Exception {
		
		session.update(namespace + ".increaseHits", id);
		
	}


	/*----------------------------마이페이지 관리자 스케줄 ------------------------------------------*/
	@Override
	public List<ScheduleVO> HomeScheduleAll() throws Exception {
		log.info("ScheduleDAOImpl::listAll(year) invoked.");
		
		
		return session.selectList(namespace + ".HomeScheduleAll");
	} // listAll

	
	/*----------------------------마이페이지 학생 스케줄 ------------------------------------------*/
	@Override
	public List<ScheduleVO> HomeScheduleCourse(MyPageDTO dto) throws Exception {
		
	
		return session.selectList(namespace + ".HomeScheduleCourse", dto);
	} // listCourse
	

	
	/*----------------------------마이페이지 관리자 스케줄 ------------------------------------------*/
	@Override
	public List<ScheduleVO> TomorrowHomeScheduleAll() throws Exception {
		log.info("ScheduleDAOImpl::listAll(year) invoked.");
		
		
		return session.selectList(namespace + ".TomorrowHomeScheduleAll");
	} // listAll

	
	/*----------------------------마이페이지 학생 스케줄 ------------------------------------------*/
	@Override
	public List<ScheduleVO> TomorrowHomeScheduleCourse(MyPageDTO dto) throws Exception {
		
	
		return session.selectList(namespace + ".TomorrowHomeScheduleCourse", dto);
	} // listCourse
	

	

} // end class

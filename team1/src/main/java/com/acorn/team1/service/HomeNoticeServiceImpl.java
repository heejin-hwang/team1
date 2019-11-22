package com.acorn.team1.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.HomeNoticeSearchCriteria;
import com.acorn.team1.domain.HomeNoticeVO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.persistence.HomeNoticeDAO;


@Service
public class HomeNoticeServiceImpl implements HomeNoticeService {

	@Inject
	private HomeNoticeDAO dao;
	

	
	/*----------------------------게시글 목록 보기--------------------------------------------*/
	@Override
	public List<HomeNoticeVO> HomeNotice(HomeNoticeSearchCriteria cri, HttpSession session) throws Exception {
		
		
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


} // end class


package com.acorn.team1.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.acorn.team1.domain.HomeNoticeSearchCriteria;
import com.acorn.team1.domain.HomeNoticeVO;

public interface HomeNoticeService {

	/*----------------------------게시글 목록 보기--------------------------------------------*/
	public List<HomeNoticeVO> HomeNotice(HomeNoticeSearchCriteria cri, HttpSession session) throws Exception;
	

	/*----------------------------조회수 증가------------------------------------------*/
	public void increaseHits(int id) throws Exception;

	
	
}

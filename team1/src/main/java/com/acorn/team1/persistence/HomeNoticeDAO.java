package com.acorn.team1.persistence;

import java.util.List;

import com.acorn.team1.domain.HomeNoticeDTO;
import com.acorn.team1.domain.HomeNoticeSearchCriteria;
import com.acorn.team1.domain.HomeNoticeVO;

public interface HomeNoticeDAO {
	

	/*----------------------------게시글 목록 보기--------------------------------------------*/
	public List<HomeNoticeVO> HomeNotice(HomeNoticeSearchCriteria cri)throws Exception;
	
	
	/*----------------------------조회수 증가------------------------------------------*/
	public void increaseHits(int id) throws Exception;
	

	
} // end interface

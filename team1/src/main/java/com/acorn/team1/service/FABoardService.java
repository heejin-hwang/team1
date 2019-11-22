package com.acorn.team1.service;

import java.util.List;

import com.acorn.team1.domain.FABoardVO;
import com.acorn.team1.domain.FABoardCriteria;
import com.acorn.team1.domain.FABoardSearchCriteria;

public interface FABoardService {
	
	public void regist(FABoardVO vo) throws Exception;
	
	public FABoardVO read(Integer bno)throws Exception;
	
	public void modify(FABoardVO vo) throws Exception;
	
	public void remove(Integer bno)throws Exception;
	
	
	//-----------------------페이징 처리----------------------------//

	public List<FABoardVO> listSearchCriteria(FABoardSearchCriteria cri) throws Exception;
	
	public int listSearchCount(FABoardSearchCriteria cri) throws Exception;

	
	public void updateViewcnt(int bno) throws Exception;
	


}

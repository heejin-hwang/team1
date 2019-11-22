package com.acorn.team1.persistence;

import java.util.List;

import com.acorn.team1.domain.FABoardVO;
import com.acorn.team1.domain.FABoardCriteria;
import com.acorn.team1.domain.FABoardSearchCriteria;

public interface FABoardDAO {

	public void create(FABoardVO vo) throws Exception;
	
	public FABoardVO read(Integer bno) throws Exception;
	
	public void update(FABoardVO vo) throws Exception;
	
	public void delete(Integer bno) throws Exception;
	
	public void updateViewcnt(int id) throws Exception;

	
	
	//-----------------------페이징 처리----------------------------//
	


	public List<FABoardVO> listSearch(FABoardSearchCriteria cri) throws Exception;

	public int listSearchCount(FABoardSearchCriteria cri) throws Exception;

}

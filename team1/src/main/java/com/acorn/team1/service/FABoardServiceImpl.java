package com.acorn.team1.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.FABoardVO;
import com.acorn.team1.domain.FABoardCriteria;
import com.acorn.team1.domain.FABoardSearchCriteria;
import com.acorn.team1.persistence.FABoardDAO;

@Service
public class FABoardServiceImpl implements FABoardService {

	@Inject
	private FABoardDAO dao;
	
	@Override
	public void regist(FABoardVO vo) throws Exception {

		dao.create(vo);
	}

	@Override
	public FABoardVO read(Integer bno) throws Exception {

		return dao.read(bno);
	}

	@Override
	public void modify(FABoardVO vo) throws Exception {

		dao.update(vo);
	}

	@Override
	public void remove(Integer bno) throws Exception {
		
		dao.delete(bno);		
	}

	@Override
	public void updateViewcnt(int bno) throws Exception {
		dao.updateViewcnt(bno);
	} 

	
	
	//-----------------------페이징 처리----------------------------//

	@Override
	public List<FABoardVO> listSearchCriteria(FABoardSearchCriteria cri) throws Exception {

		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(FABoardSearchCriteria cri) throws Exception {

		return dao.listSearchCount(cri);
	}
}

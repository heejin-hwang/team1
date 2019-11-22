package com.acorn.team1.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.FABoardVO;
import com.acorn.team1.domain.FABoardCriteria;
import com.acorn.team1.domain.FABoardSearchCriteria;

@Repository
public class FABoardDAOImpl implements FABoardDAO{

	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.acorn.team1.mappers.FABoardMapper";
	
	@Override
	public void create(FABoardVO vo) throws Exception {
		
		session.insert(namespace+".create",vo);
	}

	@Override
	public FABoardVO read(Integer bno) throws Exception {

		return session.selectOne(namespace+".read", bno);
	}

	@Override
	public void update(FABoardVO vo) throws Exception {
		
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(Integer bno) throws Exception {

		session.delete(namespace + ".delete", bno); 
	}
	
	
	@Override
	public void updateViewcnt(int bno) throws Exception {
		
		session.update(namespace + ".updateViewcnt", bno);
		
	}

	//-----------------------페이징 처리----------------------------//



	@Override
	public List<FABoardVO> listSearch(FABoardSearchCriteria cri) throws Exception {

		return session.selectList(namespace+".listSearch", cri);
	}
	
	@Override
	public int listSearchCount(FABoardSearchCriteria cri) throws Exception {

		return session.selectOne(namespace+".listSearchCount", cri);
	}

}

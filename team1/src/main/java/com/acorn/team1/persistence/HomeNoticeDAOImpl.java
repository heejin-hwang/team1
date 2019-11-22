package com.acorn.team1.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.HomeNoticeSearchCriteria;
import com.acorn.team1.domain.HomeNoticeVO;



@Repository
public class HomeNoticeDAOImpl 
	implements HomeNoticeDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private final String namespace = "com.acorn.team1.mapper.HomeNoticeMapper";
	
	
	/*----------------------------게시글 목록 보기--------------------------------------------*/
	@Override
	public List<HomeNoticeVO> HomeNotice(HomeNoticeSearchCriteria cri) throws Exception {
		
		return sqlSession.selectList(namespace+".HomeNotice", cri);
	}


	/*----------------------------조회수 증가------------------------------------------*/
	@Override
	public void increaseHits(int id) 
			throws Exception {
		
		sqlSession.update(namespace + ".increaseHits", id);
		
	}




} // end class

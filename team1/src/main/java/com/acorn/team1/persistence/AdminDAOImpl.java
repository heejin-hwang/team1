package com.acorn.team1.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.Admin;

@Repository
public class AdminDAOImpl implements AdminDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private final String namespace = "com.acorn.team1.mapper.AdminMapper";

	/*----------------------------관리자 맞는 지 확인하는 작업--------------------------------------------*/
	@Override
	public int check_admin(Admin admin) throws Exception {
		
		return sqlSession.selectOne(namespace+".checkAdmin", admin);
	}

	/*----------------------------관리자 id--------------------------------------------*/
	@Override
	public String searchId(String name) throws Exception {
		
		return sqlSession.selectOne(namespace+".searchId", name);
	}

}

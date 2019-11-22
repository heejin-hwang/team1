package com.acorn.team1.persistence;


import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.Password;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository //데이터 저장소
public class LoginDAOImpl implements LoginDAO {

	//loginMapper.XML과 DAO Interface를 연결해주는 
	//SqlSession을 LoginDAOImpl 클래스에 의존성을 주입(DI)해 사용
	@Inject
	private SqlSession session;
	
	private final String namespace ="com.acorn.team1.mapper.loginMapper";
	private final String dbSelectId = "login";
	
	//------------------------로그인 확인--------------------------//

	@Override
	public LoginUserVO login(LoginDTO dto) throws Exception {
		
		log.info("LoginDAOImpl :: login(dto) invoked.");
		
		log.info("\t+ sqlSession: " +session);

		//사용자가 넣은 비밀번호를 암호화한다.
		String encryption = Password.encryption(dto.getPassword());

		dto.setPassword(encryption);
		
		//selectOne = SqlSession의 구문을 실행하는 메서드
		//메서드 반환 타입인 LoginUserVO의 변수인 vo에 Mapper의 namespace와 dbSelectId, 사용자가 넣은 로그인 정보인 dto를 넣어줌
		//즉 vo는 db에 저장된 정보와 사용자가 입력한 로그인 정보를 둘다 가지고 있음		
		 LoginUserVO vo = session.<LoginUserVO>selectOne(namespace +"."+dbSelectId, dto);
		 
		 return vo;
	}
	
	//-------------------------remember me-----------------------//
   //관리자와 학생 테이블을 union해서 트랜잭션처리 함
	@Override 
	//자동 로그인 시 보안을 위해  세션과 쿠키를 동시 사용하도록  데이터베이스에 사용자 아이디와 세션 아이디,유효기간을 저장 
	public void keepLogin(String userId, String sessionId, Date next) {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next",next);
		
		session.update(namespace+".KeepLogin", paramMap);
		
	}
	
	@Override
	public void keepLogin1(String userId, String sessionId, Date next) {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next",next);
		
		session.update(namespace+".KeepLogin1", paramMap);
		
	}
	

	@Override
	//이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크
	public LoginUserVO checkUserWithSession_key(String value) {
		
		return session.selectOne(namespace+".checkUserWithSession_key", value);
	}

	
	//------------------------------------------------------------------------//
	
	//----------------------------비밀번호 찾기 인증-------------------------------//
	
	@Override
	public LoginUserVO authorization(LoginDTO dto) throws Exception {
		
		log.info("ChangeUserPasswordDAOImpl :: authorization(dto) invoked.");
		
		log.info("\t+ sqlSession: " +session);


		//selectOne = SqlSession의 구문을 실행하는 메서드
		//메서드 반환 타입인 LoginUserVO의 변수인 vo에 Mapper의 namespace와 dbSelectId, 
		//사용자가 넣은 로그인 정보인 dto를 넣어줌
		//즉 vo는 db에 저장된 정보와 사용자가 입력한 로그인 정보를 둘다 가지고 있음		
		 LoginUserVO vo = session.<LoginUserVO>selectOne(namespace +".authorization", dto);
		 
		 return vo;
	}
	
	
	
	//----------------------------임시 비밀번호 업데이트 -----------------------------//
	@Override
	public void updateUserTempPassword(String userId, String password) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("password", password);
	
		log.info("userId*******" + userId );
		log.info("password*******" + password );
		
		session.update(namespace+".update_temp_pw", paramMap);
		 
	}

	@Override

	public void updateUserTempPassword1(String userId, String password) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("password", password);
	
		
		session.update(namespace+".update_temp_pw1", paramMap);
		 
	}


}



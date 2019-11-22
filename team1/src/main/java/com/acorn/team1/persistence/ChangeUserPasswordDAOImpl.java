package com.acorn.team1.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.ChangeUserPasswordDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.Password;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository //데이터 저장소
public class ChangeUserPasswordDAOImpl implements ChangeUserPasswordDAO {

	@Inject
	private SqlSession session;
	
	private final String namespace ="com.acorn.team1.mapper.loginMapper";
	

	//--------------------------------비밀번호 변경------------------------------//
	@Override
	public LoginUserVO checkPassword(ChangeUserPasswordDTO dto) throws Exception {
		//현재 비밀번호 체크
		log.info("ChangeUserPasswordDAOImpl :: checkPassword(dto) invoked.");
		
		//사용자가 넣은 비밀번호를 암호화하여 데이터베이스에 저장된 암호화되어있는 비밀번호로 변경해준다.
		String encryption = Password.encryption(dto.getPassword());

		dto.setPassword(encryption);
		
		 LoginUserVO vo = session.<LoginUserVO>selectOne(namespace +".checkPassword", dto);
		 
		 return vo;
	}

	@Override
	public void updateUserPassword(String userId, String password, String newPassword) {
		//새로운 비밀번호 저장(DB에 업데이트)		
		
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("password", password);
		paramMap.put("newPassword", newPassword);
	
		
		session.update(namespace+".update_pw", paramMap);		
	}

	@Override
	public void updateUserPassword1(String userId, String password, String newPassword) {

				
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("password", password);
		paramMap.put("newPassword", newPassword);
	
		
		session.update(namespace+".update_pw1", paramMap);			
	}
	
	
	

}

package com.acorn.team1.persistence;

import java.util.Date;

import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;

public interface LoginDAO {
	
	//------------------------로그인 확인--------------------------//

	
	public LoginUserVO login(LoginDTO dto) throws Exception;
	
	
	//----------------------remember me-------------------------//
	
	public void keepLogin(String userId, String sessionId, Date next);

	public void keepLogin1(String userId, String sessionId, Date next);
	
	public LoginUserVO checkUserWithSession_key(String value);

	//----------------------------비밀번호 찾기 인증--------------------------------//
	
	public LoginUserVO authorization(LoginDTO dto) throws Exception;
	
	
	//----------------------------임시 비밀번호 업데이트 -----------------------------//

	
	public void updateUserTempPassword(String userId, String password);
	
	public void updateUserTempPassword1(String userId, String password);
	
}

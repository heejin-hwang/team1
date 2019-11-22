package com.acorn.team1.service;

import java.util.Date;

import javax.servlet.http.HttpSession;

import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;

public interface LoginService {
	
	//----------------------------------login---------------------------------//

	public LoginUserVO login(LoginDTO dto) throws Exception;
	
	//--------------------------------remember me-------------------------------//

	public void keepLogin(String userId, String sessionId, Date next)throws Exception;


	public LoginUserVO checkLoginBefore(String value);
	
	//----------------------------비밀번호 찾기 인증--------------------------------//
	
	public LoginUserVO authorization(LoginDTO dto) throws Exception;
	

	//----------------------------임시 비밀번호 업데이트 -----------------------------//
	
	public void updateUserTempPassword(String userId, String password)throws Exception;
	
	
	
	
}

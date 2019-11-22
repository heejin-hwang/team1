package com.acorn.team1.service;


import com.acorn.team1.domain.ChangeUserPasswordDTO;
import com.acorn.team1.domain.LoginUserVO;

public interface ChangeUserPasswordService {


	//------------------------------비밀번호 변경--------------------------------//
	
	public LoginUserVO checkPassword(ChangeUserPasswordDTO dto) throws Exception;
	
	public void updateUserPassword(String userId, String password, String newPassword);
	
			
}

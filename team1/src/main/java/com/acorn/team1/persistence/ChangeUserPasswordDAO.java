package com.acorn.team1.persistence;

import com.acorn.team1.domain.ChangeUserPasswordDTO;
import com.acorn.team1.domain.LoginUserVO;

public interface ChangeUserPasswordDAO {

	

	
	//------------------------------비밀번호 변경--------------------------------//
	
	public LoginUserVO checkPassword(ChangeUserPasswordDTO dto) throws Exception;
	
	public void updateUserPassword(String userId, String password, String newPassword);
	
	public void updateUserPassword1(String userId, String password, String newPassword);
	
}

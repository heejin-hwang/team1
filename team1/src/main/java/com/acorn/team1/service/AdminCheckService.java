package com.acorn.team1.service;

import com.acorn.team1.domain.Admin;

public interface AdminCheckService {

	/*----------------------------관리자 맞는 지 확인하는 작업--------------------------------------------*/
	public abstract int check_admin(Admin admin) throws Exception;
	
}

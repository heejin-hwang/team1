package com.acorn.team1.persistence;

import com.acorn.team1.domain.Admin;

public interface AdminDAO {

	/*----------------------------관리자 맞는 지 확인하는 작업--------------------------------------------*/
	public abstract int check_admin(Admin admin) throws Exception;

	/*----------------------------관리자 id--------------------------------------------*/
	public abstract String searchId(String name) throws Exception;
}

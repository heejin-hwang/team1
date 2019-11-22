package com.acorn.team1.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.Admin;
import com.acorn.team1.persistence.AdminDAO;


@Service
public class AdminCheckServiceImpl implements AdminCheckService {

	@Inject
	private AdminDAO dao;
	
	
	@Override
	public int check_admin(Admin admin) throws Exception {
		
		return dao.check_admin(admin);
	}

}

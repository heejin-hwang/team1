package com.acorn.team1.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.acorn.team1.domain.ChangeUserPasswordDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.Password;
import com.acorn.team1.persistence.ChangeUserPasswordDAO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ChangeUserPasswordServiceImpl implements ChangeUserPasswordService {

	@Inject
	private ChangeUserPasswordDAO dao;


	
	
	//------------------------------비밀번호 변경--------------------------------//

	@Override
	public LoginUserVO checkPassword(ChangeUserPasswordDTO dto) throws Exception {
		log.info("ChangeUserPasswordServiceImpl::checkPassword invoiked");
		log.info("\t+ dao : " +dao);
		
		
		//비지니스 로직 : 사용자 비밀번호 확인
		LoginUserVO vo = dao.checkPassword(dto);//vo에 주입받은 dao의 로그인 메서드 넣어줌
		String newPW =  dto.getNewPassword();
		String newCPW = dto.getConfirmNewPassword();
		
		
		if(vo != null) { //비밀번호 확인 성공 
			
			log.info(" user 비밀번호 확인");
			
			
			if(newPW.equals(newCPW) ) {
		
	
				String encryption = Password.encryption(newPW);
				
				
				updateUserPassword(vo.getId(), vo.getPassword(), encryption);
				
			
			}else {
				
			log.info("\t +no same newPassword" );
			
			}	
			
		}else {
			log.info("\t+ no same nowPassword."+vo);
		}
		
		return vo;
	
	}

	
	
	@Transactional
	@Override
	public void updateUserPassword(String userId, String password, String newPassword) {
		log.info("password :&&&&&&&&&&&&" + password);
		log.info("newPassword :&&&&&&&&&&&&" + newPassword);
		dao.updateUserPassword(userId, password, newPassword);
		dao.updateUserPassword1(userId, password, newPassword);
	}
	
	
}



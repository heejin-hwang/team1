package com.acorn.team1.service;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.acorn.email.MailSend;
import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.Password;
import com.acorn.team1.persistence.LoginDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginServiceImpl implements LoginService {
	
	@Inject
	private LoginDAO dao;

	@Override
	public LoginUserVO login(LoginDTO dto) throws Exception {
	
		
		log.info("LoginServiceImpl::checkLogin invoiked");
		log.info("\t+ dao : " +dao);
		
		//비지니스 로직 : 사용자 로그인 성공 여부 확인
		
		
		LoginUserVO vo = dao.login(dto);//vo에 주입받은 dao의 로그인 메서드 넣어줌
		
		if(vo != null) { //로그인 성공
			log.info("\t + logineduser user:" +vo);
			
			
		}else {
			log.info("\t+ no logineduser found.");
		}
		
		return vo;
	
	}
	
	//------------------------------remember me--------------------------------------//

	@Transactional
	@Override
	public void keepLogin(String userId, String sessionId, Date next) throws Exception {
	
		dao.keepLogin(userId, sessionId, next);
		dao.keepLogin1(userId, sessionId, next);
	}
	

	@Override
	public LoginUserVO checkLoginBefore(String value) {
		
		return dao.checkUserWithSession_key(value);
	}
	//----------------------------------------------------------------------------//

	//----------------------------비밀번호 찾기 인증--------------------------------//
	
	
	@Override
	public LoginUserVO authorization(LoginDTO dto) throws Exception {

		
		log.info("ChangeUserPasswordServiceImpl::authorization invoiked");
		log.info("\t+ dao : " +dao);
		
		//비지니스 로직 : 사용자 인증 성공 여부 확인
		LoginUserVO vo = dao.authorization(dto);//vo에 주입받은 dao의 인증 메서드 넣어줌
		
		if(vo != null) { //사용자 인증 성공 
			
			log.info("LoginService authorization :: user 확인");
			

			String pw= Password.CreatePassword(); //임시 비밀번호 생성
			
			dto.setPassword(pw); //임시비밀번호로 변경하여 
		   
			
			
			
			MailSend.mailSend(vo.getId(),pw); //mailSend 메소드 호출하여 아이디와 임시 비밀번호 넣어주고 메일 발송
			
			
			String encryption = Password.encryption(pw); //바뀐 임시비밀번호를 sha256 클래스에서 만든 encrypt 메서드를 사용하여  암호화,
			//encrypt 메서드를 static 메서드로 만들었기 때문에 앞에 클래스 이름을 그대로 쓰고 메서드를 이어나가면 됨

			updateUserTempPassword(vo.getId(), encryption); //메소드 호출하여 데이터베이스에 업데이트 해줌

			log.info("\t + auth user:" +vo);
			
			
			
			
		}else {
			log.info("\t+ no auth found.");
		}
		
		return vo;
	
	}
	
	//----------------------------임시 비밀번호 업데이트 -----------------------------//

	@Transactional
	@Override //db에 저장(업데이트)
	public void updateUserTempPassword(String userId, String password)throws Exception{
		
		dao.updateUserTempPassword(userId, password);
		dao.updateUserTempPassword1(userId, password);
		
	}


	
	


}

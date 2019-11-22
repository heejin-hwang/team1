package com.acorn.team1.controller;

import java.io.IOException;
import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;


import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.MyPageVO;
import com.acorn.team1.service.LoginService;
import com.acorn.team1.service.MyPageService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/Member")
public class LoginController {
	
	@Inject
	private LoginService service;
	
	@Inject
	private MyPageService mService;
	
	
	//---------------------------로그인 폼-----------------------------//

	@RequestMapping(value ="/login", method = RequestMethod.GET)
	public void loginGET(
 			@ModelAttribute("dto") LoginDTO dto) throws IOException {
		
		log.info("LoginController ::loginGET invoked.");
	
		}//loginGET
	
	

	//--------------------------로그인 처리-----------------------------//

	@RequestMapping(value ="/loginPost", method = RequestMethod.POST)
	public String loginPOST(
			LoginDTO dto,
			MyPageDTO dto1,
			HttpSession session,
			Model model) 
			throws Exception {
		
		log.info("LoginController ::loginPost invoked.");

		LoginUserVO vo = service.login(dto);
		
		
	   if(vo == null) {
			  
		   model.addAttribute("loginUserVO", vo); //로그인 입력 정보가 DB에 있으면 vo에 담아 모델로 저장
		
		   System.out.println(vo);
		   
		   return "Member/loginError";	
		   
	   }
		else if(vo != null) {
			  
		model.addAttribute("loginUserVO", vo); //로그인 입력 정보가 DB에 있으면 vo에 담아 모델로 저장
		
		MyPageVO vo1 = mService.startTimeCheckedAgain(dto1);
		
		model.addAttribute("MyPageVO", vo1);
		
		MyPageVO vo2 = mService.endTimeCheckedAgain(dto1);
		
		model.addAttribute("MyPageVO2", vo2);
		
		
		System.out.println(vo);
		System.out.println(vo1);
		
		//-------------------------remember me------------------------//
			if(dto.isUseCookie()) { //자동로그인 선택시
				
				int amount = 60*60*24*7; //세션리밋을 7일로 설정하고
				
				Date session_limit = new Date(System.currentTimeMillis()+(1000*amount));
				
				//DB에 update해준다.
				service.keepLogin(vo.getId(), session.getId(), session_limit);
				
				log.info("session.getId() : **********" + session.getId());
				
			}//if(remember me)
			
		//-------------------------임시 비밀번호 변경 체크 ------------------------//
			if(vo.isPw_checked()==false) { 
				
				log.info("임시 비밀번호 변경 체크");
				
				return "Member/ChangeUserPasswordForm";
				
			}else {
				
				return "/Member/loginPost";	
				
			} //inner if-else (임시 비밀번호 변경 체크)
			
		} //if-else(로그인 성공)
	  
		return "Member/loginPost";	
		
		
	} //loginPost
	
	

	//---------------------------로그아웃 처리 --------------------------//

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
 	public String logout(HttpServletRequest request,
 			HttpServletResponse response,
 			HttpSession session) throws Exception { 
 		
		log.info("logout invoked.********************");
		
		Object obj = session.getAttribute("login"); //obj에 세션에 담긴 로그인 정보를 담는다.
		
		
 		if (obj != null) { //세션에 로그인 정보가 남아있으면
 			
 			LoginUserVO vo = (LoginUserVO) obj;
 			
 			
	 			session.removeAttribute("login"); // 세션 값을 제거하고,
	 			session.invalidate(); //세션을 무효화시킨다.
	 			
	 			log.info("로그아웃 되었습니다.");
 			
	 	//-----------------------자동로그인 선택시 남아있는 쿠키값 제거 -----------------------//
 			Cookie loginCookie = WebUtils.getCookie(request,  "loginCookie");
 		
 			  if ( loginCookie !=null ){ //쿠키 값이 null이 아니면
 				  
 	                loginCookie.setPath("/"); //쿠키를 찾을 경로를 컨텍스트 경로로 변경하고,
 	                
 	                loginCookie.setMaxAge(0); //유효시간을 0으로 설정 후
 	               
 	                response.addCookie(loginCookie); // 쿠키값을 response 객체에 담는다.
 	                
 	                // 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해준다.
 	                Date date =new Date(System.currentTimeMillis());
 	                
 	                //DB에 update해준다.
 	                service.keepLogin(vo.getId(), session.getId(), date);

 			  }//inner if
				
	    }//if
		return "redirect:/Member/login";
		
	
	}
	
	//------------------로그인 실패 또는 로그인 없이 접속 시-----------------------//
	
	@GetMapping("/loginError")
	public void loginError(Model model) {
		
		log.info("loginError ::loginError invoked.");
	
	}
	
	//--------------------------비밀번호 찾기 인증 폼---------------------------//
	
		@RequestMapping(value ="/authorizationGet", method = RequestMethod.GET)
		public String authorizationGET(
	 			@ModelAttribute("dto") LoginDTO dto) throws IOException {
			
			log.info("authorizationGet ::authorizationGet invoked.");
			
			return "Member/authorizationForm";
			
		}//authorizationGET
		
		  //--------------------------비밀번호 찾기 인증 주소---------------------------//
		
		    @GetMapping("/authorization")
			public void authorization(Model model)  {
				
				log.info("authorization ::authorization invoked.");
				
			}//authorization
		
		
			 

	  //--------------------------비밀번호 찾기 인증 처리---------------------------//
		
		@RequestMapping(value ="/authorizationPost", method = RequestMethod.POST)
		public String authorizationPost(
				LoginDTO dto,
				HttpSession session,
				Model model) 
				throws Exception {
			
			log.info("authorizationPost ::authorizationPost invoked.");

			LoginUserVO vo = service.authorization(dto);
			
				if(vo == null) { //처리 실패
				
			       return "Member/authorizationPost";
			       
			 	}else { //처리 성공
			 	 
				model.addAttribute("loginUserVO", vo);
				
				System.out.println(vo);
				
				log.info(dto.getUserId()); //입력아이디값 받아옴
				
				return "Member/authorizationPost";
						
				}
					
		} //authorizationPost

		
		
}

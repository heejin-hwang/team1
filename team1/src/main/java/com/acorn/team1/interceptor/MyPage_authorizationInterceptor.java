package com.acorn.team1.interceptor;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.acorn.team1.service.MyPageService;

import lombok.extern.log4j.Log4j;

@Log4j
public class MyPage_authorizationInterceptor extends HandlerInterceptorAdapter {


	private final String authKey = "authorization"; //세션에 담은 로그인 정보 키
	
	@Inject
	private MyPageService service;
	  
	
	
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception{
	
		
		log.info("UserInterceptor :: preHandle invoked.");
		//세션 객체를 얻어냄
		HttpSession session = request.getSession();
		
		//로그인 키로 세션영역에 사용자객체(UserVO)가 존재하는지 체크
		if(session.getAttribute(authKey) == null) { //null이면 
			
			log.info("**** Current User is not authed ***");
			
		
			response.sendRedirect("/HOME/authorization");
			
			return false; // 아직까지 로그인 하지 않은 상태라면 false로 이동못하게 막는다.
		}//outer if
		
		
		//이미 로그인 했다면
		//saveOriginalRequestURI(request); 

		return true; //계속 진행시킴 
			
	}//preHandle
}

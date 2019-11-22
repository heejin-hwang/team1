package com.acorn.team1.interceptor;



import javax.inject.Inject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.MyPageVO;

import com.acorn.team1.service.MyPageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AttendanceInterceptor extends HandlerInterceptorAdapter {

	@Inject
	private MyPageService service;
	
	private final String attendanceKey = "attendance";
	private final String checkoutKey = "checkout";
	//private final String origRequestURIKey = "origDest";


	
	
	//로그인 상태에서 재로그인시 기존 로그인 기록은 삭제된다.
		@Override
		public boolean preHandle(
				HttpServletRequest request, 
				HttpServletResponse response, 
				Object handler)
			throws Exception {

			log.info("LoginInterceptor::preHandle invoked.");
			//로그인 포스트가 호출되기 전에 수행됨

			log.info("\t+ SessionId : " + request.getSession().getId());
			//세션아이디는 브라우저가 가장 처음으로 (이전에 접속한적없이 최초로 요청을 보낼때 서버가 브라우저에 할당해주는 식별값)
		
		  HttpSession session =request.getSession(); //세션 정보 요청
		  
		  session.getAttribute(attendanceKey); 
		  session.getAttribute(checkoutKey);
		 

			return true;
		}
		
		
	@Override
	public void postHandle( //컨트롤러에서 loginUserVO라는 이름으로 객체를 담아둔 상태이므로,
			//이 상태를 체크해서 HttpSession에 저장
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler,
			ModelAndView modelAndView) 
		throws Exception {
		
	
		
		//ModelAndView modelAndView 객체를 파라미터로 받음
		log.info("LoginInterceptor::postHandle invoked.");
		log.info("\t+ SessionId : " + request.getSession().getId());
		//세션아이디는 브라우저가 가장 처음으로 (이전에 접속한적없이 최초로 요청을 보낼때 서버가 브라우저에 할당해주는 난수값.식별값)
		
		
		//로그인 성공 후 , 사후 처리 진행
		//1. 기존에 생성된 세션객체가 있으면 반환하고, 없으면 새로이 세션 객체를 만들어서 반환함.
		HttpSession session = request.getSession();
		//session = request.getSession(boolean);//불린을 false면 이미 세션이 존재하면 그걸 돌려주고 없다면 널을 주겠다.
		//true이면 매개변수 없는 위에거랑 같다.
		//기존에 생성된 세션 객체가 있으면 반환하고 없으면 null값을 반환
		//session = request.getSession(false);
		
		//2  modelAndView 객체를 활용하여, 이미 세션 스콥에 사용자 정보 객체가 있으면
		// 엎어치고, 없다면 새로운 속성으로 등록해준다.
		
			
		ModelMap modelMap = modelAndView.getModelMap();
			Object pageVO = modelMap.get("MyPageVO1");
		
		//출석정보를 받아와서 세션에 저장 
		if(pageVO != null) {
			
			log.info("new attandance success");
			
			//2-1 세션 영역에 사용자 정보 객체를 속성으로 설정
			
			session.setAttribute(attendanceKey, pageVO);
			
		
		}
		
			ModelMap modelMap2 = modelAndView.getModelMap();
			Object pageVO1 = modelMap2.get("MyPageVO2");
			
		    if(pageVO1 != null) {
				
				log.info("new checkout success");
				
				//2-1 세션 영역에 사용자 정보 객체를 속성으로 설정
				
				session.setAttribute(checkoutKey, pageVO1);
				
			
	
			 
		}//스레드는 자기에게 주어진건 무조건 한다 어디에 들어가든 끝까지 한다.		
		
		
	}

	
	
}



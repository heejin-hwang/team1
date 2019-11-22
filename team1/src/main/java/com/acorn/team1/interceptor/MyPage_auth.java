package com.acorn.team1.interceptor;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.MyPage_authVO;
import com.acorn.team1.service.LoginService;

import lombok.extern.slf4j.Slf4j;

/*
 * 로그인 사후 처리 담당
 * 제작자 : 박문영
 *최종 작성일 : 2019.09.20
*/

@Slf4j

public class MyPage_auth extends HandlerInterceptorAdapter {
	
	@Inject
	private LoginService service;
	
	private final String authKey = "authorization"; //세션에 담은 로그인 정보 키

	
	
		@Override
		public boolean preHandle(
				HttpServletRequest request, 
				HttpServletResponse response, 
				Object handler)
			throws Exception {

			log.info("MyPage_auth::MyPage_auth MyPage_auth.");
			//로그인 포스트가 호출되기 전에 수행됨

			log.info("\t+ SessionId : " + request.getSession().getId());
			//세션아이디는 브라우저가 가장 처음으로 (이전에 접속한적없이 최초로) 요청을 보낼때 서버가 브라우저에 할당해주는 식별값
			
			
			//1.로그인 할 때 이미 세션 영역에 어떤 사용자의 정보가 존재한다면,이 속성 객체를 세션 영역에서  제거(기존 로그인 정보 제거)
			
			HttpSession session =request.getSession(); //세션 정보 요청
			
			Object obj = session.getAttribute(authKey);// 로그인 정보를 담고,
			

	 		if (obj != null) { // 세션에 담긴 정보가 null이 아니면
	 			
	 			MyPage_authVO vo = (MyPage_authVO) obj;

				log.info("clear MyPage_authVO data before");
				
				session.removeAttribute(authKey); //정보를 제거 
				
				
			}
			return true;//인터셉터 체인이 없으면 컨트롤러의 지정된 메소드로 이동 시킬때에  ture 반환함
			//만일  false를 반환하면 더이상 아무것도 진행되지 않고, 이 메소드 호출로 모든게 종료되므로 
			
		}// preHandle
		
    //----------로그인 성공 후 세션에 로그인 정보 저장|| 로그인 정보 없을 시 로그인 화면 이동 -----------//
	@Override
	public void postHandle( 
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler,
			ModelAndView modelAndView) 
		throws Exception {
		
		log.info("LoginInterceptor::postHandle invoked.");
		log.info("\t+ SessionId : " + request.getSession().getId());
		
		//컨트롤러에서 loginUserVO라는 이름으로 객체를 담아둔 상태이므로, HttpSession에 저장하기 위해
		//(기존에 생성된 세션객체가 있으면 반환하고, 없으면 새로이 세션 객체를 만들어서 반환함.)
		HttpSession session = request.getSession();
		
		//사용자 정보가 담긴 ModelAndView modelAndView 객체를 파라미터로 받음	
		ModelMap modelMap = modelAndView.getModelMap();
		Object MyPage_authVO = modelMap.get("MyPage_authVO");
		
		
		if(MyPage_authVO != null) { //받은 객체가 null이 아니면
			
			log.info("new MyPage_authVO success");
			
			
			session.setAttribute(authKey, MyPage_authVO); // 세션 영역에 사용자 정보 객체를 속성으로 설정
			
			
		
		}//if - 로그인 성공
		
		if (MyPage_authVO == null) { //로그인 정보 없음.
			

			log.info("NONONO");
			
			response.sendRedirect("/Member/loginError"); //정보 없음 알리고 로그인 창으로 이동
			
		}//if - 로그인 정보 없음
		
	}//postHandle
	
	
}//LoginInterceptor

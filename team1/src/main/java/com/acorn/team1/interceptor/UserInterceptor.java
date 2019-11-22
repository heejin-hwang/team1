package com.acorn.team1.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.service.LoginService;

import lombok.extern.slf4j.Slf4j;

/*
 * 컨트롤러 메소드 수행 전에 로그인 여부를 체크
 * 제작자 : 박문영
 *최종 작성일 : 2019.09.20
*/

@Slf4j
public class UserInterceptor implements HandlerInterceptor {
	
	@Inject
	private LoginService service;

	private final String loginKey = "login"; //세션에 담은 로그인 정보 키
	private final String origRequestURIKey = "origDest"; //로그인 정보 없이 화면 접속 시 로그인 처리 후 이동 URI

	//---------로그인 없이 접속 시 로그인 후에 사용하던 화면으로 이동시키기 위해  uri 저장-----//
	private void saveOriginalRequestURI(HttpServletRequest request) {

		String RequestURI = request.getRequestURI();
		String queryString= request.getQueryString();
		String orignalRequesURI = "";
		
		
		if(queryString ==null || queryString.equals("null")) { //쿼리스트링이 없는 경우
			
			queryString = "";
		
		}else {//쿼리스트링이 있을 경우
			queryString ="?" + queryString; 
		
		}//if-else
		
		//원래의 request uri 저장
		orignalRequesURI = RequestURI + queryString; //겟방식일때만 동작한다.
		
		HttpSession session =request.getSession();
		session.setAttribute(origRequestURIKey, orignalRequesURI ); //세션에 기존 uri정보를 담아둔다.
		
	}//saveOriginalRequestURI

	
	
	//로그인 된 사용자인지 아닌지 판단하여 비로그인자이면 로그인 화면으로 이동시킨다.
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception{
	
		
		log.info("UserInterceptor :: preHandle invoked.");
		//세션 객체를 얻어냄
		HttpSession session = request.getSession();
		
		//로그인 키로 세션영역에 사용자객체(UserVO)가 존재하는지 체크
		if(session.getAttribute(loginKey) == null) { //null이면 
			
			log.info("**** Current User is not logined ***");
			
			//메소드 호출하여 original request uri를 보관하고,
			saveOriginalRequestURI(request); 
			
			//----------------------자동 로그인 사용자 인지 체크---------------//
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) { //자동 로그인 사용자라면, 쿠키 값을 얻어와서 
				
				LoginUserVO userVO = service.checkLoginBefore(loginCookie.getValue());
				
				log.info("userVO:" + userVO);
				
				if(userVO != null) {
					session.setAttribute("login", userVO); //사용자 정보를 가져오고 
					return true; //계속 진행시킴
			
				}//inner if
				
			}//if
			
			//---------------------------------------------------//

			
			//로그인 정보도, 쿠키(자동 로그인) 정보도 없으면 리다이렉트를 통해서 로그인 화면으로 이동시킴
			response.sendRedirect("/Member/login");
			
			return false; // 아직까지 로그인 하지 않은 상태라면 false로 이동못하게 막는다.
		}//outer if
		
		
		//이미 로그인 했다면
		//saveOriginalRequestURI(request); 

		return true; //계속 진행시킴 
			
	}//preHandle

}

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
import com.acorn.team1.service.LoginService;

import lombok.extern.slf4j.Slf4j;

/*
 * 로그인 사후 처리 담당
 * 제작자 : 박문영
 *최종 작성일 : 2019.09.20
*/

@Slf4j

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Inject
	private LoginService service;
	
	private final String loginKey = "login"; //세션에 담은 로그인 정보 키
	private final String origRequestURIKey = "origDest"; //로그인 정보 없이 화면 접속 시 로그인 처리 후 이동 URI
	private final String attendanceKey = "attendance";
	private final String checkoutKey = "checkout";
	private final String authKey = "authorization"; //세션에 담은 로그인 정보 키

	
	
	   //-------------로그인 상태에서 재로그인시 기존 로그인 기록은 삭제 처리-------------//
		@Override
		public boolean preHandle(
				HttpServletRequest request, 
				HttpServletResponse response, 
				Object handler)
			throws Exception {

			log.info("LoginInterceptor::preHandle invoked.");
			//로그인 포스트가 호출되기 전에 수행됨

			log.info("\t+ SessionId : " + request.getSession().getId());
			//세션아이디는 브라우저가 가장 처음으로 (이전에 접속한적없이 최초로) 요청을 보낼때 서버가 브라우저에 할당해주는 식별값
			
			
			//1.로그인 할 때 이미 세션 영역에 어떤 사용자의 정보가 존재한다면,이 속성 객체를 세션 영역에서  제거(기존 로그인 정보 제거)
			
			HttpSession session =request.getSession(); //세션 정보 요청
			
			Object obj = session.getAttribute(loginKey);// 로그인 정보를 담고,
			

	 		if (obj != null) { // 세션에 담긴 정보가 null이 아니면
	 			
	 			LoginUserVO vo = (LoginUserVO) obj;

				log.info("clear login data before");
				
				session.removeAttribute(loginKey); //정보를 제거 
				
				Cookie loginCookie = WebUtils.getCookie(request,  "loginCookie");
		 		
	 			  if ( loginCookie !=null ){ //쿠키값도 가져와서 null이 아니면 
	 				
	 	                loginCookie.setPath("/"); //쿠키를 찾을 경로를 컨텍스트 경로로 변경하고,
	 	                
	 	                loginCookie.setMaxAge(0); //유효시간을 0으로 설정 후
	 	                
	 	                response.addCookie(loginCookie); // 쿠키값을 response 객체에 담는다.
	 	              
	 	                // 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해줘야함.
	 	                Date date =new Date(System.currentTimeMillis());
	 	                
	 	               //DB에 update해준다.
	 	                service.keepLogin(vo.getId(), session.getId(), date);
	 	                
	 	                log.info("기존 자동 로그인 정보 삭제");
	 			  }
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
		Object loginUserVO = modelMap.get("loginUserVO");
		
		
		if(loginUserVO != null) { //받은 객체가 null이 아니면
			
			log.info("new login success");
			
			
			session.setAttribute(loginKey, loginUserVO); // 세션 영역에 사용자 정보 객체를 속성으로 설정
			
			
			//--------------remember me --------------------//
			
			if(request.getParameter("useCookie") != null) { //자동로그인 체크 후 로그인 시
				
				log.info("rememeber me..........");
				
				//쿠키를 생성하고 로그인되어 있을 때 생성한 세션의 id를 쿠키에 저장한다.// 

				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				
				//쿠키를 찾을 경로를 컨텍스트 경로로 변경하고
				loginCookie.setPath("/");;
				
				//7일로 유효기간을 설정한다.
				loginCookie.setMaxAge(60*60*24*7);
				
				//쿠키를 response 객체에 담는다.
				response.addCookie(loginCookie);
				
			}
			
			else if(request.getParameter("useCookie") == null) { //자동로그인 체크없이 로그인 시
				log.info("not rememeber me..........");
			} //if-else (remember me)
			
			//ModelMap modelMap1 = modelAndView.getModelMap();
			Object MyPageVO = modelMap.get("MyPageVO");
			
			if(MyPageVO != null) {
				
				log.info("new attandance success");
				
				//2-1 세션 영역에 사용자 정보 객체를 속성으로 설정
				
				session.setAttribute(attendanceKey, MyPageVO);
			}
			
		//	ModelMap modelMap2 = modelAndView.getModelMap();
			Object MyPageVO2 = modelMap.get("MyPageVO2");
			
			if(MyPageVO2 != null) {
				
				log.info("new checkout success");
				
				//2-1 세션 영역에 사용자 정보 객체를 속성으로 설정
				
				session.setAttribute(checkoutKey, MyPageVO2);
				
			}

		//	ModelMap modelMap3 = modelAndView.getModelMap();
			Object studentInfo = modelMap.get("studentInfo");
			
			if(studentInfo != null) {
				
				log.info("studentInfo studentInfo success");
				
				//2-1 세션 영역에 사용자 정보 객체를 속성으로 설정
				
				session.setAttribute("studentInfo", studentInfo);
				
			}

			
			Object MyPage_auth = modelMap.get("MyPage_authVO");
			
			
			if(MyPage_auth != null) { //받은 객체가 null이 아니면
				
				log.info("authKey success");
				
				
				session.setAttribute(authKey, MyPageVO); // 세션 영역에 사용자 정보 객체를 속성으로 설정
				
				
			
		
			}
			
			/*
			 * Object allattendance_count = modelMap.get("allattendance_count");
			 * 
			 * session.setAttribute("allattendance_count", allattendance_count);
			 * 
			 * Object attendance_count = modelMap.get("attendance_count");
			 * 
			 * session.setAttribute("attendance_count", attendance_count);
			 * 
			 * Object late_count = modelMap.get("late_count");
			 * 
			 * session.setAttribute("late_count", late_count);
			 * 
			 * Object early_count = modelMap.get("early_count");
			 * 
			 * session.setAttribute("early_count", early_count);
			 * 
			 * Object noAttendance_count = modelMap.get("noAttendance_count");
			 * 
			 * session.setAttribute("noAttendance_count", noAttendance_count);
			 */
			

			
			  Object orignalrequestURI = session.getAttribute(origRequestURIKey);
			  
			  if(orignalrequestURI != null) { //로그인 전에 접속한 페이지가 있다면
				  response.sendRedirect((String)orignalrequestURI);
			  }
		}//if - 로그인 성공
		
		if (loginUserVO == null) { //로그인 정보 없음.
			

			log.info("NONONO");
			
			response.sendRedirect("/Member/loginError"); //정보 없음 알리고 로그인 창으로 이동
			
		}//if - 로그인 정보 없음
		
	}//postHandle
	
	
}//LoginInterceptor

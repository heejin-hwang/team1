package com.acorn.team1.interceptor;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.acorn.team1.domain.Admin;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.service.AdminCheckService;
import com.acorn.team1.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class NoticeInterceptor extends HandlerInterceptorAdapter {
	
	@Inject
	private AdminCheckService Aservice;
	@Inject
	private NoticeService Nservice;
	
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
					throws Exception {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		log.info("NoticeInterceptor:::::::::preHandler:::::::::invoke");
		
		//session값을 얻어오기
		HttpSession session = request.getSession();
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		
				String job_id = vo.getJob_id();
				String name = vo.getName();
				Admin admin = new Admin(name, job_id);
				
		// 권한에 따라 작업 여부	
		if( job_id.equals("0") ||job_id.equals("1") || job_id.equals("2") ) {
			
			return true;
		}else if(Aservice.check_admin(admin) == 0) {		//job_id와 name을 확인 해서 권한이 없다고 판명날 때 
			out.println("<script> alert('등록되지 않은 관리자입니다.'); history.back(); </script>");
			out.flush();
			return false;
		}else {
			out.println("<script> alert('해당 동작에 대한 권한이 없습니다.'); history.back(); </script>");
			out.flush();
			return false;
		}
		
	} //pre-handler

} // end - interceptor

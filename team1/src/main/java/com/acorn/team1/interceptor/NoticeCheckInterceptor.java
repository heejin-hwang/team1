package com.acorn.team1.interceptor;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.acorn.team1.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class NoticeCheckInterceptor extends HandlerInterceptorAdapter {

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
		
		String notice_id = request.getParameter("id");
		String result = request.getParameter("result");
		/*해당 게시물이 없을 때 나오는 작업*/
		if( notice_id != null) {
			log.info("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::notice_id::::::::::::::::::::::::::::"+notice_id);
			int noticeId = Integer.parseInt(notice_id);
			int notice_count = Nservice.check_notice(noticeId);
			log.info(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::notice_count:::::::::::"+notice_count);
			if(notice_count == 0) {
				out.println("<script> alert('없는 게시물입니다.'); location.href='/Notice/Notice'; </script>");
				result = null;
				request.setAttribute("result", result);
				out.flush();
				out.close();
				return false;
			}else {
		
				return true;
			}
			
		}
		return true;
	}

}

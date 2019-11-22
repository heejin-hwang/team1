package com.acorn.team1.interceptor;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.acorn.team1.service.FileNoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileNoticeCheckInterceptor extends HandlerInterceptorAdapter {

	@Inject
	private FileNoticeService FNservice;
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
					throws Exception {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		String filenotice_id = request.getParameter("id");
		String result = request.getParameter("result");
		
		/*없는 게시물을 열람할 때 나타나는 action*/
		if( filenotice_id != null) {
		
			int filenoticeId = Integer.parseInt(filenotice_id);
			int filenotice_count = FNservice.check_filenotice(filenoticeId);
		
			if(filenotice_count == 0) {
				out.println("<script> alert('없는 게시물입니다.'); location.href='/FileNotice/FileNotice'; </script>");
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

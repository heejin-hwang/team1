package com.acorn.team1.controller;

import java.util.Calendar;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.service.ScheduleService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/Schedule/*")
@Slf4j
public class ScheduleController {

	@Inject
	private ScheduleService service;

	private static int currYear = Calendar.getInstance().get(Calendar.YEAR);

	@GetMapping("/Schedule")
	public void listAll(Model model, HttpSession session/* , HttpServletRequest request */) throws Exception {
		log.info("ScheduleController::listAll(model) invoked.");
		log.info("\t+ service: " + service);
		log.info("\t+ currYear: " + currYear);
		
		
		/* session.setAttribute("job_id", "1"); */
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		
		String job_id = vo.getJob_id();
		
		System.out.println("jobId: " + job_id);
		
//		String prev_url = request.getHeader("referer");
//		System.out.println("prev_url: " + prev_url);
//		session.setAttribute("prev_url", prev_url);
//		model.addAttribute("prev_url", prev_url);
		  
		switch (job_id) { 
		case "0": // admin 
			model.addAttribute("list", service.listAll(currYear)); 
			model.addAttribute("year", currYear); 
			break; 
		case "1": // chat admin 
			model.addAttribute("list", service.listAll(currYear));
			model.addAttribute("year", currYear); 
			break; 
		case "2": // teacher
			model.addAttribute("list", service.listCourse(currYear, vo.getCourse_code())); 
			model.addAttribute("year", currYear);
			model.addAttribute("coursecode", (Integer) session.getAttribute("coursecode")); 
			break; 
		case "4": // student
			model.addAttribute("list", service.listCourse(currYear, vo.getCourse_code())); 
			model.addAttribute("year", currYear);
			model.addAttribute("coursecode", (Integer) session.getAttribute("coursecode")); 
			break; 
		} // switch		 
		
		
//		  model.addAttribute("list", service.listAll(currYear));
//		  model.addAttribute("year", currYear);
		 
		
	} // listAll

	@PostMapping("/Schedule")
	public void listAllPost(Model model, @RequestParam int year, HttpSession session) throws Exception {
		log.info("ScheduleController::listAllPost(model) invoked.");
		log.info("\t+ year: " + year);

		/* session.setAttribute("job_id", "1"); */
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		
		String job_id = vo.getJob_id();
		
		System.out.println("jobId: " + job_id);
		
		switch (job_id) {
		case "0": // admin
			model.addAttribute("list", service.listAll(year));
			model.addAttribute("year", year);
			break;
		case "1": // chat admin
			model.addAttribute("list", service.listAll(year));
			model.addAttribute("year", year);
			break;
		case "2": // teacher
			model.addAttribute("list", service.listCourse(year, vo.getCourse_code()));
			model.addAttribute("year", year);
//			model.addAttribute("coursecode", course_code);
			break;
		case "4": // student
			model.addAttribute("list", service.listCourse(year, vo.getCourse_code()));
			model.addAttribute("year", year);
//			model.addAttribute("coursecode", (Integer) session.getAttribute("coursecode"));
			break;
		} // switch

	} // listAllPost

} // end class

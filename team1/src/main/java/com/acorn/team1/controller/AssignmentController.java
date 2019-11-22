package com.acorn.team1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.acorn.team1.domain.AssignmentDTO;
import com.acorn.team1.domain.AssignmentVO;
import com.acorn.team1.domain.FileVO;
import com.acorn.team1.domain.GroupVO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.GroupSubmitVO;
import com.acorn.team1.service.AssignmentService;
import com.acorn.team1.service.FileService;
import com.acorn.team1.service.GroupmainService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value="/Assignment/*")
@Log4j
public class AssignmentController {
	
	@Inject
	private AssignmentService service;
	@Inject
	private FileService Fservice;
		
	@GetMapping("/main")
	public void main(Model model, HttpSession session) throws Exception {
		log.info("AssignmentController::main invoked.");	
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		
		log.info("adminID: " +  vo.getId());
		
		int curr_course_code = service.getCurrentCourseId(vo.getId());
		

		log.info("curr_course_code: " + curr_course_code);
		
		List<AssignmentVO> list = service.listAll(vo.getId(), curr_course_code);
		
		System.out.println("list: " + list.toString());
		
		model.addAttribute("list", list);
		model.addAttribute("courseName", service.getCourseName(vo.getId()));
		
	} // viewAssignment
	
	@PostMapping("/main")
	@ResponseBody
	public Map main(@RequestParam("id") int id, Model model, HttpSession session) throws Exception {
		log.info("AssignmentController::main invoked.");
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		
		int curr_course_code = service.getCurrentCourseId(vo.getId());
		
		Map result = new HashMap();
		
		result.put("assignment", service.read(id));
		
		result.put("submit", service.listStatus(id));
		
		result.put("group", service.listGroup(vo.getId(), curr_course_code));
				
		return result;
	} // viewAssignment
	
	@GetMapping("/main/register")
	public void registerGET(AssignmentDTO dto, Model model, HttpSession session) throws Exception {
		log.info("AssignmentController::registerGET invoked.");
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		model.addAttribute("adminId", vo.getId());
		model.addAttribute("adminName", vo.getName());
		
		int curr_course_code = service.getCurrentCourseId(vo.getId());
		model.addAttribute("courseCode", curr_course_code);
		
		String courseName = service.getCourseName(vo.getId());
		
		log.info("courseName: " + courseName);
		model.addAttribute("courseName", courseName);
		
	} // registerGET
	
	@PostMapping("/main/register")
	public void registPOST(AssignmentDTO dto, Model model, HttpSession session) throws Exception {
		log.info("AssignmentController::registerPOST invoked.");
		log.info("dto.toString(): " + dto.toString());
		service.regist(dto);
	} // registerPOST
	
	@GetMapping("/main/modify")
	public void modifyGET(@RequestParam("id") int id, Model model, HttpSession session) throws Exception {
		log.info("AssignmentController::modifyGET invoked.");
		model.addAttribute("list", service.read(id));
	} // modifyGET
	
	@PostMapping("/main/modify")
	public void modifyPOST(AssignmentDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception  {
		log.info("AssignmentController::modifyPOST invoked");
		service.modify(dto);
		rttr.addFlashAttribute("msg", "SUCCESS");
	} // modifyPOST
	
	@PostMapping("/delete")
	public void remove(@RequestParam("id") int id, RedirectAttributes rttr, HttpSession session) throws Exception {
		log.info("AssignmentController::remove invoked");
		service.remove(id);
		rttr.addFlashAttribute("msg", "SUCCESS");
	} // remove
	
	@RequestMapping("/fileDownload")
	public ModelAndView fileDownload(@RequestParam("file_id") int file_id) throws Exception {
		
		FileVO file = Fservice.searchFile_info(file_id);
		Map<String, Object> fileInfo = new HashMap<String, Object>();
		fileInfo.put("fileNameKey", file.getName_key());
		fileInfo.put("fileName", file.getName());
		fileInfo.put("filePath", file.getPath());
		
		return new ModelAndView("fileDownloadUtil", "fileInfo", fileInfo);
	}

} // end class

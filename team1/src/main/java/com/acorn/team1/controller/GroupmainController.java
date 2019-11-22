package com.acorn.team1.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.team1.domain.AssignmentSubmitDTO;
import com.acorn.team1.domain.AssignmentSubmitVO;
import com.acorn.team1.domain.FileVO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.service.AssignmentService;
import com.acorn.team1.service.FileService;
import com.acorn.team1.service.GroupmainService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value="/Group/*")
@Log4j
public class GroupmainController {
	
	@Inject
	private GroupmainService service;
	@Inject
	private AssignmentService AssignmentService;
	@Inject
	private FileService Fservice;
	
	private static final String UPLOADPATH = "C:/Temp/Assignment/";
		
	@GetMapping("DetailGroup")
	public void main(Model model, HttpSession session) throws Exception {
		log.info("GroupmainController::main invoked.");
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		
		int course_code = vo.getCourse_code();
		
		log.info("Id: " + vo.getId());
		log.info("course_code: " + course_code);
			
		int groups_id = service.getGroupsId(vo.getId());
		
		log.info("groups_id: " + groups_id);
		
		model.addAttribute("assignment", service.listAssignmentAll(course_code, groups_id));
		model.addAttribute("member", service.listMemberAll(course_code, groups_id));
		model.addAttribute("status", service.listSubmitStatus(course_code, groups_id));
		
		model.addAttribute("courseName", service.getCourseName(course_code));
		model.addAttribute("groupName", service.getGroupName(course_code, groups_id));
		
	} // viewAssignment
	
	@PostMapping("DetailGroup")
	@ResponseBody
	public Map main(@RequestParam("id") int id, Model model, HttpSession session) throws Exception {
		log.info("AssignmentController::main invoked.");
		
		Map result = new HashMap();
		
		result.put("assignment", AssignmentService.read(id));
				
		return result;
	} // viewAssignment
	
	@GetMapping("DetailGroup/check")
	public String submitForm(@RequestParam("id") int id, Model model, HttpSession session) throws Exception {
		// check group is submitted assignment or not
		
		System.out.println("id: " + id);
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		log.info("vo.getId(): " + vo.getId());
		int groups_id = service.getGroupsId(vo.getId());
		
		
		
		List<AssignmentSubmitVO> result = service.checkSubmitStatus(groups_id, id);
		
		System.out.println(result);
		
		if (result.size() == 1) {
			return "redirect:/Group/DetailGroup/status?id=" + id;
		} else {
			return "redirect:/Group/DetailGroup/submit?id=" + id;
		}
		
	} // submitForm
	
	@GetMapping("DetailGroup/status")
	public void displayStatus(@RequestParam("id") int id, Model model, HttpSession session) throws Exception {
		log.info("GroupmainController::displayStatus invoked");
		log.info("id: " + id);
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		int course_code = vo.getCourse_code();
		int groups_id = service.getGroupsId(vo.getId());
		
		model.addAttribute("submitFile", service.checkSubmitStatus(groups_id, id));
		model.addAttribute("name", service.getAssignmentName(id));
		model.addAttribute("groupName", service.getGroupName(course_code, groups_id)); // session
		model.addAttribute("courseName", service.getCourseName(course_code)); // session
	}
	
	@GetMapping("DetailGroup/submit")
	public void displayUpload(@RequestParam("id") int id, Model model, HttpSession session) throws Exception {
		log.info("GroupmainController::displayUpload invoked");
		log.info("id: " + id);
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		int course_code = vo.getCourse_code();
		int groups_id = service.getGroupsId(vo.getId());
		
		model.addAttribute("id", id);
		model.addAttribute("name", service.getAssignmentName(id));
		model.addAttribute("groupName", service.getGroupName(course_code, groups_id));
		model.addAttribute("courseName", service.getCourseName(course_code));
	}
	
	@PostMapping("DetailGroup/Submit")
	public String fileTest(@RequestParam("id") int id, MultipartFile uploadFile, HttpSession session) throws Exception {
		
		log.info("- id: " + id);
		log.info("uploadFile: " + uploadFile.getOriginalFilename());
		
		if (!(uploadFile.isEmpty() || uploadFile == null || uploadFile.getSize() == 0)) {
			
			String orgName = uploadFile.getOriginalFilename(); // name
			
			String savName;
			Date date = new Date();
			
			LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
			int course_code = vo.getCourse_code();
			int groups_id = service.getGroupsId(vo.getId());
			
			savName = date.getTime() + course_code + groups_id + orgName; // name_key
			
			log.info(orgName);
			log.info(savName);
			
			try {
				uploadFile.transferTo(new File(UPLOADPATH + savName));
				
				AssignmentSubmitDTO dto = new AssignmentSubmitDTO();
				
				dto.setName_key(savName);
				dto.setName(orgName);
				dto.setPath(UPLOADPATH);
				dto.setSize(Long.toString(uploadFile.getSize()));
				dto.setGroup_id(groups_id); // session
				
				dto.setCourse_code(course_code); // session
				dto.setAssignment_id(id);
				dto.setGroups_id(groups_id); // session
				
				service.submitAssignment(dto);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return "redirect:/Group/DetailGroup/success";
			
		}
		return "redirect:/Group/DetailGroup/fail";
	} // fileTest
	
	@GetMapping("DetailGroup/success")
	public void success(Model model, HttpSession session) throws Exception {
		
	} // success
	
	@GetMapping("DetailGroup/fail")
	public void fail(Model model, HttpSession session) throws Exception {
		
	} // fail
	
	@GetMapping("Group")
	public void groupInfo(
			@RequestParam("id") int id, 
			@RequestParam("course_code") int course_code, 
			Model model, HttpSession session
			) throws Exception {
		model.addAttribute("assignment", service.listAssignmentAll(course_code, id));
		model.addAttribute("member", service.listMemberAll(course_code, id));
		model.addAttribute("status", service.listSubmitStatus(course_code, id));
		model.addAttribute("courseName", service.getCourseName(course_code));
	}
	
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

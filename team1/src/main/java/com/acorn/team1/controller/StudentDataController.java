package com.acorn.team1.controller;

import java.io.UnsupportedEncodingException;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.team1.domain.DetailStudentDTO;
import com.acorn.team1.domain.PageMaker;
import com.acorn.team1.domain.StudentVO;
import com.acorn.team1.domain.UpdateStudentByAdminDTO;
import com.acorn.team1.domain.UpdateStudentByStudentDTO;
import com.acorn.team1.service.StudentService;

import lombok.extern.log4j.Log4j;
@Log4j
@Controller
@RequestMapping("/Student")
public class StudentDataController {

	@Inject
	public StudentService service; //service object inject
	
	@GetMapping("/addStudent")//student enroll view
	public void addStudent(Model model) throws Exception {
		log.info("StudentDataController::addStudent invoked");
		
		model.addAttribute("courseList", service.readCourseList());
		
	}
	
	@PostMapping("/addStudent")//student enroll implement
	public String addStudentAction(StudentVO vo) throws UnsupportedEncodingException {
		log.info("addStudent invoked - " + vo.toString());
		service.insertStudentData(vo);
		
		return "redirect:/Student/detailStudent?id="+vo.getId(); //redirect : detail of enrolled student data
	}
	
	@GetMapping("/idExist")
	@ResponseBody
	public int idExist(@RequestParam("id") String id) {
		 
		return service.idExist(id);
		
	}
	
	
	@GetMapping("/detailStudent")//detail information of the student
	public void detailStudent(@RequestParam("id") String id, @ModelAttribute("criteria") Criteria criteria, Model model) throws Exception { //?id="" 
		
		DetailStudentDTO dsdto = service.readStudentData(id); //call readStudentData method
		
		model.addAttribute("id", dsdto.getId()); //set model attributes
		model.addAttribute("name", dsdto.getName());
		model.addAttribute("birthday", dsdto.getBirthday());
		model.addAttribute("temporarily_number", dsdto.getTemporarily_number());
		model.addAttribute("course_name", dsdto.getCourse_name());
		model.addAttribute("mobile_phone", dsdto.getMobile_phone());
		model.addAttribute("detail_address", dsdto.getDetail_address());
		model.addAttribute("address", dsdto.getAddress());
		model.addAttribute("state", dsdto.getState());
		
		//log.info("StudentDataController::detailStudent invoked");
	}
	
	

	//Student data update by student		
	@GetMapping("/editStudent") //edit student view
	public void editStudentByStudent(String id, Model model) throws Exception{
		DetailStudentDTO dsdto = service.readStudentData(id);
		
		model.addAttribute("detail", dsdto);
		log.info("StudentDataController::editStudent invoked");
	}
	

	@PostMapping("/editStudent") //edit student by Student implement
	public String editStudentByStudentAction(UpdateStudentByStudentDTO usdto){
		
		log.info("StudentDataController::editStudent invoked");
		log.info("target_id: " + usdto.getTarget_id());
		log.info("usdto: "+ usdto.toString());
		service.updateStudentByStudent(usdto.getTarget_id(), usdto.getId(), usdto.getMobile_phone(), usdto.getTemporarily_number(),usdto.getPassword(), usdto.getAddress(), usdto.getDetail_address());
		
		return "redirect:/Student/detailStudent?id="+usdto.getId();
	}
	
	//Student data update by admin
	@GetMapping("/editStudentAdmin") //edit student view
	public void editStudentByAdmin(String id, Model model) throws Exception{
		model.addAttribute("target_id",id);
		DetailStudentDTO dsdto = service.readStudentData(id);
		model.addAttribute("detail", dsdto);
		model.addAttribute("courseList", service.readCourseList());

		
		/* log.info("StudentDataController::editStudent invoked "+ id); */
		//model.addAttribute("targetid",dto.getTargetid());
		
	}
	@PostMapping("/editStudentAdmin") //edit student by Admin implement
	public String editStudentByAdminAction(UpdateStudentByAdminDTO usdto){
		
		log.info("StudentDataController::editStudent invoked");
		log.info("target_id: " + usdto.getTarget_id());
		log.info("getId :"+usdto.getId());
		service.updateStudentByAdmin(usdto.getTarget_id(), usdto.getId(), usdto.getName(), usdto.getBirthday(), usdto.getMobile_phone(), usdto.getTemporarily_number(), usdto.getAddress(), usdto.getDetail_address(), usdto.getCourse_code(),/*usdto.getCourse_name(),*/ usdto.getState());
		
		return "redirect:/Student/detailStudent?id="+usdto.getId();
	}
	
	
	
	//list of Student
	
	@GetMapping("/Student") //student list view
	public void student(String search, String value, 
			Model model, @ModelAttribute("criteria")Criteria criteria) 
					throws Exception{
		PageMaker pageMaker = new PageMaker();
		log.info("searchType: " +search);
		criteria.setType(search);
		criteria.setValue(value);
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(service.listCountCriteria(criteria));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("studentListPaging", service.listCriteria(criteria));
		model.addAttribute("search", search);
		model.addAttribute("value", value);

	}
	
	@PostMapping("/Student")
	public void searchStudent(String search, String value, Model model, @ModelAttribute("criteria")Criteria criteria) throws Exception{
		PageMaker pageMaker = new PageMaker();
		
		criteria.setType(search);
		criteria.setValue(value);
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(service.listCountCriteria(criteria));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("studentListPaging", service.listCriteria(criteria));
		
		
//		log.info("type: " + search + " value: "+value);
//		List<StudentListDTO> studentList;
//		studentList = service.searchStudentList(search, value);
//		model.addAttribute("studentList", studentList);
		
	}
}

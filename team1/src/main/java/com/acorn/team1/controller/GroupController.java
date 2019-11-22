package com.acorn.team1.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.acorn.team1.domain.GroupDTO;
import com.acorn.team1.domain.GroupMemberVO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.service.GroupService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/Group/*")
@Log4j
public class GroupController {

	@Inject
	GroupService service;

	@GetMapping("/AdminGroup")
	public void listAll(Model model, HttpSession session) throws Exception {
		log.info("GroupController::adminGroup() invoked...");

		// 관리자인지 강사인지 확인할 수 있는 job_id를 세션으로부터 읽기
		LoginUserVO loginVo = (LoginUserVO) session.getAttribute("login");

		String job_id = loginVo.getJob_id();
		

		// 관리자용 (job_id)

		if (job_id.equals("0") || job_id.equals("1")) { // 또는 1
			model.addAttribute("grouplist", service.listAll());
			model.addAttribute("groupSize", service.listAll().size());
			model.addAttribute("memberCount", service.countStudent());

		}
		// if job_id is 0, 1


		// 강사용
		// if job_id is 2
		if (job_id.equals("2")) {
			String admin_id = loginVo.getId();

			String teacher_name = loginVo.getName();

			log.info("teacher_name: " + teacher_name);

			model.addAttribute("teacherName", teacher_name);

			// String admin_id = vo.getId();
			model.addAttribute("grouplist", service.listAllT(admin_id));
			model.addAttribute("groupSize", service.listAllT(admin_id).size());
			model.addAttribute("memberCount", service.countStudent());

		}
		
		model.addAttribute("job_id", job_id);

		/*
		 * List<GroupPageVO> grouplist = service.listAll();
		 * 
		 * model.addAttribute("grouplist", grouplist); model.addAttribute("groupsize",
		 * grouplist.size());
		 */
	}

//------------------------------------------------------------//
//						   	그룹 생성							  //
//------------------------------------------------------------//

	@GetMapping("/RegisterGroup")
	public void registerGET(Model model, HttpSession session) throws Exception {
		log.info("GroupController::registerGet(model) invoked...");
		log.info("\t+service: " + service);

		LoginUserVO loginVo = (LoginUserVO) session.getAttribute("login");
		// String job_id = loginVo.getJob_id();
		String admin_id = loginVo.getId();
		int course_code = loginVo.getCourse_code();

		model.addAttribute("courseName", service.readCourse(admin_id));
		model.addAttribute("studentlist", service.readStudent(course_code));

		// session에서 adminId 받기
		model.addAttribute("adminId", admin_id);

		model.addAttribute("courseCode", service.readCourseCode(admin_id)); // course id

		// LoginUserVO loginVo = (LoginUserVO) session.getAttribute("login");
		String teacher_name = loginVo.getName();

		log.info("teacher_name: " + teacher_name);

		model.addAttribute("teacherName", teacher_name);

		List<GroupMemberVO> vo = service.readStudent(course_code);

		for (int i = 0; i < vo.size(); i++) {
			System.out.println("member[" + i + "]: " + vo.get(i).getName());
		} // for

	}

	@RequestMapping("/createNewGroup")
	public String createNewGroup(GroupDTO dto, Model model) throws Exception {
		service.createNewGroup(dto);
		return "redirect:/Group/RegisterGroup";
	}

//------------------------------------------------------------//
//   						그룹원 수정						  //
//------------------------------------------------------------//

	@GetMapping("/EditGroup")
	public void editGet(@RequestParam("coursecode") int coursecode, @RequestParam("groupsid") int groupsid,
			@RequestParam("coursename") String coursename, @RequestParam("groupsname") String groupsname, HttpSession session, 
		
			Model model) throws Exception {

		log.info("GroupController::editGet(coursecode, groupsid) invoked.");
		
		
		LoginUserVO loginVo = (LoginUserVO) session.getAttribute("login");

		
		String teacher_name = loginVo.getName();

		log.info("teacher_name: " + teacher_name);

		model.addAttribute("teacherName", teacher_name);

		// model.addAttribute("courseName", service.readCourse("TA02"));
		model.addAttribute("courseName", coursename);
		model.addAttribute("groupsName", groupsname);

		// model.addAttribute("groupName", service.readGroup(7, 15));
		// log.info("groupName: "+service.readGroup(7, 15));

		model.addAttribute("courseCode", coursecode);
		model.addAttribute("groupsId", groupsid);
		model.addAttribute("editMemberList", service.readEditMemberList(coursecode, groupsid));
		


	} // editGet

	@GetMapping("/editGroupMember")
	public String editGroupMember(GroupDTO dto, Model model, @RequestParam("coursecode") int coursecode,
			@RequestParam("groupsid") int groupsid, @RequestParam("coursename") String coursename,
			@RequestParam("groupsname") String groupsname,

			RedirectAttributes rttr) throws Exception {

		log.info("editGroupMember_____________________invoked");

		service.modifyMember(dto);

		rttr.addAttribute("coursecode", coursecode);
		rttr.addAttribute("groupsid", groupsid);
		rttr.addAttribute("coursename", coursename);
		rttr.addAttribute("groupsname", groupsname);

		return "redirect:/Group/EditGroup";

	}

//------------------------------------------------------------//
//							그룹원 추가						  //
//------------------------------------------------------------//
	@GetMapping("/AddMember")
	public void addGET(@RequestParam("coursecode") int coursecode, @RequestParam("groupsid") int groupsid,
			@RequestParam("coursename") String coursename, @RequestParam("groupsname") String groupsname, Model model, HttpSession session)
			throws Exception {
		log.info("GroupController::addGET(coursecode, groupsid, coursename, groupsname) invoked.");
		log.info("coursecode: " + coursecode);
		log.info("groupsid: " + groupsid);
		log.info("coursename" + coursename);
		log.info("groupsname" + groupsname);
		
		LoginUserVO loginVo = (LoginUserVO) session.getAttribute("login");

		
		String teacher_name = loginVo.getName();

		log.info("teacher_name: " + teacher_name);

		model.addAttribute("teacherName", teacher_name);


		model.addAttribute("courseName", coursename);
		model.addAttribute("groupsName", groupsname);
		model.addAttribute("courseCode", coursecode);
		model.addAttribute("groupsId", groupsid);

		model.addAttribute("studentlist", service.readStudent(coursecode));

	}

	@GetMapping("/addGroupMember")
	public String addMemer(GroupDTO dto, Model model, @RequestParam("coursecode") int coursecode,
			@RequestParam("groupsid") int groupsid, @RequestParam("coursename") String coursename,
			@RequestParam("groupsname") String groupsname, RedirectAttributes rttr) throws Exception {
		log.info("GroupController::addMemer(coursecode, groupsid, coursename, groupsname) invoked.");
		
		dto.setGroupsId(Integer.toString(groupsid));

		service.addMember(dto);

		log.info("coursecode: " + coursecode);
		log.info("groupsid: " + groupsid);
		log.info("coursename: " + coursename);
		log.info("groupsname: " + groupsname);

		rttr.addAttribute("coursecode", coursecode);
		rttr.addAttribute("groupsid", groupsid);
		rttr.addAttribute("coursename", coursename);
		rttr.addAttribute("groupsname", groupsname);

		/*
		 * log.info("coursecode: " + dto.getCourseCode()); log.info("groupsid: " +
		 * dto.getGroupsId()); log.info("coursename" + dto.getCourseName());
		 * log.info("groupsname" + dto.getGroupName());
		 */

		/*
		 * model.addAttribute("courseName", dto.getCourseName());
		 * model.addAttribute("groupName", dto.getGroupName());
		 * model.addAttribute("groupsId", dto.getGroupsId());
		 * model.addAttribute("courseCode", dto.getCourseCode());
		 */

		// return "redirect:/Group/AddMember";
		// return "redirect:/Group/AddMember?coursecode=" + dto.getCourseCode() +
		// "&groupsid=" + dto.getGroupsId() + "&coursename=" + dto.getCourseName() +
		// "&groupsname=" + dto.getGroupName();

		return "redirect:/Group/AddMember";

	}

//------------------------------------------------------------//
//							그룹 삭제							  //
//------------------------------------------------------------//
	@GetMapping("/removeGroup")
	public String removeGroup(@RequestParam("groupsid") int groupsid, RedirectAttributes rttr) throws Exception {
		log.info("GroupController::removeGroup() invoked......");
//		log.info("coursecode: " + coursecode);
		log.info("groupsid: " + groupsid);

		service.updateNull(groupsid);
		service.removeGroup(groupsid);
		rttr.addFlashAttribute("msg", "SUCCESS");
		// model.addAttribute("msg", "SUCCESS");
		return "redirect:/Group/AdminGroup";
	}

	@GetMapping("/checkGname")
	@ResponseBody
	public int checkGroupName(@RequestParam("name") String name, @RequestParam("course_code") int course_code)
			throws Exception {

		System.out.println("name: " + name);

		return service.checkGroupName(name, course_code);

	}

} // end class

package com.acorn.team1.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.acorn.team1.domain.ChangeUserPasswordDTO;
import com.acorn.team1.domain.DetailStudentDTO;
import com.acorn.team1.domain.FABoardPageMaker;
import com.acorn.team1.domain.FABoardSearchCriteria;
import com.acorn.team1.domain.HomeBoardSearchCriteria;
import com.acorn.team1.domain.HomeBoardVO;
import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.MyPageVO;
import com.acorn.team1.domain.MyPage_authVO;
import com.acorn.team1.domain.Password;
import com.acorn.team1.service.CourseService;
import com.acorn.team1.service.FABoardService;
import com.acorn.team1.service.HomeBoardService;
import com.acorn.team1.service.LoginService;
import com.acorn.team1.service.MyPageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/HOME")
public class MyPageController {

	@Inject
	private MyPageService service;
	
	@Inject
	private HomeBoardService Hservice;

	
	@Inject
	private FABoardService Fservice;
	
	@Inject
	private LoginService Lservice;
	
	
	private static int currYear = Calendar.getInstance().get(Calendar.YEAR);

	
	 //--------------------------로그인 후 홈 화면---------------------------//

		@GetMapping("/HOME")
		public void home(@ModelAttribute("cri") HomeBoardSearchCriteria cri, 
				Model model, 
				MyPageDTO dto,
				HttpSession session,
				@ModelAttribute("criF")
		  FABoardSearchCriteria criF
			) 
						throws Exception {
			
			/*-------출석 체크---------------*/
			/*----------출석정보-----*/
			
		
			List<String> attendanceInfo = service.attendanceInfo(dto, session);
			
			String str = null;
			int allattendance_count =0;
			int attendance_count=0;
			int noAttendance_count=0;
			int late_count=0;
			int early_count=0;
			
			for(int i=0; i<attendanceInfo.size(); i++) {
				 str = attendanceInfo.get(i);
				 
				 allattendance_count++;
				 
				if(str.equals("정상")) {
					
					attendance_count++;
					
					log.info("이미 attendance_count 했음"+attendance_count);
					session.setAttribute("attendance_count", attendance_count);
				}
				else if(str.equals("지각")) {
							
					late_count++;
					
					session.setAttribute("late_count", late_count);
					
				}
					
				else if(str.equals("조퇴")) {
					
					early_count++;
					
					session.setAttribute("early_count", early_count);
				}
				
				else if(str.equals("결석")) {
					
					noAttendance_count++;
					
					session.setAttribute("noAttendance_count", noAttendance_count);
				}
				
			}
		
			
			model.addAttribute("getAttendanceInfo_A", service.getAttendanceInfo_A(dto));
			session.setAttribute("attendance_rate", allattendance_count);

			
			/*--------과정 진행률---------*/
			model.addAttribute("course_rate", service.course_rate(dto, session));

			
			/*-------게시글 리스트--------*/
			model.addAttribute("list", Hservice.HomeNotice(cri, session));
			
			

			//-----스케줄 리스트------//
			log.info("ScheduleController::listAll(model) invoked.");
			log.info("\t+ service: " + service);
			
			
			/*-------테스트 정보-------*/
			model.addAttribute("getTest_T", service.getTest_T(dto, session));
			
			/*-------테스트 평균-------*/
			model.addAttribute("getLastTestScore_T", service.getLastTestScore_T(dto));
			
			/*-------운영자 계획중인 코스------*/
			model.addAttribute("getPCouseInfo_A", service.getPCouseInfo_A(dto));
			
			
		  LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		  
		  String job_id = vo.getJob_id();
		  
		  System.out.println("jobId: " + job_id);
		 
			
//			session.setAttribute("HomeSchedule", Hservice.HomeScheduleAll()); 
			
			switch (job_id) { 
			case "0": // admin 
				session.setAttribute("HomeSchedule", Hservice.HomeScheduleAll());
				session.setAttribute("TomorrowHomeSchedule", Hservice.TomorrowHomeScheduleAll());

				break; 
			case "1": // chat admin 
				session.setAttribute("HomeSchedule", Hservice.HomeScheduleAll());
				session.setAttribute("TomorrowHomeSchedule", Hservice.TomorrowHomeScheduleAll());

				break; 
			case "2": // teacher
				session.setAttribute("HomeSchedule", Hservice.HomeScheduleCourse(dto, session));
				session.setAttribute("TomorrowHomeSchedule",  Hservice.TomorrowHomeScheduleAll());

				break; 
			case "4": // student
				session.setAttribute("HomeSchedule", Hservice.HomeScheduleCourse(dto, session)); 
				session.setAttribute("TomorrowHomeSchedule",  Hservice.TomorrowHomeScheduleAll());
				break; 
			} // switch	
			
			
	
			
			/*-------홈페이지 이용 TIP  --------*/  
		    model.addAttribute("FABoardList", Fservice.listSearchCriteria(criF));
			  
			FABoardPageMaker pageMaker = new FABoardPageMaker(); pageMaker.setCri(criF);
			  
			pageMaker.setTotalCount(Fservice.listSearchCount(criF));
			  
			model.addAttribute("pageMaker", pageMaker); 
			
			  
			/*-------성적확인 --------*/  
  
		/*
		 * model.addAttribute("grade_list", service.getGrade_student(dto, session)); int
		 * score = 0; List<MyPageVO> grade = service.getGrade_student(dto, session);
		 * for(MyPageVO vo1 : grade) { score = vo1.getScore(); }
		 * 
		 * model.addAttribute("last_score", score);
		 */

		
		  session.setAttribute("getGrade_student", service.getGrade_student(dto,session));
		  model.addAttribute("last_score", service.last_score(dto,session));
		  session.setAttribute("getGrade_admin", service.getGrade_admin(dto));
		  
			//--------------------------- 테스트 정보 가져오기---------------------------//
	
		  session.setAttribute("getTest_T", service.getTest_T(dto, session));
		  session.setAttribute("attendanceList_T", service.attendanceList(dto, session));

		}
		

	
    //------------------------회원정보 수정 인증 폼---------------------------//

		@GetMapping("/authorization")
		public String authorization(
	 			@ModelAttribute("dto") MyPageDTO dto) throws IOException {
			
			log.info("authorizationGet ::authorizationGet invoked.");
			
			return "HOME/authorizationForm";
			
		}//authorizationGET
		

	  //-----------------------회원정보 수정 인증 처리---------------------------//
		
		@PostMapping("/authorizationPost")
		public String authorizationPost(
				MyPageDTO dto,
				HttpSession session,
				Model model) 
				throws Exception {
			
			log.info("authorizationPost ::authorizationPost invoked.");

			MyPage_authVO vo = service.authorization(dto);
			
				if(vo == null) { //처리 실패
				
			       return "HOME/authorizationError";
			       
			 	}else { //처리 성공
			 	 
				model.addAttribute("MyPage_authVO", vo);
				
				System.out.println(vo);
				
				
				
				return "redirect:/HOME/editStudent";
						
				}
					
		} //authorizationPost
		

		//------------------인증 실패 시-----------------------//
		
		@GetMapping("/authorizationError")
		public void authorizationError(Model model) {
			
			log.info("authorizationError ::authorizationError invoked.");
		
		}
		
		
	  //---------------------------회원정보 수정 ----------------------------//
	
	  @GetMapping("/editStudent") //edit student view 
	  public void editStudent(Model model,HttpServletRequest request , HttpSession session) throws Exception{
			
		  Object obj = session.getAttribute("authorization"); //obj에 세션에 담긴 로그인 정보를 담는다.
			
			
	 		if (obj != null) { //회원정보 수정에 접근할 세션 정보가 남아있으면
	 			
	 			//MyPage_authVO vo = (MyPage_authVO) obj;
	 			
	 			
		 			session.removeAttribute("authorization"); // 세션 값 제거
	 	
	 		}
	 
       log.info("StudentDataController::editStudent invoked"); 
	  
	  
	  }
	  
	  
	  @PostMapping("/editStudentPost")
	  public void editStudentPost( 
			  MyPageDTO dto, LoginDTO ldto,
			  HttpSession session, Model model,RedirectAttributes rttr 
	     ) throws Exception {
			
		  String pw =  dto.getPassword();
		  String encryption = Password.encryption(pw);
		  
		  
		  service.updateStudentInfo(dto.getId(),dto.getUserId(), encryption, dto.getMobile_phone(),
				  dto.getTemporarily_number(), dto.getAddress(), dto.getDetail_address());
		  log.info("-------------------------------------editStudentPost::editStudentPost");
		  
		  
			LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
				if (vo != null) { //회원정보 수정에 접근할 세션 정보가 남아있으면
	 			
	 			//MyPage_authVO vo = (MyPage_authVO) obj;
	 			
	 			
		 			session.removeAttribute("login"); // 세션 값 제거
		 			
		 			
				
		 			LoginUserVO lvo = Lservice.login(ldto);
		 				  
		 			session.setAttribute("login", lvo); //로그인 입력 정보가 DB에 있으면 vo에 담아 모델로 저장
		 			log.info("loginInfo keeps in session again!!!!!!!!!!!!!!!!!!");
		 			
	 		}
	 
		 
		  
		  
		
//		  Object obj = session.getAttribute("authorization"); //obj에 세션에 담긴 로그인 정보를 담는다.
//			
//			
//	 		if (obj != null) { //회원정보 수정에 접근할 세션 정보가 남아있으면
//	 			
//	 			//MyPage_authVO vo = (MyPage_authVO) obj;
//	 			
//	 			
//		 			session.removeAttribute("authorization"); // 세션 값 제거
//	 	
//	 		}
	  }//changeUserPasswordPost


	//--------------------------------출석 체크 처리 -------------------------------//

	@PostMapping( "/attendancePost")
	public String attendancePost(MyPageDTO dto, HttpSession session, Model model) throws Exception {

		log.info("attendancePost ::attendancePost invoked.");

		
		MyPageVO vo = service.startTimeChecked(dto);
		
		if (vo == null) { //이미 출석 체크 함.

			log.info("null.null() :null**********" );
			return "/HOME/attendancePost";
		}

		if (vo != null) {//기존 출석체크 없음 - 출석체크 가능
			
			//----------------------이미 들어간 timestamp 시간 변경을 위해 쿠키 사용-------------//
			
			int amount = 1; // - 세션리밋을 설정하고
			
			Date start_date_time = new Date(System.currentTimeMillis()+(10*amount));
			
			service.updateStartTime(vo.getStudent_id(), session.getId(), start_date_time); //DB에 update해준다.
			
			model.addAttribute("MyPageVO", vo); //뷰에 보내기 위해 모델에 담고
			
			MyPageVO vo1 = service.startTimeCheckedAgain(dto);//세션에 저장 하기 위해 변경 된 값을 다시 불러온다
						
			model.addAttribute("MyPageVO1", vo1);//인터셉터에서 세션에 담기 위해 모델에 담는다.
			
			log.info("vo.MyPageVO() : ***MyPageVO******" + vo1);
			
			return "/HOME/attendancePost";
		}


		return "/HOME/attendancePost";

	}

	
	//--------------------------체크아웃 시간 등록 처리----------------------------//

	@PostMapping("/checkoutPost")
	public String checkoutPost(MyPageDTO dto, HttpSession session, Model model) throws Exception {

		log.info("checkOutPost ::checkOutPost invoked.");

		MyPageVO vo = service.endTimeChecked(dto); //체크아웃 처리 위해 비교할 기존 값을 불러오고 
		
		log.info("vo ::" + vo);

		if (vo != null) { //체크아웃 할 (오늘 날짜 체크아웃 안된 상태) vo가 널이 아니면 체크아웃 가능 

		//	 if (vo.isStart_checked() == true && vo.isEnd_checked() == false) {

				log.info("체크아웃");
				
				model.addAttribute("MyPageVO", vo); //뷰에 보낼 정보를 모델에 담고,
				
				MyPageVO vo2 = service.endTimeCheckedAgain(dto);//세션에 등록하기 위해 바뀐 값을 불러와서 
				
				model.addAttribute("MyPageVO2", vo2);//모델에 담는다.
				
				log.info("vo.MyPageVO() : ***MyPageVO******" + vo2);
				
				return "/HOME/checkoutPost";

		}
				
		if(vo == null) { //기존에 체크아웃을 했다면..

		
			log.info("이미 체크아웃 했음");
	
			return "/HOME/checkoutPost2";

			
			
		}
		return "/HOME/checkoutPost";

	}

	//----------------------------[학생] 출석 리스트-------------------------------//
	
	@PostMapping("/attendanceList_student")
	public void attendanceList_student(@ModelAttribute("dto") MyPageDTO dto, Model model,  HttpServletRequest request) throws Exception {

		model.addAttribute("attendanceList_student", service.attendanceList_student(dto));
		


	} // attendanceList_student
	

	//----------------------------[강사] 출석 현황 리스트-------------------------------//
	@GetMapping("/attendanceList_T")
	public void attendanceList_T(@ModelAttribute("dto") MyPageDTO dto, Model model,HttpSession session) throws Exception {


		/*
		 * session.setAttribute("attendanceList", service.attendanceList(dto));
		 */
	} // attendanceList
	
	
	
	
	  @GetMapping("/test_info") 
	  public void test_info(  @ModelAttribute("dto") MyPageDTO dto,Model model,  HttpSession session) throws Exception {
		    
		  model.addAttribute("getGrade_T", service.getGrade_T(dto,session));
			 
			
			
			
	  } // test_info
	 	
	//----------------------------성적 불러오기-------------------------------//
	@GetMapping("/getGrade_student")
	public void getGrade_student( @ModelAttribute("dto") MyPageDTO dto, Model model, HttpSession session) throws Exception {

		model.addAttribute("grade_list", service.getGrade_student(dto, session));

	} // getGrade_student
	
	//----------------------------[강사] 시험점수 넣기---------------------------//
	@PostMapping("/test_infoPost")
	public String insertGrade_T(
			MyPageDTO dto,
			Model model, 
			HttpSession session ) throws Exception {
		
	 
		service.insertGrade_T(dto,session);
		return "/HOME/HOME";
	}
}



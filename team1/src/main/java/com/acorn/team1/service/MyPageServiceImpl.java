package com.acorn.team1.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.MyPageVO;
import com.acorn.team1.domain.MyPage_authVO;
import com.acorn.team1.persistence.ChangeUserPasswordDAO;
import com.acorn.team1.persistence.MyPageDAO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MyPageServiceImpl implements MyPageService{

	@Inject
	private MyPageDAO dao;
	
	//private final String attendanceList_studentKey = "attendanceList_student";
	
	//----------------------------회원정보 수정 인증---------------------------//

	@Override
	public MyPage_authVO authorization(MyPageDTO dto) throws Exception {
	
		
		
		MyPage_authVO vo = dao.authorization(dto);//vo에 주입받은 dao의 로그인 메서드 넣어줌
		
		if(vo != null) { //로그인 성공
			log.info("\t + logineduser user:" +vo);
			
			
		}else {
			log.info("\t+ no logineduser found.");
		}
		
		return vo;
	
	}
	//----------------------------회원정보 수정---------------------------//
	@Override
	public void updateStudentInfo( String id,String userId, String password, String mobile_phone, String temporarily_number,
			String address, String detail_address) {
	
		
		dao.updateStudentInfo( id,userId, password, mobile_phone, temporarily_number, address, detail_address);
	}
		
	
	//-------------------------출석 자동 저장 스케줄러------------------------//

	@Override 
	public void insertAttendance(MyPageDTO dto) throws Exception {
		
		// 현재 날짜 받아오기
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
		
		Calendar time = Calendar.getInstance();
		       
		String date = format1.format(time.getTime());
		
		String hol =null;
		
		log.info("date :" + date);
		// 올해 공휴일 배열로 넣기
		String[] holiday = {"2019-01-01", "2019-02-04", "2019-02-05", "2019-02-06", "2019-03-01",
				"2019-05-05","2019-05-06","2019-05-12","2019-06-06","2019-08-15","2019-09-12",
				"2019-09-13","2019-09-14","2019-10-03","2019-10-14","2019-10-15","2019-10-16",
				"2019-10-09","2019-12-25" };
		
		for(int i =0; i<holiday.length; i++) {
			
			if (date.equals(holiday[i])){ //배열을 돌려서 오늘 날짜가 공휴일에 들어가 있으면 
				
				hol = holiday[i];  //hol에 그 값을 넣은 뒤
				
			}	
		}
		if(hol == null) { //hol이 null이면 오늘 공휴일이 아니므로

			dao.insertAttendance(dto); //스케줄러 실행
		}
		else { //null이라면 공휴일이므로 건너뛰기
			
			log.info("휴일"); 
		}
		
	}
	

	//-------------------------출석체크 정보 가져오기-------------------------//

	@Override
	public MyPageVO startTimeChecked(MyPageDTO dto) throws Exception {

		MyPageVO vo = dao.startTimeChecked(dto);
				
				if(vo != null ) { //사용자 출석정보 확인
					
					log.info("로그인 출석정보 확인");
						
					log.info("\t+ 출석체크 ok");
					
				}			
				else if(vo == null) {
					log.info("\t+ 이미 출석체크 함");
					
				}
				return vo;
	}
	
	

	//---------------------------출석체크 시간 업데이트-----------------------//
	
	@Override
	public void updateStartTime(String userId, String sessionId, Date next) throws Exception {
	
		dao.updateStartTime(userId, sessionId, next);
		
	}

	//----------------------출석체크 시간 업데이트 한 정보 가져오기-----------------//

	@Override
	public MyPageVO startTimeCheckedAgain(MyPageDTO dto) throws Exception {

		MyPageVO vo1 = dao.startTimeCheckedAgain(dto);
		
		return vo1;
	}

	
	//---------------------------체크아웃 정보 가져오기-----------------------//

	@Override
	public MyPageVO endTimeChecked(MyPageDTO dto) throws Exception {
	
		MyPageVO vo = dao.endTimeChecked(dto);//vo에 주입받은 dao의 로그인 메서드 넣어줌
		

		if(vo != null) { //출석체크 확인
			
			log.info("user 출석체크 확인");
			
			
			if(vo.isStart_checked() == true && vo.isEnd_checked() == false) {
		
				updateEndTime(dto);
				
				log.info("\t+ updateEndTime" +dto);

			
			}else if (vo.isStart_checked() == false && vo.isEnd_checked() != false){
				
			log.info("\t +service 출석체크 한적 없음" );
			
			}	
			
		}else {
			log.info("\t+ service 이미 체크됨");
		}
		
		return vo;
	}
	
	//---------------------------체크아웃 시간 업데이트-----------------------//

	@Override
	public void updateEndTime(MyPageDTO dto) throws Exception {
	log.info("ChangeUserPasswordServiceImpl::authorization invoiked");
	log.info("\t+ dao : " +dao);
	
	 dao.updateEndTime(dto);
	
		
	}

	//----------------------체크아웃 시간 업데이트 한 정보 가져오기-----------------//

	@Override
	public MyPageVO endTimeCheckedAgain(MyPageDTO dto) throws Exception {

		MyPageVO vo2 = dao.endTimeCheckedAgain(dto);
		
		return vo2;
	}

	//------------------------------과정 진행롤-------------------------------//
	
	@Override
	public int course_rate(MyPageDTO dto, HttpSession session) throws Exception{
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		int course_code = vo.getCourse_code();
		
		dto.setCourse_code(course_code);
			
		return dao.course_rate(dto);

			
		}
	//-----------------------------출석현황-----------------------------//
	
	@Override
	public List<String> attendanceInfo(MyPageDTO dto, HttpSession session) throws Exception {
		
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		String id = vo.getId();
		
		dto.setUserId(id);
		
		return dao.attendanceInfo(dto);

	} //HomeNotice

	
	//----------------------------[학생] 출석 리스트-------------------------------//
	
	@Override
	public List<MyPageDTO> attendanceList_student(MyPageDTO dto) throws Exception{

		
		
		return dao.attendanceList_student(dto);
	}

	//----------------------------[강사]출석 현황 리스트-------------------------------//

	@Override
	public List<MyPageVO> attendanceList(MyPageDTO dto, HttpSession session) throws Exception {
		 LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
			int course_code = vo.getCourse_code();
			log.info("##############################course_code"+course_code);
			dto.setCourse_code(course_code);

		return dao.attendanceList(dto);
	}

	//----------------------------[학생] 시험정보 가져오기-----------------------------//
	
	@Override
	public List<MyPageVO> getGrade_student(MyPageDTO dto, HttpSession session)throws Exception{
	
		 LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
			String id = vo.getId();
			
			dto.setUserId(id);
			
			return dao.getGrade_student(dto);
	}



	//----------------------------지난 성적 가져오기-----------------------------//
	 @Override
	public List<Integer> last_score(MyPageDTO dto, HttpSession session)throws Exception{
		 
		 LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
			String id = vo.getId();
			
			dto.setUserId(id);
			
	
		 return dao.last_score(dto);		
	}
		

		//----------------------------[관리자] 시험정보 가져오기-----------------------------//
	 @Override
	public List<MyPageVO> getGrade_admin(MyPageDTO dto)throws Exception{
	
		 return dao.getGrade_admin(dto);		
	}
	 
		//----------------------------[강사] 시험정보 가져오기-----------------------------//
	 @Override
	public List<MyPageVO> getGrade_T(MyPageDTO dto, HttpSession session )throws Exception{
		 
		 LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
			int course_code = vo.getCourse_code();
			
			dto.setCourse_code(course_code);
			

				
		 return dao.getGrade_T(dto);		
	}
	
		//----------------------------[강사] 시험점수 넣기---------------------------//
		@Override
		public void insertGrade_T(MyPageDTO dto, HttpSession session) throws Exception {

	
		dao.insertGrade_T(dto);
			 
		}
	
		
		
		//--------------------------- 테스트 정보 가져오기---------------------------//
		@Override
		public MyPageVO getTest_T(MyPageDTO dto, HttpSession session) throws Exception{
			 LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
				int course_code = vo.getCourse_code();
				
				dto.setCourse_code(course_code);
				
			
			return dao.getTest_T(dto);
		}

		//----------------------------[관리자] 수강정보 가져오기-----------------------------//
		@Override
		public List<MyPageVO> getAttendanceInfo_A(MyPageDTO dto)throws Exception{
			
			
			 return dao.getAttendanceInfo_A(dto);		
		}
		
		//----------------------------[관리자] 계획중인 코스 가져오기-----------------------------//
		@Override
		public List<MyPageVO> getPCouseInfo_A(MyPageDTO dto)throws Exception{
			
			return dao.getPCouseInfo_A(dto);	
		
		}
		
		//----------------------------마지막시험정보 평균 가져오기 -강사-----------------------------//
		@Override
		public int getLastTestScore_T(MyPageDTO dto) throws Exception{

			
			 return dao.getLastTestScore_T(dto);
			 
		}
	
	
	
	
}

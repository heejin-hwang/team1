package com.acorn.team1.service;


import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.MyPageVO;
import com.acorn.team1.domain.MyPage_authVO;



public interface MyPageService {
	
	
	//-------------------------회원정보 수정 인증 폼---------------------------//
	public MyPage_authVO authorization(MyPageDTO dto) throws Exception;


	//----------------------------회원정보 수정---------------------------//
	public void updateStudentInfo(String id, String userId, String password, String mobile_phone, String temporarily_number,
			String address, String detail_address);
	
	
	//-------------------------출석 자동 저장 스케줄러------------------------//

	public void insertAttendance(MyPageDTO dto) throws Exception;

	
	//-------------------------출석체크 정보 가져오기-------------------------//

	public MyPageVO startTimeChecked(MyPageDTO dto) throws Exception;
	
	
	//---------------------------출석체크 시간 업데이트-----------------------//

	public void updateStartTime(String userId, String sessionId, Date next) throws Exception;
	
	
	//----------------------출석체크 시간 업데이트 한 정보 가져오기-----------------//

	public MyPageVO startTimeCheckedAgain(MyPageDTO dto) throws Exception;
	
	
	//---------------------------체크아웃 정보 가져오기-----------------------//

	public MyPageVO endTimeChecked(MyPageDTO dto) throws Exception;
	
	
	//---------------------------체크아웃 시간 업데이트------------------------//

	public void updateEndTime(MyPageDTO dto) throws Exception;
	
	
	//----------------------체크아웃 시간 업데이트 한 정보 가져오기------------------//

	public MyPageVO endTimeCheckedAgain(MyPageDTO dto) throws Exception;
	

	//-----------------------------과정 진행률-----------------------------//

	public int course_rate(MyPageDTO dto, HttpSession session) throws Exception;
		
	
	//-----------------------------출석현황-----------------------------//
	
	public List<String> attendanceInfo(MyPageDTO dto, HttpSession session) throws Exception;	
	

	//----------------------------[학생] 출석 리스트-------------------------------//
	
	public List<MyPageDTO> attendanceList_student(MyPageDTO dto) throws Exception;
	
	
	//----------------------------[강사]출석 현황 리스트-------------------------------//
	
	public List<MyPageVO> attendanceList(MyPageDTO dto, HttpSession session) throws Exception;


	//----------------------------[학생] 시험정보 가져오기-----------------------------//

	public List<MyPageVO> getGrade_student(MyPageDTO dto, HttpSession session) throws Exception;
	

	//----------------------------지난 성적 가져오기-----------------------------//
	public List<Integer> last_score(MyPageDTO dto,HttpSession session )throws Exception;

	
	//----------------------------[강사] 시험점수 넣기---------------------------//
	public void insertGrade_T(MyPageDTO dto, HttpSession session) throws Exception; 
	
	//----------------------------[관리자] 시험정보 가져오기-----------------------------//
	public List<MyPageVO> getGrade_admin(MyPageDTO dto)throws Exception;


	//----------------------------[강사] 시험정보 가져오기-----------------------------//
	public List<MyPageVO> getGrade_T(MyPageDTO dto,  HttpSession session)throws Exception;


	//--------------------------- 테스트 정보 가져오기---------------------------//
	public MyPageVO getTest_T(MyPageDTO dto, HttpSession session) throws Exception;


	//----------------------------[관리자] 수강정보 가져오기-----------------------------//
	public List<MyPageVO> getAttendanceInfo_A(MyPageDTO dto) throws Exception;
	
	
	//----------------------------[관리자] 계획중인 코스 가져오기-----------------------------//
	public List<MyPageVO> getPCouseInfo_A(MyPageDTO dto)throws Exception;

	
	//----------------------------마지막시험정보 평균 가져오기 -강사-----------------------------//
	public int getLastTestScore_T(MyPageDTO dto) throws Exception;

}

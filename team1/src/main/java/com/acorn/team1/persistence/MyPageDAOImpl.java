package com.acorn.team1.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.domain.MyPageVO;
import com.acorn.team1.domain.MyPage_authVO;
import com.acorn.team1.domain.Password;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository //데이터 저장소
public class MyPageDAOImpl implements MyPageDAO {
	
	@Inject
	private SqlSession session;
	
	private final String namespace ="com.acorn.team1.mapper.myPageMapper";
	
	//------------------------회원정보 수정 인증--------------------------//

		@Override
		public MyPage_authVO authorization(MyPageDTO dto) throws Exception {
			
			
			//사용자가 넣은 비밀번호를 암호화한다.
			String encryption = Password.encryption(dto.getPassword());

			dto.setPassword(encryption);
			
			//selectOne = SqlSession의 구문을 실행하는 메서드
			//메서드 반환 타입인 LoginUserVO의 변수인 vo에 Mapper의 namespace와 dbSelectId, 사용자가 넣은 로그인 정보인 dto를 넣어줌
			//즉 vo는 db에 저장된 정보와 사용자가 입력한 로그인 정보를 둘다 가지고 있음		
			MyPage_authVO vo = session.<MyPage_authVO>selectOne(namespace +".authorization", dto);
			 
			 return vo;
		}
		
	
		
	
	//----------------------------회원정보 수정---------------------------//
	@Override
	public void updateStudentInfo( String id, String userId, String password, 
			String mobile_phone, String temporarily_number, String address, String detail_address) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("userId", userId);
		paramMap.put("password", password);
		paramMap.put("mobile_phone", mobile_phone);
		paramMap.put("temporarily_number", temporarily_number);
		paramMap.put("address", address);
		paramMap.put("detail_address", detail_address);
		
	
		
		session.update(namespace+".updateStudentInfo", paramMap);
		 
	}
	
	
	//-------------------------출석 자동 저장 스케줄러------------------------//

	@Override
	public void insertAttendance(MyPageDTO dto) throws Exception {
		session.insert(namespace+".insertAttendance", dto);
		  
		  log.info("insertStartTime DTO "+ dto);
	}


	//-------------------------출석체크 정보 가져오기-------------------------//
	
	@Override //이중 출석 체크 방지
	public MyPageVO startTimeChecked(MyPageDTO dto) {

		MyPageVO vo = session.<MyPageVO>selectOne(namespace +".startTimeChecked", dto);
		
		
		return vo;	
		
	}

	//---------------------------출석체크 시간 업데이트-----------------------//

	@Override //세션에 등록 할 값
	public void updateStartTime(String userId, String sessionId, Date next) {
	
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next",next);
		
		session.update(namespace+".updateStartTime", paramMap);
		
	} 
	
	//----------------------출석체크 시간 업데이트 한 정보 가져오기-----------------//
	
	@Override
	public MyPageVO startTimeCheckedAgain(MyPageDTO dto) { //출석하고 DB에 저장 후  세션에 저장하고 사용하기 위해 바뀐 데이터를 불러옴

		MyPageVO vo1 = session.<MyPageVO>selectOne(namespace +".startTimeCheckedAgain", dto);
		
		
		return vo1;	
		
	}

	
	//----------------------------------체크아웃----------------------------------------//


	//---------------------------체크아웃 정보 가져오기-----------------------//

	@Override
	public MyPageVO endTimeChecked(MyPageDTO dto) {
	
		MyPageVO vo = session.<MyPageVO>selectOne(namespace +".endTimeChecked", dto);
		
		
		return vo;
	}
	
	
	//---------------------------체크아웃 시간 업데이트-----------------------//

	@Override  //DB에 update
	public void updateEndTime(MyPageDTO dto) throws Exception{
		
			session.update(namespace +".updateEndTime", dto);
				
		
			log.info("checkAttendance DTO "+ dto);
		
	}

	//----------------------체크아웃 시간 업데이트 한 정보 가져오기-----------------//

	@Override
	public MyPageVO endTimeCheckedAgain(MyPageDTO dto) { //출석하고 DB에 저장 후  세션에 저장하고 사용하기 위해 바뀐 데이터를 불러옴

		MyPageVO vo2 = session.<MyPageVO>selectOne(namespace +".endTimeCheckedAgain", dto);
		
		
		return vo2;	
		
	}
	
	//------------------------------과정 진행률-------------------------------//
	@Override
	public int course_rate(MyPageDTO dto) throws Exception{
		
		return session.selectOne(namespace+".course_rate", dto);
		
	}
	
	//-----------------------------출석률-----------------------------//

	 @Override
	public List<String> attendanceInfo(MyPageDTO dto) throws Exception{
		 
		
		 return session.selectList(namespace+".attendanceInfo", dto);
		 
	
	}
		

	//----------------------------[학생] 출석 리스트-----------------------------//
	 @Override
	public List<MyPageDTO> attendanceList_student(MyPageDTO dto)throws Exception{
	
		return session.selectList(namespace+".attendanceList_student", dto);	
	}
	
		
	//----------------------------[강사]출석 현황 리스트-------------------------------//
	
	@Override //관리자 화면에서 보여지는 출석 리스트
	public List<MyPageVO> attendanceList(MyPageDTO dto) throws Exception {
	
		return session.selectList(namespace+".attendanceList_T", dto);	
		
	}


	//----------------------------[학생] 시험정보 가져오기-----------------------------//
	 @Override
	public List<MyPageVO> getGrade_student(MyPageDTO dto)throws Exception{
	
		return session.selectList(namespace+".getGrade_student", dto);	
	}
	


	 
	//----------------------------지난 성적 가져오기-----------------------------//
	 @Override
	public List<Integer> last_score(MyPageDTO dto)throws Exception{
	
		return session.selectList(namespace+".last_score", dto);	
	}
		

		//----------------------------[관리자] 시험정보 가져오기-----------------------------//
	 @Override
	public List<MyPageVO> getGrade_admin(MyPageDTO dto)throws Exception{
	
		return session.selectList(namespace+".getGrade_admin", dto);	
	}
	

		//----------------------------[강사] 시험정보 가져오기-----------------------------//
		public List<MyPageVO> getGrade_T(MyPageDTO dto)throws Exception{
			
			return session.selectList(namespace+".getGrade_T", dto);	

		}

		//--------------------------- 테스트 정보 가져오기---------------------------//
		@Override
		public  MyPageVO getTest_T(MyPageDTO dto) throws Exception{

			
			return session.selectOne(namespace+".getTest_T", dto);
			 
		}

	
		//----------------------------[강사] 시험점수 넣기---------------------------//
		@Override
		public void insertGrade_T(MyPageDTO dto) throws Exception{

			
			session.insert(namespace+".insertGrade_T", dto);
			 
		}
		//----------------------------[관리자] 수강정보 가져오기-----------------------------//
		@Override
		public List<MyPageVO> getAttendanceInfo_A(MyPageDTO dto)throws Exception{
			
			return session.selectList(namespace+".getAttendanceInfo_A", dto);	

		}
		
		

		//----------------------------[관리자] 계획중인 코스 가져오기-----------------------------//
		@Override
		public List<MyPageVO> getPCouseInfo_A(MyPageDTO dto)throws Exception{
			
			return session.selectList(namespace+".getPCouseInfo_A", dto);	
		
		}

		//----------------------------마지막시험정보 평균 가져오기 -강사-----------------------------//
		@Override
		public int getLastTestScore_T(MyPageDTO dto) throws Exception{
			
			System.out.println("dto: " + dto.toString());

			int result = session.selectOne(namespace+".getLastTestScore_T", dto);
			
			System.out.println("result: " + result);
			
			return result;
			 
		}
		
	
	
}

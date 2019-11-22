package com.acorn.team1.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.acorn.email.MailSend;
import com.acorn.team1.controller.Criteria;
import com.acorn.team1.domain.CourseDTO;
import com.acorn.team1.domain.DetailStudentDTO;
import com.acorn.team1.domain.Password;
import com.acorn.team1.domain.StudentFindDTO;
import com.acorn.team1.domain.StudentListDTO;
import com.acorn.team1.domain.StudentVO;
import com.acorn.team1.domain.UpdateStudentByAdminDTO;
import com.acorn.team1.domain.UpdateStudentByStudentDTO;
import com.acorn.team1.persistence.StudentDAO;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Service
public class StudentServiceImpl implements StudentService {

	
	@Inject
	private StudentDAO dao;

	//@Inject
	//private ReadStudentMapper rsm;
	
	
	@Override
	public List<CourseDTO> readCourseList() throws Exception{
		
		return dao.readCourseList();
		
	}
	
	@Override
	public List<StudentListDTO> readStudentList() throws Exception {
		log.info("readStudentList invoked");
		
		return dao.readStudentList();
		
	
	}
	
	@Override
	public List<StudentListDTO> searchStudentList(String type, String value) throws Exception {
		
		return dao.searchStudentList(type, value);
	}
	
	@Override
	public int idExist(String id) {

		StudentFindDTO dto = new StudentFindDTO(id);
		return dao.readIdExist(dto);

	}


	@Override
	public DetailStudentDTO readStudentData(String id) throws Exception { //receive id by String
		
		StudentFindDTO dto = new StudentFindDTO(id); // create studentDTO

		if (dao.readIdExist(dto) != 0) { // check student exist
			return dao.readStudentData(dto); // if student exist, return the student's data
		} else {
			System.out.println(".");
			return null;
		}
		
	}

//	@Override
//	public void deleteStudentData(String id) throws Exception {
//		
//		log.info("StudentServiceImpl::deleteStudent invoked.");
//		StudentDTO dto = new StudentDTO(id);
//		if(dao.readidExist(dto)) {
//			dao.deleteStudentData(dto);
//			System.out.println(id+ "�븰�깮�씠 �궘�젣�릺��?�뒿�땲�떎.");
//			
//		}else {
//			System.out.println("�븰�깮�씠 �뾾�뒿�땲�떎.");
//		}
//	
//	}

	@Override
	public void insertStudentData(StudentVO vo) throws UnsupportedEncodingException {
		log.info("StudentServiceImpl::insertStudentData invoked");
		StudentFindDTO dto = new StudentFindDTO(vo.getId());
		
		if(dao.readIdExist(dto) != 0) { //check id exist
			log.info("학생이 이미 존재합니다.");
			
		}else {

			
			//password
			vo.setPw_checked(false); 

			String pw = Password.CreatePassword(); //create password
			
			MailSend.mailSend(vo.getId(), pw); //send mail to the student
			log.info("mail sent");
			vo.setPassword(Password.encryption(pw)); //password encryption and save
			dao.insertStudentData(vo); //insert data
			
			log.info("학생 등록 완료.");
		}
		
		
		
		
		
		
		
	}

	//Update student data
	@Override
	public void updateStudentByAdmin(String target_id, String id, String name, String birthday, String mobile_phone, String temporarily_number,String address, String detail_address,String course_code,String state) {
		
		StudentFindDTO dto = new StudentFindDTO(target_id);
		
		if (dao.readIdExist(dto) != 0) {
			UpdateStudentByAdminDTO usdto = new UpdateStudentByAdminDTO(target_id, id, name, birthday, mobile_phone, temporarily_number, address, detail_address, course_code,state);
			dao.updateStudentByAdmin(usdto);
		} else {
			log.info("학생을 찾을 수 없습니다.");
		}
	}
	
	public void updateStudentByStudent(String target_id, String id, String mobile_phone, String temporarily_number,String password, String address, String detail_address) {
		
		
		StudentFindDTO dto = new StudentFindDTO(target_id);
		
		if (dao.readIdExist(dto) != 0) {
		password = Password.encryption(password);
		UpdateStudentByStudentDTO usdto = new UpdateStudentByStudentDTO(target_id, id, mobile_phone, temporarily_number, password, address, detail_address);
		
		}else {
			log.info("학생이 존재하지 않습니다.");
		}
		
		
	}
	
	//paging data 
	@Override 
	public int listCountCriteria(Criteria criteria) throws Exception {
	
		
		return dao.countPaging(criteria);
	}
	@Override
	public  List<StudentVO> listCriteria(Criteria criteria) throws Exception {
		return dao.listCriteria(criteria);
	}



}

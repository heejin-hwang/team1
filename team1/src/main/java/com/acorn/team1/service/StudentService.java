package com.acorn.team1.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import com.acorn.team1.controller.Criteria;
import com.acorn.team1.domain.CourseDTO;
import com.acorn.team1.domain.DetailStudentDTO;
import com.acorn.team1.domain.StudentListDTO;
import com.acorn.team1.domain.StudentVO;



public interface StudentService {

	
	public abstract List<CourseDTO> readCourseList() throws Exception;
	public abstract List<StudentListDTO> readStudentList() throws Exception;
	public abstract List<StudentListDTO> searchStudentList(String type, String value) throws Exception;
//	public abstract boolean readStudentEmailExist(String studentId) throws Exception;
	
	public abstract DetailStudentDTO readStudentData(String id)throws Exception;
	public abstract void insertStudentData(StudentVO vo)throws UnsupportedEncodingException;
	public void updateStudentByAdmin(String target_id, String id, String name, String birthday, String mobile_phone, String temporarily_number,String address, String detail_address,String course_code,String state);
	public void updateStudentByStudent(String target_id, String id, String mobile_phone, String temporarily_number,String password,String address, String detail_address);
	public List<StudentVO> listCriteria(Criteria criteria) throws Exception;
	int listCountCriteria(Criteria criteria) throws Exception;
	public int idExist(String id);



}

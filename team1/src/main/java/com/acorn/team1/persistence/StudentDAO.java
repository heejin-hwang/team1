package com.acorn.team1.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;


import com.acorn.team1.controller.Criteria;
import com.acorn.team1.domain.CourseDTO;
import com.acorn.team1.domain.DetailStudentDTO;
import com.acorn.team1.domain.StudentFindDTO;
import com.acorn.team1.domain.StudentListDTO;
import com.acorn.team1.domain.StudentVO;
import com.acorn.team1.domain.UpdateStudentByAdminDTO;


@Repository
public interface StudentDAO {

	
	public abstract List<CourseDTO> readCourseList() throws Exception;
	public abstract List<StudentListDTO> readStudentList() throws Exception;
	public abstract List<StudentListDTO> searchStudentList(String type, String value) throws Exception;
	public DetailStudentDTO readStudentData(StudentFindDTO dto) throws Exception;
	public int readIdExist(StudentFindDTO dto);
	public void insertStudentData(StudentVO vo);
	public void updateStudentByAdmin(UpdateStudentByAdminDTO usdto);
	public void updateStudentByStudent(UpdateStudentByAdminDTO usdto);
	public List<StudentVO> listCriteria(Criteria criteria) throws Exception;
	public int countPaging(Criteria criteria) throws Exception;
}

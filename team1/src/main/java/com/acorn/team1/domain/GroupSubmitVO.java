package com.acorn.team1.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class GroupSubmitVO {

	// tbl_assignment	
	private Integer a_id; 
	private String a_name;
	private String a_description;
	private String a_startdate;
	private String a_enddate;
	private Integer a_coursecode;
	private String a_adminId;
	
	// tbl_groups
	private Integer g_id;
	private String g_name;
	private Integer g_coursecode;
	private String g_adminId;
	
	// tbl_submit
	private Integer s_id;
	private String s_uploaddate;
	private Integer s_coursecode;
	private Integer s_assignmentId;
	private Integer s_groupsId;
	
	// tbl_fileupload
	private Integer f_id;
	private String f_namekey;
	private String f_name;
	private String f_path;
	private String f_size;
	private Integer f_groupId;
	private Integer f_submitId;
	
} // end class

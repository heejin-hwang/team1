package com.acorn.team1.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudentVO {

	
	
	private String id;
	private String name;
	private String birthday;
	private String mobile_phone;
	private String temporarily_number;
	private String password;
	private String address;
	private String detail_address;
	private String job_id;
	//private String session_limit;
	//private String session_key;
	private Boolean pw_checked;
	private String state;
	private String course_code;
	
}

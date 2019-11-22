package com.acorn.team1.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginUserVO { //세션에 보관할 용도
	
	private String id;
	private String password;
	private String job_id;
	private String name;
	private String birthday;
	private String session_key;
	private String state;
	private Timestamp session_limit;
	private boolean pw_checked;
	private String course_name;
	private int course_code;
	private Timestamp start_date;
	private Timestamp end_date;
	private String mobile_phone;
	private String temporarily_number;
	private String address;
	private String detail_address;
	
	
}

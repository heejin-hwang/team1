package com.acorn.team1.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyPageVO {

	private String id;
	private String password;
	private String name;
	private Timestamp start_date_time;
	private Timestamp end_date_time;
	private int course_code;
	private String student_id;
	private String student_name;
	private String admin_id;
	private boolean start_checked;
	private boolean end_checked;
	private String attendance_key;
	private String state;
	private String address;
	private String detail_address;
	private String mobile_phone;
	private String temporarily_number;
	private int score;
	private int test_id;
	private Timestamp date;
	


}

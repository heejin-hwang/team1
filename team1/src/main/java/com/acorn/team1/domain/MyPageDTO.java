                          package com.acorn.team1.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyPageDTO {
	
	private Timestamp start_date_time;
	private int course_code;
	private int code;
	private String id;
	private String admin;
	private boolean start_checked;
	private boolean end_checked;
	private String userId;
	public Timestamp end_date_time;
	private String address;
	private String detail_address;
	private String mobile_phone;
	private String temporarily_number;
	private String password;
	private String categorize;
	public String score;
	public int test_id;
	private String admin_id;
	private String pass;
	
	
}

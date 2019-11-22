package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateStudentByAdminDTO {
	
	private String target_id;
	private String id;
	private String name;
	private String birthday;
	private String mobile_phone;
	private String temporarily_number;
	private String address;
	private String detail_address;
	private String course_code;
	private String state;
}

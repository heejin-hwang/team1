package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateStudentByStudentDTO {
	
	
	private String target_id;
	private String id;
	private String mobile_phone;
	private String temporarily_number;
	private String password;
	private String address;
	private String detail_address;
	
}

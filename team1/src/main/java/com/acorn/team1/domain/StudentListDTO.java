package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudentListDTO {

	private String id;
	private String name;
	private String course_name;
	private String course_code;
	private String state;
	private int attendence;
}

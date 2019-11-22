package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudentListVO {

	
	private String id;
	private String name;
	private String course_name;
	private String groups_name;
	private int course_code;
	//private int groups_id;
}

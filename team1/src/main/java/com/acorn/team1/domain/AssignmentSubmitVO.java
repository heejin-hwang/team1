package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AssignmentSubmitVO {

	private String upload_date;
	private Integer course_code;
	private Integer assignment_id;
	private Integer groups_id;
	
	private Integer id;
	private String name_key;
	private String name;
	private String path;
	private String size;
	private Integer submit_id;
	
}

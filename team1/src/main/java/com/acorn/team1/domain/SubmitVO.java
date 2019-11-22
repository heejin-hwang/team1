package com.acorn.team1.domain;

import lombok.Data;

import lombok.AllArgsConstructor;

import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class SubmitVO {

	private Integer id;
	private String upload_date;
	private Integer course_code;
	private Integer assignment_id;
	private Integer groups_id;
	
} // end class

package com.acorn.team1.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssignmentDTO {
	
	private int id;
	private String name;
	private String description;
	private String end_date;
	private String course_code;
	private String admin_id;
	
}

package com.acorn.team1.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssignmentVO {
	
	private Integer id;					// assignment id
	private String name;				// assignment name
	private String description;			// assignment description
	private String start_date;			// assignment upload date
	private String end_date;				// assignment due date
			
	private Integer course_code;		// course code
	private String admin_id;			// teacher id
	
}

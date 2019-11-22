package com.acorn.team1.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ScheduleVO {
	
	private Integer id;
	private String subject;
	private String categorize;
	private Date start_date;
	private Date end_date;
	private String course_code;
	private String admin_id;
	
} // end class

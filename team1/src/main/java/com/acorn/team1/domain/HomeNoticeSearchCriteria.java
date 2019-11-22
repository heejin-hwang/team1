package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HomeNoticeSearchCriteria extends HomeNoticeCriteria {

	private String searchType;
	private String keyword;
	private String scategorize;
	private int scourse_code;
	private String job_id;
	private String admin_id;
	private String student_id;
	private int course_code;
//	private int code;


}

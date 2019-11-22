package com.acorn.team1.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {
	
	private int id;
	private String subject;
	private String categorize;
	private String file;
	private String context;
	private Date start_date;
	
	private Date end_date;
	private int course_code;
	private String admin_id;
	private Date upload_date;
	private Date update_date;
	private int hits;
	private String course_name;
	private String name;
	
	List<FileVO> files;
} // end Notice_BoardVO

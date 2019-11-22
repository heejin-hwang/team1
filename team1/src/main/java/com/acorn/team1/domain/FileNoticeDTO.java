package com.acorn.team1.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileNoticeDTO {

	private int id;
	private String subject;
	private String categorize;
	private String context;
	private int course_code;
	private String admin_id;
	private Date update_date;
	private String course_name;
	private String name;

	private String search_type;
	private String nt_file;
	private List<Integer> delete_file;
}	//FileBoardDTO

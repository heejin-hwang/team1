package com.acorn.team1.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileVO {

	private int id;
	private String name_key;
	private String name;
	private String path;
	private String size;
	private String admin_id;
	private Date upload_date;
	private Date update_date;
	private int notice_id;
	private int fileboard_id;
	private int submit_id;
	
} // end class

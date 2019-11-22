package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AssignmentSubmitDTO {

	// tbl_fileupload
//	private Integer id;
	private String name_key;
	private String name;
	private String path;
	private String size;
	private Integer group_id;
//		private Integer submit_id;

	// tbl_submit
	private Integer course_code;
	private Integer assignment_id;
	private Integer groups_id;

}

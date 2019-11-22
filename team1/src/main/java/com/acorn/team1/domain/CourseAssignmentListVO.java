package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseAssignmentListVO {
	
	// tbl_groups
	private Integer gid;				// id
	private String gname;				// name
	private Integer gccode;				// code
	private String gaid;				// admin_id
	
	// tbl_assignment	
	private Integer aid;				// id
	private String aname;				// name
	private String adescription;		// description
	private String astart;				// start_date
	private String aend;				// end_date
	private int accode;					// course_code
	private String aadminId;			// admin_id

}

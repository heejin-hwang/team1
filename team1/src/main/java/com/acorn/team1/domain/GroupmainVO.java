package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GroupmainVO {

	// tbl_groups
	private int gid;				// id
	private String gname;			// name
	private int gccode;				// course_code
	private String gaid;			// groups_id
	
	// tbl_student
	private int sid; 				// id
	private String sname;			// name
	private int sccode;				// course_code
	private int sgid;				// groups_id
	
	// tbl_assignment
	private int aid;				// id
	private String aname;			// name
	private String adescription;	// description
	private String astart;			// start_date
	private String aend;			// end_date
	private int accode;				// course_code
	private String aadminid;		// admin_id
	
} // end class
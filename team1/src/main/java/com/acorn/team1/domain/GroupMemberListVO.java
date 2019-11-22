package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GroupMemberListVO {
	
	// tbl_groups
	private Integer gid;
	private String gname;
	private Integer gccode;
	private String gaid;
	
	// tbl_student
	private String sid;
	private String sname;
	private Integer sccode;
	private String sgid;	
	
} // end class

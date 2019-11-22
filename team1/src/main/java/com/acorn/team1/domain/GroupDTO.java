package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GroupDTO {
	
	private String groupName;
	private Integer courseCode;
	private String adminId;
	private String registerList;
	private String editList;
	private String addList;
	private String groupsId;
	private String studentId;
	private String courseName;

}

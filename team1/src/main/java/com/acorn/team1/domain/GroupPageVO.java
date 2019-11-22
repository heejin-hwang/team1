package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GroupPageVO {
	
	private Integer gid;
	private String gname;
	private Integer gccode;
	private String gaid;
	private String cname;
	private String cstate;
	private String sid;

}

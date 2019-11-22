package com.acorn.team1.domain;

import lombok.Data;

@Data
public class SearchCriteria extends Criteria {

	private String searchType;
	private String keyword;
	private String scategorize;
	private int scourse_code;
	private String cstate;
	private String sadmin_id;
}

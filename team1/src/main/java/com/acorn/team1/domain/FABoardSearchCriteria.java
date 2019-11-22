package com.acorn.team1.domain;

import lombok.Data;


public class FABoardSearchCriteria extends FABoardCriteria{

	private String searchType;
	private String keyword;
	
	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType =searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword =keyword;
	}

//	@Override
//	public String toString() {
//		return super.toString()
//				+ "HomeNoticeSearchCriteria" 
//				+ "[searchType=" +searchType 
//				+ ",keyword=" +keyword + "]";
//	}
}

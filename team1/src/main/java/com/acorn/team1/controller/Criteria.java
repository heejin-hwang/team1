package com.acorn.team1.controller;

public class Criteria {
	
	

	private int page = 1;
	private int perPageNum = 10;
	private String type = null;
	private String value= null;
	
	private String name;
	private String birthday;
	private String course_name;
	// private String state;
	
	
	
	
	public void setPage(int page) {
		
		if(page <= 0) {
			this.page =1;
			return;
		}
		
		this.page = page;
	}
	
	public int getPage() {
		return page;
	}
	
	public void setPerPageNum(int perPageNum) {
		
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		
		this.perPageNum = perPageNum;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public int getPageStart() {
		return (this.page -1) * perPageNum;
	}
	public void setType(String type) {
		this.type = type;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getType() {
		return type;
	}
	public String getValue() {
		return value;
	}
}

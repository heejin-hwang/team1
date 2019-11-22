package com.acorn.team1.domain;

//페이징 처리를 위한 클래스
public class Criteria {
	
	private int page=1;
	
	private int perPageNum=10;
	
	//페이지 설정
	public void setPage(int page) {
		if(page<=0) {
			this.page=1;
			return ;
		} // if
		this.page = page;
	}//setPage
	
	//페이지당 나올 게시물 수 설정
	public void setPerPageNum(int perPageNum) {
		if(perPageNum<=0 || perPageNum > 10) {
			this.perPageNum = 10;
			return;
		} // if
		this.perPageNum = perPageNum;
	} //setPerPageNum
	
	
	public int getPageStart() {
		return (this.page -1)*perPageNum;
	} //getPageStart
	
	public int getPage() {
		return this.page;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}

	
} // end-class

package com.acorn.team1.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class FABoardPageMaker {

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int displayPageNum = 10; 
	
	private FABoardCriteria cri;
	
	public void setCri(FABoardCriteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount=totalCount;
		
		calcData();
	}
	
	private void calcData() {
		endPage =(int)(Math.ceil(cri.getPage()/(double) displayPageNum) * displayPageNum);
		
		startPage = (endPage - displayPageNum)+1;
		
		int tempEndPage =(int)(Math.ceil(totalCount/(double) cri.getPerPageNum()));
		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
			
		}
		
		prev = startPage ==1? false : true;
		next = endPage*cri.getPerPageNum() >=totalCount ? false:true;
	}
	
	public String makeQuery(int page) {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.queryParam("page",page)
				.queryParam("perPageNum",cri.getPerPageNum())
				.build();
		
		return uriComponents.toUriString();
	}

	public String makeSearch(int page) {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.queryParam("page",page)
				.queryParam("perPageNum",cri.getPerPageNum())
				.queryParam("searchType",((FABoardSearchCriteria)cri).getSearchType())
				.queryParam("keyword",((FABoardSearchCriteria)cri).getKeyword())
				.build();
		
		return uriComponents.toUriString();
	}
	
}

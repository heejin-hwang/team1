package com.acorn.team1.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.acorn.team1.domain.Criteria;
import com.acorn.team1.domain.SearchCriteria;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NpageMaker  {

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean pot;
	private boolean prev;
	private boolean next;
	private boolean pprev;
	private boolean nnext;
	
	private int displayPageNum = 5;
	
	@Setter
	private Criteria cri;
	@Setter
	private SearchCriteria scri;
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		pot = this.totalCount == 0 ? true : false; // 검색 결과가 없을때
		calcData();
	} //setTotalCount

	/*-------------------------------------page count----------------------------------------------------------*/
	public void calcData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum); 
		startPage = (endPage - displayPageNum) +1;
		
		int tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		} //if
		//검색 시 page 초기화
		if(cri.getPage() > endPage) {
			cri.setPage(1);
		} //if
		prev = cri.getPage() <= 1 ? false : true;
		next = cri.getPage() >= endPage ? false: true;
		pprev = startPage ==1 ? false : true;
		nnext = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	} //calcDate()
	
	/*-------------------------------------search----------------------------------------------------------*/
	public String makeSearch(int page) {
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance().
				queryParam("Scourse_code",((SearchCriteria)cri).getScourse_code()).
				queryParam("Scategorize", ((SearchCriteria)cri).getScategorize()).
				queryParam("searchType",((SearchCriteria)cri).getSearchType()).
				queryParam("keyword",((SearchCriteria)cri).getKeyword()).
				queryParam("page", page).
				queryParam("perPageNum", cri.getPerPageNum()).
				build();
		return uriComponents.toUriString();
	}
	/*-------------------------------------uri setting(검색 기본값이 따라다니게 하는 역할)----------------------------------------------------*/
	public String makeUri() throws UnsupportedEncodingException {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().
				queryParam("Scourse_code", ((SearchCriteria)cri).getScourse_code()).
				queryParam("Scategorize",  URLEncoder.encode( ((SearchCriteria)cri).getScategorize() , "UTF-8") ).
				queryParam("searchType",URLEncoder.encode( ((SearchCriteria)cri).getSearchType() , "UTF-8") ).
				queryParam("keyword",URLEncoder.encode( ((SearchCriteria)cri).getKeyword() , "UTF-8") ).
				queryParam("page", cri.getPage()).
				queryParam("perPageNum", cri.getPerPageNum()).
				build();
		return uriComponents.toUriString();
	}
} //end-class

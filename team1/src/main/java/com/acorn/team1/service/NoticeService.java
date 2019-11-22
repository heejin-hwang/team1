package com.acorn.team1.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.acorn.team1.domain.FileDTO;
import com.acorn.team1.domain.FileVO;
import com.acorn.team1.domain.NoticeDTO;
import com.acorn.team1.domain.NoticeVO;
import com.acorn.team1.domain.SearchCriteria;


public interface NoticeService {

	/*--------------------------------검색 및 페이징 // 게시글 리스트 보기----------------------------------------------*/
	public List<NoticeVO> listSearch(SearchCriteria cri, HttpSession session) throws Exception;
	
	/*----------------------------페이징 처리--------------------------------------------*/
	public NpageMaker paging(SearchCriteria cri) throws Exception;

	/*----------------------------게시글 추가--------------------------------------------*/
	public abstract String create(NoticeDTO dto, MultipartFile[] files) throws Exception;

	/*----------------------------게시글 내용 보기--------------------------------------------*/
	public abstract NoticeVO read(int id) throws Exception;

	/*----------------------------게시글 수정--------------------------------------------*/
	public abstract String update(NoticeDTO dto, MultipartFile[] files) throws Exception;

	/*----------------------------게시글 삭제--------------------------------------------*/
	public abstract String delete(int id) throws Exception;

	/*----------------------------조회수 증가------------------------------------------*/
	public void increaseHits(int id) throws Exception;
	
	/*----------------------------게시글 파일 첨부--------------------------------------------*/
	List<FileDTO> insertFileInfo(NoticeDTO dto, MultipartFile[] files) throws Exception;

	/*---------------------------- check Notice--------------------------------------------*/
	public int check_notice(int notice_id)throws Exception;

} // end interface

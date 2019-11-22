package com.acorn.team1.persistence;

import java.util.List;

import com.acorn.team1.domain.FileDTO;
import com.acorn.team1.domain.FileVO;
import com.acorn.team1.domain.FileNoticeDTO;
import com.acorn.team1.domain.FileNoticeVO;
import com.acorn.team1.domain.SearchCriteria;

public interface FileNoticeDAO {


	/*----------------------------검색기능 // 게시글 목록 보기--------------------------------------------*/
	public List<FileNoticeVO> listSearch(SearchCriteria cri)throws Exception;
	
	/*----------------------------게시글 추가--------------------------------------------*/
	public abstract int create(FileNoticeDTO dto) throws Exception;
	/*게시판 - 파일 등록*/
	public abstract int insertFile(FileDTO FileDTO) throws Exception;
	
	/*----------------------------게시글 내용 보기--------------------------------------------*/
	public abstract FileNoticeVO read(int id) throws Exception;
	/*게시판 - 첨부 파일 조회*/
	List<FileVO> getFileNoticeFileList(int fileboard_id) throws Exception;
	
	/*----------------------------게시글 수정--------------------------------------------*/
	public abstract int update(FileNoticeDTO dto) throws Exception;
	
	/*----------------------------게시글 삭제--------------------------------------------*/
	public abstract int delete(int id) throws Exception;
	
	/*게시판 - 첨부파일 삭제*/
	public abstract int deleteFileNoticeFile(FileDTO FileDTO) throws Exception;
	
	/*----------------------------조회수 증가------------------------------------------*/
	public void increaseHits(int id) throws Exception;
	
	/*----------------------------페이징 숫자세기--------------------------------------------*/
	public int listSearchCount(SearchCriteria cri)throws Exception;

	/*---------------------------- check Notice--------------------------------------------*/
	public int check_filenotice(int fileboard_id)throws Exception;


}

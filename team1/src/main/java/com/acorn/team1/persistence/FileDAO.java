package com.acorn.team1.persistence;

import java.util.List;

import com.acorn.team1.domain.FileVO;

public interface FileDAO {
	
/*======================= 특정 파일의 모든 정보를 불러온다. ===============================*/
	public abstract FileVO file_info(int file_id);
	
/*======================= 특정 글에 포함된 파일들의 이름 키와 경로를 받아온다. ===============================*/
	public abstract List<FileVO> getFile(int notice_id);
	
/*======================= 특정 글에 포함된 파일들의 이름 키와 경로를 받아온다. ===============================*/
	public abstract List<FileVO> getFN_File(int filenotice_id);
}

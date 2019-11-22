package com.acorn.team1.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.FileVO;

@Repository
public class FileDAOImpl implements FileDAO {

	@Inject
	private SqlSession sqlSession;
	
	private String namespace = "com.acorn.team1.mapper.FileMapper";
	
	/*======================= 특정 파일의 모든 정보를 불러온다. ===============================*/
	@Override
	public FileVO file_info(int file_id) {
		
		return sqlSession.selectOne(namespace+".searchFile_info", file_id);
	}	
	
	/*======================= 특정 글에 포함된 파일들의 이름 키와 경로를 받아온다. ===============================*/

	/*Notice 글*/
	@Override
	public List<FileVO> getFile(int notice_id) {
	
		return sqlSession.selectList(namespace+".searchFile", notice_id);
	}
	
	/*fileNotice 글*/
	@Override
	public List<FileVO> getFN_File(int filenotice_id) {
	
		return sqlSession.selectList(namespace+".searchFN_file", filenotice_id);
	}

}

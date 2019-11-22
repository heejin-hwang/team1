package com.acorn.team1.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.FileNoticeDTO;
import com.acorn.team1.domain.FileNoticeVO;
import com.acorn.team1.domain.FileDTO;
import com.acorn.team1.domain.FileVO;
import com.acorn.team1.domain.SearchCriteria;

@Repository
public class FileNoticeDAOImpl implements FileNoticeDAO {

	@Inject
	private SqlSession sqlSession;
	
	private String namespace="com.acorn.team1.mapper.FileNoticeMapper";
	
	/*--------------------------------검색 기능-------------------------------------------------*/
	@Override
	public List<FileNoticeVO> listSearch(SearchCriteria cri) throws Exception {
		
		return sqlSession.selectList(namespace+".listSearch", cri);
	}

	/*----------------------------페이징 숫자세기--------------------------------------------*/
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
	
		return sqlSession.selectOne(namespace+".listSearchCount", cri);
	}
	
	/*----------------------------게시글 추가--------------------------------------------*/
	@Override
	public int create(FileNoticeDTO dto) throws Exception {
		
		return sqlSession.insert(namespace + ".create", dto);
	}

	/*게시판 - 파일 등록*/
	@Override
	public int insertFile(FileDTO FileDTO) throws Exception {
		
		return sqlSession.insert(namespace + ".insertFile", FileDTO);
	}

	/*----------------------------게시글 내용 보기--------------------------------------------*/
	@Override
	public FileNoticeVO read(int id) throws Exception {
	
		return sqlSession.selectOne(namespace + ".read", id);
	}

	/*게시판 - 첨부 파일 조회*/
	@Override
	public List<FileVO> getFileNoticeFileList(int fileboard_id) throws Exception {
		
		return sqlSession.selectList(namespace + ".getFileNoticeFileList", fileboard_id);
	}

	/*----------------------------게시글 수정--------------------------------------------*/
	@Override
	public int update(FileNoticeDTO dto) throws Exception {
		
		return sqlSession.update(namespace + ".update", dto);
	}

	/*----------------------------게시글 삭제--------------------------------------------*/
	@Override
	public int delete(int id) throws Exception {
		
		return sqlSession.delete(namespace + ".delete", id);
	}

	/*게시판 - 첨부파일 삭제*/
	@Override
	public int deleteFileNoticeFile(FileDTO FileDTO) throws Exception {
		
		return sqlSession.delete(namespace +".deleteFileNoticeFile", FileDTO);
	}

	/*----------------------------조회수 증가------------------------------------------*/
	@Override
	public void increaseHits(int id) throws Exception {
		sqlSession.update(namespace + ".increaseHits", id);
	}

	/*===================== check Notice =======================*/
	@Override
	public int check_filenotice(int fileboard_id) throws Exception {
		
		return sqlSession.selectOne(namespace+".checkFileNotice", fileboard_id);
	}

}

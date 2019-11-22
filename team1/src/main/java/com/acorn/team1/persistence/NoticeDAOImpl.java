package com.acorn.team1.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.FileDTO;
import com.acorn.team1.domain.FileVO;
import com.acorn.team1.domain.NoticeDTO;
import com.acorn.team1.domain.NoticeVO;
import com.acorn.team1.domain.SearchCriteria;

import lombok.Setter;


@Repository
public class NoticeDAOImpl 
	implements NoticeDAO {
	
	@Setter(onMethod_ = {@Autowired})
	private SqlSession sqlSession;
	
	private final String namespace = "com.acorn.team1.mapper.NoticeMapper";
	
	/*--------------------------------검색 기능-------------------------------------------------*/
	@Override
	public List<NoticeVO> listSearch(SearchCriteria cri) throws Exception {
		
		return sqlSession.selectList(namespace+".listSearch", cri);
	}

	/*----------------------------페이징 숫자세기--------------------------------------------*/
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		
		return sqlSession.selectOne(namespace+".listSearchCount", cri);
	}
	
	/*----------------------------게시글 추가--------------------------------------------*/
	@Override
	public int create(NoticeDTO dto) 
			throws Exception {
		
		return sqlSession.insert(namespace + ".create", dto);

	}
	/*게시판 - 파일 등록*/
	@Override
	public int insertFile(FileDTO FileDTO) throws Exception {
		
		return sqlSession.insert(namespace + ".insertFile", FileDTO);
	}

	/*----------------------------게시글 내용 보기--------------------------------------------*/
	@Override
	public NoticeVO read(int id) 
			throws Exception {
	
		return sqlSession.selectOne(namespace + ".read", id);
		
	}
	/*게시판 - 첨부 파일 조회*/
	@Override
	public List<FileVO> getNoticeFileList(int notice_id) throws Exception {
		
		return sqlSession.selectList(namespace + ".getNoticeFileList", notice_id);
	}

	/*----------------------------게시글 수정--------------------------------------------*/
	@Override
	public int update(NoticeDTO dto) 
			throws Exception {
		
		return sqlSession.update(namespace + ".update", dto);
		
	}

	/*----------------------------게시글 삭제--------------------------------------------*/
	@Override
	public int delete(int id) 
			throws Exception {
		
		return sqlSession.delete(namespace + ".delete", id);
		
	}
	/*게시판 - 첨부파일 삭제*/
	@Override
	public int deleteNoticeFile(FileDTO FileDTO) throws Exception {
		return sqlSession.delete(namespace +".deleteNoticeFile", FileDTO);
	}

	/*----------------------------조회수 증가------------------------------------------*/
	@Override
	public void increaseHits(int id) 
			throws Exception {
		
		sqlSession.update(namespace + ".increaseHits", id);
		
	}

	/*===================== check Notice =======================*/
	@Override
	public int check_notice(int notice_id) throws Exception {
		
		return sqlSession.selectOne(namespace+".checkNotice", notice_id);
	}

} // end class

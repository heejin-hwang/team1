package com.acorn.team1.service;

import java.io.File;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.io.Resources;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.acorn.team1.domain.FileDTO;
import com.acorn.team1.domain.FileNoticeDTO;
import com.acorn.team1.domain.FileNoticeVO;
import com.acorn.team1.domain.FileVO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.SearchCriteria;
import com.acorn.team1.persistence.AdminDAO;
import com.acorn.team1.persistence.CourseDAO;
import com.acorn.team1.persistence.FileDAO;
import com.acorn.team1.persistence.FileNoticeDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FileNoticeServiceImpl implements FileNoticeService {

	@Inject
	private FileNoticeDAO dao;
	@Inject
	private CourseDAO Cdao;
	@Inject
	private AdminDAO Adao;
	@Inject
	private FileDAO Fdao;
	
	/*파일 첨부를 위한 설정*/
	private List<FileDTO> fileList = null;
	/*해당 기능을 구현한 후 결과를 도출하기 위한 작업*/
	private String result;
	
	private String resource = "fileupload.properties";
	private Properties properties = new Properties();
	
	
	/*----------------------------검색기능 및 게시글 목록 보기--------------------------------------------*/
	@Override
	public List<FileNoticeVO> listSearch(SearchCriteria cri, HttpSession session) throws Exception {
		
		/*------------------------------session에서 job_id를 통해 분별---------------------------------*/
		LoginUserVO vo = (LoginUserVO) session.getAttribute("login");
		String job_id = vo.getJob_id();
	
		if(job_id.equals("2")) {
			String sadmin_id = vo.getId();	//강사일 때만 사용
			cri.setSadmin_id(sadmin_id);
		}else if(job_id.equals("4")) {
			int code = vo.getCourse_code();	// 학생 일 때만 사용
			cri.setScourse_code( code );
		}
		return dao.listSearch(cri);
	
	} //listSearch
	
	
/*---------------------------- 페이징 처리 --------------------------------------------*/
	@Override
	public NpageMaker paging(SearchCriteria cri) throws Exception {
		NpageMaker pageMaker = new NpageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.listSearchCount(cri));
		return pageMaker;
	} //listSearchCount

/*----------------------------게시글 추가--------------------------------------------*/
	@Transactional
	@Override
	public String create(FileNoticeDTO dto) throws Exception {
		
		/*=== 특수문자를 지정해줘서 스크립트 공격 방어 ===*/
		String subject = dto.getSubject();
		String context = dto.getContext();
		subject = subject.replace("<", "&lt;");
		subject = subject.replace(">", "&gt;");
		context = context.replace("<", "&lt;");
		context = context.replace(">", "&gt;");
		dto.setSubject(subject);
		dto.setContext(context);
	
		/*=== 자동적으로 admin_id를 등록 ===*/
		String admin_id = Adao.searchId(dto.getName());
		
		dto.setAdmin_id(admin_id);	
		
		/*=== create ===*/
		int insertCnt = 0;
		insertCnt = dao.create(dto);
		
		String result = null;
		if (insertCnt > 0) {
			result = "SUCCESS";
		} else {
			result = "FAIL";
		}	//if-else

		/*==== Insert Files ====*/
		if (fileList != null) {
			for (FileDTO fileDTO : fileList) {
				fileDTO.setAdmin_id(dto.getAdmin_id() );
				fileDTO.setFileboard_id(dto.getId() );
				dao.insertFile(fileDTO);
			}
			fileList=null;
		}	//if-else
	
		return result;
		
	} // create

/*---------------------------- 게시글 내용 보기 --------------------------------------------*/
	@Override
	public FileNoticeVO read(int id) throws Exception {
		
		/*=== FileNotice Search ===*/
		FileNoticeVO vo = dao.read(id);
		/*=== 반 이름을 자동적으로 나타내기 위한 작업 ===*/
		vo.setCourse_name(Cdao.selectedCourse_name(vo.getCourse_code()));
		
		/*=== file Search ===*/
		List<FileVO> filechk = dao.getFileNoticeFileList(id);
	
		if(filechk != null) {
			vo.setFiles(dao.getFileNoticeFileList(id));
		}
		
		return vo;
	} // read

/*---------------------------- 게시글 수정 --------------------------------------------*/
	@Transactional
	@Override
	public String update(FileNoticeDTO dto) throws Exception {
		
		Reader reader = Resources.getResourceAsReader(resource);
		properties.load(reader);
		
		/*==== 특수문자를 지정해줘서 스크립트 공격 방어 ====*/
		String subject = dto.getSubject();
		String context = dto.getContext();
		subject = subject.replace("<", "&lt;");
		subject = subject.replace(">", "&gt;");
		context = context.replace("<", "&lt;");
		context = context.replace(">", "&gt;");
		dto.setSubject(subject);
		dto.setContext(context);
		
		/*=== 자동적으로 admin_id를 등록 ===*/
		String admin_id = Adao.searchId(dto.getName());
		
		dto.setAdmin_id(admin_id);	
		
		/*=== delete Files ===*/
		int filenotice_id = dto.getId();
		
		List<Integer> deleteFile = dto.getDelete_file();
		if(!deleteFile.isEmpty()) {
			
			for(int file_id : deleteFile) {
				
				/*== 저장소에 있는 해당 파일 삭제 작업*/
				FileVO fileVo = Fdao.file_info(file_id);
				
				File file = new File(properties.getProperty("uploadPath")+fileVo.getPath(), fileVo.getName_key());
				file.delete();
				
				/*== DB에 저장되어 있는 file정보 제거 ==*/
				FileDTO deleteFileDTO = new FileDTO();
				deleteFileDTO.setFileboard_id(filenotice_id);
				deleteFileDTO.setId(file_id);
				
				dao.deleteFileNoticeFile(deleteFileDTO);
			}	//for
		}	//if
		/*=== Insert Files ===*/
			if (fileList != null) {
				for (FileDTO fileDTO : fileList) {
					fileDTO.setAdmin_id(dto.getAdmin_id() );
					fileDTO.setFileboard_id(filenotice_id );
					dao.insertFile(fileDTO);
				}
				fileList=null;
		}// if

		/*=== Result ===*/
		int insertCnt = 0;
		insertCnt = dao.update(dto);
		
		if (insertCnt > 0) {
			result = "SUCCESS";
		} else {
			result = "FAIL";
		}	//if-else
		
		return result;
	
	} // update
	
	
/*---------------------------- 게시글 파일 첨부 --------------------------------------------*/
	@Override
	public List<FileDTO> insertFileInfo(MultipartFile[] files) throws Exception {
		
		Reader reader = Resources.getResourceAsReader(resource);
		properties.load(reader);
		
		FileDTO fileDTO = new FileDTO();

		List<FileDTO> fileList = new ArrayList<FileDTO>();
		
		Date today = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
		
		String fileName = null;
		String fileExt = null;
		String fileNameKey = null;
		String fileSize = null;
		String fileSaveFolder = date.format(today);
		
		// 파일이 저장될 Path 경로 설정 임시파일을 거쳐 실제 저장소에 저장
		String uploadTempFilePath = properties.getProperty("uploadTempFilePath");
		String uploadTargetFilePath = properties.getProperty("uploadPath")+fileSaveFolder;
		
		if (files != null && files.length > 0 ) {

			File TempDirFile = new File(uploadTempFilePath);
			File DirFile = new File(uploadTargetFilePath);

			// 디렉토리가 없으면 생성
			TempDirFile.mkdirs();
			DirFile.mkdirs();
			
			/*= files insert =*/
			for (MultipartFile multipartFile : files) {
				
				// 업로드 한 파일의 이름을 구함
				fileName = multipartFile.getOriginalFilename();
				/*== file 이름이 없다는 것은 파일이 존재하지 않는다 ==*/
				if(fileName == "".toString()) {
					
					return null;
				}

				File file = new File(uploadTempFilePath +"/"+ fileName);
				
				multipartFile.transferTo(file);
				
				/*== 파일 확장자 명이 붙여지지 않는 파일이 있을 경우 insert를 실패하게 하는 작업 ==*/
				if(fileName.lastIndexOf(".") <0) {
					
					return null;
				}
				
				fileExt = fileName.substring(fileName.lastIndexOf("."));
				
				// 파일명 변경(UUID로 암호화) + 확장자
				fileNameKey = getRandomString() + fileExt;
				// 업로드한 파일의 크기를 구함
				fileSize = String.valueOf(multipartFile.getSize());

				// 폴더 경로와 이름 설정
				File fileNew = new File(uploadTargetFilePath +"/"+ fileNameKey);
				
				// 설정한 Path에 파일 저장
				file.renameTo(fileNew);
				
				fileDTO = new FileDTO();
				fileDTO.setName(fileName);
				fileDTO.setName_key(fileNameKey);
				fileDTO.setPath(fileSaveFolder);
				fileDTO.setSize(fileSize);
				
				fileList.add(fileDTO);

			} // for
		} // if

		return fileList;
	}

/*---------------------------- 게시글 삭제 --------------------------------------------*/
	@Override
	public String delete(int id) throws Exception {
		
		Reader reader = Resources.getResourceAsReader(resource);
		properties.load(reader);
		
		/*=== 게시글의 포함된 파일 삭제 ===*/
		List<FileVO> files = Fdao.getFN_File(id);
		for(FileVO Notice_file : files) {
			File file = new File(properties.getProperty("uploadPath")+Notice_file.getPath(), Notice_file.getName_key());
			file.delete();
		}
	
		/*게시글 삭제*/
		int insertCnt = 0;
		insertCnt = dao.delete(id);

		if (insertCnt > 0) {
			result = "Delete_SUCCESS";
		} else {
			result = "FAIL";
		}
		
		return result;
	} // delete

/*---------------------------- 조회수 증가 ------------------------------------------*/
	@Override
	public void increaseHits(int id) throws Exception {
		dao.increaseHits(id);
	} //increaseHits


/*---------------------------- 랜덤한 숫자 값 생성 ----------------------------*/
	public String getRandomString() {

		return UUID.randomUUID().toString().replaceAll("-", "");
	}

/*===================== check Notice =======================*/
	@Override
	public int check_filenotice(int filenotice_id) throws Exception {
		
		return dao.check_filenotice(filenotice_id);
	}
	
/*======================= file drag&drop or  button click after ==========================*/
	@Override
	public void dragInsert(MultipartFile[] files) throws Exception {
			
			if(files!=null) {
				fileList = insertFileInfo(files);
			}
		}
}

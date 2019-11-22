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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.acorn.team1.domain.FileDTO;
import com.acorn.team1.domain.FileVO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.domain.NoticeDTO;
import com.acorn.team1.domain.NoticeVO;
import com.acorn.team1.domain.SearchCriteria;
import com.acorn.team1.persistence.AdminDAO;
import com.acorn.team1.persistence.CourseDAO;
import com.acorn.team1.persistence.FileDAO;
import com.acorn.team1.persistence.NoticeDAO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class NoticeServiceImpl 
	implements NoticeService {

	@Setter(onMethod_= {@Autowired})
	private NoticeDAO dao;
	@Inject
	private CourseDAO Cdao;
	@Inject
	private AdminDAO Adao;
	@Inject
	private FileDAO Fdao;
	
	
	private String result;
	
	private String resource = "fileupload.properties";
	private Properties properties = new Properties();
	
	/*----------------------------검색기능 및 게시글 목록 보기--------------------------------------------*/
	@Override
	public List<NoticeVO> listSearch(SearchCriteria cri, HttpSession session) throws Exception {
		
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
	
	
	/*----------------------------페이징 처리--------------------------------------------*/
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
	public String create(NoticeDTO dto, MultipartFile[] files) throws Exception {
		
	/*==========================특수문자를 지정해줘서 스크립트 공격 방어======================*/
		String subject = dto.getSubject();
		String context = dto.getContext();
		subject = subject.replace("<", "&lt;");
		subject = subject.replace(">", "&gt;");
		context = context.replace("<", "&lt;");
		context = context.replace(">", "&gt;");
		dto.setSubject(subject);
		dto.setContext(context);
	
/*==========================자동적으로 admin_id를 등록======================*/
		String admin_id = Adao.searchId(dto.getName());
		
		dto.setAdmin_id(admin_id);	
		
/*=========================Result======================*/
		int insertCnt = 0;
		insertCnt = dao.create(dto);
		
		String result = null;
		if (insertCnt > 0) {
			result = "SUCCESS";
		} else {
			result = "FAIL";
		}

/*==========================Insert Files======================*/
		if(files!=null) {
			List<FileDTO> fileList = insertFileInfo(dto,files);
			if (fileList != null) {
				for (FileDTO fileDTO : fileList) {
					dao.insertFile(fileDTO);
				}
			}
		}
		
		return result;
		
	} // create

	/*----------------------------게시글 내용 보기--------------------------------------------*/
	@Override
	public NoticeVO read(int id) throws Exception {
		
		/*=== Notice Search ===*/
		NoticeVO vo = dao.read(id);
		vo.setCourse_name(Cdao.selectedCourse_name(vo.getCourse_code()));
		
		/*=== file Search ===*/
		List<FileVO> filechk;
		
		filechk = dao.getNoticeFileList(id);
		log.info("filechk :" + filechk);
		if(filechk != null) {
			
		vo.setFiles(dao.getNoticeFileList(id));
		
		}
		
		return vo;
	} // read

	/*----------------------------게시글 수정--------------------------------------------*/
	@Transactional
	@Override
	public String update(NoticeDTO dto, MultipartFile[] files) throws Exception {
		
		Reader reader = Resources.getResourceAsReader(resource);
		properties.load(reader);
		
/*==========================특수문자를 지정해줘서 스크립트 공격 방어======================*/
		String subject = dto.getSubject();
		String context = dto.getContext();
		subject = subject.replace("<", "&lt;");
		subject = subject.replace(">", "&gt;");
		context = context.replace("<", "&lt;");
		context = context.replace(">", "&gt;");
		dto.setSubject(subject);
		dto.setContext(context);
		
/*==========================자동적으로 admin_id를 등록======================*/
		String admin_id = Adao.searchId(dto.getName());
		
		dto.setAdmin_id(admin_id);	
		
/*==========================Insert Files======================*/
		int notice_id = dto.getId();
		
		
		List<Integer> deleteFile = dto.getDelete_file();
		if(!deleteFile.isEmpty()) {
			
			for(int file_id : deleteFile) {
				
				FileVO fileVo = Fdao.file_info(file_id);
				
				File file = new File(properties.getProperty("uploadPath")+fileVo.getPath(), fileVo.getName_key());
				file.delete();
			
				
				FileDTO deleteFileDTO = new FileDTO();
				deleteFileDTO.setNotice_id(notice_id);
				deleteFileDTO.setId(file_id);
				
				dao.deleteNoticeFile(deleteFileDTO);
			}
		}

	if(files!=null) {
			List<FileDTO> fileList = insertFileInfo(dto,files);
			if (fileList != null) {
				for (FileDTO fileDTO : fileList) {
					dao.insertFile(fileDTO);
				}
			}
		}
/*=========================Result======================*/
		int insertCnt = 0;
		insertCnt = dao.update(dto);
	
		if (insertCnt > 0) {
			result = "SUCCESS";
		} else {
			result = "FAIL";
		}
		
		return result;
	
	} // update
	
	
	/*----------------------------게시글 파일 첨부--------------------------------------------*/
	@Override
	public List<FileDTO> insertFileInfo(NoticeDTO dto, MultipartFile[] files) throws Exception {
		
		Reader reader = Resources.getResourceAsReader(resource);
		properties.load(reader);
		
		List<FileDTO> fileList = new ArrayList<FileDTO>();

		FileDTO fileDTO = new FileDTO();

		int notice_id = dto.getId();
		String admin_id = dto.getAdmin_id();
		
		Date today = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
		
		String fileName = null;
		String fileExt = null;
		String fileNameKey = null;
		String fileSize = null;
		String fileSaveFolder = date.format(today);
		// 파일이 저장될 Path 경로 설정
		String uploadTempFilePath = properties.getProperty("uploadTempFilePath");
		String uploadTargetFilePath = properties.getProperty("uploadPath")+fileSaveFolder;

		if (files != null && files.length > 0) {

			File TempDirFile = new File(uploadTempFilePath);
			File DirFile = new File(uploadTargetFilePath);

			// 디렉토리가 없으면 생성
			TempDirFile.mkdirs();
			DirFile.mkdirs();


			for (MultipartFile multipartFile : files) {

				// 업로드 한 파일의 이름을 구함
				fileName = multipartFile.getOriginalFilename();
				if(fileName == "".toString()) {
					return null;
				}

				File file = new File(uploadTempFilePath +"/"+ fileName);
				
				multipartFile.transferTo(file);
				
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
				fileDTO.setNotice_id(notice_id);
				fileDTO.setName(fileName);
				fileDTO.setName_key(fileNameKey);
				fileDTO.setPath(fileSaveFolder);
				fileDTO.setSize(fileSize);
				fileDTO.setAdmin_id(admin_id);
				fileList.add(fileDTO);

			} // for
		} // if

		return fileList;
	}

	/*----------------------------게시글 삭제--------------------------------------------*/
	@Override
	public String delete(int id) throws Exception {
		
		Reader reader = Resources.getResourceAsReader(resource);
		properties.load(reader);
		
		/*=== 게시글의 포함된 파일 삭제 ===*/
		List<FileVO> files = Fdao.getFile(id);
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

	/*----------------------------조회수 증가------------------------------------------*/
	@Override
	public void increaseHits(int id) throws Exception {
		dao.increaseHits(id);
	} //increaseHits


	/*----------------------------랜덤한 숫자 값 생성----------------------------*/
	public String getRandomString() {

		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	/*===================== check Notice =======================*/
	@Override
	public int check_notice(int notice_id) throws Exception {
		
		return dao.check_notice(notice_id);
	}
	
} // end class

package com.acorn.team1.controller;


import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.team1.domain.FileNoticeDTO;
import com.acorn.team1.domain.FileVO;
import com.acorn.team1.domain.SearchCriteria;
import com.acorn.team1.service.CourseService;
import com.acorn.team1.service.FileNoticeService;
import com.acorn.team1.service.FileService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@RequestMapping("/FileNotice/*")
@Controller
public class FileNoticeController {
	
	@Setter(onMethod_ = { @Autowired })
	private FileNoticeService service;
	@Inject
	private CourseService Cservice;
	@Inject
	private FileService Fservice;

	/*---------------------------- 게시글 리스트 보기 화면 Mapping --------------------------------------------*/
	/*-------게시글 리스트 보기 화면 표시--------*/
	@GetMapping("FileNotice")
	public void listAll(
			@ModelAttribute("cri") SearchCriteria cri, 
			Model model,
			HttpSession session) 
					throws Exception {

		/*-------게시글 리스트--------*/
		model.addAttribute("list", service.listSearch(cri, session));
		model.addAttribute("cri", cri);
		
		/*-------게시글 페이징 처리--------*/
		model.addAttribute("pageMaker", service.paging(cri));

		/*-----------반 이름 출력-------------*/
		model.addAttribute("course", Cservice.readCourse_name(session));
	
	} // listAll
	
	/*====================== 게시글 내용 보기 Mapping============================*/
	/*-------게시글 내용 보기 화면 표시--------*/
	@GetMapping("detailFileNotice")
	public void read(
			@RequestParam("id") int id, 
			@ModelAttribute("cri") SearchCriteria cri, 
			Model model)
					throws Exception {
		/*---------검색 관련 객체 전달-----------*/
		model.addAttribute("cri", cri);
		
		/*-------조회수 증가--------*/
		service.increaseHits(id);
		/*---------정보 보기-----------*/
		model.addAttribute("read", service.read(id));
		

	} // read

/*======================= 게시글 내용 추가 Mapping --------------------------------------------*/
	
	/*-------게시글 내용 추가 화면 표시--------*/
	@GetMapping("addFileNotice")
	public void createview(
			@ModelAttribute("cri") SearchCriteria cri, 
			HttpSession session,
			Model model) 
					throws Exception {
		
		/*---------검색 관련 객체 전달-----------*/
		model.addAttribute("cri", cri);
		/*-----------반 이름 출력-------------*/
		model.addAttribute("course", Cservice.readCourse_name(session));

	} // createview

	/*-------게시글 내용 추가 등록--------*/
	@PostMapping("addFileNotice")
	public String create(
			FileNoticeDTO dto, 
			@ModelAttribute("cri") SearchCriteria cri, 
			Model model) 
					throws Exception {

		/*=== 실행 결과에 따른 분류 ===*/
		String result = service.create(dto);
		model.addAttribute("result", result);
		
		if(result == "SUCCESS") {
			return "redirect:/FileNotice/FileNotice";
		}else {
			return	"redirect:/FileNotice/addFileNotice"+service.paging(cri).makeUri();
		}
		
	} // create
	

/*----------------------------게시글 내용 수정 Mapping=================================*/
	/*-------게시글 내용 수정 화면 표시--------*/
	@GetMapping("editFileNotice")
	public void editread(
			@RequestParam("id") int id,
			@ModelAttribute("cri") SearchCriteria cri, 
			Model model, 
			HttpSession session) 
					throws Exception {
		
		/*---------정보 보기-----------*/
		model.addAttribute("editread", service.read(id));
		/*-----------반 이름 출력-------------*/
		model.addAttribute("course", Cservice.readCourse_name(session));
		/*---------검색 관련 객체 전달-----------*/
		model.addAttribute("cri", cri);
	} // read


	/*-------게시글 내용 수정후 등록--------*/
	@PostMapping("editFileNotice")
	public String update(
			@RequestParam("id") int id, 
			@ModelAttribute("cri")SearchCriteria cri,
			FileNoticeDTO dto,
			Model model) 
					throws Exception {
		
		/*---------검색 관련 객체 전달-----------*/
		model.addAttribute("id", id);
		model.addAttribute("cri",cri);
		
		/*=== 실행 결과에 따른 분류 ===*/
		String result = service.update(dto);
		model.addAttribute("result", result);
		if(result == "SUCCESS") {
			return "redirect:/FileNotice/detailFileNotice"+service.paging(cri).makeUri();
		}else {
			return	"redirect:/FileNotice/editFileNotice"+service.paging(cri).makeUri();
		}
		
		
	} // update

/*========================== 게시글 내용 삭제 mapping -------------------------------------------*/
	@PostMapping("deleteFileNotice")
	public String delete(
			@RequestParam("id") int id,
			@ModelAttribute("cri") SearchCriteria cri,
			Model model) 
					throws Exception {
		/*==== 게시글 삭제 ===*/
		String result = service.delete(id);
		model.addAttribute("cri", cri);
		
		/*=== 실행 결과에 따른 분류 ===*/
		model.addAttribute("result", result);
		if(result == "Delete_SUCCESS") {
			return "redirect:/FileNotice/FileNotice"+service.paging(cri).makeUri();
		}else {
			return	"redirect:/FileNotice/detailFileNotice"+service.paging(cri).makeUri()+"&id="+id;
		}
		
	} // delete

/*=========================== File DownLoad Mapping======================================*/
	/*jsp에서 호출한 url이 매핑된 컨트롤러*/
	@RequestMapping("/fileDownload")
	public ModelAndView fileDownload(
			@RequestParam("file_id") int file_id) throws Exception {
		
		FileVO file = Fservice.searchFile_info(file_id);
		
		/* 첨부파일 정보 조회*/
		Map<String, Object> fileInfo = new HashMap<String, Object>();
		fileInfo.put("fileNameKey", file.getName_key());
		fileInfo.put("fileName", file.getName());
		fileInfo.put("filePath", file.getPath());
		
		return new ModelAndView("fileDownloadUtil", "fileInfo", fileInfo);
	}
	
/*=========================== Drag&Drop insertFile Mapping======================================*/
	/*ajax를 사용하여 파일 첨부 요청*/
	@RequestMapping("/insertFile")
	@ResponseBody
	public void insertFile(
			@RequestParam("files")MultipartFile[] files) throws Exception {
			
			service.dragInsert(files);
	}

}	//end class


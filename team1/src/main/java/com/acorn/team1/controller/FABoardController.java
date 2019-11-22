package com.acorn.team1.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.acorn.team1.domain.FABoardCriteria;
import com.acorn.team1.domain.FABoardPageMaker;
import com.acorn.team1.domain.FABoardSearchCriteria;
import com.acorn.team1.domain.FABoardVO;
import com.acorn.team1.service.FABoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/HOME")
public class FABoardController {

	@Inject
	private FABoardService service;
	
	
	@GetMapping(value = "/register")
	public void registerGET(FABoardVO vo, Model model)throws Exception{
		log.info("register get....");
	}
	
	@PostMapping(value = "/register")
	public String registerPost(FABoardVO vo, RedirectAttributes rttr )throws Exception{
		log.info("register post....");
		
		service.regist(vo);
	
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/HOME/HOME";
	}
	
	
	@GetMapping("/readPage")
	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") FABoardSearchCriteria cri,@RequestParam("bno") int id, Model model)
	throws Exception{
		
		model.addAttribute("cri", cri);
		
		service.updateViewcnt(bno);
		
		model.addAttribute("vo",service.read(bno));
	}
	
	@PostMapping("/removePage")
	public String remove(@RequestParam("bno") int bno, FABoardSearchCriteria cri, RedirectAttributes rttr)
	throws Exception{
		
		service.remove(bno);
		
		rttr.addFlashAttribute("page", cri.getPage());
		rttr.addFlashAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("searchType", cri.getSearchType());
		rttr.addFlashAttribute("keyword", cri.getKeyword());
		
		rttr.addFlashAttribute("msg", "success");
		
		return "redirect:/HOME/HOME";
		
	}
	
	@GetMapping("/modify")
	public void modifyGET(@RequestParam("bno") int bno, @ModelAttribute("cri") FABoardSearchCriteria cri, Model model) throws Exception{
		
		model.addAttribute("vo",service.read(bno));
	}
	
	@PostMapping("/modify")
	public String modifyPOST(FABoardVO vo, FABoardSearchCriteria cri, RedirectAttributes rttr) throws Exception{
		
		log.info("mod post..");
		
		
		service.modify(vo);

		rttr.addFlashAttribute("page", cri.getPage());
		rttr.addFlashAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("searchType", cri.getSearchType());
		rttr.addFlashAttribute("keyword", cri.getKeyword());
		
		rttr.addFlashAttribute("msg","success");
		
		System.out.println("rttr.toString() :" +rttr.toString());
		return "redirect:/HOME/HOME";
	}
	
	

	 
}

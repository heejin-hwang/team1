package com.acorn.team1.controller;

import java.io.IOException;

import javax.inject.Inject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.acorn.team1.domain.ChangeUserPasswordDTO;
import com.acorn.team1.domain.LoginDTO;
import com.acorn.team1.domain.LoginUserVO;
import com.acorn.team1.service.ChangeUserPasswordService;
import com.acorn.team1.service.LoginService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/Member")
public class ChangeUserPasswordController {

	@Inject
	private ChangeUserPasswordService service;
	
  
   //---------------------------비밀번호 변경 폼----------------------------//

	  
	  @RequestMapping(value ="/ChangeUserPassword", method = RequestMethod.GET)
	  public String changeUserPasswordGet(
	  
	  @ModelAttribute("dto") ChangeUserPasswordDTO dto) throws IOException {
	  
	  log.info("ChangeUserInfoController ::ChangeUserInfo invoked.");
	  
	  return "Member/ChangeUserPasswordForm"; 
	  
	  }//ChangeUserPasswordGet
	  
	  
	  
   //---------------------------비밀번호 변경 처리----------------------------//
	  
	  @RequestMapping(value ="/ChangeUserPasswordPost", method = RequestMethod.POST)
	  public String changeUserPasswordPost( 
			  ChangeUserPasswordDTO dto, 
			  HttpSession session, Model model,RedirectAttributes rttr 
	     ) throws Exception {
		
			
			String newPW =  dto.getNewPassword(); //새로운 비밀번호
			String newCPW = dto.getConfirmNewPassword(); //새로운 비밀번호 확인
			
			log.info("ChangeUserInfoController ::changeUserPasswordPost invoked.");

			LoginUserVO vo = service.checkPassword(dto);
		
					
				if(vo != null && newPW.equals(newCPW)) { //변경 성공
								
			       return "/Member/ChangeUserPasswordPost"; 
			       
			 	}else  { //변경 실패
			 		rttr.addFlashAttribute("msg", "fail");
			        return  "redirect:/Member/ChangeUserPassword";
			    }//	if-else
			
				
	  }//changeUserPasswordPost
		
	  
}//ChangeUserPasswordController
	
		
		
		
		
		
		
		
		
		
	





		
	
		

		
		
		
		
	

		

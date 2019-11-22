package com.acorn.team1.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;




@Controller
public class HomeController {


	// ----------------------------index-----------------------------//

	@GetMapping("/")
	public String doMain(Model model) {

		return "index";

	}

	

}

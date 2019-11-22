
package com.acorn.team1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {

	@RequestMapping("/chat")
	public void viewChattingPage() {
	}

	@RequestMapping("/chatAdmin")
	public void viewAdminChattingPage(Model model) {
	}

}

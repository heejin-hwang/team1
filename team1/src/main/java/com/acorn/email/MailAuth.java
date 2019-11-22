package com.acorn.email;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuth extends Authenticator{

	PasswordAuthentication pa;
	
	public MailAuth() {
		String mail_id = "tihearts2@gmail.com";
		String mail_pw = "quest112233!";
		
		pa= new PasswordAuthentication(mail_id, mail_pw);
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
}

package com.acorn.email;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class MailSend {

	public static void mailSend(String reicever, String pw) throws UnsupportedEncodingException {
		Properties prop = System.getProperties();
		
		prop.put("mail.smtp.host","smtp.gmail.com");
		prop.put("mail.smtp.port",	465);
		prop.put("mail.smtp.auth","true");
		prop.put("mail.smtp.ssl.enable","true");
		prop.put("mail.smtp.ssl.trust","smtp.gmail.com");
		
		Authenticator auth = new MailAuth();
		
		Session session = Session.getDefaultInstance(prop, auth);
		
		try {
			MimeMessage message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress("tihearts2@gmail.com","shim"));
			
			InternetAddress to = new InternetAddress(reicever);
			
			message.setRecipient(Message.RecipientType.TO, to);
			message.setSubject("비밀번호", "UTF-8");
			message.setText("임시비밀번호는 "+pw + " 입니다.", "UTF-8");
			
			Transport.send(message);
			
			System.out.println("message sent successfully");
		
		}
		catch(AddressException ae) {
			System.out.println("AddressException: " + ae.getMessage());
		}catch(MessagingException me) {
			System.out.println("MessagingException: " + me.getMessage());
		}finally {
			System.out.println("Try Check");
		}
	
	}
}

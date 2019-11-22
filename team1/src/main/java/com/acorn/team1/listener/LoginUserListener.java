package com.acorn.team1.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import lombok.extern.log4j.Log4j;


@Log4j
@WebListener
public class LoginUserListener implements HttpSessionAttributeListener {

  
    public LoginUserListener() {
    	log.info("LoginUserListener :: LoginUserListener() invoked." );
    }

	
    public void attributeAdded(HttpSessionBindingEvent event)  { 
    	log.info("LoginUserListener :: attributeAdded() invoked." );
    }

	
    public void attributeRemoved(HttpSessionBindingEvent event)  { 
    	log.info("LoginUserListener :: attributeRemoved() invoked." );
    }


    public void attributeReplaced(HttpSessionBindingEvent event)  { 
    	log.info("LoginUserListener :: attributeReplaced() invoked." );

    }
	
}

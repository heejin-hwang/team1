package com.acorn.team1.listener;


import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;


import lombok.extern.log4j.Log4j;


@Log4j
@WebListener
public class UserListener implements HttpSessionListener {

		
    public UserListener() {
    	log.info("UserListener :: UserListener() invoked." );
    }

    public void sessionCreated(HttpSessionEvent se)  { 
    	log.info("UserListener :: sessionCreated() invoked." );
    	HttpSession session = se.getSession();
    	
    	log.info("se.getSession : *********************" + se.getSession());
    	log.info("se.getId : *********************" + se.getSession().getId());
    	log.info("se.getCreationTime : *********************" + se.getSession().getCreationTime());
	

    }

    public void sessionDestroyed(HttpSessionEvent se)  { 
    	log.info("UserListener :: sessionDestroyed() invoked."  );
    
    	log.info("UserListener :: 세션만료() invoked."  );
    	
    }
    
}

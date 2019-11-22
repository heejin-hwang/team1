package com.acorn.team1.controller;

import javax.inject.Inject;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import com.acorn.team1.domain.MyPageDTO;
import com.acorn.team1.service.MyPageService;

@Component
@Controller
public class SchedulerController {
	
	@Inject
	private MyPageService service;
	
	protected MyPageDTO dto;
 
	
	//-------------------------출석 자동 저장 스케줄러------------------------//

	//톰캣이 구동중일 때 지정된 시간에 자동으로 학생별로 결석이 기본값이 출석 값을 만들어 준다. 
    @Scheduled(cron="00 51 10 ? * MON-FRI") // 초/ 분/ 시   아무 날이나, 매월, 월~금,
    public void TestScheduler() throws Exception{
    	service.insertAttendance(dto);
        System.out.println("----------학생 출석 insert----------");
    }


}

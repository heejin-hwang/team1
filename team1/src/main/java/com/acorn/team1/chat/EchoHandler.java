package com.acorn.team1.chat;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.acorn.team1.domain.LoginUserVO;

import lombok.extern.log4j.Log4j;

@Log4j
@ServerEndpoint(value = "/websocket", configurator = HttpSessionConfigurator.class)
public class EchoHandler extends TextWebSocketHandler {

	static List<Session> sessionList = new ArrayList<Session>();
	static List<Session> studentSessionList = new ArrayList<Session>();
	static private Session studentSession; // 메시지를 받는 학생 세션
	static private Session adminSession;

	@OnOpen
	public void handleOpen(Session session) {
		System.out.println("WebSocket Opened!");

		// 로그인 정보 확인하여 채팅 관리자라면 해당 세션을 adminSession에 저장
		HttpSession httpSession = (HttpSession) session.getUserProperties().get(HttpSessionConfigurator.Session);
		LoginUserVO login = (LoginUserVO) httpSession.getAttribute("login");
		System.out.println("job id: " + login.getJob_id());

		if (login.getJob_id().equals("1")) {
			System.out.println("관리자가 접속하였습니다.");
			adminSession = session;
		} else if (login.getJob_id().equals("4")) {
			System.out.println("학생이 접속하였습니다.");
			studentSessionList.add(session);
		} else {
			System.out.println("잘못된 접근입니다.");
			return;
		}
		System.out.println("job_id : " + login.getJob_id() + " adminSession : " + adminSession);
		sessionList.add(session);
		System.out.println("session : " + session.toString());
		System.out.println("sessions : " + studentSessionList.toString());
	}

	@OnMessage
	public void handleMessage(String message, Session session) throws Exception {

		Calendar oCalendar = Calendar.getInstance(); // 메시지 보낸 시각 출력
		String messageTime = oCalendar.get(Calendar.HOUR) + ":" + oCalendar.get(Calendar.MINUTE);
		System.out.println("메시지 보낸 시각 - " + messageTime);
		System.out.println("내용 : " + message);

		// 세션에서 로그인 정보를 가져옴
		HttpSession httpSession = (HttpSession) session.getUserProperties().get(HttpSessionConfigurator.Session);
		LoginUserVO login = (LoginUserVO) httpSession.getAttribute("login");
		System.out.println(login.toString());

		String[] splitMessage = message.split(" ", 2);

		if (login.getJob_id().equals("4")) {

			// 학생이 보낸 메시지는 채팅 관리자에게 전달

			if (adminSession != null) {
				System.out.println("채팅매니저에게 메시지 전송");
				if (message.equals("!채팅요청")) {
					adminSession.getBasicRemote().sendText("!채팅요청 " + login.getName());
					System.out.println("!채팅요청 " + login.getName());
				} else {
					adminSession.getBasicRemote().sendText(message);
					System.out.println("채팅매니저에게 메시지 전송 " + message);
				}

			} else {
				session.getBasicRemote().sendText("관리자와 연결되지 않았습니다.");
			}

		} else if (login.getJob_id().equals("1")) { // 관리자가 보낸 메시지는 특정 학생에게 전달

			// 메시지를 " " 기준으로 쪼갬(id가 들어옴)

			if (splitMessage[0].equals("!학생선택")) {

				for (int i = 0; i < studentSessionList.size(); i++) {

					// 세션에서 LoginVO 정보를 가져옴
					System.out.println("sessionList.get(i) : " + studentSessionList.get(i));
					HttpSession receiveSession = (HttpSession) studentSessionList.get(i).getUserProperties()
							.get(HttpSessionConfigurator.Session);
					LoginUserVO receiveLoginVO = (LoginUserVO) receiveSession.getAttribute("login");

					// 이름이 같으면 해당 세션에 메시지 전달
					if (receiveLoginVO.getName().equals(splitMessage[1])) {
						studentSession = studentSessionList.get(i);
						System.out.println("받을 사람: " + receiveLoginVO.getName());
						System.out.println("studentSession 저장 " + studentSession);
						break;
					}
					System.out.println("studentSession " + studentSession);

				} // for
			} else if (splitMessage[0].equals("채팅종료")) {
				System.out.println("학생세션종료");
				studentSessionList.remove(session);
				studentSession.close();

			}

			else {
				System.out.println("관리자가 학생" + studentSession + "에게 " + message);
				if (studentSession !=null) {
				studentSession.getBasicRemote().sendText(message);
				}else {
					System.out.println("학생이 없습니다.");
				}
			}
		} else {

		}
	}// handleMessage

//    /**
//    * 웹 소켓이 닫히면 호출되는 이벤트
//    */
	@OnClose
	public void handleClose(Session session) {
		sessionList.remove(session);
		studentSessionList.remove(session);
		System.out.println("client is now disconnected");
	}

}
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="/resources/css/chat.css" rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script>
	var job_id = "<c:out value='${login.job_id}'/>";
	var id = "<c:out value='${login.name}'/>";
	var webSocket = new WebSocket("ws://192.168.0.100:8080/websocket");

	
	function openChatting() {

		if (job_id == '1') {
			var url = "../chatAdmin";
			var name = "chatAdmin";
			var option = "width = 1100, height = 800, top = 100, left = 200, location = no"
			window.open(url, name, option);
		} else if (job_id == '4') {
			document.getElementById("chatStu").style.display = "block";
			
			webSocket = new WebSocket("ws://192.168.0.100:8080/websocket");
			
			//웹 소켓이 연결되었을 때 호출되는 이벤트
			webSocket.onopen = function(message) {
				
			};
			
			
			var msg = '<button onclick="request()" class="request" type="button">'+
			'관리자에게 상담 요청하기 <i class="fas fa-assistive-listening-systems"></i></button></div>';
			$('.chatInput').html(msg);

		
		}

	};
	


	var messageTextArea = document.getElementById("messageTextArea");

	function checkTime(i) {
		return (i < 10) ? "0" + i : i;
	}

	var date = new Date();
	var hours = checkTime(date.getHours());
	var minutes = checkTime(date.getMinutes());
	var time = hours + ':' + minutes;

	//웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
	webSocket.onmessage = function(message) {

		if (message.data == '채팅종료') {

			var text = '<div class="requestMsg">채팅이 종료되었습니다. <i class="far fa-grin"></i></div>'
			$('#messageTextArea').append(text);
			$('#textMessage').prop("disabled", true);
			$('.send').prop("disabled", true);
			$('.send').css("background-color", "#aaaaaa");
			disconnect();

			return false;
		};

		$('#textMessage').prop("disabled", false);
		$('.send').prop("disabled", false);
		$('.send').css("background-color", "#3C6188");

		$('#messageTextArea').append(
				'<div class="message sol">'
						+ '<div class="messageText" data-time="'+time+'">'
						+ message.data + '</div></div>');
		$('.chatBox').scrollTop($('.chatBox').height());
		$('.requestMsg').hide();

	};
	
	webSocket.onclose = function() {
		//if (message.data == '채팅종료') {

			var text = '<div class="requestMsg">채팅이 종료되었습니다. <i class="far fa-grin"></i></div>'
			$('#messageTextArea').append(text);
			$('#textMessage').prop("disabled", true);
			$('.send').prop("disabled", true);
			$('.send').css("background-color", "#aaaaaa");

			return false;
		//};
	};

	// 엑스 버튼을 누르면 disconnect
	//웹소켓 종료
	function disconnect() {
		webSocket.close();

	}

	function closeChatting() {
		webSocket.send('채팅종료');
		document.getElementById("chatStu").style.display = "none";
	};

	function request() {

		var text = '<div class="requestMsg">관리자에게 대화를 요청했습니다.<br>잠시만 기다려주세요 <i class="far fa-grin"></i></div>'
		$('#messageTextArea').html(text);

		$('.chatInput')
				.html(
						'<form onsubmit="sendMessage(); return false;">'
								+ '<span><input id="textMessage" class="text" type="textarea" /></span>'
								+ '<button onclick="sendMessage()" value="Send" class="send" type="button">'
								+ '<i class="fas fa-paper-plane"></i></button></form>');

		webSocket.send('!채팅요청');
		//webSocket.send(id, '!학생이 채팅요청 보냄!');
		$('#textMessage').prop("disabled", true);
		$('.send').prop("disabled", true);
		$('.send').css("background-color", "#aaaaaa");

	}

	//Send 버튼을 누르면 실행되는 함수
	function sendMessage() {
		var message = document.getElementById("textMessage");

		//웹소켓으로 textMessage객체의 값을 보낸다.
		webSocket.send(message.value);

		$('#messageTextArea').append(
				'<div class="message sag mtLine">'
						+ '<div class="messageText" data-time="'+time+'">'
						+ message.value + '</div></div>');
		$('.chatBox').scrollTop($('.chatBox').height());

		//textMessage객체의 값 초기화
		message.value = "";

	}
</script>

</head>
<body>
	<div class="box">

		<div class="topButton">
			<img src="/resources/img/top.png" id="top_button" alt="top" />
		</div>
		<c:if test="${login.job_id == '1' || login.job_id == '4' }">
			<div class="chatButton" onclick="openChatting()">
				<img src="/resources/img/chat.png" alt="chat" />
			</div>
		</c:if>
		<div id="chatStu" class="chatWrapStudent" style="display: none">

			<div class="chatTitle">
				<div class="icon1">
					<i class="fas fa-comment"></i>
				</div>
				<div class="title">
					<h3>문의하기</h3>
				</div>
				<div class="icon2" onclick="closeChatting();disconnect()">
					<i class="fas fa-times"></i>
				</div>
			</div>
			<div id="messageTextArea" class="chatBox" name="chatBox"></div>



			<div class="chatInput">


			</div>

		</div>
	</div>


</body>
	<script>
		var top_button = document.getElementById("top_button");
		top_button.style.display = "none";
		top_button.onclick = topFunction;
	
		window.onscroll = function() {
			scrollFunction()
		};
	
		function scrollFunction() {
			if (document.body.scrollTop > 20
					|| document.documentElement.scrollTop > 20) {
				top_button.style.display = "block";
			} else {
				top_button.style.display = "none";
			}
		}
	
		function topFunction() {
			document.body.scrollTop = 0;
			document.documentElement.scrollTop = 0;
		}
	
	</script>
</html>

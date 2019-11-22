<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	Object receiver = session.getAttribute("receiver");
%>
<%-- <%= receiver %> --%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>관리자 채팅화면</title>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<link href="/resources/css/chat.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<script>
	var webSocket = new WebSocket("ws://192.168.0.100:8080/websocket")
	var messageTextArea = document.getElementById("messageTextArea");
	var job_id = "<c:out value='${login.job_id}'/>";
	var receiver = "<c:out value='${receiver}'/>";
	var selected;
	var name;
	var now;
	var idx;

	function checkTime(i) {
		return (i < 10) ? "0" + i : i;
	}

	var date = new Date();
	var hours = checkTime(date.getHours());
	var minutes = checkTime(date.getMinutes());
	var time = hours + ':' + minutes;

	//웹 소켓이 연결되었을 때 호출되는 이벤트
	webSocket.onopen = function(message) {
		return false;
	};

	var first = 0;
	//웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
	webSocket.onmessage = function(message) {
		var msgArr = message.data.split(" ", 2);

		if (msgArr[0] == '채팅종료') {
			endChat();
			return false;
		} else if (msgArr[0] == '!채팅요청') {
			name = msgArr[1];
			var preInsTag = '<div class="chatSub newChat"><div class="chatLine1"><div id="chat" class="chat">'
					+ msgArr[1] + '</div><div class="time">'+ time
					+ '</div></div><div class="chatLine2"><p>채팅을 요청합니다.</p></div></div>';
			$(".chatListBox").prepend(preInsTag);
			console.log('chatSub added');
			first++;
		}

		/* 메세지 내용  */
		else if (first != 0) {
			$('#messageTextArea').append(
					'<div class="message sol">'
							+ '<div class="messageText" data-time="'+time+'">'
							+ message.data + '</div></div>');
			$('.chatBox').scrollTop($('.chatBox').height());
		};

				$(".chatSub").on('click', function f_loadChatBox() {
				
				
				now = $(this);
				
				var index = now.index();
				
				$('.chatSub').eq(index).addClass('nowChatting');
				now.removeClass('newChat');
				
				selected = $(this).find('.chat').text();
				$("#chatWith").text(selected);
				$('#messageTextArea').text("");

				firstMsg();
				now.find('.chatLine2').html('<p>채팅 중입니다.</p>');
				
				return false;

			});
	};

	function firstMsg() {

		webSocket.send("!학생선택" + " " + name);
		webSocket.send('무엇을 도와드릴까요?');

		$('#messageTextArea').append(
				'<div class="message sag mtLine">'
						+ '<div class="messageText" data-time="'+time+'">'
						+ '무엇을 도와드릴까요?' + '</div></div>');
	}

	//Send 버튼을 누르면 실행되는 함수
	function sendMessage() {
		var message = document.getElementById("textMessage");
		webSocket.send(message.value);

		$('#messageTextArea').append(
				'<div class="message sag mtLine">'
						+ '<div class="messageText" data-time="'+time+'">'
						+ message.value + '</div></div>');
		$('.chatBox').scrollTop($('.chatBox').height());
		//textMessage객체의 값 초기화
		message.value = "";

	}

	function endChat() {
		first = 0;
		
			$('.nowChatting').addClass('closedChatting');
			$('.closedChatting').removeClass('nowChatting');
			$('.closedChatting').find('.chatLine2').html('<p>채팅이 종료되었습니다.</p>');
			$('.closedChatting').removeClass('closedChatting');

			webSocket.send("채팅종료");
			var text = '<div class="requestMsg">채팅이 종료되었습니다. <i class="far fa-grin"></i></div>'
			$('.chatBox').append(text);

	}

	//웹소켓 종료
	function disconnect() {
		webSocket.close();
	}

	$(function() {

		$(".icon2")
				.on(
						'click',
						function f_searchOpen() {

							$(".icon2").toggleClass('search');
							console.log($('.icon2').prop('class'))
							if ($('.icon2').hasClass('search')) {
								$($(".icon2").prev().children())
										.html(
												'<input class="search_text" type="text" placeholder="대화상대 검색"/>');
							} else {
								$($(".icon2").prev().children()).html('채팅목록');
							}
						});

	});
</script>
</head>

<body>
	<div class="section">
		<div class="chattingList">
			<div class="chatTitle">
				<div class="icon1">
					<i class="fas fa-comment"></i>
				</div>
				<div class="title">
					<h3>채팅목록</h3>
				</div>
				<div class="icon2">
					<i class="fas fa-search"></i>
				</div>
			</div>

			<div class="chatListBox"></div>
		</div>

		<div class="chatWrapAdmin">
			<div class="chatTitle">
				<div class="icon1">
					<i class="fas fa-comment"></i>
				</div>
				<div class="title">
					<h3 id="chatWith">대화상대</h3>
				</div>
			</div>

			<div id="messageTextArea" class="chatBox" name="chatBox"></div>


			<div class="chatInput">
				<form onsubmit="sendMessage(); return false;">
					<span><input id="textMessage" class="text" type="textarea" /></span>
					<button onclick="sendMessage()" value="Send" class="send"
						type="button">
						<i class="fas fa-paper-plane"></i>
					</button>
					<button onclick="endChat()" class="send" type="button">
						<i class="fas fa-times"></i>
					</button>
				</form>
			</div>

		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/resources/css/style.css">
		<link rel="stylesheet" href="/resources/css/groupmain.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
	    <script>
	    $(function() {
	    	$("#closeBtn").on("click", function() {
	    		opener.parent.location.reload();
	    		self.close();
	    	}); // closeBtn
	    });
	    </script>
	</head>
	<body>
		<div class="popupDiv" id="popupResult">
			<i class="fas fa-exclamation-triangle"></i>
			<h3>알 수 없는 에러 때문에 시스템이 요청된 작업을 수행하지 못했습니다. 잠시 후 다시 시도해주시길 바랍니다.</h3>
			<div class="form_bottom">
				<button id="closeBtn" class="click_bo">닫기</button>
			</div>
		</div>
	</body>
</html>
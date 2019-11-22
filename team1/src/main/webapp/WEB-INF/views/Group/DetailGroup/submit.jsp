<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/resources/css/style.css">
		<link rel="stylesheet" href="/resources/css/groupmain.css">
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
		<div class="popupDiv">
			<div class="registerTitle"><h3>과제 제출</h3></div>
			<hr> 
			<form method="post" action="/Group/DetailGroup/Submit" enctype="multipart/form-data">
				<input type="hidden" name="id" id="id" value="${ id }">
				<table class="add_table">
					<tr>
						<td>과제명<span style="color: red;">*</span></td>
						<td>
							${ name }
						</td>
					</tr>
					<tr>
						<td>조명<span style="color: red;">*</span></td>
						<td>
							${ groupName }
						</td>
					</tr>
					<tr>
						<td>교육과정명</td>
						<td>
							${ courseName }
						</td>
					</tr>
					<tr>
						<td>제출 파일<span style="color: red;">*</span></td>
						<td>
							<input type="file" name="uploadFile" id="uploadFile">
						</td>
					</tr>
				</table>
				<div class="form_bottom">
					<input type="submit" id="submitBtn" class="click_bo" value="제출하기">
					<button id="closeBtn" class="click_bo">닫기</button>
				</div>
			</form>
		</div>
	</body>
</html>
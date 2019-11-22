<%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
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
		<div class="popupDiv">
			<div class="registerTitle"><h3>과제 제출</h3></div>
			<hr> 
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
						<c:forEach items="${submitFile}" var="result">
						<a href='/Group/fileDownload?file_id=${ result.id }'>
							<p><i class="fas fa-download"></i>&nbsp;${ result.name }</p>
						</a>
						</c:forEach>
					</td>
				</tr>
			</table>
			<div class="form_bottom">
				<button id="closeBtn" class="click_bo">닫기</button>
			</div>
		</div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = " java.util.List" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/resources/css/style.css">
<!-- <link rel="stylesheet" href="/resources/css/style_pw.css"> -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

<link href="/resources/css/addNotice.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>

<% String result = request.getParameter("result");%>
<script>
	$(function(){
		$('#cancelBtn').on("click",function() {
			location.href="/HOME/HOME";
		})
			
	});
</script>
<style>
	#wrap {
		width: 1100px;
		margin: auto;
	}
</style>
</head>
<body>

	<header>
		<!-- User icon -->
		<div class="header_1">
			<div class="user_account">
				<img src="/resources/img/user.png" alt="user" class="user_icon">
				<div class="user_dropdown">
					<div class="dropdown_box">
						<div class="dropdown_1">
							<img src="/resources/img/user.png" alt="user">
						</div>
						<div class="dropdown_2">
							<p style="padding-bottom: 5px;">
								<b>${login.name}</b>
							</p>
							<c:if test="${login.job_id == '4' }">"${login.course_name}" </c:if>
							<c:if test="${login.job_id == '0' }">관리자 모드입니다. </c:if>
							<c:if test="${login.job_id == '1' }">채팅 관리자 모드입니다. </c:if>
							<c:if test="${login.job_id == '2' }">강사 모드입니다. </c:if>
							<p>${login.id}</p>
						</div>
					</div>
					<div class="dropdown_3">
						<form action="/Member/logout" method="GET">
							<button class="click_bo">로그아웃</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div class="header_bar">
			<div class="header_2" style="background-color: #fff;">
				<a href="../../HOME/HOME"><img src="/resources/img/logo.png"
					alt="logo"></a>
			</div>
			<nav class="header_3">
				<div id="menu">
					<i class="fa fa-bars" aria-hidden="true"></i>
				</div>
				<ul>
					<li><a href="../HOME/HOME" class="active">홈</a></li>
					<li><a href="../Notice/Notice">공지사항</a></li>
					<li><a href="../Schedule/Schedule">일정</a></li>
					<li><a href="../FileNotice/FileNotice">파일공유</a></li>
					<c:if
						test="${login.job_id eq '0' || login.job_id eq '1' || login.job_id eq '2' }">
						
						<li><a href="../Student/Student">학생관리</a></li>
					</c:if>
					<c:choose>
						<c:when
							test="${login.job_id eq '0' || login.job_id eq '1' || login.job_id eq '2' }">
							
							<li><a href="../Group/AdminGroup">그룹</a></li>
							
						</c:when>
						<c:when test="${login.job_id eq '4'}">
							<li><a href="../Group/DetailGroup">그룹</a></li>
							
						</c:when>
					</c:choose>
				</ul>
			</nav>

		</div>

	</header>

	<div class="titlebar">
		<div class="sub">
			<h1 class="sub2">TIP</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding: 8px;"></i>홈</a></li>
				<li><a href="#">TIP</a></li>
			</ul>
		</div>
	</div>
	
	<!-- 
	<c:set var="result" value="<%=result%>"></c:set>


	<input type="hidden" id="notice_result" value="${result}">
	
	 -->
	
	<div id="wrap"> 
		<form role = "form" method = "POST">
			
			<!------------------------------게시글 작성란------------------------------->
			<div class="add_list">
				
				<table class="boardtable">
					
					<!---------------------------------제 목------------------------------------------------->
					<tr> 	<!--subject-->
						<th>제목<span class="t_red">*</span></th>
						<td colspan="3">
							<input class="input_area" type = "text" name="title" id="subject" autofocus > <!-- class = input_area -->
						</td>
					</tr>		<!-- end tr :: subject-->
		 				 
					<!---------------------------------작성자----------------------------------------------->
					<tr>	<!-- admin_id-->
						<th>작성자<span class="t_red">*</span></th>
						<td colspan="3">
							<input class="input_area" type = "text" name="writer"id="name"value="${login.name}" readonly>
						</td>	 <!-- class = input_area -->
		
					</tr>		<!-- end tr :: admin_id-->
		
				</table>	<!--end table :: class=table-->
		
				<!------------------------------textarea----------------------------------------->
				<div class="content">
					<label>내용</label>	<!--textarea label-->
					<textarea class="text_area"name="content" placeholder="1000자 이하로 내용을 입력해주세요."></textarea>
				</div>	<!-- end div :: class = content -->
				
			</div>    <!-- end div :: class = add_list -->
			
			<!------------------------------등록 취소 버튼------------------------------->
			<div class="add_outList">
				<div class="add_button">
					<!-- 버튼 -->
					<button class="click_bo" type ="submit" id="submitBtn">등록</button>
					<button class="click_bo" type="button" id="cancelBtn">취소</button>
					
					
				</div>	<!-- end div :: class = add_button -->
			</div>	<!-- end div :: class = add_outList --> 
			
		</form>	 <!-- end form :: action : addNotice :: method : poast -->	
	</div>
	
	<%@ include file="../footer.jsp"%>
</body>
</html>
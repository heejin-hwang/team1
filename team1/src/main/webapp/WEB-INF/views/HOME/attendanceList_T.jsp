<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.List" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/style_pw.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	
<style>
	<!--테이블 디자인 -->
	
	table .table {
	border-collapse: collapse;
	text-align: left;
	line-height: 1.5;
	}
	
	.table thead th {
		padding: 10px;
		font-weight: bold;
		vertical-align: top;
		color: #369;
		border-bottom: 3px solid #036;
	}
	
	.table th {
		width: 150px;
		padding: 10px;
		font-weight: bold;
		vertical-align: top;
		border-bottom: 1px solid #ccc;
		background: #f3f6f7;
	}
	
	.table td {
		width: 350px;
		/* padding: 10px; */
		/* vertical-align: top; */
		border-bottom: 1px solid #ccc;
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
				</nav>

		</div>

	</header>

	<div class="titlebar">
		<div class="sub">
			<h1 class="sub2">학생출석 현황</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding: 8px;"></i>홈</a></li>
				<li><a href="#">학생출석 현황</a></li>
			</ul>
		</div>
	</div>
	<div class="content">
	 <!------------------ 게시글 테이블 -------------------->
     
    	<table class="table">      <!-- 테이블 -->
	        <colgroup>
				<col style="width: 80px"/>
				<col style="width: 180px"/>
				<col style="width: 180px"/>
				<col style="width: 80px"/>
     		</colgroup>
            <tr>         <!-- 테이블 목록 제목-->
                <th >학생</th>
                <th >출석시간</th>
                <th >퇴실시간</th>
                <th >상태</th>
            </tr>

			<!-- 게시글 목록 -->
			<c:forEach var="attendanceList_T" items="${attendanceList_T}" >
				<tr>
	                <td>${attendanceList_T.name}</td> 
					<td>${attendanceList_T.start_date_time}</td> 
					<td>${attendanceList_T.end_date_time}</td> 
					<%-- <td>${attendanceList_T.state}</td> --%> 
					<td>
						<c:set var="state" value="${attendanceList_T.state}" /> 
								<c:choose>
									<c:when test="${state == '정상'}">
										<p style="color: black">${state}</p>
									</c:when>

									<c:when test="${state == '지각'}">
										<p style="color: blue">${state}</p>
									</c:when>
									<c:when test="${state == '조퇴'}">
										<p style="color: blue">${state}</p>
									</c:when>
									<c:when test="${state == '결석'}">
										<p style="color: red">${state}</p>
									</c:when>
								</c:choose>
					</td>
					
				</tr>
			</c:forEach>
		</table>  <!--end table :: class=table-->
        
	</div>
</body>
</html>
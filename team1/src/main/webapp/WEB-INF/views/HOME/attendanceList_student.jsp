<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar, java.text.SimpleDateFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${contextPath}/resources/css/style_pw.css?ver=1">
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script>
	history.replaceState(null, null, "/HOME/HOME");
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<script src="/resources/js/sidebanner.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>

#SB {
	position: absolute;	
}

<!--테이블 디자인 -->table .table {
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

.sidebanner {
	display: block;
	position: fixed;
	top: 500px;
	right: 300px;
	z-index: 1000;
 	cursor: move; 
	width: 200px;
	padding-bottom: 4px;
	text-align: center;
	background: url(https://ssl.pstatic.net/static/comic/images/2012/remote_bg_b.gif) no-repeat 0 100%;
	background-size: contain;
}

.sidebanner .head_area {
	/* background:url(https://ssl.pstatic.net/static/comic/images/2012/remote_bg_t.gif) no-repeat 0 100%; */
	background-size: cover;
	height: 66px;
	background-color: #f3f6f7;
}

.head_area > table {
	margin: 0 auto;
}

/* .head_area > table > tbody > tr {
	vertical-align: middle;
	height: 50px;
} */

.head_area > table > tbody > tr > td {
	/* padding-bottom: 8px; */
}

.head_area h3 {
	margin: 5px 0;
	text-align: center;
	vertical-align: middle;
}

.sidebanner .side_cont {
	overflow: hidden;
	padding: 12px 0 0;
	border-left: 1px solid #cbcbcb;
	border-right: 1px solid #cbcbcb;
	background: #fff;
	text-align: center;
	/* display: block;
	line-height: 18px;
	color: #000;
	width: inherit; */
}

.side_cont .tit {
	display: block;
    padding: 5px 6px 10px;
    line-height: 18px;
    color: #000;
    text-overflow: ellipsis;
	text-decoration: none;
}

.sidebanner .floating_menu {
/* 	padding: 15px 0 8px; */
    border: 1px solid #fcfcfc;
    border-top: 1px solid #e2e3e3;
    border-bottom: 0;
    background: #f8f8f8;
}

.floating_menu > div {
	display: inline-block;
}

/* .sidebanner #floating_menu {
	max-width: 100%;
	background-color: transparent;
	border-collapse: collapse;
	border-spacing: 0;
	box-sizing: border-box;
}

#floating_menu tbody {
	display: table-row-group;
	vertical-align: middle;
	border-color: inherit;
}

#floating_menu tr {
	display: table-row;
	vertical-align: inherit;
	border-color: inherit;
}

#floating_menu td {
	display: table-cell;
	vertical-align: inherit;
} */

#homeup {
	display: inline-block;
	width: 25px;
	height: 25px;
	background-image: url("/resources/img/arrow.png");
	background-repeat: no-repeat;
	background-size: 25px auto;
	transform: rotate(180deg);
}

#homedown {
	display: inline-block;
	width: 25px;
	height: 25px;
	background-image: url("/resources/img/arrow.png");
	background-repeat: no-repeat;
	background-size: 25px auto;
}

#prevM {
	display: block;
	margin-left: 10px;
	width: 30px;
	height: 30px;
	background-image: url("/resources/img/restart.png");
	background-repeat: no-repeat;
	background-size: 30px auto;
}

#nextM {
	display: block;
	margin-right: 10px;
	width: 30px;
	height: 30px;
	background-image: url("/resources/img/restart.png");
	background-repeat: no-repeat;
	background-size: 30px auto;
	transform: rotate(180deg);
}

#mydiv {
  position: fixed;
  z-index: 9;
  background-color: #f1f1f1;
  text-align: center;
  border: 1px solid #d3d3d3;
}

#mydivheader {
  padding: 10px;
  cursor: move;
  z-index: 10;
  background-color: #2196F3;
  color: #fff;
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
			<h1 class="sub2">출석현황</h1>
			<ul class="breadcrumb sub1">
				<li><a href="#"><i class="fa fa-home" aria-hidden="true"
						style="padding: 8px;"></i>홈</a></li>
				<li><a href="#">출석현황</a></li>
			</ul>
		</div>
	</div>


	<div id="container">
		<div id="SB">
			<div class="sidebanner" id="sidebanner">
				<div class="head_area">
					<table>
						<tbody>
							<tr>
								<td style="width: 40px;">
									<a href="#" id="prevM"></a>
								</td>
								<td style="width: 120px">
									<h3 class="change_month">
										<input type="hidden" id="date" value="${login.start_date}" />
										<fmt:formatDate pattern="yyyy-M" value= "${login.start_date}" />
									</h3>
								</td>
								<td style="width: 40px;">
									<a href="#" id="nextM"></a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="side_cont">
					<a href="#" class="tit" style="text-overflow : ellipsis; overflow : hidden; margin-right: 6px; display:inline-block; white-space:nowrap; width: 180px;">"${login.course_name}"</a>
					<!-- <table id="floating_menu">
						<tbody>
							<tr>
								<td><a id="homeup" href="#top"></a></td>
								<td><a id="homedown" href="#footer"></a></td>
							</tr>
						</tbody>
					</table> -->
					<div class="floating_menu">
						<div style="float: left; margin-left: 30px;">
							<a id="homeup" href="#top"></a>
						</div>
						<div style="float: right; margin-right: 30px;">
							<a id="homedown" href="#footer"></a>						
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<div class="content">
			<div class="content_header">
				<h2>
					<fmt:formatDate pattern="M" value="${login.start_date}" />
					월 출석현황
				</h2>
			</div>
			<p class="summary">.</p>
			<div id="div1">
				<table class="table">
					<colgroup>
						<col style="width: 80px" />
						<col style="width: 180px" />
						<col style="width: 180px" />
						<col style="width: 80px" />
					</colgroup>

					<tr>
						<th>학생</th>
						<th>출석시간</th>
						<th>퇴실시간</th>
						<th style="text-align: center">상태</th>
					</tr>

					<h3>1회차</h3>
					<!-- 출석 현황 -->
					<c:forEach var="attendanceList_student"
						items="${attendanceList_student}" begin="0" end="19">
						<tr>
							<td>${attendanceList_student.id}</td>
							<td>
								<fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${attendanceList_student.start_date_time}" />
							</td>
							<td>
								<fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${attendanceList_student.end_date_time}" />
							</td>
							<td>
								<c:set var="state" value="${attendanceList_student.state}" /> 
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
					</c:forEach>
				</table>
			</div>
			<br> <br>

			<div id="div2">
				<table class="table">
					<colgroup>
						<col style="width: 80px" />
						<col style="width: 180px" />
						<col style="width: 180px" />
						<col style="width: 80px" />
					</colgroup>

					<tr>
						<th>학생</th>
						<th>출석시간</th>
						<th>퇴실시간</th>
						<th>상태</th>
					</tr>

					<h3>2회차</h3>
					<!-- 출석 현황 -->
					<c:forEach var="attendanceList_student"
						items="${attendanceList_student}" begin="20" end="39">
						<tr>
							<td>${attendanceList_student.id}</td>
							<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss"
									value="${attendanceList_student.start_date_time}" /></td>
							<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss"
									value="${attendanceList_student.end_date_time}" /></td>
							<td><c:set var="state"
									value="${attendanceList_student.state}" /> <c:choose>
									<c:when test="${state == '정상'}">
										<p style="color: black">정상</p>
									</c:when>

									<c:when test="${state == '지각'}">
										<p style="color: blue">지각</p>
									</c:when>
									<c:when test="${state == '조퇴'}">
										<p style="color: blue">조퇴</p>
									</c:when>
									<c:when test="${state == '결석'}">
										<p style="color: red">결석</p>
									</c:when>
								</c:choose></td>
					</c:forEach>


				</table>
			</div>
			<br> <br>

			<div id="div3">
				<table class="table">
					<colgroup>
						<col style="width: 80px" />
						<col style="width: 180px" />
						<col style="width: 180px" />
						<col style="width: 80px" />
					</colgroup>

					<tr>
						<th>학생</th>
						<th>출석시간</th>
						<th>퇴실시간</th>
						<th>상태</th>
					</tr>

					<h3>3회차</h3>
					<!-- 출석 현황 -->
					<c:forEach var="attendanceList_student"
						items="${attendanceList_student}" begin="40" end="59">
						<c:set var="state" value="${attendanceList_student.state}" />
						<c:choose>

							<c:when test="${state == '지각'}">
								<col style="color: yellow" />
							</c:when>
							<c:when test="${state == '조퇴'}">
								<col style="color: yellow" />
							</c:when>
							<c:when test="${state == '결석'}">
								<col style="color: yellow" />
							</c:when>
						</c:choose>
						<tr>
							<td>${attendanceList_student.id}</td>
							<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss"
									value="${attendanceList_student.start_date_time}" /></td>
							<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss"
									value="${attendanceList_student.end_date_time}" /></td>
							<td><c:set var="state"
									value="${attendanceList_student.state}" /> <c:choose>
									<c:when test="${state == '정상'}">
										<p style="color: black">정상</p>
									</c:when>

									<c:when test="${state == '지각'}">
										<p style="color: blue">지각</p>
									</c:when>
									<c:when test="${state == '조퇴'}">
										<p style="color: blue">조퇴</p>
									</c:when>
									<c:when test="${state == '결석'}">
										<p style="color: red">결석</p>
									</c:when>
								</c:choose></td>
						</tr>

					</c:forEach>


				</table>
			</div>
			<br> <br>

			<div id="div4">
				<table class="table">
					<colgroup>
						<col style="width: 80px" />
						<col style="width: 180px" />
						<col style="width: 180px" />
						<col style="width: 80px" />
					</colgroup>

					<tr>
						<th>학생</th>
						<th>출석시간</th>
						<th>퇴실시간</th>
						<th>상태</th>
					</tr>

					<h3>4회차</h3>
					<!-- 출석 현황 -->
					<c:forEach var="attendanceList_student"
						items="${attendanceList_student}" begin="60" end="79">
						<tr>
							<td>${attendanceList_student.id}</td>
							<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss"
									value="${attendanceList_student.start_date_time}" /></td>
							<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss"
									value="${attendanceList_student.end_date_time}" /></td>
							<td><c:set var="state"
									value="${attendanceList_student.state}" /> <c:choose>
									<c:when test="${state == '정상'}">
										<p style="color: black">정상</p>
									</c:when>

									<c:when test="${state == '지각'}">
										<p style="color: blue">지각</p>
									</c:when>
									<c:when test="${state == '조퇴'}">
										<p style="color: blue">조퇴</p>
									</c:when>
									<c:when test="${state == '결석'}">
										<p style="color: red">결석</p>
									</c:when>
								</c:choose></td>
						</tr>

					</c:forEach>


				</table>
			</div>
			<br> <br>

			<div id="div5">
				<table class="table">
					<colgroup>
						<col style="width: 80px" />
						<col style="width: 180px" />
						<col style="width: 180px" />
						<col style="width: 80px" />
					</colgroup>

					<tr>
						<th>학생</th>
						<th>출석시간</th>
						<th>퇴실시간</th>
						<th>상태</th>
					</tr>

					<h3>5회차</h3>
					<!-- 출석 현황 -->
					<c:forEach var="attendanceList_student"
						items="${attendanceList_student}" begin="80" end="99">
						<tr>
							<td>${attendanceList_student.id}</td>
							<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss"
									value="${attendanceList_student.start_date_time}" /></td>
							<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss"
									value="${attendanceList_student.end_date_time}" /></td>
							<td><c:set var="state"
									value="${attendanceList_student.state}" /> <c:choose>
									<c:when test="${state == '정상'}">
										<p style="color: black">정상</p>
									</c:when>
									<c:when test="${state == '지각'}">
										<p style="color: blue">지각</p>
									</c:when>
									<c:when test="${state == '조퇴'}">
										<p style="color: blue">조퇴</p>
									</c:when>
									<c:when test="${state == '결석'}">
										<p style="color: red">결석</p>
									</c:when>
								</c:choose></td>
						</tr>
					</c:forEach>




				</table>
			</div>
		</div>
	</div>

	<%--  <%@ include file="../footer.jsp" %> --%>

</body>
</html>
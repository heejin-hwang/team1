<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
	String[] addr = request.getRequestURI().split("/");
	String currPage = addr[addr.length - 2];
	String title = addr[addr.length - 1];
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<%
	if (currPage.equals("Schedule")) {
%>
<title>에이콘아카데미 일정</title>
<%
	}
%>
<%
	if (currPage.equals("Notice")) {
%>
<title>에이콘아카데미 공지사항</title>
<%
	}
%>
<%
	if (currPage.equals("HOME")) {
%>
<title>에이콘아카데미</title>
<%
	}
%>
<%
	if (currPage.equals("Student")) {
%>
<title>에이콘아카데미 학생관리</title>
<%
	}
%>
<%
	if (currPage.equals("Group")) {
%>
<title>에이콘아카데미 그룹</title>
<%
	}
%>
<%
	if (currPage.equals("Assignment")) {
%>
<title>에이콘아카데미 과제관리</title>
<%
	}

	if (currPage.equals("FileNotice")) {
%>
<title>에이콘아카데미 파일공유</title>
<%		
	}
%>


<link rel="icon" href="/resources/img/favicon.ico">
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<script src="/resources/js/header.js"></script>

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

			<!-- Logo section -->
			<div class="header_2">
				<a href="../../HOME/HOME"><img src="/resources/img/logo.png"
					alt="logo"></a>
			</div>

			<!-- Navigation bar section -->
			<nav class="header_3">
				<div id="menu">
					<i class="fa fa-bars" aria-hidden="true"></i>
				</div>
				<ul>
					<%
						if (currPage.equals("HOME")) {
					%>
					<li><a href="../HOME/HOME" class="active">홈</a></li>
					<%
						} else {
					%>
					<li><a href="../HOME/HOME">홈</a></li>
					<%
						} // if-else
					%>
					<%
						if (currPage.equals("Notice")) {
					%>
					<li><a href="../Notice/Notice" class="active">공지사항</a></li>
					<%
						} else {
					%>
					<li><a href="../Notice/Notice">공지사항</a></li>
					<%
						} // if-else
					%>
					<%
						if (currPage.equals("Schedule")) {
					%>
					<li><a href="../Schedule/Schedule" class="active">일정</a></li>
					<%
						} else {
					%>
					<li><a href="../Schedule/Schedule">일정</a></li>
					<%
						} // if-else

						if (currPage.equals("FileNotice")) {
					%>
					<li><a href="../FileNotice/FileNotice" class="active">파일공유</a></li>
					<%
						} else {
					%>
					<li><a href="../FileNotice/FileNotice">파일공유</a></li>
					<%
						} // if-else
					%>

					<c:if
						test="${login.job_id eq '0' || login.job_id eq '1' || login.job_id eq '2' }">
						<%
							if (currPage.equals("Student")) {
						%>
						<li><a href="../Student/Student" class="active">학생관리</a></li>
						<%
							} else {
						%>
						<li><a href="../Student/Student">학생관리</a></li>
						<%
							} // if-else
						%>
					</c:if>
					<c:choose>
						<c:when
							test="${login.job_id eq '0' || login.job_id eq '1' || login.job_id eq '2' }">
							<%
								if (currPage.equals("Group")) {
							%>
							<li><a href="../Group/AdminGroup" class="active">그룹</a></li>
							<%
								} else {
							%>
							<li><a href="../Group/AdminGroup">그룹</a></li>
							<%
								} // if-else
							%>
						</c:when>
						<c:when test="${login.job_id eq '4'}">
							<%
								if (currPage.equals("Group")) {
							%>
							<li><a href="../Group/DetailGroup" class="active">그룹</a></li>
							<%
								} else {
							%>
							<li><a href="../Group/DetailGroup">그룹</a></li>
							<%
								} // if-else
							%>
						</c:when>
					</c:choose>
				</ul>
			</nav>

		</div>

	</header>

	<div class="titlebar">
		<div class="sub">
			<%
				if (title.matches("HOME(.*)") && currPage.equals("HOME")) {
			%>
			<h1 class="sub2">
				<span class="typer" data-text="안녕하세요. 에이콘포탈입니다."></span>
			</h1>
			<%
				}

				if (title.matches("Schedule(.*)") && currPage.equals("Schedule")) {
			%>
			<h1 class="sub2">일정</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">일정</a></li>
			</ul>
			<%
				}

				if (title.matches("addNotice(.*)") && currPage.equals("Notice")) {
			%>
			<h1 class="sub2">공지사항 추가</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">공지사항</a></li>
				<li><a href="#">추가</a></li>
			</ul>
			<%
				}

				if (title.matches("detailNotice(.*)") && currPage.equals("Notice")) {
			%>
			<h1 class="sub2">공지사항</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">공지사항</a></li>
			</ul>
			<%
				}

				if (title.matches("editNotice(.*)") && currPage.equals("Notice")) {
			%>
			<h1 class="sub2">공지사항 수정</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">공지사항</a></li>
				<li><a href="#">수정</a></li>
			</ul>
			<%
				}

				if (title.matches("Notice(.*)") && currPage.equals("Notice")) {
			%>
			<h1 class="sub2">공지사항</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">공지사항</a></li>
			</ul>
			<%
				}

				if (title.matches("Student(.*)") && currPage.equals("Student")) {
			%>
			<h1 class="sub2">학생관리</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">학생관리</a></li>
			</ul>
			<%
				}

				if (title.matches("addStudent(.*)") && currPage.equals("Student")) {
			%>
			<h1 class="sub2">학생 추가</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">학생관리</a></li>
				<li><a href="#">추가</a></li>
			</ul>
			<%
				}

				if (title.matches("detailStudent(.*)") && currPage.equals("Student")) {
			%>
			<h1 class="sub2">학생 관리</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">학생관리</a></li>
			</ul>
			<%
				}

				if (title.matches("editStudent(.*)") && currPage.equals("Student")) {
			%>
			<h1 class="sub2">학생 수정</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">학생관리</a></li>
				<li><a href="#">수정</a></li>
			</ul>
			<%
				}

				if (title.matches("main(.*)") && currPage.equals("Assignment")) {
			%>
			<h1 class="sub2">과제 관리</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">과제관리</a></li>
			</ul>
			<%
				}

				if (title.matches("DetailGroup(.*)") && currPage.equals("Group")) {
			%>
			<h1 class="sub2">그룹</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">그룹</a></li>
			</ul>
			<%
				}

				if (title.matches("Group(.*)") && currPage.equals("Group")) {
			%>
			<h1 class="sub2">그룹</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">그룹</a></li>
			</ul>
			<%
				}
				
				if (title.matches("AdminGroup(.*)") && currPage.equals("Group")) {
			%>
			<h1 class="sub2">그룹</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">그룹</a></li>
			</ul>
			<%
				}
				
				if (title.matches("addFileNotice(.*)") && currPage.equals("FileNotice")) {
			%>
			<h1 class="sub2">파일 추가</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">파일공유</a></li>
				<li><a href="#">추가</a></li>
			</ul>
			<%
				}
				if (title.matches("editFileNotice(.*)") && currPage.equals("FileNotice")) {
			%>
			<h1 class="sub2">파일 수정</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">파일공유</a></li>
				<li><a href="#">수정</a></li>
			</ul>

			<%
				}

				if (title.matches("FileNotice(.*)") && currPage.equals("FileNotice")) {
			%>
			<h1 class="sub2">파일공유</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">파일공유</a></li>
			</ul>
			<%
				}

				if (title.matches("detailFileNotice(.*)") && currPage.equals("FileNotice")) {
			%>
			<h1 class="sub2">파일공유</h1>
			<ul class="breadcrumb sub1">
				<li><a href="../HOME/HOME"><i class="fa fa-home" aria-hidden="true"
						style="padding-right: 5px;"></i>홈</a></li>
				<li><a href="#">파일공유</a></li>
			</ul>
			<%
				}
			%>
		</div>
	</div>
	
	<script>
	var $typer = $('.typer'),
	txt = $typer.data("text"),
	tot = txt.length,
	ch  = 0;

	(function typeIt() {   
	if(ch > tot) return;
	$typer.text( txt.substring(0, ch++) );
	setTimeout(typeIt, ~~(Math.random()*(300-60+1)+60));
	}());
	</script>

	<section>
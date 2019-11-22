<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>

<link rel="stylesheet" href="/resources/css/style.css">

<script>
$(document).ready(function(){
	var formObj = $("form[role='form']");
	console.log(formObj);
	
	$("#btn-warning").on("click", function(){
		self.location="/HOME/HOME?page=${cri.page}&perPageNum=${cri.perPageNum}"
				+"&searchType=${cri.searchType}&keyType=${cri.keyword}";
		});
	
	$("#btn-primary").on("click", function(){
		formObj.submit();
	});
});
	
</script>

<link href="/resources/css/editNotice.css" rel="stylesheet">

<style>
	.box-footer{
		margin-top: 12px;
		float:right;
	}
	.box-footer::after{
		context:'';
		display:block;
		clear: both;
	}
	.click_bo2{
		border: none;
		color: #fff;
		background-color: #3C6188;
		font-size: 14px;
		display: inline-block;
		width: 80px;
		height: 30px;
		line-height: 30px;
		border-radius: 5px;
		margin: 0 5px;
		cursor: pointer;
		-webkit-border-radius: 5px;
		-moz-border-radius: 5px;
		-ms-border-radius: 5px;
		-o-border-radius: 5px;
	}
	.add_outList {
		width: 1100px;
		margin: auto;
	}
	.text_area{
		width: 1100px;
	}
	
</style>


<%@ include file="../chat.jsp" %>

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
						style="vertical-align: middle; padding: 8px;"></i>홈</a></li>
				<li><a href="#">TIP</a></li>
			</ul>
		</div>
	</div>


<div class="add_outList">
	<form role="form" action="modify" method="post">

		<input type='hidden' name='bno' value="${vo.bno}">
		<input type='hidden' name='page' value="${cri.page}">
		<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
		<input type='hidden' name='searchType' value="${cri.searchType}">
		<input type='hidden' name='keyword' value="${cri.keyword}">
		
		<div class="add_button">
				
			<div class="write_form">
				<p class="list_num">글번호: ${vo.bno }</p>
				
				<table class="table">
	
			<!---------------------------------제 목------------------------------------------------->
					<tr>	
						<th>제목</th>
						<td colspan="3">
							<input type="text" name='title' class="input_area" value="${vo.title}">
						</td>
					</tr>		
					
			
		
			<!---------------------------------작성자----------------------------------------------->
					<tr>		
						<th>작성자</th>
						<td colspan="3">
							<input type="text" name='writer' class="input_area" value="${vo.writer}" readonly>
						</td>
					</tr>		
					
				</table>
				<!------------------------------textarea----------------------------------------->
				<div class="content">
					<label>내용</label>	
					<textarea class="text_area" name="content">${vo.content }</textarea>
				</div>	
			</div>	
			
			<div class="box-footer">
				<button class="click_bo" type ="button" id="btn-warning">취소</button>
				<button class="click_bo2" type ="button" id="btn-primary"> 수정완료</button>
		
			</div>
		</div>
	</form>
</div>

</body>
</html>
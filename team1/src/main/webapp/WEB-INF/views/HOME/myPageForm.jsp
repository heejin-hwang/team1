<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<!-- 
<script type="text/javascript">
	$(function() {
		$("#alert-check").hide();

		$("input").keyup(function() {
			var start_checked = $("#start_checked").val();
			if (start_checked == "${attendance.start_checked}") {
				$("#alert-check").show();
			} else {
				$("#alert-check").hide();
			}
		});
	});
</script>
 -->

</head>
<!-- <script type="text/javascript">

	window.history.forward();

		function noBack() {

			window.history.forward();

		}

 



         </script> -->
<body>

	<!-- <body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
 -->
	<h5>[${login.name}]님</h5>
	<h5>그룹명 : email : ${login.id}</h5>
	<a href="/HOME/HOME"><strong>HOME></strong></a>


	<%-- 	
		<input type="hidden" name="start_checked" id="start_checked" value="true" >
  <div class="alert-check" id="alert-check" style="margin: 0; padding: 5px 0 20px; color: red;"><h5>출석 시간 :[${attendance.start_date_time}] </h5></div> 
			
 --%>
	<h5>현재 [${login.course_name}] 를 수강중입니다.</h5>


	<h5><c:if test="${attendance.start_date_time == true }">출석 시간 :[${attendance.start_date_time}] </c:if>
		<c:if test="${attendance.end_checked == false }">[${attendance.state}] </c:if> </h5>
	<h5>체크아웃 시간 :[${checkout.end_date_time}] [${checkout.state}]</h5>


	<form action="/HOME/attendancePost" method="post">
		<input type="hidden" name="userId" id="email" value="${login.id}"
			style="border: none;" readonly>

		<%--      <input type="hidden" name="end_checked" id="end_checked" value="${checkout.end_checked}" style =  border:none;  readonly>
    <br>   --%>


		<input type="hidden" name="useAttendanceCookie" value="true"
			style="border: none;" readonly> <input type="submit"
			value="출석하기 " class="submit">
	</form>

	<form action="/HOME/checkoutPost" method="post">
		<input type="hidden" name="userId" id="email" value="${login.id}"
			style="border: none;" readonly> <br>

		<!--    <input type="hidden" name="end_checked"  value="true" style =  border:none;  readonly>
    <br>  -->


		<input type="submit" value="체크아웃 " class="submit">
	</form>
	<form action="/Member/logout" method="GET">
		<a href=""><button>로그아웃</button></a>
	</form>
	<form action="/HOME/attendanceList" method="GET">
		<a href=""><button>출석리스트</button></a>
	</form>
</body>
</html>
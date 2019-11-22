<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(function(){
	
	var score =[];
	
	/* $("#submit").on("click",function(){
		$("input[name=score]").foreach({
			var sc = $(this);
			console.log("5555555555", sc);
			score.push(sc);
		});
		$("#score").val(score);
		console.log("score[]",score);
	})
	 */
})
</script>
<body>
	<div class="table">
		<!-- <form id="Form" method="POST" action="/HOME/test_infoPost"> -->

			<table class="table">
				<!-- 테이블 -->
				<tr>
					<td>시험 명</td>
					<td><c:forEach var="getGrade_T" items="${getGrade_T}"
							begin="0" end="0">
							<input type="text" name="test_name" required
								value="${getGrade_T.name}">
						</c:forEach>
				<tr>
					<td><input type="text" name="test_id"
						value="${getTest_T.id}"></td>
				</tr> 
				<tr>
					<td><input type="text" name="admin_id"
						value="${getTest_T.admin_id}"></td>
				</tr>

				<colgroup>
					<col style="width: 80px" />
					<col style="width: 180px" />
					<col style="width: 80px" />
					

				</colgroup>

				<tr>
					<!-- 테이블 목록 제목-->
					<th>학생</th>
					<th>점수</th>
					<th>통과 여부</th>


				</tr>

				<!-- 게시글 목록 -->
				<%-- <c:forEach var="attendanceList_T" items="${attendanceList_T}"
					begin="0" end="0">

					<tr>

						<td>${attendanceList_T.name}</td>
						<td><input type=hidden name="userId" value="${attendanceList_T.student_id}"> 
					
							<input type="text" name="score" required> </td>
						
						<td>	<input type="text"name="pass" required></td>



					</tr>
				</c:forEach> --%>
				
					<!-- 게시글 목록 -->
				<c:forEach var="attendanceList_T" items="${attendanceList_T}"
				>

					<tr>

						<td>${attendanceList_T.name}</td>
						<td><input type=hidden name="userId" value="${attendanceList_T.student_id}"> 
				
					<%-- <% 
					String[] score = (String[])(request.getParameterValues("score")); 
					%>  --%>
					
					<input type="text" name="score" required> </td>
							
					
						<td>	<input type=hidden name="pass" value="합격"></td>



					</tr>
				</c:forEach>
				<input type="hidden" id="score">
			</table>
			<!--end table :: class=table-->

			<input type="button" id="submit" value="등록">




		<!-- </form> -->
	</div>
</body>
</html>
<%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>

<link href="/resources/css/studentTable.css" rel="stylesheet">
<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>
<script type="text/javascript">

</script>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
        <div class="buttons">
            <div class="button">
                <input type="button" type="submit" value="수정" onclick="location.href='editStudentAdmin?id=${id}';">
                <input type="button" value="목록" onclick="location.href='Student';">
            </div>
        </div>
        <div class="table">
            <table id="detail" class="boardtable">
                <tr>
					<th>학생아이디</th>
					<td>${id}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${name}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${birthday}</td>
				</tr>
				<tr>
					<th>훈련과정</th>
					<td>${course_name}</td>		
					<%-- <option value="${courseDTO.code}">${courseDTO.name}</option> --%>
				</tr>
								
				
                <tr>
                    <th>훈련상태</th>
                    <td>${state}</td>
                </tr>
 <!--                <tr>
					<th>출석일수</th>
					<td></td>
				</tr>
				<tr>
					<th>결석일수</th>
					<td></td>
				</tr>
				<tr>
					<th>시험점수</th>
					<td></td>
				</tr> -->
				<tr>
					<th>핸드폰번호</th>
					<td>${mobile_phone}</td>
				</tr>
				<tr>
					<th>비상연락처</th>
					<td>${temporarily_number}</td>
				</tr>
				<tr>
					<th>기본주소</th>
					<td>${address}</td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td>${detail_address}</td>
				</tr>
                
            </table>
        </div>

<%@ include file="../footer.jsp" %>



<%-- <%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>에이콘아카데미 학생상세정보</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/studentTable.css">
    <style>
        <%@ include file="/css/studentTable.css"%>
    </style>
</head>

<body>
    <%@ include file="/header.jsp" %>
	<%@ include file="/chat.jsp" %>
	

    <div class="section">
    <div
			class="subsubject">
		<p><a href="#">홈 > <a href="#">학생관리</a></p>
	</div>
        <div class="buttons">
            <div class="button">
                <input type="button" type="submit" value="수정" onclick="location.href='editStudent?student_id=${id}';">
                <input type="button" value="테이블" onclick="location.href='Student';">
            </div>
        </div>
        <div class="table">
            <table id="detail">
                <tr>
					<th>학생아이디</th>
					<td>${id}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${name}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${birthday}</td>
				</tr>
				<tr>
					<th>훈련과정</th>
					<td>${course_name}</td>
				</tr>
				<tr>
					<th>그룹아이디</th>
					<td>${groups_name}</td>
				</tr>
                <tr>
                    <th>훈련상태</th>
                    <td>${state}</td>
                </tr>
                <tr>
					<th>출석일수</th>
					<td></td>
				</tr>
				<tr>
					<th>결석일수</th>
					<td></td>
				</tr>
				<tr>
					<th>시험점수</th>
					<td></td>
				</tr>
				<tr>
					<th>핸드폰번호</th>
					<td>${mobile_phone}</td>
				</tr>
				<tr>
					<th>비상연락처</th>
					<td>${temporarily_number}</td>
				</tr>
				<tr>
					<th>기본주소</th>
					<td>${address}</td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td>${detail_address}</td>
				</tr>
                
            </table>
        </div>
    </div>
   
    <%@ include file="/footer.jsp"%>
</body>

</html> --%>
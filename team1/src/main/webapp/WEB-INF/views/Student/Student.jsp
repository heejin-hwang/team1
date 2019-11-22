<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/resources/css/studentTable.css" rel="stylesheet">
<link href="/resources/css/pagination.css" rel="stylesheet">
<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>

<script> 
function press(f){ 
	if(f.keyCode == 13){ //javascript에서는 13이 enter키를 의미함 
		search.submit(); 
	//formname에 사용자가 지정한 form의 name입력 
		} 
	} 

function fn_searchList(){
	var search_text = $("#search_text").val();
	
	window.location.href="Student?page=1&perPageNum=10&search_text="+search_text;
}
</script>



		
		<div id="search">
			<form action="" method="GET" name="search">
				<div class="button">
					<span> 
						<select name="search" id="option" default = "${search}" }>
							<option value="name">이름</option>
							<option value="id">학생아이디</option>
							<option value="birthday">생년월일</option>
							<option value="state">훈련상태</option>
							<option value="course_name">훈련과정</option>
						</select>
					</span> 
					<span><input name="value" default = "${value}" id = "search_text" class="search_text" type="text"></span> 
					<span><input id="button" onkeypress="JavaScript:press(this.form)" type="submit" value="검색"></span>
					<span>
					<button id="button" onclick="location.href='addStudent'; return false;">등록</button>
					</span>
				</div>
			</form>

		</div>
		<div class="table">
			<table id="board" class="boardtable">
				<tr>
					<th>이름</th>
					<th>학생아이디</th>
					<th>훈련과정</th>
					<th>훈련상태</th>
					<th>출석일수</th>
				</tr>
				
				
				<c:forEach var="studentListVO" items="${studentListPaging}">
				
					<tr class=table_list>
					<td><a href="${path}/Student/detailStudent?id=${studentListVO.id}">${studentListVO.name}</a></td>
						<%-- <td><a href="${path}/Student/detailStudent${pageMaker.makeQuery(pageMaker.criteria.page)}&id=${studentListVO.id}">${studentListVO.name}</a></td> --%>
						<td>${studentListVO.id}</td>
						<td>${studentListVO.course_name}</td>
						<td>${studentListVO.state}</td>
						<td>50</td>
					</tr>
				</c:forEach>
				

			</table>
		</div>
		<div class="center">
			<div class="pagination">
				  
			  	<c:if test="${pageMaker.prev}">
					<a href="Student${pageMaker.makeQuery(pageMaker.startPage - 1)}">&laquo;</a>
				</c:if>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<c:if test="${pageMaker.criteria.page == idx}">
						<a href="Student${pageMaker.makeQuery(idx)}&search=${search}&value=${value}" class="active">${idx}</a>
					</c:if>
					<c:if test="${pageMaker.criteria.page != idx}">
						<a href="Student${pageMaker.makeQuery(idx)}&search=${search}&value=${value}">${idx}</a>
					</c:if>
					
					
					<%-- <c:out value="${pageMaker.criteria.page == idx?'class = active':''}"/>
						<a href="Student${pageMaker.makeQuery(idx)}">${idx}</a> --%>
					
				</c:forEach>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<a href="Student${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a>
				</c:if>
			</div>
		</div>

<%@ include file="../footer.jsp" %>

</html>

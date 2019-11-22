<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>


<script>

var result='${msg}';

if(result == 'success'){
	alert("처리가 완료되었습니다.");
}

</script>

<script>
	$(document).ready(function(){
		$('#searchBtn').on(
			"click",
			function(event){
					self.location = "list"
					+ '${pageMaker.makeQuery(1)}'
					+"&searchType="
					+$("select option:selected").val()
					+"&keyword=" +$('#keywordInput').val();
				});
			/* $('#newBtn').on("click", function(evt){
				self.location = "HomeNotice/register";
			}); */
	});
	

</script>

<style type="text/css">
	
	.pagination{
		border: 1px solid red;
	}

</style>

</head>
<body>

<form action="/HomeNotice/register" method ="Get"> 
	<a href=""><button>글쓰기</button></a>
</form>
	
<div class='box-body'>

	<select name = "searchType">
		<option value ="n"
			<c:out value="${cri.searchType == null?'selected':''}"/>>
			---</option>
		<option value ="t"
			<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
			제목</option>
		<option value="c"
			<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
			내용</option>
		<option value="w"
			<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
			작성자</option>
		<option value="tc"
			<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
			제목 OR내용</option>
		<option value="cw"
			<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
			내용 OR 작성자</option>
		<option value="tcw"
			<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
			제목 OR 내용 OR 작성자</option>
	</select>
</div>

	<input type="text" name ='keyword' id="keywordInput" value='${cri.keyword} '>
	<button id='searchBtn'>Search</button>


       <!--  게시글  -->
        <div class="table_div">           
            <table class="table">     

                <colgroup>
                    <col style="width: 60px"/>
                    <col style="width: 150px"/>
                    <col style="width: 100px"/>
                    <col style="width: 150px"/>
                    <col style="width: 80px"/>
                </colgroup>

                <tr>         
                    <th >글번호</th>
                    <th >제목</th>
                    <th >작성자</th>
                    <th >작성일</th>
                    <th >조회수</th>
                </tr>
	
	<c:forEach items="${FABoardList}" var="FABoardVO">
	<tr>
	    <td>${FABoardVO.bno}</td>
	   <%--  <td><a href='/HomeNotice/readPage?bno=${FABoardVO.bno}'>${FABoardVO.title}</a></td> --%>
		<td><a href='/HomeNotice/readPage${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${FABoardVO.bno}'>
		${FABoardVO.title}</a></td>
		<td>${FABoardVO.writer}</td>
		<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
			value="${FABoardVO.regdate}"/></td>
		<td><span class="badge bg-red">${FABoardVO.viewcnt}</span></td>
	</tr>
	
	</c:forEach>
			
		
	<!-- 페이징처리 -->
	<div class="text-center">
		<ul class="pagination">
			
			<c:if test="${pageMaker.prev}">
			<li><a href="list${pageMaker.makeSearch(pageMaker.startPage -1)}">&laquo;</a></li>
			</c:if>
			
			<c:forEach begin="${pageMaker.startPage }"
			end="${pageMaker.endPage }" var="idx">
			<li
				<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
				<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
			</li>
			</c:forEach>
			
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<li><a href="list${pageMaker.makeSearch(pageMaker.endPage +1)}">&raquo;</a></li>
			</c:if>
			
		</ul>
	
	</div>

</div>    

</table>


</body>
</html>
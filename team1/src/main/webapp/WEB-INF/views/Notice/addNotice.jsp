<%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>
<%@ page import = " java.util.List" %>



<link href="/resources/css/addNotice.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>

<script src="/resources/js/addNotice.js"></script>
<% String result = request.getParameter("result");%>

<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>

<c:set var="result" value="<%=result%>"></c:set>


<input type="hidden" id="notice_result" value="${result}">

<form action = "addNotice" method = "POST" enctype="multipart/form-data" id="form">
	<!------------------------------등록 취소 버튼------------------------------->
	<div class="add_outList">
		<div class="add_button">
				<!-- 버튼 -->
				<button class="click_bo" type ="button" id="submitBtn">등록</button>
				<button class="click_bo" type="button" id="cancelBtn">취소</button>
				
				<!-- 검색을 유지를 위한 값들 -->
				<input type="hidden" name="page" id="page"value="${cri.page }">
				<input type="hidden" name="scourse_code" id="scourse_code" value="${cri.scourse_code }">
				<input type="hidden" name="scategorize" id="scategorize" value="${cri.scategorize}">
				<input type="hidden" name="cstate" id="cstate" value="${cri.cstate}">
				<input type="hidden" name="searchType" id="searchType" value="${cri.searchType }">
				<input type="hidden" name="keyword" id="keyword" value="${cri.keyword }">
		</div>	<!-- end div :: class = add_button -->
	</div>	<!-- end div :: class = add_outList -->
	
	<!------------------------------게시글 작성란------------------------------->
	<div class="add_list">
		
			<table class="boardtable">
			
			<!---------------------------------제 목------------------------------------------------->
				<tr> 	<!--subject-->
					<th>제목<span class="t_red">*</span></th>
					<td colspan="3">
						<input class="input_area" type = "text" name="subject" id="subject" autofocus > <!-- class = input_area -->
					</td>
				</tr>		<!-- end tr :: subject-->

			<!---------------------------------분 류------------------------------------------------->
				<tr> 	<!-- categorize-->
					<th>분류<span class="t_red">*</span></th>
					<td colspan="3">
						<select class="input_area" name="categorize" id="categorize">
							<option value="" disabled selected>글 종류</option>
							<option value="채용">채용</option>
							<option value="시험">시험</option>
							<option value="안내사항">안내사항</option>
							<option value="기타">기타</option>
						</select>	<!-- end select :: categorize :: class = input_area -->
					</td>
				</tr> <!-- end tr :: categorize -->

				<!---------------------------------반 목록------------------------------------------------->
				<tr> 
					<th>반 목록<span class="t_red">*</span></th>
					<td colspan="3">
							<select class="input_area" name="course_code" id="course_code">
								<option value="" disabled selected>반 목록</option>
								<c:forEach var="list" items="${course}">
                    				<option value="${list.code}">${list.name} </option>
                    			</c:forEach>
							</select>	<!-- end select :: course_code :: class = input_area -->
					</td>
				</tr>	 <!-- end tr :: course_code -->
 
				<!---------------------------------작성자----------------------------------------------->
				<tr>	<!-- admin_id-->
					<th>작성자<span class="t_red">*</span></th>
					<td colspan="3">
						<input class="input_area" type = "text" name="name"id="name"value="${login.name}" readonly>
					</td>	 <!-- class = input_area -->
	
				</tr>		<!-- end tr :: admin_id-->

				<!---------------------------------시작 날짜 / 종료날짜-------------------------------------------->
				<tr>	<!-- start_date // end_date-->
					<th>시작 날짜<span class="t_red">*</span></th>
					<td><input class="input_date" type="date" pattern="yyyy-MM-dd" name="start_date" id="start_date"></td> <!-- class = input_date -->
					<th>종료 날짜<span class="t_red">*</span></th>
					<td><input class="input_date" type="date" pattern="yyyy-MM-dd" name="end_date" id="end_date"></td>  <!-- class = input_date -->
				</tr>		<!-- end tr :: start_date // end_date -->

				<!---------------------------------파일 업로드-------------------------------------------->
				<tr>	
					<th>첨부파일</th>
					<td colspan="3">
						<div class="filebox">
							<label for="file" id="upload">Upload</label>
							<input class="upload-hidden" type="file" name = "files" id="file" multiple>
							
							<input class="upload-name" value="파일선택" disabled="disabled">
						</div>
					</td>	
				</tr>	
			</table>	<!--end table :: class=table-->
			

		<!------------------------------textarea----------------------------------------->
		<div class="content">
			<label>내용</label>	<!--textarea label-->
			<textarea class="text_area"name="context" placeholder="1000자 이하로 내용을 입력해주세요."></textarea>
		</div>	<!-- end div :: class = content -->
		
	</div>    <!-- end div :: class = add_list -->
</form>	 <!-- end form :: action : addNotice :: method : poast -->	
<%@ include file="../footer.jsp"%>

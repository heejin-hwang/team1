<%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>    	
<%@ page import = "java.util.List" %>

<link href="/resources/css/editNotice.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<script src="/resources/js/editNotice.js"></script>

<% String result = request.getParameter("result");%>
<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>

<c:set var="result" value="<%=result%>"></c:set>


<input type="hidden" id="notice_result" value="${result}">

	<form action="editNotice" method="Post" id="form" enctype="multipart/form-data">
	
        <!------------------------------등록, 취소, 삭제 버튼------------------------------->
        <div class="add_outList">
            <div class="add_button">
            		<!-- 검색 유지를 위한 값들 -->
            		<input type="hidden" name ="id" id="id" value="${editread.id }">
            		<input type="hidden" name="page" id="page"value="${cri.page }">
					<input type="hidden" name="scourse_code" id="scourse_code" value="${cri.scourse_code }">
					<input type="hidden" name="scategorize" id="scategorize" value="${cri.scategorize}">
					<input type="hidden" name="cstate" id="cstate" value="${cri.cstate}">
					<input type="hidden" name="searchType" id="searchType" value="${cri.searchType }">
					<input type="hidden" name="keyword" id="keyword" value="${cri.keyword }">
					
					<!-- 버튼 -->
                    <button class="click_bo" type="button" id="updateBtn">수정완료</button>
                    <button class="click_bo" type="button" id="cancelBtn">취소</button>
                    <button class="click_bo" type="button" id="deleteBtn" >삭제</button>
            </div>	<!--end div :: add_button-->
        </div>	<!--end div :: add_outList-->

        <!------------------------------게시글 ------------------------------->
        <div class="write_form">
            <p class="list_num">글번호: ${editread.id } </p> 
            <p class="list_date">작성일: <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${editread.upload_date }"/></p>
			<p class="list_date">수정일: <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${editread.update_date }"/></p>
                
                <table class="boardtable">
                
                <!---------------------------------제 목------------------------------------------------->
                    <tr>  <!-- subject-->
                        <th>제목<span class=t_red>*</span></th>
                        <td colspan="3">
                            <input class="input_area" type = "text"id="subject" name="subject" id="subject" value = "${editread.subject }" autofocus> <!-- class = input_area -->
                        </td>
                    </tr>		<!-- end tr :: subject-->
                    
                    <!---------------------------------분 류------------------------------------------------->
                    <tr> 	<!-- categorize-->
                        <th>분류</th>
                        <td colspan="3">
                            <select class="input_area" name="categorize" >
                                <option value="채용" 
                                	<c:out value="${editread.categorize eq '채용' ? 'selected':''}"/>>
                                	채용
                                </option>
                                <option value="시험"
                                	<c:out value="${cri.scategorize eq '시험' ? 'selected':''}"/>>
                                	시험안내
                                </option>
                                <option value="안내사항"
                                	<c:out value="${editread.categorize eq '안내사항' ? 'selected':''}"/>>
                                	안내사항
                                </option>
                                <option value="기타"
                                	<c:out value="${editread.categorize eq '기타' ? 'selected':''}"/>>
                                	기타
                                </option>
                             </select> <!-- end select :: class = input_area -->
                        </td>
                    </tr>		<!-- end tr :: categorize -->
                    
               <!---------------------------------반 목록------------------------------------------------->
                    <tr>	<!-- course_code-->
                        <th>반 목록</th>
                        <td colspan="3">
                           		<select class="input_area" name="course_code">   
                    				<c:forEach var="list" items="${course}">
                    					<option value="${list.code}"
                    						<c:out value="${list.code == editread.course_code? 'selected':'' }"/>>
                    						${list.name} 
                    					</option>
                    				</c:forEach>
                            	</select>	<!-- end select :: class = input_area -->
                        </td>
                    </tr>		<!-- end tr :: course_code  -->
                    
                <!---------------------------------작성자----------------------------------------------->
                    <tr>	<!-- admin_id-->
                        <th>작성자<span class=t_red>*</span></th>
                        <td colspan="3">
                            <input class="input_area" type = "text" name="name" value = "${login.name}" readonly >
                        </td> <!-- class = input_area -->
                    </tr>		<!-- end tr :: admin_id-->
                    
                <!---------------------------------시작 날짜 / 종료날짜-------------------------------------------->
                    <tr>	<!-- start_date // end_date-->
                        <th>시작 날짜<span class=t_red>*</span></th>	<!-- start_date -->
                        <td class="start_date">
                         	<input class="input_date" type="date"  pattern="yyyy-MM-dd" name="start_date" id="start_date"value="<fmt:formatDate pattern="yyyy-MM-dd" value="${editread.start_date }"/>" required> <!-- class = input_date -->
                        </td>		<!-- start_date  :: class = start_date -->
                        
                        <th>종료 날짜<span class=t_red>*</span></th>	<!-- end_date -->
                        <td class="end_date">
                        	<input class="input_date" type="date" pattern="yyyy-MM-dd" name="end_date" id="end_date" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${editread.end_date }"/>" required> <!-- class = input_date -->
                        </td>		<!-- end_date  :: class = end_date -->
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
							 <c:forEach var="list" items="${editread.files}">
	                          	<div class="fileDiv">
									<a href="/Notice/fileDownload?file_id=${list.id}">${list.name}</a>
									<button type="button" class="fileCancel" value="${list.id }">X</button>
								 </div>
							</c:forEach>
                    	</td>	
                    </tr>		
                     <input type="hidden" id="delete_file" name="delete_file" value="">
                </table>	<!--end table :: class=table-->
          
            <!------------------------------textarea----------------------------------------->
            <div class="content">
                <label>내용</label>	<!--textarea label-->
                <textarea class="text_area"name="context" placeholder="1000자 이하로 내용을 입력해주세요.">${editread.context}
                </textarea>		<!--end textarea label :: class = text_area--> 
            </div>	<!-- end div :: class = content -->
        </div>     <!-- end div :: class = write_form -->
       </form>		 <!-- end form :: action : editNotice :: method : poast -->	

    
<%@ include file="../footer.jsp"%>
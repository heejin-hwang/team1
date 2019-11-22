<%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>    
<%@ page import = "java.util.List" %>

<link href="/resources/css/fileNotice/FileNotice.css" rel="stylesheet">
<link href="/resources/css/pagination.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<script src="/resources/js/fileNotice/FileNotice.js"></script>

<% String result = request.getParameter("result");%>
<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>
<c:set var="result" value="<%=result%>"></c:set>


<input type="hidden" id="notice_result" value="${result}">
	
        <div class="search">
           <form id="form">
         
            <div class="select_C_N">
             <!---------------반 목록 select박스--------------->
         		<c:if test="${login.job_id eq '1' || login.job_id eq '0' || login.job_id eq '2'}">
             
                <select name="scourse_code" class="search_select2" id="course_code">
                	<option value="0">반 목록</option>	<!-- end option :: null -->
                    <c:forEach var="list" items="${course}">
                    	<option value="${list.code}"
                    		<c:out value="${list.code == cri.scourse_code ? 'selected':'' }"/>>
                    		${list.name} 
                    	</option>	 <!-- end option :: course_code :: course_code -->
                    </c:forEach>
                </select>		  <!--end select :: course_code-->
       			</c:if>
               
             <!---------------categorize 목록 select박스--------------->
                <select class="search_select" name = "scategorize" id="categorize">
                        <option value=""
                        	<c:out value="${cri.scategorize == null ? 'selected':''}"/>>
                        	글 종류
                        </option>	 <!-- end option :: null -->
                        <option value="채용"
                        	<c:out value="${cri.scategorize eq '채용' ? 'selected':''}"/>>
                        	채용
                        </option>	 <!-- end option :: 채용-->
                        <option value="시험"
                         	<c:out value="${cri.scategorize eq '시험' ? 'selected':''}"/>>
                         	시험사항
                         </option>	 <!-- end option :: 시험사항-->
                        <option value="안내사항"
                       		 <c:out value="${cri.scategorize eq '안내사항' ? 'selected':''}"/>>
                       		 안내사항
                       	</option>	 <!-- end option :: 안내사항-->
                        <option value="기타"
                        	<c:out value="${cri.scategorize eq '기타' ? 'selected':''}"/>>
                        	기타
                       </option>	 <!-- end option :: 기타-->
                </select>       <!--end select :: categorize-->
                
               <!---------------state 목록 select박스--------------->
                <c:if test="${login.job_id eq '1' || login.job_id eq '0' || login.job_id eq '2'}">
                	<select class="search_select" name = "cstate" id="state">
                        <option value=""
                        	<c:out value="${cri.cstate == null ? 'selected':''}"/>>
                        	수업 상태
                        </option>	 <!-- end option :: null -->
                        <option value="Closed"
                        	<c:out value="${cri.cstate eq 'Closed' ? 'selected':''}"/>>
                        	Closed
                        </option>	 <!-- end option :: 채용-->
                        <option value="Running"
                         	<c:out value="${cri.cstate eq 'Running' ? 'selected':''}"/>>
                         	Running
                         </option>	 <!-- end option :: 시험사항-->
                        <option value="Planning"
                       		 <c:out value="${cri.cstate eq 'Planning' ? 'selected':''}"/>>
                       		 Planning
                       	</option>	 <!-- end option :: 안내사항-->
                	</select>       <!--end select :: categorize-->
               	 </c:if>
            </div>  <!--end div :: select_C_N-->
            
        	<!-----------------검색 목록---------------------->
            	<!------------ 검색 란  ------------------>
            	<div class="search2">
	                <select name="searchType"  class="search_select">
	                    <option value=""
	                    	<c:out value="${cri.searchType == null ? 'selected':''}"/>>
	                    	--------
	                    </option>	 <!-- end option :: null-->
	                    <option value="t"
	                    	<c:out value="${cri.searchType eq 't' ? 'selected':''}"/>>
	                    	제목
	                    </option>	 <!-- end option :: t :: 제목-->
	                    <option value="c"
	                    	<c:out value="${cri.searchType eq 'c' ? 'selected':'' }"/>>
	                    	내용
	                    </option>	<!-- end option :: c :: 내용-->
	                    <option value="a"
	                    	<c:out value="${cri.searchType eq 'a'? 'selected':'' }"/>>
	                    	작성자
	                    </option>	 <!-- end option :: a :: 작성자-->
	                </select>  <!--end select :: searchType-->
	                
	                 <!------------  검색 키워드 입력란 + 검색 버튼  ------------------>
	                     <input class="search_keyword" type = "text" name="keyword" id="keyword">
	                     <button class="click_bo" type = "button" id="searchBtn" >검색</button>
	                <c:if test="${login.job_id eq '1' || login.job_id eq '0' || login.job_id eq '2'}">
	                    <button class="click_bo" type = "button" id="addBtn">글쓰기</button>
       				</c:if>
           		</div>  <!-- end div :: search2 -->
        	</form> <!-- end form ::: -->
        </div>      <!-- end div ::  search -->

        <!------------------ 게시글 테이블 -------------------->
        <div class="table_div">           <!--테이블을 감싸는 공간-->
        
        	<div class="page_info">
				<span class="total_count"><strong>전체</strong> : <span id="total_count" class="t_red">${pageMaker.totalCount}</span>개</span>
			</div>
            <table class="boardtable">      <!-- 테이블 -->

                <colgroup>
                    <col style="width: 80px"/>
                    <col style="width: 480px"/>
                    <col style="width: 180px"/>
                    <col style="width: 180px"/>
                    <col style="width: 80px"/>
                </colgroup>

                <tr>         <!-- 테이블 목록 제목-->
                    <th >글번호</th>
                    <th >제목</th>
                    <th >작성자</th>
                    <th >작성일</th>
                    <th >조회수</th>
                </tr>
                
              <!-- 게시글 목록 -->
               <c:if test = "${pageMaker.pot }">
               		<tr>
               			<td colspan=5> 검색된 글이 없습니다. </td>
               		</tr>
               </c:if>
               
                <c:forEach var="list" items="${list}">
				<tr class="table_list">
                    <td>${list.id}</td> 
                    <td class="list_subject">
                    	<a href="detailFileNotice?id=${list.id}&scourse_code=${cri.scourse_code }&scategorize=${cri.scategorize}&cstate=${cri.cstate}&searchType=${cri.searchType}&keyword=${cri.keyword}&page=${cri.page}">
                    					${list.subject}
                    	</a>
                    </td>
                    <td>${list.name}</td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.update_date}"/></td>
                    <td>${list.hits}</td>
                </tr>
                </c:forEach>
            
            </table>  <!--end table :: class=table-->
            <!--  페이징 처리 공간 -->
            <div class="center">
            	<div class="pagination">
					<c:if test="${pageMaker.pprev}">
			  			<a href="FileNotice${pageMaker.makeSearch(pageMaker.startPage-1) }">&laquo;</a>
			  		</c:if>
			  		
			  		<c:if test="${pageMaker.prev}">
			  			<a href="${pageMaker.makeSearch(pageMaker.cri.page-1) }">&lt;</a>
			  		</c:if>
			  		
			  		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
			  			<a href="${pageMaker.makeSearch(idx) }" <c:out value="${pageMaker.cri.page == idx ? 'class =active' : '' }"/>>${idx}</a>
			  		</c:forEach>
			  		
			  		<c:if test="${pageMaker.next}">
			  			<a href="${pageMaker.makeSearch(pageMaker.cri.page+1) }">&gt;</a>
			  		</c:if>
			  		<c:if test="${pageMaker.nnext && pageMaker.endPage > 0 }">
			  			<a href="FileNotice${pageMaker.makeSearch(pageMaker.endPage+1) }">&raquo;</a>
			  		</c:if>
				</div> <!-- end ul :: class = pagination -->
			</div> <!--  end div :: center -->
        </div>      <!-- end div :: table_div-->
<%@ include file="../footer.jsp"%>
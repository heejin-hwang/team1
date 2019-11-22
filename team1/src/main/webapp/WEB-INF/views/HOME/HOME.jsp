<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="/resources/css/circular_prog_bar.css" rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<!-- schedule -->
<link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">

<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>
<link href="/resources/css/myMenu.css" rel="stylesheet">

<div class="wrap">
	<div class="container">
		<div class="container_service">
			<div class="content_left">
				<div class="section_info">
					<div class="info_img"></div>
					<div class="info_content">
						<div class="dl" style="padding-top:6px;">
							<div class="dt">
								<span>${login.name}&#10;(${login.id})</span>
							</div>
							<!-- <div class="dd" style="text-overflow : ellipsis; overflow : hidden; margin-right: 6px; display:inline-block; white-space:nowrap; width: 350px;"> -->
							<div class="dd">
								<span>
									<c:if test="${login.job_id == '4' }">"${login.course_name}" </c:if>
									<c:if test="${login.job_id == '0' }">관리자 모드입니다. </c:if> 
									<c:if test="${login.job_id == '1' }">채팅 관리자 모드입니다. </c:if>
									<c:if test="${login.job_id == '2' }">강사 모드입니다. </c:if>
								</span>
							</div>
							<div class="ul">
								<div class="info_resmod">
									<input type="button" class="info_button" type="submit" value="회원정보 수정" onclick="location.href='editStudent?id=${id}';">
								</div>
							</div>
						</div>
						
					</div>
				</div>
				
				<div class="section_course">
					<div class="course">
						<div class="tit">
							<h3>수강 정보</h3>
						</div>
						<div class="status">
							<div class="graph">
								<p class="date">훈련기간 :  
									<fmt:formatDate pattern="yyyy.MM.dd" value = "${login.start_date}"/> ~ <fmt:formatDate pattern="yyyy.MM.dd" value = "${login.end_date}"/>
								</p>
								<p class="dateR">과정
									<span class="date_percent">${attendance_rate}%</span>
								</p>
								<div class="graph_img">
									<form action="/HOME/HOME" method="post">
										<input type="hidden" name="userId"  value="${login.id}" style="border: none;" readonly> 
										<meter name = "meter" value="${attendance_rate}" min="1" max="100" low="1" high="100" optimum="100" style="width: 466px;">
										</meter>
									</form>
								</div>
							</div>
							<div class="detail">
								<c:if test="${login.job_id == '4' }">
									<ul class="type">
										<li class="#">출석
											<span>${attendance_count}</span>일 
										</li>
										<li class="#">지각
											<span>${late_count}</span>일
										</li>
										<li class="#">조퇴
											<span>${early_count}</span>일
										</li>
										<li class="#">결석
											<span>${noAttendance_count}</span>일
										</li>
									</ul>
								</c:if>
			   				</div>
						</div>
				
						<div class="attendance">
							<c:if test="${login.job_id == '4' }">
								<form action="/HOME/attendancePost" method="post" style="display: inline-block;">
									<input type="hidden" name="userId" id="email" value="${login.id}" style="border: none;" readonly>
									<input type="hidden" name="useAttendanceCookie" value="true" style="border: none;" readonly> 
									<input type="submit" value="출석하기 " class="button_attendance">
								</form>
								<form action="/HOME/attendanceList_student" method="post" style="display: inline-block;">
									<input type="hidden" name="userId" id="email" value="${login.id}" style =  border:none;  readonly> <br>
									<input type="submit" value="출석 현황" class="button_attendance" id="submit">
								</form>
								<form action="/HOME/checkoutPost" method="post" style="display: inline-block;">
									<input type="hidden" name="userId" id="email" value="${login.id}" style="border: none;" readonly> <br>
									<input type="submit" value="체크아웃 " class="button_attendance">
								</form>
							</c:if>
							<c:if test="${login.job_id == '1'||login.job_id == '0'||login.job_id == '2' }">
								<form action="attendanceList_T" method="GET">
									<input type="hidden" name="userId" id="email" value="${login.id}" style="border: none;" readonly> <br>
									<input type="submit" value="학생출석리스트 " class="button_attendance">
									<!-- <a href="#"><button class="button_attendance">학생출석리스트</button></a> -->
								</form>
							</c:if>
							<br>
							<h5 style="display: inline">
								<c:if test="${attendance.start_checked == true }">
									출석 시간 :[ <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value = "${attendance.start_date_time}"/>] 
								</c:if>
								<c:if test="${attendance.end_checked == false && attendance.start_checked == true }">
									[${attendance.state}] 
								</c:if>
							</h5>
							<h5>
								<c:if test="${attendance.end_checked == true }"> 
									체크아웃 시간 :[<fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value ="${checkout.end_date_time}"/>]
								</c:if>
								<c:if test="${attendance.start_checked == true && attendance.end_checked == true }">
									[${checkout.state}]
								</c:if>
							</h5> 
						</div>
			   		</div>
				</div>
	         
	         	<div class="project">
	            	<ul class="tit">
						<li class="tit_left">
							<h3>성적 확인</h3>
						</li>
	               		<li class="tit_right">
	                  		<span class="button_more">
	                     		<a class="more" href="../HOME/getGrade_student">더보기</a>
                  			</span>
               			</li>
           			</ul>
	            	<div class="pro_con">
						<div class="pro_left">
							<c:forEach var="last_score" items="${last_score}" begin="0" end="0">
                  				<c:set var="score" value="${last_score}" />
                  				<c:choose>
                     				<c:when test="${score <= 50}">
                        				<div class="progress-circle p${last_score}">
                           					<span>${score}점</span>
                           					<div class="left-half-clipper">
                              					<div class="first50-bar" ></div>
                              					<div class="value-bar"></div>
                           					</div>
                        				</div>
                     				</c:when>
                     				<c:when test="${score > 50}">
                        				<div class="progress-circle over50 p${last_score}">
                          					<span>${score}점</span>
                           					<div class="left-half-clipper">
												<div class="first50-bar"></div>
												<div class="value-bar"></div>
                       						</div>
                       					</div>
                   					</c:when>
               					</c:choose>
               				</c:forEach>
           				</div>
	               		<div class="pro_right">
	                  		<div class="table">
	                     		<table class="tbl">
	                        		<tbody>
	                           			<tr>
	                              			<th scope="row">시 험 명</th>
	                              			<td>
	                              				<c:forEach var="getGrade_student" items="${getGrade_student}" begin="0" end="0">
                                 					${getGrade_student.name}
                                 				</c:forEach>	
                              				</td>
	                           			</tr>
	                           			<tr>
	                              			<th scope="row">시험 일자</th>
	                              			<td>
	                              				<c:forEach var="getGrade_student" items="${getGrade_student}" begin="0" end="0">
													<fmt:formatDate pattern="yyyy.MM.dd" value="${getGrade_student.date}" />
                                 				</c:forEach>	
                              				</td>
	                           			</tr>
	                           			<tr>
	                              			<th scope="row">통과 여부</th>
	                              			<td>
	                              				<c:forEach var="score" items="${last_score}" begin="0" end="0">
													<c:choose>
                                       					<c:when test="${score < 60}"> <p>미통과</p> </c:when>
														<c:when test="${score >= 60}"> <p>통과</p></c:when>
													</c:choose>
                               					</c:forEach>
                           					</td>
	                           			</tr>
                       				</tbody>
                     			</table>
                  			</div>
               			</div>
            		</div>
         		</div>
	         
	         	<div class="job">
	            	<ul class="tit">
	               		<li class="tit_left">
	                  		<h3>채용 사이트 바로가기</h3>
               			</li>
            		</ul>
	            	<div class="job_con">
						<div class="jc1">
							<a href="https://www.saramin.co.kr/zf_user/" target="_blank">
								<img alt="saramin" src="/resources/img/SARAMIN.svg">							
							</a>
						</div>
						<div class="jc2">
							<a href="https://www.work.go.kr/seekWantedMain.do" target="_blank">
								<img alt="worknet" src="/resources/img/worknet.gif">
							</a>							
						</div>
						<div class="jc3">
							<a href="https://www.jobkorea.co.kr/" target="_blank">
								<img alt="jobkorea" src="/resources/img/JOBKOREA.svg">
							</a>
						</div>
					</div>
         		</div>
         		
			</div>
	      
			<div class="content_right">
				<div class="Notice">
	            	<ul class="tit">
	               		<li class="tit_left">
	                  		<h3>공지사항</h3>
               			</li>
	               		<li class="tit_right">
	                  		<span class="button_more">
                     			<a class="more" href="../Notice/Notice">더보기</a>
                  			</span>
               			</li>
            		</ul>
	            	<div class="tab_con">
						<!------------------ 게시글 테이블 -------------------->
						<table class="table">      <!-- 테이블 -->
							<colgroup>
                          		<col style="width: 80px"/>
	                          	<col style="width: 300px"/>
	                          	<col style="width: 100px"/>
	                          	<col style="width: 150px"/>
	                          	<col style="width: 80px"/>
                      		</colgroup>
	                      	<tr>         <!-- 테이블 목록 제목-->
                          		<th >글번호</th>
	                          	<th >제  목</th>
	                          	<th >작성자</th>
	                          	<th >작성일</th>
	                          	<th >조회수</th>
                      		</tr>
	                      	<!-- 게시글 목록 -->
							<c:if test = "${login.course_code ==null }">
								<tr>
	                            	<td colspan=4> 검색된 글이 없습니다. </td>
								</tr>
							</c:if>
							<c:forEach var="list" items="${list}">
                  				<tr class="table_list">
	                          		<td>${list.id}</td> 
	                          		<td class="list_subject">
	                             		<a href="../Notice/detailNotice?id=${list.id}&scourse_code=${cri.scourse_code }&scategorize=${cri.scategorize}&searchType=${cri.searchType}&keyword=${cri.keyword}&page=${cri.page}">
                                        	${list.subject}
                             			</a>
                          			</td>
	                          		<td>${list.name}</td>
	                          		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.update_date}"/></td>
	                          		<td>${list.hits}</td>
								</tr>
							</c:forEach>
						</table> 
					</div>
         		</div>
         		
	          	<div class="calendar">
					<ul class="tit">
	               		<li class="tit_left">
	                  		<h3>금주의 일정</h3>
               			</li>
	               		<li class="tit_right">
	                  		<span class="button_more">
	                     		<a class="more" href="../Schedule/Schedule">더보기</a>
                  			</span>
               			</li>
           			</ul>
	            	<div class="#">
						<%@ include file="../calendar2.jsp" %>
					</div>  
         		</div>   <!-- /calendar -->
         		
	         	<div class="tip">
	            	<ul class="tit">
	               		<li class="tit_left">
	                  		<h3>홈페이지 TIP</h3>
               			</li>
	               		<li class="tit_right">
	                  		<span class="button_more">
	                  			<c:if test="${login.job_id != '4' }">
		                  			<form action="/HOME/register" method ="Get"> 
		                     			<a href="#" class="more"><button>글쓰기</button></a>
	                  				</form> 
	               				</c:if>
                  			</span>
               			</li>
            		</ul>
           			<div class="tab_con">
           				<table class="table">
                  			<!-- 테이블 -->
							<colgroup>
								<col style="width: 80px" />
								<col style="width: 300px" />
								<col style="width: 100px" />
								<col style="width: 150px" />
								<col style="width: 80px" />
							</colgroup>
		                    <tr>
								<!-- 테이블 목록 제목-->
                           		<th>글번호</th>
		                        <th>제 목</th>
		                        <th>작성자</th>
		                        <th>날 짜</th>
		                        <th>조회수</th>
							</tr>
							<!-- 게시글 목록 -->
                       		<c:if test="${login.course_code ==null }">
                       			<tr>
                           			<td colspan=5>검색된 글이 없습니다.</td>
                       			</tr>
							</c:if>
							<c:forEach items="${FABoardList}" var="FABoardVO">
                  		   		<tr class="table_list">
                   					<td>${FABoardVO.bno}</td>
									<td class="list_subject">
                      					<a href='/HOME/readPage${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${FABoardVO.bno}'>${FABoardVO.title}</a>
              						</td>
                   					<td>${FABoardVO.writer}</td>
                  					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${FABoardVO.regdate}" /></td>
                   					<td><span class="badge bg-red">${FABoardVO.viewcnt}</span></td>
                   				</tr>
							</c:forEach>
           				</table>
                       	<!-- 페이징처리 -->
               			<div class="center" >
                  			<div class="pagination" >
                   	    		<c:if test="${pageMaker.prev}">
                           			<a href="list${pageMaker.makeSearch(pageMaker.startPage -1)}">&laquo;</a>
                              	</c:if>
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
                           			<a href="${pageMaker.makeSearch(idx) }"
										<c:out value="${pageMaker.cri.page == idx ? 'class =active' : '' }"/>>${idx}
                                    </a>
                           		</c:forEach>
                                <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<a href="list${pageMaker.makeSearch(pageMaker.endPage +1)}">&raquo;</a>
                           		</c:if>
           					</div>
           				</div>
           			</div>
      			</div>
   			</div>
	   
		</div>
	</div>
</div>

<%@ include file="../footer.jsp" %>


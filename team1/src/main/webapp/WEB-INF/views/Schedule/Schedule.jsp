<%@ page 
        language="java" 
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"
%>
<%@ page import="java.util.Calendar, java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
	Calendar cal = Calendar.getInstance();
	int currYear = Integer.parseInt(new SimpleDateFormat("YYYY").format(cal.getTime()));
	String currMonth = new SimpleDateFormat("MM").format(cal.getTime());
	System.out.println(currYear + " " + currMonth);
%>

<link href="/resources/css/Schedule.css" rel="stylesheet">
<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>

<div id="schedule">
	<form role="form" method="post" id="schedule_top">
		<button type="submit" id="schedule_btn1" name="year" value="${year - 1}">${year - 1}년</button>
		<p id="schedule_btn2">${year}년</p>
		<c:set var="requestYear" value="${year}" />
		<button type="submit" id="schedule_btn3" name="year" value="${year + 1}">${year + 1}년</button>
	</form>
	<div id="category">
		<div class="category_sub">
			<div class="category_sub1">
				<div id="category_box1"></div>
				<p>채용</p>
			</div>
		</div>
		<div class="category_sub">
			<div class="category_sub2">
				<div id="category_box2"></div>
				<p>시험</p>
			</div>
		</div>
		<div class="category_sub">
			<div class="category_sub3">
				<div id="category_box3"></div>
				<p>안내사항</p>
			</div>
		</div>
		<div class="category_sub">
			<div class="category_sub4">
				<div id="category_box4"></div>
				<p>기타</p>
			</div>
		</div>
	</div>
	<%
		int requestYear = (int)pageContext.getAttribute("requestYear");
        System.out.println("requestYear: " + requestYear);
	%>
	<table id="schedule_year">

		<!------------------------1,2,3월의 일정 출력------------------------>
		<tr class="schedule_month">
			<td>1월</td>
			<td>2월</td>
			<td>3월</td>
		</tr>

		<tr class="schedule_content">
			
			<!-----------------------1월의 일정 출력----------------------->
			<% if (currMonth.equals("01") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${1}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!-- if end date is same as start date -->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!-- if end date is not same as start date -->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!-- month of end date is not january -->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-- -----------end check sameMonth and sameDate----------- -->

							<!-- --------------------check category--------------------- -->

							<c:choose>
								
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!-- month of end date and month of start date is same month -->
										<% if(sameMonth == true) { %>
											
											<!-- end date is same as start date -->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!-- month of end date and month of start date is not same month -->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!-- month of end date and month of start date is same month -->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------1월의 일정 출력 끝--------------------->


			<!-----------------------2월의 일정 출력----------------------->
			<% if (currMonth.equals("02") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${2}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------2월의 일정 출력 끝--------------------->

			<!-----------------------3월의 일정 출력----------------------->
			<% if (currMonth.equals("03") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${3}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------3월의 일정 출력 끝--------------------->

		</tr>
		<!---------------------1,2,3월의 일정 출력 끝--------------------->

		<!------------------------4,5,6월의 일정 출력------------------------>
		<tr class="schedule_month">
			<td>4월</td>
			<td>5월</td>
			<td>6월</td>
		</tr>

		
		<tr class="schedule_content">
			
			<!-----------------------4월의 일정 출력----------------------->
			<% if (currMonth.equals("04") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${4}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------4월의 일정 출력 끝--------------------->


			<!-----------------------5월의 일정 출력----------------------->
			<% if (currMonth.equals("05") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${5}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------5월의 일정 출력 끝--------------------->

			<!-----------------------6월의 일정 출력----------------------->
			<% if (currMonth.equals("06") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${6}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------6월의 일정 출력 끝--------------------->

		</tr>
		<!---------------------4,5,6월의 일정 출력 끝--------------------->


		<!------------------------7,8,9월의 일정 출력------------------------>
		<tr class="schedule_month">
			<td>7월</td>
			<td>8월</td>
			<td>9월</td>
		</tr>

		
		<tr class="schedule_content">
			
			<!-----------------------7월의 일정 출력----------------------->
			<% if (currMonth.equals("07") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${7}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------7월의 일정 출력 끝--------------------->


			<!-----------------------8월의 일정 출력----------------------->
			<% if (currMonth.equals("08") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${8}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------8월의 일정 출력 끝--------------------->

			<!-----------------------9월의 일정 출력----------------------->
			<% if (currMonth.equals("09") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${9}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------9월의 일정 출력 끝--------------------->

		</tr>
		<!---------------------7,8,9월의 일정 출력 끝--------------------->


		<!------------------------10,11,12월의 일정 출력------------------------>
		<tr class="schedule_month">
			<td>10월</td>
			<td>11월</td>
			<td>12월</td>
		</tr>

		
		<tr class="schedule_content">
			
			<!-----------------------10월의 일정 출력----------------------->
			<% if (currMonth.equals("10") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${10}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------10월의 일정 출력 끝--------------------->


			<!-----------------------11월의 일정 출력----------------------->
			<% if (currMonth.equals("11") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${11}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------11월의 일정 출력 끝--------------------->

			<!-----------------------12월의 일정 출력----------------------->
			<% if (currMonth.equals("12") && currYear == requestYear) { %>
			<td class="focusMonth">
			<% } else { %>
			<td>
			<% } %>
				<c:forEach items="${list}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<c:set var="pointMonth" value="${12}" />
					<c:if test="${s_month == pointMonth}">
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == pointMonth}">
								<% sameMonth = true; %>
								
								<!--if end date is same as start date-->
								<c:if test="${s_day == e_day}">
									<% sameDate = true; %>
								</c:if>

								<!--if end date is not same as start date-->
								<c:if test="${s_day != e_day}">
									<% sameDate = false; %>
								</c:if>
							</c:if>

							<!--month of end date is not january-->
							<c:if test="${e_month != pointMonth}">
								<% sameMonth = false; %>
							</c:if>

							<!-------------end check sameMonth and sameDate------------->

							<!----------------------check category----------------------->

							<c:choose>
								
								 
								<c:when test="${category == '채용'}">
									<div class="event1_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '시험'}">
									<div class="event2_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '안내사항'}">
									<div class="event3_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

								 
								<c:when test="${category == '기타'}">
									<div class="event4_cate">
										
										<!--month of end date and month of start date is same month-->
										<% if(sameMonth == true) { %>
											
											<!--end date is same as start date-->
											<% if (sameDate == true) { %>
												${s_month}/${s_day}
											<% } else { %> <!--end date is not same as start date-->
												${s_month}/${s_day} - ${e_month}/${e_day}
											<% } %>

										<% } else { %> <!--month of end date and month of start date is not same month-->
											${s_month}/${s_day} - ${e_month}/${e_day}
										<% } %>

									</div>
								</c:when>

							</c:choose>

							<div class="event_desc">${schedule.subject}</div>

						</div>
					</c:if>
				</c:forEach>
			</td>
			<!---------------------12월의 일정 출력 끝--------------------->

		</tr>
		<!---------------------10,11,12월의 일정 출력 끝--------------------->

	</table>
</div>
<%@ include file="../footer.jsp" %>

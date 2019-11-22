<%@ page 
        language="java" 
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"
%>
<%@ page import="java.util.Calendar, java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- <%
	Calendar cal = Calendar.getInstance();
	int currYear = Integer.parseInt(new SimpleDateFormat("YYYY").format(cal.getTime()));
	String currMonth = new SimpleDateFormat("MM").format(cal.getTime());
	int currDate = Integer.parseInt(new SimpleDateFormat("dd").format(cal.getTime()));
	System.out.println(currYear + " " + currMonth+" "+currDate);
%> --%>

<link href="/resources/css/HomeSchedule.css" rel="stylesheet">


<div id="schedule">


	

		<tr class="schedule_content">
			
			<td class="focusMonth">
			
				<c:forEach items="${TomorrowHomeSchedule}" var="schedule">
					<fmt:formatDate value="${schedule.start_date}" pattern="M" var="s_month" />
					<fmt:formatDate value="${schedule.start_date}" pattern="d" var="s_day" />
					<fmt:formatDate value="${schedule.end_date}" pattern="M" var="e_month" />
					<fmt:formatDate value="${schedule.end_date}" pattern="d" var="e_day" />
					<c:set var="category" value="${schedule.categorize}" />
					<%--  <c:set var="pointMonth" value="${1}" />
					<c:if test="${s_month == pointMonth}"> --%>
						<% 
						boolean sameMonth = false; 
						boolean sameDate = false; 
						%>
						<div class="event">

							<!------------check sameMonth and sameDate------------->

							<!--month of end date is january-->
							<c:if test="${e_month == s_month}">
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
							<c:if test="${e_month != s_month}">
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
					<%-- </c:if> --%><br><br>
				</c:forEach>
			</td>
		</tr>



</div>


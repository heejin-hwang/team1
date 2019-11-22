<!-- Group main page for admin and teacher -->

<%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*, com.acorn.team1.domain.SubmitVO" %>

<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/groupmain.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>
<h2>${ courseName }</h2>
<h3>${ groupName }</h3>
<div class="groupDetailDiv">
	<div class="groupMemberDiv">
		<ul class="list-group">
			<c:forEach items="${ member }" var="member">
			<li class="list-group-item">
				<div><a href="/Student/detailStudent?id=${member.sid}">${ member.sname }</a></div>
			</li>
		</c:forEach>
	</ul>
</div>
<div class="studentMain">
	<div class="acc-main">
		<div class="container">
			<div class="kind">
				<div class="accordion_container">
					<c:forEach items="${assignment}" var="assignment">
						<div class="accordion-main">
							<div class="accordion_head"
								onclick="showDetail(${assignment.aid})">
								${assignment.aname}
								<%
												boolean check = false;
											%>
								<c:if test="${ not empty status }">
									<c:forEach items="${status}" var="status">
										<c:choose>
											<c:when test="${ status.assignment_id == assignment.aid }">
												<%
																check = true;
															%>
											</c:when>
										</c:choose>
									</c:forEach>
								</c:if>
								<%
												if (check == true) {
											%>
								<font color="blue">&emsp;제출</font>
								<%
												} else {
											%>
								<font color="red">&emsp;미제출</font>
								<%
												}
											%>
								<span class="plusminus">+</span>
							</div>
						</div>
					</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../footer.jsp" %>
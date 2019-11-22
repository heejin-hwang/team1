<!-- Group main page for student -->

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
<script>
   $(document).ready(function() {
       //toggle the component with class accordion_body
       $(".accordion_head").click(function() {
         $(this).removeClass('coll-back');
         if ($('.accordion_body').is(':visible')) {
           $(".accordion_body").slideUp(300);
           $(".plusminus").text('+');
           $(this).removeClass('coll-back');
           $('.rmv-cls').removeClass('coll-back');
         }

         if($(this).next(".accordion_body").is(':visible')) {
           $(this).next(".accordion_body").slideUp(300);
           $(this).children(".plusminus").text('+');
           $(this).removeClass('coll-back');
         }else {
           $(this).next(".accordion_body").slideDown(300);
           $(this).children(".plusminus").text('');
           $(this).children(".plusminus").append('<hr class="hr-clc">');
           $(this).toggleClass('coll-back');
           $(this).addClass('rmv-cls');
         }
       });
     });
   
   
   function showDetail(id) {
	$.ajax({
		url: "/Group/DetailGroup?id=" + id,
			
		type: "POST",
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		success: function(result) {
			var html = "";
			
			var assignment = result.assignment;
			
			console.log('assignment: ', assignment);
			
			// display assignment description
			html += "<div class='assignmentdetail'><p>";
			html += assignment.description;
			html += "</p>";
			
			// display upload date of assignment
			html += "<p>등록 날짜: ";
			html += assignment.start_date;
			html += "<br>";
			
			// display due date of assignment
			html += "제출 날짜: ";
			html += assignment.end_date;
			html += "</p>";
			
			html += "<div class='item_bottom'><input type='button' class='click_bo' id='fileBtn' value='제출 파일' onclick='openSubmit(";
			html += assignment.id;
			html += ")'></div></div>";
			
			$(".accordion_body").html(html);
			
		}, 
		error:function() {
			console.log('error');
		}
	}); // ajax
} // clickDetail

function openSubmit(id) {
	Window = window.open("/Group/DetailGroup/check?id=" + id, 'popUpWindow','height=600,width=800,left=100,top=100,resizable=no,scrollbars=no,menubar=no,location=no,directories=no, status=yes');
}
</script>

<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>
<h2 class="groupHeader">${ courseName }</h2>
<h3>${ groupName }</h3>
<div class="groupDetailDiv">
	<div class="groupMemberDiv">
		<ul class="list-group">
			<c:forEach items="${ member }" var="member">
				<li class="list-group-item">
					<div>${ member.sname }</div>
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
									<% boolean check = false; %>
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
								<div class="accordion_body" id="a1" style="display: none;">

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
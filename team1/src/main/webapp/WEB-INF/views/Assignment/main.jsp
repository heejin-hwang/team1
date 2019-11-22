<%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="/resources/css/assignment.css">
<link rel="stylesheet" href="/resources/css/style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<script>
	// Function that open the new Window
function windowEdit(id) {
	Window = window.open("/Assignment/main/modify?id=" + id, 'popUpWindow','height=600,width=800,left=100,top=100,resizable=no,scrollbars=no,toolbar=yes,menubar=no,location=no,directories=no, status=yes');
} // windowEdit

function showDetail(id) {
	
	$.ajax({
		url: "/Assignment/main?id=" + id,
		type: "POST",
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		success: function(result) {
			var html = "";
			
			var submit = result.submit;
			var group = result.group;
			var assignment = result.assignment;
			
			var j = 0;
			var submitGroup = [];
			var submitPath = [];
			var submitName = [];
			var submitId = [];
			
			console.log('submit: ', submit);
			console.log('assignment: ', assignment);
			console.log('group: ', group.length);
			
			for (var i = 0; i < submit.length; i++) {
				submitGroup[i] = submit[i].g_id;
				submitPath[i] = submit[i].f_path;
				submitName[i] = submit[i].f_name;
				submitId[i] = submit[i].f_id;
			}
			
			console.log("submitGroup: ", submitGroup);
			console.log("submitPath: ", submitPath);
			console.log("submitName: ", submitName);
			
			// display assignment subject
			html += "<div class='assignmentdetail'><p><b>";
			html += assignment.name;
			html += "</b></p>";
			
			// display assignment description
			html += "<p>";
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
			
			for (var i = 0; i < group.length; i++) {
								
				// display group status with table
				html += "<table class='boardtable'>";
				html += "<tr>";
				html += "<th width='10%'>";
				html += group[i].name;
				html += "</th>";
				html += "<td width='90%'>";
				
				// check submit or not
				if (group[i].id == submitGroup[j]) {
					html += "<a href='/Assignment/fileDownload?file_id=";
					html += submitId[j];
					html += "'>";
					html += submitName[j];
					html += "</a>";
					j++;
				} else {
					html += "미제출";
				}
				
				html += "</td>";
				html += "</tr>";
				html += "</table>";
			}
			
			html += "<div class='item_bottom'>";
			html += "<button id='editBtn' class='click_bo' onclick='windowEdit(";
			html += assignment.id;
			html += ")'>수정</button>";
			html += "</div></div>";
			
			$("#detail").html(html);
			
		}, 
		error:function() {
			console.log('error');
		}
	}); // ajax
} // clickDetail

$(function() {
	$(".accordion td").click(function() {
		console.log("this: ", $(this));
		$(".accordion td").removeClass('selected');
		$(this).addClass('selected');
	});
});
</script>
<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>

<h2 class="assignmentHeader">${ courseName }<input type="button" class="click_bo" id="registerBtn" value="과제 등록" onclick="window.open('/Assignment/main/register','popUpWindow','height=600,width=800,left=100,top=100,resizable=no,scrollbars=no,toolbar=yes,menubar=no,location=no,directories=no, status=yes');"></h2>

			
<div class="studentMain">
	<div class="studentMain1">
		<table class="accordion" style="padding: 0;">
			<c:forEach items="${list}" var="assignment">
			<tr class="item">
				<td onclick="showDetail(${assignment.id})"><span>${assignment.name}</span></td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div id="detail" class="studentMain2">
		
	</div>
</div>

<%@ include file="../footer.jsp" %>
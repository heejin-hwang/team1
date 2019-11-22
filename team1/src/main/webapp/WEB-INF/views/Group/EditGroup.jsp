<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link href="/resources/css/style.css" rel="stylesheet">
<link href="/resources/css/general.css" rel="stylesheet">
<link href="/resources/css/groupPopup.css" rel="stylesheet">


<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>

<script>

	$(function() {
		
		var editListCheckbox = $('.editList');
		var submitButton = $('#submit');
		var closeButton = $('#close');
		
		//-----------------------------------------//
		
		closeButton.on('click', function() {
			window.close();
		}); // When clicking the close button.
		
		//-----------------------------------------//
		
		submitButton.on("click", function(e) {
			
			// To validate checkboxs.
			if( editListCheckbox.length > 0 ) {
				var isChecked = false;
				
				for(var checkbox of editListCheckbox) {
					if(checkbox.checked) {
						isChecked = true;
					} // if
				} // enhanced for-of
				
				if(isChecked) { // if TRUE
					// alert('Do submit!!!');
				
					// Submit this form.
					return true;
				} else { // No anyone checked.
					alert('수정할 회원을 선택해주세요');

					return false;
				} // if-else
				
			} else {
				alert('관리자에게 문의해주세요.');

				return false;
			} // outer-if
			
		}); // onsubmit
		
	}); // jq.
	
</script>


<div class="popupDiv">
	<div class="registerTitle">
		<h3>그룹원 수정</h3>
	</div>
	<hr>

	<form method="get" action="/Group/editGroupMember" id='modifyMemberForm'>
	
		<input type="hidden" name="coursecode" id="coursecode" value="${ courseCode }">
		<input type="hidden" name="coursename" id="coursename" value="${ courseName }">
 		<input type="hidden" name="groupsid" id="groupsid" value="${ groupsId }">
 		<input type="hidden" name="groupsname" id="groupsname" value="${ groupsName }">
 
		<input type="hidden" name="studentId" id="studentId"
			value="${ student.id }">
			
			
		<table class="add_table">

			<tr>
				<td>조 이름</td>
				<td>${groupsName}</td>
			</tr>
			
			<tr>
				<td>훈련과정명</td>
				<td>${courseName}</td>
			</tr>
			
			<tr>
				<td>강사</td>
				<td>${teacherName}</td>
			</tr>
			
			<tr>
				<td>조원</td>
				<td class="check"><c:forEach items="${editMemberList}"
						var="student">
						<input type="checkbox" name="editList" class="editList" value="${ student.id }">	${ student.name }<br>
					</c:forEach>
				</td>
			</tr>
		</table>


		<div class="update">
			<button type='submit' class="click_bo" id="submit">삭제</button>
			<button type='button' class="click_bo" id="close" >닫기</button>
		</div>

	</form>
</div>



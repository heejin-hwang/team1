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
$(function(){
	var addListCheckbox = $('.addList');
	var submitButton = $('#add');
	var closeButton = $('#close');
	
	closeButton.on('click', function(){
		window.close();
	});
	
	//-----------------------------------------//
	
	submitButton.on('click', function(e){
		if(addListCheckbox.length > 0 ){
			var isChecked = false;
			
			for(var checkbox of addListCheckbox){
				if(checkbox.checked){
					isChecked = true;
				}
			}
			
			if(isChecked){
				return true;
			} else{
				alert('추가할 회원을 선택해주세요.');
				
				return false;
			}
		} else{
			alert('관리자에게 문의해주세요.');
			return false;
		}
	});
	
}); //jq

</script>

<div class="popupDiv">
	<div class="registerTitle">
		<h3>그룹원 추가</h3>
	</div>
	<hr>
	<form method="get" action="/Group/addGroupMember" id="addMemberForm">
		<input type="hidden" name="coursecode" id="coursecode" value="${ courseCode }">
		<input type="hidden" name="coursename" id="coursename" value="${ courseName }">
 		<input type="hidden" name="groupsid" id="groupsid" value="${ groupsId }">
 		<input type="hidden" name="groupsname" id="groupsname" value="${ groupsName }">

	
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
				<td class="check">
					<c:forEach items="${studentlist}" var="student">
						<input type="checkbox" name="addList" class="addList" value="${student.id}">${ student.name }<br>
					</c:forEach>
				</td>
			</tr>
		</table>


		<div class="update">
			<button type='submit' class="click_bo" id="add">추가</button>
			<button type='button' class="click_bo" id="close" >닫기</button>
		</div>
	</form>
</div>


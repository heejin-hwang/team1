<%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/resources/css/assignment.css">
		<link rel="stylesheet" href="/resources/css/style.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
	    <script>
	    $(function() {
	    	
	    	$("#closeBtn").on("click", function() {
	    		opener.parent.location.reload();
	    		self.close();
	    	}); // closeBtn
	    							
	    	$("#removeBtn").on("click", function(e) {
	    		e.preventDefault();
	    		var $id = $("#id").val();
	    		var $name = $("#name").val();
	    		
	    		if (confirm($name + " 게시물을 삭제하시겠습니까?")) {
	    			$.ajax({
	    				url: "/Assignment/delete?id=" + $id,
	    				type: "POST",
	    				async: false,
	    				success: function(result, data) {
	    					console.log(success);
	    				},
	    				error: function() {
	    					console.log(error);
	    				}
	    			}); // ajax
	    			
	    			opener.parent.location.reload();
	    			self.close();
	    			
	    		} // if				
	    		
	    	}); // removeBtn
	    	
	    	$("#editBtn").on("click", function(e) {
	    		
	    		var formData = {
	    				name: $("#name").val(),
	    				description: $("#description").val(),
	    				end_date: $("#end_date").val()
	    		}; // formData
	    		
	    		var $id = $("#id").val();
	    		
	    		console.log("id: ", id);
	    						
	    		$.ajax({
	    			url: "/Assignment/main/modify?id=" + $id,
	    			type: "POST",
	    			data: formData,
	    			async: false,
	    			success: function(result, data) {
	    				if (result == "SUCCESS") {
	    					console.log("success");
	    				} // if
	    				
	    			},
	    			error:function() {
	    				console.log("error");
	    			}
	    		}); // ajax
	    		
	    		opener.parent.location.reload();
	    		self.close();
	    		
	    	}); // editBtn 		    	
	    });
	    </script>
	</head>
	<body>
		<div class="popupDiv">
			<div class="registerTitle"><h3>과제 수정</h3></div>
			<hr> 
			<form role="form" enctype="multipart/form-data">
				<input type="hidden" id="id" name="id" value="${list.id}">
				<table class="add_table">
					<tr>
						<td>제목<span style="color: red;">*</span></td>
						<td><input type="text" id="name" name="name" placeholder="과제 제목을 작성해주세요." value="${ list.name }"></td>
					</tr>
					<tr>
						<td>등록날짜<span style="color: red;">*</span></td>
						<td><input type="text" id="start_date" value="${ list.start_date }" disabled></td>
					</tr>
					<tr>
						<td>마감일</td>
						<td><input type="date" id="end_date" name="end_date" value="${list.start_date}" disabled></td>
					</tr>
					<tr>
						<td>강사</td>
						<td><input type="text" id="admin" value="TA03" disabled></td>
					</tr>
					<tr>
						<td>교육과정명</td>
						<td><input type="text" id="course" value="6" disabled></td>
					</tr>
					<tr>
						<td>설명<span style="color: red;">*</span></td>
						<td><textarea id="description" name="description">${ list.description }</textarea></td>
					</tr>
					
				</table>
				<div class="form_bottom">
					<button id="editBtn" class="click_bo">수정</button>
					<button id="removeBtn" class="click_bo">삭제</button>					
					<button id="closeBtn" class="click_bo">닫기</button>
				</div>
			</form>
		</div>		
	</body>
</html>
<%@ page 
		language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8"%>
    	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>register</title>
		<link rel="stylesheet" href="/resources/css/assignment.css">
		<link rel="stylesheet" href="/resources/css/style.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
	    <script>
	    $(function() {
	    	$("#submitBtn").on("click", function(e) {
				
	    		var formData = {
	    				name: $("#name").val(),
	    				description: $("#description").val(),
	    				end_date: $("#end_date").val(),
	    				course_code: $("#course").val(),
	    				course_name: $("#courseName").val(),
	    				admin_id: $("#admin").val(),
	    				admin_name: $("#adminName").val()
	    		}; // formData
				
	    		console.log("submitBtn::invoked.");
	    		
	    		console.log(formData);
				
	    		$.ajax({
	    			url: "/Assignment/main/register",
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
				
			}); // submitBtn
			
			$("#closeBtn").on("click", function() {
	    		opener.parent.location.reload();
	    		self.close();
	    	}); // closeBtn
	    });	    
	    </script>
	</head>
	<body>
		<div class="popupDiv">
			<div class="registerTitle"><h3>과제 추가</h3></div>
			<hr> 
			<form role="form" enctype="multipart/form-data">
				<table class="add_table">
					<tr>
						<td>제목<span style="color: red;">*</span></td>
						<td>
							<input type="text" id="name" name="name" placeholder="과제 제목을 작성해주세요." required>
						</td>
					</tr>
					<tr>
						<td>마감일<span style="color: red;">*</span></td>
						<td>
							<input type="date" id="end_date" name="end_date" required>
						</td>
					</tr>
					<tr>
						<td>강사</td>
						<td>
							<input type="hidden" id="admin" value="${ adminId }">
							<input type="text" id="adminName" value="${ adminName }" disabled>
						</td>
					</tr>
					<tr>
						<td>교육과정명</td>
						<td>
							<input type="hidden" id="course" value="${ courseCode }">
							<input type="text" id="courseName" value="${ courseName }" disabled>
						</td>
					</tr>
					<tr>
						<td>설명<span style="color: red;">*</span></td>
						<td>
							<textarea id="description" name="description" placeholder="과제 설명을 작성해주세요."></textarea>
						</td>
					</tr>
				</table>
				<div class="form_bottom">
					<button id="submitBtn" class="click_bo">등록</button>
					<button id="closeBtn" class="click_bo">닫기</button>
				</div>
			</form>
		</div>
	</body>
</html>
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

$(document).ready(function(){
    $("#myInput").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myList li").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });
  });
  
	function closePopup() {
		self.close();
	}

	$(function() {
		$("#submit").on("click", function(e) {

			var checkArr = [];

			$("input[name='registerList']:checked").each(funciton(i))
			{
				checkArr.push($(this).val());
			}

			var formData = {
				courseCode : $("#courseCode").val(),
				adminId : $("#adminId").val(),
				groupName : $("#groupName").val(),
				checkArr : checkArr
			}; // formData

			$.ajax({
				url : "/Group/createNewGroup",
				type : "GET",
				data : formData,
				async : false,
				success : function(result, data) {
					if (result == "SUCCESS") {
						console.log("success");
						
						
					} // if
				},
				error : function() {
					console.log("error");
				}
			}); // ajax
		});
		
		var check = 0;	
		$("#groupName").focusout(function(){
		//$("#groupName").on('focusout', function(){
			//console.log('#groupName on input');
	            //$('#groupName').focusout(function (e) {
	       		
	        	var group_name = $('#groupName').val();
	        	console.log('- group_name:' , group_name);
	        	
	        	var course_code = $("#courseCode").val();
	        	
	        	// aJax call.
	            $.ajax({
	                data : {
	                    name : group_name,
	                    course_code: course_code
	                },
	                
	                url : '/Group/checkGname',
	                		
	                type : 'GET',
	                
	                success : function(data, result) {
	                    console.log('- typeof data:', typeof data);
	                    console.log("result: ", result);
	                    console.log(data);
						if(data > 0) { // =1, 조 이름 중복될시 
							$("#checkmsg").text("중복된 조 이름입니다.");
	                        $("#checkmsg").css("color", "red");
	                        check = 1;
	                        if(check==1) {
	                        	//document.getElementById("submit").disabled = true;

								console.log("중복되었습니다");
	                            $("#submit").prop("disabled", true);
	                            $("#submit").css("background-color", "#aaaaaa"); 
	                               	
	                        	}
	                        	
	                        } 
						 else if(group_name == "" && data == "0"){
							$("#checkmsg").text("조 이름을 입력해주세요.");
	                        $("#checkmsg").css("color", "red");
	                        check = 1;
	                        if(check==1) {
	                            $("input[type=submit]").prop("disabled", true);
	                            $("input[type=submit]").css("background-color", "#aaaaaa");
	                        }
						} else if(data == "0"){
							var gnameRegex =  /^[0-9][.조]$/;
				            if (!gnameRegex.test($('#groupName').val())) {
				                $("#checkmsg").text("올바른 형식으로 입력해주세요. ex) 1조, 2조");
		                        $("#checkmsg").css("color", "red");
				            } else {
	                        $("#checkmsg").text("사용 가능한 조 이름입니다.");
	                        $("#checkmsg").css("color", "blue");
	                        check = 0;
				            }
						    
			        	} // if-else
	                    
	                },
	                error: function(e) {
	                	console.log(`- e:`, e);
	                }
	            });
	        	

		
		});
	});
	
	
</script>

<div class="popupDiv">
	<div class="registerTitle">
		<h3>그룹 추가</h3>
	</div>
	<hr>
	<form method="get" action="/Group/createNewGroup">
		<input type="hidden" name="courseCode" id="courseCode"
			value="${ courseCode }"> <input type="hidden" name="adminId"
			id="adminId" value="${ adminId }">

		<table class="add_table">

			<tr>
				<td>조 이름<span style="color: red;">*</span></td>
				<td><input type="text" name="groupName" id="groupName"
					placeholder="내용을 입력해주세요. 예: 1조" required>
					<div id="checkmsg"></div></td>
			</tr>
			
			<tr>
				<td>훈련과정명</td>
				<td>${courseName}</td>
			</tr>
			
			<tr>
				<td>강사</td>
				<td>
					${teacherName}
				</td>
			</tr>
			
			<tr class="myTable">
				
				<td colspan="2" class="checkR">
					<input id="myInput" type="text" placeholder="학생의 이름을 입력하세요">
					<br>
					<div id="outerDiv">
						<div id="memberlist">
							<ul id="myList">
								<c:forEach items="${studentlist}" var="student">
									 <li class="myli">
									 	<input type="checkbox" name="registerList" class="checkBox" value="${ student.id }">${student.name}
									 </li>							
								</c:forEach>							
							</ul>
						</div>
					</div>
				</td>
			</tr>
			
		</table>


		<div class="update">
			<button class="click_bo" id="submit">확인</button>
			<button class="click_bo" id="close" onclick='closePopup()'>닫기</button>
		</div>
	</form>
</div>

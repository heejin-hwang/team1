<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<link href="/resources/css/studentTable.css" rel="stylesheet">
<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>


<script>

		history.replaceState(null, null, "/HOME/HOME");

	
</script> 

<script type="text/javascript"> 
var id_check = 0;
var name_check = 0;
var password_check = 0;
var mobile_phone_check = 0;
var address_check = 0;

$(function(){

	btnDisabled();
    console.log('btnDisabled?')
	
 
	$("#id").on('input', function(){
		if($("#id").val()!=''){
            $('#checkbtn').click(function (e) {
       		var check = 0;
        	var user_id = $('#id').val();
        	console.log(`- user_id:`, user_id);
        	
        	// aJax call.
            $.ajax({
                data : {
                    id : user_id
                },
                
                url : '/Student/idExist',
                		
                type : 'GET',
                
                success : function(data) {
                    console.log('- typeof data:', typeof data);
                    console.log(data);
					if(data > 0) { // Duplicated 
						$("#checkMsg").text("중복된 이메일입니다.");
                        $("#checkMsg").css("color", "red");
                        check = 1;
                        if(check==1) {
                            $("input[type=submit]").prop("disabled", true);
                            $("input[type=submit]").css("background-color", "#aaaaaa");
                        } 
					} else if(user_id == "" && data == "0"){
						$("#checkMsg").text("이메일을 입력해주세요.");
                        $("#checkMsg").css("color", "red");
                        check = 1;
                        if(check==1) {
                            $("input[type=submit]").prop("disabled", true);
                            $("input[type=submit]").css("background-color", "#aaaaaa");
                        }
					} else if(data == "0"){
						var emailRegex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			            if (!emailRegex.test($('#id').val())) {
			                $("#checkMsg").text("이메일 주소가 유효하지 않습니다. ex)abc@gmail.com");
	                        $("#checkMsg").css("color", "red");
			            } else {
                        $("#checkMsg").text("사용 가능한 이메일입니다.");
                        $("#checkMsg").css("color", "green");
                        check = 0;
			            }
					    
		        	} // if-else
                    
                },
                error: function(e) {
                	console.log(`- e:`, e);
                }
            });
        	
        	
            }); // onclick */
            id_check = 1;
            console.log('id_check', id_check);
		}
		judgeBtn();
		
	})
	$("#name").on('input', function(){
		if($("#name").val()!=''){
            name_check = 1;
            console.log('name_check', name_check);
            
		}
		judgeBtn();
		
	})
	$("#password").on('input', function(){
		if($("#course_code").val()!='0'){
			course_code_check = 1;
            console.log('course_code', course_code);
            
		}
		judgeBtn();
		
	})
	$("#mobile_phone").on('input', function(){
		if($("#mobile_phone").val()!=''){
            mobile_phone_check = 1;
            console.log('mobile_phone_check', mobile_phone_check);
		}
		judgeBtn();
		
	})
	$("#address").on('input', function(){
		if($("#address").val()!=''){
            address_check = 1;
            console.log('address_check', address_check);
		}
		judgeBtn();
		
	})


});

function btnDisabled() {
    $("input[type=submit]").prop("disabled", true);
    $("input[type=submit]").css("background-color", "#aaaaaa");
    console.log('btnDisabled!')
}

function btnEnabled() {
	$("input[type=submit]").attr("disabled", false);
    $("input[type=submit]").css("background-color", "#3C6188"); 
    console.log('btnEnabled?')
}

function judgeBtn() {
    console.log('저지버튼 시동걸렸다.')
   /*  if(id_check == 1 && name_check == 1 && mobile_phone_check == 1 && address_check == 1){ */
	   if(id_check + name_check + mobile_phone_check + address_check + password_check == 5){
        console.log('저지가 버튼을 켠다.')
        btnEnabled();
        
    } else {
        console.log('저지가 버튼을 끈다.')
        btnDisabled();
    }
}

	$(function(){ 
		$("#alert-success").hide(); 
		$("#alert-danger").hide();

		$("input").keyup(function(){ 
			var pwd1=$("#password").val(); 
			var pwd2=$("#confirmPassword").val(); 
			if(pwd1 != "" || pwd2 != ""){ 
				if(pwd1 == pwd2){ 
					
					$("#alert-success").show(); 
					$("#alert-danger").hide(); 
					$("#alert-success").css("color", "green");
					$("input[type=submit]").removeAttr("disabled");
					$("input[type=submit]").css("background-color", "#3C6188");

				} else { 
					$("#alert-success").hide(); $("#alert-danger").show(); 
					$("#alert-danger").css("color", "red");
					$("input[type=submit]").attr("disabled", "disabled");
					$("input[type=submit]").css("background-color", "#aaaaaa");
					
				}
			} 
		}); 
		

	}); 
</script>


		<div class="table">
			<form id="Form" method="POST" action="/HOME/editStudentPost">
				<table id="register">
					<tr>
						<th><label for="id">학생아이디<span class="required">*</span><label for="id"></th>
						<td><input id="id" type="email" name="userId" required value="${login.id}">
						<td><input type="hidden" id="id" name="id" value ="${login.id}"></td>
						<!-- <button type="submit" id=checkbtn>중복확인</button> -->
							<div id="checkMsg"></div></td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${login.name}</td>
						<td><input type="hidden" id="name" name="name" value ="${login.name}"></td>
						
					</tr>

					<tr>
						<th>비밀번호<span class="required">*</span></th>
						<td><input id="password" type="password" name="password" onChange="isSame()" required></td>
					</tr>
					<tr>
						<th>비밀번호 확인<span class="required">*</span></th>
						<td><input id="confirmPassword" type="password" name="confirmPassword" onChange="isSame()" required>&nbsp;&nbsp;<span class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</span> <span class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</span>
					</tr>
					<tr>
						<!-- <th><label for="birthday">생년월일<span class="required">*</span></label></th> -->
				            <th>생년월일</th> 
							<td>${login.birthday}</td>
						<td><input type="hidden" id="name" name="name" value ="${login.birthday}"></td>
						<%-- <td><input id="birthday" type="text" name="birthday" maxlength="6"
							value="${detail.birthday}" required
							oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td> --%>
					</tr>
					<tr>
						<th>훈련과정</th>
						<td>${login.course_name}</td>
						<%-- <td><input type="hidden" id="course_code" name="course_code" value ="${detail.course_name}">${detail.course_name}</td> --%>
					</tr>
					<%-- <tr>
						<th>그룹아이디</th>
						<td><input type="hidden" id="groups_id" name="groups_id" value ="${detail.groups_id}">${detail.groups_id}</td>
					</tr> --%>
					<tr>
						<th>훈련상태</th>
						<td>${login.state}</td>
<%-- 						<td><input type="hidden" id="course_code" name="course_code" value ="${detail.state}">${detail.state}</td>
 --%>					</tr>
					<tr>
						<th>출석일수</th>
						<td>${attendance_count}
						</td>
					</tr>
					<tr>
						<th>결석일수</th>
						<td>${noAttendance_count}
						</td>
					</tr>
					<tr>
						<th>시험점수</th>
						<td>
							100
						</td>
					</tr>
					<tr>
						<th><label for="mobile_phone">핸드폰번호<span class="required">*</span></label></th>
						<td><input id="mobile_phone" type="tel" name="mobile_phone" maxlength="11" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
						 value="${login.mobile_phone}" required></td>
					</tr>

					<tr>
						<th><label for="temporarily_number">비상연락처</label></th>
						<td><input type="tel" id="temporarily_number" name="temporarily_number"
							value="${login.temporarily_number}"></td>
					</tr>
					
					<tr>
						<th><label for="address">기본주소<span class="required">*</span></label></th>
						<td><input id="address" name="address" class="address" type="text" 
						value="${login.address}" required></td>
					</tr>
					<tr>
						<th><label for="detail_address">상세주소</label></th>
						<td><input name="detail_address" id="detail_address" class="address" type="text"
							value="${login.detail_address}"></td>
					</tr>

				</table>
				<table id="register_button">
					<div class="button">
						<input type="submit" value="등록">
						<input type="button" class="back" value="취소"
							onclick="history.back(-1)">
					</div>
				</table>
				
			</form>
		</div>

<%@ include file="../footer.jsp" %>

var id_check = 0;
var name_check = 0;
var course_code_check = 0;
var mobile_phone_check = 0;
var address_check = 0;
var check = 0;

$(function(){

	btnDisabled();
    console.log('btnDisabled?')
	
 
	$("#id").on('focus', function(){
		console.log('#id on input');
            $('#checkbtn').click(function (e) {
       		
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
		judgeBtn();
		
	})
	$("#name").on('input', function(){
		if($("#name").val()!=''){
            name_check = 1;
            console.log('name_check', name_check);
            
		}
		judgeBtn();
		
	})
	$("#course_code").on('input', function(){
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

	/* 
        if(mobile_phone.val() ==''){
            alert('휴대폰 번호를 입력하세요');
            mobile_phone.focus();
            return false;
        } else if(!/^[0-9]{10,11}$/.test(mobileNO.val())){
            alert("휴대폰 번호는 숫자만 10~11자리 입력하세요.");
            return false;
        } else if(!/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/.test(mobileNO.val())){
            alert("유효하지 않은 전화번호 입니다.");
            return false;
        }
         */

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
	   /*if(id_check + name_check + mobile_phone_check + address_check + course_code_check == 5){ */
	if($("#id").val()!='' && $("#name").val()!='' && $("#mobile_phone").val()!='' && $("#address").val()!='' && $("#course_code").val()!='' && check == 0){
        console.log('저지가 버튼을 켠다.')
        btnEnabled();
        
    } else {
        console.log('저지가 버튼을 끈다.')
        btnDisabled();
    }
}


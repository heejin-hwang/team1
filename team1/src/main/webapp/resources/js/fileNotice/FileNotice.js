/**
 * 
 */
$(document).ready(function() {
	
	/*게시글 기능 결과를 확인하는 함수*/
	notice_result();
	
	/*form tag*/
	var form = $("#form");
	
/*====================add Notice로 화면 전환=============================*/
		$("#addBtn").on("click", function goWrite(){
			form.attr("action", "/FileNotice/addFileNotice");
			form.attr("method", "GET");
			form.submit();
		});

/*====================검색 기능=============================*/
		//반 select-box를 통해서 값을 바꾸면 검색기능 수행가능
		$("#course_code").change(function(){
				var scourse_code = $(this).val();
				form.submit();
		}); 	//function :: selectbox :: course :: change
		
		//목록 select-box를 통해서 값을 바꾸면 검색기능 수행가능
		$("#categorize").change( function (){
				var scategorize = $(this).val();
				form.submit();
		} );		//function :: selectbox :: categorize :: change
		
		//반 select-box를 통해서 값을 바꾸면 검색기능 수행가능
		$("#state").change(function(){
				console.log($(this).val());
				var cstate = $(this).val();
				form.submit();
		}); 	//function :: selectbox :: course :: change
		
		//키워드를 입력하여 검색 기능 구현
		$("#searchBtn").on("keydown", function(key) {
			//엔터키 이벤트
			if(key.keyCode == 13) {
				var searchType = $("#searchType").val();
				var keyword = $("#keyword").val();
				form.submit();
			}	//if
		});	//searchBtn :: click 
		
		$("#searchBtn").on("click", function(key) {
			//엔터키 이벤트
		
			var searchType = $("#searchType").val();
			var keyword = $("#keyword").val();
			form.submit();
	
		});	//searchBtn :: click 
		
		//키워드를 입력하여 검색 기능 구현
		$("#keyword").on("keydown , keyup", function(key) {
			var maxByte = 40;
			chkword(this,maxByte);
			//엔터키 이벤트
			if(key.keyCode == 13) {
				var searchType = $("#searchType").val();
				var keyword = $("#keyword").val();
				form.submit();
			}	//if
		});	//searchBtn :: click 
	
}); // document.ready

/*==============게시글 기능 결과를 확인하는 함수============================*/
function notice_result(){
	var result = $("#notice_result").val();

	if(result == "SUCCESS"){
		$("#notice_result").val(null);
		alert("글 등록에 성공하였습니다.");
		
	}else if(result == "Delete_SUCCESS"){
		$("#notice_result").val(null);
		alert("게시글을 삭제 하였습니다.");
		
	}else{
		result="";
	}
}

/*============================= 글자수 제한 ==================================================*/
function chkword(obj, maxByte) {
	 
    var strValue = obj.value;
    var strLen = strValue.length;
    var totalByte = 0;
    var len = 0;
    var oneChar = "";
    var str2 = "";

    for (var i = 0; i < strLen; i++) {
        oneChar = strValue.charAt(i);
        if (escape(oneChar).length > 4) {
            totalByte += 2;
        } else {
            totalByte++;
        }

        // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
        if (totalByte <= maxByte) {
            len = i + 1;
        }
    }

    // 넘어가는 글자는 자른다.
    if (totalByte > maxByte) {
        alert(maxByte + "자를 초과 입력 할 수 없습니다.");
        str2 = strValue.substr(0, len);
        obj.value = str2;
        chkword(obj, 4000);
    }
}




	
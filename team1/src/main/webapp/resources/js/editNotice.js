/**
 * 
 */

	$(document).ready(function() {
		
		/*게시글 기능 결과를 확인하는 함수*/
		notice_result();
		
		var deleteFile = new Array ();
		//취소 버튼 클릭시
		$("#cancelBtn").on("click", goDetailNotice);
		
		//삭제 버튼 클릭시
		$("#deleteBtn").on("click", DeleteNotice );
		
		//수정 버튼 클릭시
		$("#updateBtn").on("click", EditNotice);

		//파일이 업로드가 되었을 때
		$('.upload-hidden').on('change', uploadFile);
		
		//첨부파일 x박스 클릭시
		$(".fileCancel").on("click", function DeleteFile(){
			var file_id = $(this).val();
			deleteFile.push(file_id);
			$(this).parent("div").remove();
			$("#delete_file").val(deleteFile);
		});
		
		//제목 글자수 제한
		$("#subject").on('keyup', function(){
			var maxByte = 50;
			chkword(this, maxByte);
		});
		
		//textarea 글자수 제한
		$(".text_area").on('keyup', function(){
			var maxByte = 1000;
			chkword(this, maxByte);
		});
});	//document.ready

/*==================== 게시글 기능 결과를 확인하는 함수 ==============================*/
	function notice_result(){
		var result = $("#notice_result").val();
		console.log("-------", result);
		if(result == "FAIL"){
			alert("글 수정을 실패하였습니다.");
		}
	}
	
/*========================= CancelBtn Click ============================================*/
	function goDetailNotice() {
		
		var id = $("#id").val();
		/*=== 검색 유지 위한 것들 ===*/
		var page = $("#page").val();
		var searchType = $("#searchType").val();
		var scourse_code = $("#scourse_code").val();
		var scategorize = $("#scategorize").val();
		var cstate = $("#cstate").val();
		var keyword = $("#keyword").val();
		
		/*=== uri 인코딩 후 보내기 ===*/
		var uri="/Notice/detailNotice?id="+id+"&page="+page+"&searchType="+searchType+"&scourse_code="+scourse_code+"&scategorize="+scategorize+"&cstate="+cstate+"&keyword="+keyword;
		var enc = encodeURI(uri);
		location.href=enc;
	}

/*============================ DeleteBtn Click ========================================*/
	function DeleteNotice() {
		var yn = confirm("게시글을 삭제 하시겠습니까?");
		if (yn) {
			// history url 조정 :: history때문에 addNotice 기능이 연속적이고 반복적으로 수행 되는것 방지
			history.replaceState(null, null, "Notice"); 
			
			//submit
			$("#form").attr("action", "deleteNotice");
			$("#form").attr("method", "POST");
			$("#form").submit();
		}	//if
	}

/*============================= UpdateBtn Click ======================================*/
	function EditNotice() {
		var conf = false;
		//제목이 안적혀 있을 때
		if( $("#subject").val() == '' ){
			conf = true;
			alert("제목을 입력해 주세요");
			$("#subject").focus();
		}
		// 작성자가 입력 안되어 있을 때
		if( $("#name").val() == '' ){
			conf = true;
			alert("작성자를 입력해 주세요");
			$("#name").focus();
		}
		//시작 날짜가 입력 안되어 있을 때
		if( $("#start_date").val() == '' ){
			conf = true;
			alert("시작 날짜를 입력해 주세요");
			$("#start_date").focus();
		}
		// 종료 날짜가 입력 안되어 있을 때
		if( $("#end_date").val() == '' ){
			conf = true;
			alert("종료 날짜를 입력해 주세요");
			$("#end_date").focus();
		}

		// 입력 부분 특히 subject 부분에 ' '값이 입력 된 상태에서 등록을 눌렀을 때
		var data = $("#subject").val().trim();
		if (data.length == 0) {
			conf = true;
			alert("제목을 입력해 주세요");
			$("#subject").val(null);
			$("#subject").focus();	
		}	// if ::: data

		// start_date > end_date depend
		if ($("#start_date").val() > $("#end_date").val()) {
				conf = true;
			if ($("#end_date").val() == null|| $("#end_date").val().trim().length == 0) {
					alert("종료 날짜를 입력해 주세요");
					$("#end_date").focus();
				} else {
					alert("시작날짜를 제대로 입력해 주세요");
					$("#start_date").val(null);
				} // else-if
			} // if
		
		if(!conf){
			var yn = confirm("게시글을 수정 하시겠습니까?");
			if (yn) {
				var id = $("#id").val();
				/*========================첨부 파일 유무 check======================*/
				var filesChk = $("#file").val();
				if (filesChk == "") {
					$("#file").remove();
				}	// if ::: fileChk
				
				 // history url 조정 :: history때문에 addNotice 기능이 연속적이고 반복적으로 수행 되는것 방지
				history.replaceState(null, null, "/Notice/detailNotice?id="+id);
				$("#form").submit();
			}	 //if
		}	//if :: !conf
		
	}
	
/*============================= setDeleteFile Click ======================================*/
	function setDeleteFile(file_id){
		$("#delete_file").val(deleteFile);
		console.log("deleteFile", deleteFile);
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
	
/*============================= 첨부 파일 부분 ==================================================*/
	function uploadFile(){
		var str = ""
			// 값이 변경되면 
			console.log("=================",$(this)[0].files);
			
			var files = $(this)[0].files
			
			if(files.length <= 5){
				
				if(window.FileReader){ 
					// modern browser 
					for(var i=0; i<files.length; i++ ){
								str += files[i].name+"\t"; 
					}	// for
			
				}	// if
			
				$(this).siblings('.upload-name').val(str);

			}else{
				alert("파일이 너무 많습니다.");
				$("#files").val(null);
			}	// if -else

	}	//fileTarget :: on change
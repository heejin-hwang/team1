/**
 * 
 */

	$(function() {
		/*게시글 기능 결과를 확인하는 함수*/
		notice_result();
		/*아이콘 보여주기*/
		$(".fileDiv").each(function () {
			
			var fileName =$(this).children(".file_name").val();
			var fileIcon =$(this).children(".file_icon");

			handleImg(fileName, fileIcon);
			
		})

		//수정 버튼 클릭시
		$("#reviseBtn").on("click", goUpdateNotice);
		//목록 버튼 클릭시
		$("#cancelBtn").on("click", goNoticeList);
		//삭제 버튼 클릭
		$("#deleteBtn").on("click", deleteNotice);		//deleteBtn
		
	}); //document.ready
	
/*==================== 게시글 기능 결과를 확인하는 함수 ==============================*/
	function notice_result(){
		var result = $("#notice_result").val();
		console.log("-------", result);
		if(result == "SUCCESS"){
			alert("게시글 수정완료 하였습니다.");
		}else if(result == "FAIL"){
			alert("오류가 발생하였습니다.");
		}else{
			;;
		}	//if-else
	}	//function

/*======================= goNoticeList ===================================*/
	function goNoticeList() {
		
		/*=== 검색 유지 위한 것들 ===*/
		var page = $("#page").val();
		var searchType = $("#searchType").val();
		var scourse_code = $("#scourse_code").val();
		var scategorize = $("#scategorize").val();
		var cstate = $("#cstate").val();
		var keyword = $("#keyword").val();
		
		/*=== uri 인코딩 후 보내기 ===*/
		var uri="/FileNotice/FileNotice?page="+page+"&searchType="+searchType+"&scourse_code="+scourse_code+"&scategorize="+scategorize+"&cstate="+cstate+"&keyword="+keyword;
		var enc = encodeURI(uri);
		location.href=enc;
	}	//function :: goNoticeList

/*======================= goUpdateNotice ===================================*/
	function goUpdateNotice() {
		
		/*=== 검색 유지 위한 것들 ===*/
		var id = $("#id").val();
		var page = $("#page").val();
		var searchType = $("#searchType").val();
		var scourse_code = $("#scourse_code").val();
		var scategorize = $("#scategorize").val();
		var cstate = $("#cstate").val();
		var keyword = $("#keyword").val();
		
		/*=== uri 인코딩 후 보내기 ===*/
		var uri="/FileNotice/editFileNotice?id="+id+"&page="+page+"&searchType="+searchType+"&scourse_code="+scourse_code+"&scategorize="+scategorize+"&cstate="+cstate+"&keyword="+keyword;
		var enc = encodeURI(uri);
		location.href=enc;
	}	//function :: goUpdateNotice

/*======================= deleteNotice ===================================*/
	function deleteNotice() {
		var yn = confirm("게시글을 삭제하시겠습니까?");
		if (yn) {	
			 // history url 조정 :: history때문에 addNotice 기능이 연속적이고 반복적으로 수행 되는것 방지
			history.replaceState(null, null, "FileNotice"); 
			
			//submit
			$("#form").attr("action", "deleteFileNotice");
			$("#form").attr("method", "POST");
			$("#form").submit();
		}	// if
	}	//function :: deleteNotice

/*==================== 기존에 포함된 파일들을 icon과 출력하는 작업 ===================================*/
	function handleImg (fileName, fileIcon){
		var filelist = fileName.split(".");
		var type = filelist[filelist.length-1];

		 if(type == "jpg"|| type == "png"){
             //파일의 타입이 image일때
			 fileIcon.attr("src", "/resources/img/icon/image_icon.png");
             
         }else if(type == "txt" ){
             //파일의 타입이 txt일때
        	 fileIcon.attr("src", "/resources/img/icon/txt_file_icon.png");
 
         }else if(type == "pdf" ){
              //파일의 타입이 pdf일때
        	 fileIcon.attr("src", "/resources/img/icon/pdf_file_icon.png");
     
         }else if(type == "pptx" ){
             //파일의 타입이 pptx일때
        	 fileIcon.attr("src", "/resources/img/icon/pptx_icon.png");
    
         }else if(type=="docx" ){
             //파일의 타입이 docx일때
        	 fileIcon.attr("src", "/resources/img/icon/docx_icon.png");
    
         }else if(type =="excel" ){
             //파일의 타입이 excel일때
        	 fileIcon.attr("src", "/resources/img/icon/excel_icon.png");
         }
         else{
        	 fileIcon.attr("src","/resources/img/icon/folder_icon.png");
         }	//if-else
	}	//function
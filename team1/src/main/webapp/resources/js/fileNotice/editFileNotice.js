/**
 * 
 */
/*새로 추가된 파일을 담을 배열*/
var fileList = [];

$(document).ready(function() {
		
		/*게시글 기능 결과를 확인하는 함수*/
		notice_result();
		
		/*아이콘 보여주기*/
		$(".fileDiv").each(function () {
			
			var fileName =$(this).children(".file_name").val();
			var fileIcon =$(this).children(".file_icon");

			handleImg(fileName, fileIcon);
			
		});
		
		//button click -> file insert
		$("#filebox_img").on("change", handleImgFileSelect);
			
		//첨부파일 박스 클릭시 파일첨부 가능하도록 하는 작업
       $('#filebox').on("click",function() {
           event.stopPropagation();
           $("#filebox_img").click();
       });	//filebox-onclick
       
       /*==== 첨부파일 drag&drop ===*/
       var obj = $("#filebox");

        obj.on('dragenter', function (e) {
            e.stopPropagation();
            e.preventDefault();
        });	//filebox-ondragenter

        obj.on('dragleave', function (e) {
            e.stopPropagation();
            e.preventDefault();
        });	//filebox-ondragleave

        obj.on('dragover', function (e) {
            e.stopPropagation();
            e.preventDefault();
        });	//filebox-ondragover

        obj.on('drop', function (e) {
            e.preventDefault();
            e.stopPropagation();

            var files = e.originalEvent.dataTransfer.files;
          
            if(files.length < 1)
                return;
            handleFile(files, e);

        });	//filebox-ondrop
	
		//기존에 게시글에 포함되어 있던 파일들 삭제시 삭제목록을 담을 배열
		var deleteFile = new Array ();
		//취소 버튼 클릭시
		$("#cancelBtn").on("click", goDetailNotice);
		
		//삭제 버튼 클릭시
		$("#deleteBtn").on("click", DeleteNotice );
		
		//수정 버튼 클릭시
		$("#updateBtn").on("click", EditNotice);

		
		//첨부파일 x박스 클릭시
		$(".fileCancel").on("click", function DeleteFile(){
			
			event.stopPropagation();
			var file_id = $(this).val();
			deleteFile.push(file_id);
			
			$(this).parent("td").parent("tr").remove();
			$("#delete_file").val(deleteFile);
		});
		
		//제목 글자수 제한
		$("#subject").on('keyup', function(){
			var maxByte = 50;
			chkword(this, maxByte);
		});
		
		//textarea 글자수 제한
		$(".text_area").on('keyup', function(){
			var maxByte = 150;
			chkword(this, maxByte);
		});
});	//document.ready

/*==================== 게시글 기능 결과를 확인하는 함수 ==============================*/
	function notice_result(){
		var result = $("#notice_result").val();
	
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
		var uri="/FileNotice/detailFileNotice?id="+id+"&page="+page+"&searchType="+searchType+"&scourse_code="+scourse_code+"&scategorize="+scategorize+"&cstate="+cstate+"&keyword="+keyword;
		var enc = encodeURI(uri);
		location.href=enc;
	}

/*============================ DeleteBtn Click ========================================*/
	function DeleteNotice() {
		var yn = confirm("게시글을 삭제 하시겠습니까?");
		if (yn) {
			// history url 조정 :: history때문에 addNotice 기능이 연속적이고 반복적으로 수행 되는것 방지
			history.replaceState(null, null, "FileNotice"); 
			
			//submit
			$("#form").attr("action", "deleteFileNotice");
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

		// 입력 부분 특히 subject 부분에 ' '값이 입력 된 상태에서 등록을 눌렀을 때
		var data = $("#subject").val().trim();
		if (data.length == 0) {
			conf = true;
			alert("제목을 입력해 주세요");
			$("#subject").val(null);
			$("#subject").focus();	
		}	// if ::: data
		
		if(!conf){
			var yn = confirm("게시글을 수정 하시겠습니까?");
			if (yn) {
				var id = $("#id").val();
				/*==== 첨부 파일 유무 check =====*/
				var filesChk = $("#file").val();
				if (filesChk == "") {
					$("#file").remove();
				}	// if ::: fileChk
		 
				if(fileList != null){
					
					/*새로 추가된 파일 정보 담기*/
					var formData = new FormData();
					 for(var i = 0; i < fileList.length; i++){
			                formData.append('files', fileList[i] );
					 }
					/*== ajax를 통해서 file insert -> insert success -> 게시글 update 수행 */
					 $.ajax({ 
					
					    url: '/FileNotice/insertFile',
					    data : formData,
					    type : 'post',
					    contentType : false,
					    processData: false,
					    success : function() {
					    	// history url 조정 :: history때문에 editNotice 기능이 연속적이고 반복적으로 수행 되는것 방지
					    	history.replaceState(null, null, "/FileNotice/detailFileNotice?id="+id);
					    	
						   $("form").submit();
					    }	//success
					 });	//$.ajax
				}//if:: fileList
		
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
	    
	    //한글 입력시 달라지는 글자수 고려
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
	
/*========================== 기존에 포함된 파일들을 icon과 출력하는 작업 ==================================*/
	function handleImg (fileName, fileIcon){
		var filelist = fileName.split(".");

		var type = filelist[filelist.length-1];

		 if(type == "jpg" || type == "png"){
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
        	 // 기타 파일의 타입
        	 fileIcon.attr("src","/resources/img/icon/folder_icon.png");
         }	//if-else
	}	//function
	
/*============ filebox click시 수행되는 함수 =======================*/
	function handleImgFileSelect(e) {
	   
	    var files = e.target.files;

	    handleFile(files,e);
	}	//function

/*============ file이 새로 첨부될 때 수행되는 함수 =======================*/
	function handleFile(files, e){
	    var filesArr = Array.prototype.slice.call(files);
	  
	    var dz = document.getElementById("filebox_tbody");
	    
	        filesArr.forEach(function(f, index) {
	        	
	            var reader = new FileReader();
	            //새로운 테이블형식을 만들기 위한 작업
	            var tr = document.createElement('tr');
	            var td_img = document.createElement('td');
	            $(td_img).attr("class","fileDiv");
	           
	            var img = document.createElement('img');
	            
	            var td_name = document.createElement('td');
	            var p = document.createElement('p');
	            
	            var td_size = document.createElement('td');
	            var p_size = document.createElement('p');
	            
	            var td_button = document.createElement('td');
	            var button = document.createElement('button');
	           $(button).attr("class","img_button");
	           $(button).val(index);
	           $(button).text("X");
	           
	           //type별 아이콘을 다르게 하기 위한 사전작업
	            var type = f.type;
	            
	            //file size 제한
	            if(f.size <= 100000000){
	            	
	                if(type.match("image")){
	                    //파일의 타입이 image일때
	                    reader.onload = function(e) { 
	                        $(img).attr("src", "/resources/img/icon/image_icon.png");
	                    }
	                }else if(type.match("text")){
	                    //파일의 타입이 txt일때
	                    reader.onload = function(e) { 
	                        $(img).attr("src", "/resources/img/icon/txt_file_icon.png");
	                    }
	                }else if(type.match("pdf")){
	                     //파일의 타입이 pdf일때
	                     reader.onload = function(e) { 
	                        $(img).attr("src", "/resources/img/icon/pdf_file_icon.png");
	                    }
	                }else if(type.match("application/vnd.openxmlformats-officedocument.presentationml.presentation")|| type.match("application/haansoftshow")){
	                    //파일의 타입이 pptx일때
	                    reader.onload = function(e) { 
	                        $(img).attr("src", "/resources/img/icon/pptx_icon.png");
	                    }
	                }else if(type.match("application/vnd.openxmlformats-officedocument.wordprocessingml.document")||type.match("haansofthwp")){
	                    //파일의 타입이 docx일때
	                    reader.onload = function(e) { 
	                        $(img).attr("src", "/resources/img/icon/docx_icon.png");
	                    }
	                }else if(type.match("application/haansoftcell")){
	                    //파일의 타입이 excel일때
	                    reader.onload = function(e) { 
	                        $(img).attr("src", "/resources/img/icon/excel_icon.png");
	                    }
	                }
	                else{
	                    reader.onload = function(e) {
	                        $(img).attr("src","/resources/img/icon/folder_icon.png");
	                    }
	                }
	                
	                $(img).attr("class", "file_icon");
	                $(td_name).attr("class", "filebox_td");
	                $(p).text(f.name);
	                $(p_size).text(f.size);
	            
	            td_img.appendChild(img);
	            
	            td_name.appendChild(p);
	            
	            td_size.appendChild(p_size);
	            td_button.appendChild(button);
	            
	            tr.appendChild(td_img);
	            tr.appendChild(td_name);
	            tr.appendChild(td_size);
	            tr.appendChild(td_button);
	            
	            dz.appendChild(tr);
	            reader.readAsDataURL(f);
	            
	            //file 목록에 새로 추가된 파일 넣기
	            fileList.push(f);
	            
	            }else{
	            	alert(f.name+"파일은 파일크기가 너무 커서 제외됩니다.");
	            }// if-else :::: file size 제한
	    });	//forEach

	     	// 삭제 버튼 클릭했을 때
	            $('.img_button').on("click", function(e) {
	                
	                e.stopPropagation();

	                $(this).parent("td").parent("tr").remove();
	                
	                //새로 추가된 파일중 제거된 파일 목록 제거 작업
	                fileList.splice( $(this).val(), 1, null);
	                
	            });	//img_button-- onclick
	}
	
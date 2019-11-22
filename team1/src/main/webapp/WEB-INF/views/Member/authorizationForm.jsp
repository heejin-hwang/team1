<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>본인인증</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/css/style_pw.css">
<script>

		history.replaceState(null, null, "/Member/authorization");

	
</script>
</head>

<body>
	<header>

        <div id="logo">
        	<div class="logo">
        		<a  href="#">
            		<img src="/resources/img/logo.png" alt="logo">
           		</a>
           	</div>
        </div>
        <div class="header_2">
            <ul>
                <li class="li1"><a href="authorization.jsp">본인인증</a></li>
              <!--   <li class="li2"><a href="ChangeUserInfo.jsp">비밀번호 변경</a></li> -->
            </ul>
        </div>
    </header>
	<div id="container">
		<div class="content">
			<div class="content_header">
				<h2>본인인증</h2>
			</div>	
			<p class="summary">회원정보에 등록한 내용과 입력한 정보가 모두 같아야 합니다.</p>
			<form action="/Member/authorizationPost" method="post">
				<fieldset>
					<div class="info">
					  <label for="email"><strong>ID</strong></label>
                        <input type="email" name="userId" id="email" class="inpt" required="required" placeholder="Your id">
                       
                       <label for="your name"><strong>이름</strong></label>
                        <input type="text" name="name" id="name" class="inpt" required="required" placeholder="Your name">
                        
                     <label for="your number"><strong>생년월일 6자리 ex)030827</strong></label>
                        <input type="text" name="birthday" id="number" class="inpt" required="required" placeholder="Your birthday">
			     
			     	<div class="submit-wrap">
						<input type="submit" value="확인" class="submit" id="submit">
			
				
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/Member/footer.jsp"%>
</body>

</html>
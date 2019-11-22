<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>

<script>

var result='${msg}';

if(result == 'fail'){
   alert("현재 비밀번호가 다릅니다.");
}

</script>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/style_pw.css?ver=1">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>

<script>
$(function() {
   $("#submit").on("click", function(){
      history.replaceState(null, null, "/HOME/HOME");
   });
});
</script>
<script type="text/javascript">
   $(function(){
      $("#alert-success").hide();
      $("#alert-danger").hide();
      $("input").keyup(function(){
       
         var pwd1=$("#pwd1").val();
         var pwd2=$("#pwd2").val();
         if (pwd1 != "" && pwd2 != ""){
            if(pwd1 == pwd2){
               $("#alert-success").show();
               $("#alert-danger").hide();
               $("#submit").removeAttr("disabled");
               } else {
                  $("#alert-success").hide();
                  $("#alert-danger").show();
                  $("#submit").attr("disabled", "disabled");
               } 
            }
         if (pwd1 == "" || pwd2 == "") {
            $("#alert-danger").hide();
            $("#alert-success").hide();
            }
         });
   });
</script>


</head>

<body>
   <header>

        <div class="header_1">
           <div class="logo">
              <a  href="/HOME/HOME">
                  <img src="/resources/img/logo.png" alt="logo">
                 </a>
              </div>
        </div>
        <div class="header_2">
            <ul>
              <!--   <li class="li1"><a href="authorization.jsp">본인인증</a></li> -->
                <li class="li1"><a href="change_pw.jsp">비밀번호 변경</a></li>
            </ul>
        </div>
    </header>
   <div id="container">
      <div class="content">
         <div class="content_header">
         <c:if test="${login.pw_checked == 'false'}"> <h2>임시 비밀번호를 변경 후에 이용해 주세요</h2> </c:if>
            <h2>비밀번호 변경</h2>
         </div>   
         <p class="summary">변경할 비밀번호를 입력해 주세요.</p>
         <form action="/Member/ChangeUserPasswordPost" method="post">
            <fieldset>
         
            
                   <input type="hidden" name="userId" id="email" value="${login.id}" style =  border:none;  readonly>
                <br> 
                
            <label for="Your Password">현재 비밀번호</label> 
               <input type="password" name="password" id="password" class="inpt" required="required" placeholder="password" >
               
               <label for="Your newPassword">새 비밀번호</label> 
               <input type="password" name="newPassword" id="pwd1" class="inpt" required="required" placeholder="new password">
            
               <label for="Your password">새 비밀번호 확인</label> 
               <input type="password" name="confirmNewPassword" id="pwd2" class="inpt" required="required" placeholder="confirm new password">
               
                <div class="alert-success" id="alert-success" style="margin: 0; padding: 5px 0 20px; color: green;">비밀번호가 일치합니다.</div>
                  <div class="alert-danger" id="alert-danger" style="margin: 0; padding: 5px 0 20px; color: red;">비밀번호가 일치하지 않습니다.</div>    
               
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
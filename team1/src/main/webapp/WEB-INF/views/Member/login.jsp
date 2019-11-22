<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import = "com.acorn.team1.domain.LoginUserVO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

   <title>로그인 화면</title>
   <c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>

   <link rel="stylesheet" href="${contextPath}/resources/css/login2_ver4.css?ver=2" >



</head>
<body>
   <!-- /body -->
    <div id="wrap">
        <div class="container">
            <div class="container_back"></div>
            <section class="container_front">
                <div class="text">
                    <img src="${contextPath}/resources/img/logo2.png" alt="logo" width="604.8px" height="107.2px">
                </div>
                <fieldset class="form">
                    <div>
                        <h1 class="form_header">로그인</h1>
                    </div>
                    <div class="content">
                        <form action="/Member/loginPost" method="post">
                            <label for="id"><strong>아이디</strong></label>
                            <input type="text" name="userId" id="id" class="inpt" required="required" placeholder="Your id">
                            <label for="password"><strong>비밀번호</strong></label>
                            <input type="password" name="password" id="password" class="inpt" required="required" placeholder="Your password">
                <br> 
                          
                          <!--  <div class="alert-check" id="alert-check" style="margin: 0; padding: 5px 0 20px; color: red;">정보를 확인해 주세요.</div>--> 
                            
                            <div class="submit-wrap">
                                <input type="submit" value="로그인" class="submit">
                            </div>
                            
                            <div class="option">
                            <%--  <c:if test="${LoginUserVO == null}">정보를 확인해 주세요.</c:if>  --%>
     
                                <a href="/Member/authorizationGet" class="change"><strong>비밀번호 찾기</strong></a>
                                <input type="checkbox"   name="useCookie" id="remember" class="checkbox"  >
                                <label for="remember">자동 로그인</label>
                            </div>
                        </form>
                    </div>
                </fieldset>
            </section>
        </div>
   </div>
    
    

</body>
</html>
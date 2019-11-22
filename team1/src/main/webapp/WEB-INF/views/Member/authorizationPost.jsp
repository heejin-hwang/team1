<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import = "com.acorn.team1.domain.LoginUserVO" %>
<%@ page import = "java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%


LoginUserVO vo = (LoginUserVO) request.getAttribute("loginUserVO");


//인코딩 처리
request.setCharacterEncoding("utf-8"); 

if(vo != null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
    script.println("alert('메일이 발송되었습니다.')");
    script.println("self.location.replace('/Member/login')");
    script.println("</script>");
    script.flush();
    script.close();
}
        
 if(vo ==null){
		PrintWriter script = response.getWriter();
 		script.println("<script>");
 	    script.println("alert('등록된 정보와 다릅니다.')");
 	    script.println("self.location.replace('/Member/authorization')");
 	    script.println("</script>");
 	    script.flush();
	    script.close();

} 
  
%>

<!-- <h2>메일이 발송되었습니다.</h2>
<!--   <form action="/Member/login" method="get">
                          <input type="submit" value="로그인 하러 가기" class="submit">
                           </form> -->
                           
                            <!--	<script>
	
		alert('메일이 발송되었습니다.');
		self.location ="/Member/login"; //메인 화면으로 이동
	</script> -->
</body>
</html>
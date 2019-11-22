<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.acorn.team1.domain.MyPageVO" %>
<%@ page import = "java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<%


MyPageVO vo1 = (MyPageVO) request.getAttribute("MyPageVO");


//인코딩 처리
request.setCharacterEncoding("utf-8"); 

if(vo1 != null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
    script.println("alert('출석체크 되었습니다.')");
    script.println("location.href = '/HOME/HOME'");
    script.println("</script>");
    script.close();
}
        
 if(vo1 ==null){
		PrintWriter script = response.getWriter();
 		script.println("<script>");
 	    script.println("alert('이미 출석체크 되었습니다.')");
 	    script.println("location.href = '/HOME/HOME'");
 	    script.println("</script>");
	    script.close();

} 
 %>
</body>
</html>
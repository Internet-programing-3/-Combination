<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<body>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");   
	String password = request.getParameter("pw");
	String name = request.getParameter("name");

	String	hp1 = request.getParameter("hp1");
	String	hp2 = request.getParameter("hp2");
	String	hp3 = request.getParameter("hp3");
	String	hp = hp1 + hp2 + hp3;
	
	String	email1 = request.getParameter("email1");
	String	email2 = request.getParameter("email2");
	String	email = email1 + "@"+ email2;
	
	String	birth = request.getParameter("birth");

	String	sex = request.getParameter("sex");

try {
 	 String DB_URL="jdbc:mysql://localhost:3306/internetproject";  
     String DB_ID="multi";  
     String DB_PASSWORD="abcd"; 
 	 
     Class.forName("com.mysql.cj.jdbc.Driver");
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	 String jsql = "update User set password=?, name=?, phone=?, email=?, birth=?, gender=? where userId=?";	

	 PreparedStatement pstmt  = con.prepareStatement(jsql);
	 pstmt.setString(1,password);
	 pstmt.setString(2,name);
	 pstmt.setString(3,hp);
	 pstmt.setString(4,email);
	 pstmt.setString(5,birth);
	 pstmt.setString(6,sex);
	 pstmt.setString(7,id);

	 int result = pstmt.executeUpdate();
	 
	if(result == 1){ // 성공 %>
		<script>
			alert("회원 정보 수정에 성공하였습니다.");
			window.location.href = "<%= request.getContextPath() %>/Logout.jsp";
		</script>
	<%	} else{ // 실패		%>
		<script>
			alert("회원 정보 수정에 실패하였습니다.");
			window.location.href = "<%= request.getContextPath() %>/UpdateUser.jsp";
		</script>
	<%	}
	 
  } catch(Exception e) { 
		out.println(e);
}
%>

</body>
</html>
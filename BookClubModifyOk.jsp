<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*" %>        
<html>
   <head><title>게시판 내용 수정 처리</title></head> 
   <body>
	   <%
	       String DB_URL="jdbc:mysql://localhost:3306/internetproject";  
	       String DB_ID="multi";  
	       String DB_PASSWORD="abcd"; 
	 	 
		   Class.forName("com.mysql.jdbc.Driver");  
	 	   Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
	
		   request.setCharacterEncoding("UTF-8");
	
	       String postId = request.getParameter("postId");
	       String title = request.getParameter("title"); 
	       String content = request.getParameter("content");
		   String jsql = "update clubpost set title = ?, content = ? where postId = ?";
	       PreparedStatement pstmt = con.prepareStatement(jsql);
	       pstmt.setString(1, title);
	       pstmt.setString(2, content);
	       pstmt.setInt(3, Integer.parseInt(postId));
	       pstmt.executeUpdate();
	       %>  
		   <script>
				alert("게시물 수정이 완료되었습니다.");
				location.href = "BookClub.jsp?clubId=1"
		   </script>   
   </body>  
</html>
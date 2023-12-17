<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제</title>
</head>
<body>
	<%
		String commentId = request.getParameter("commentId");
		String postId = request.getParameter("postId");
	
		try{
			
			String DB_URL = "jdbc:mysql://localhost:3306/internetproject";	//  접속할 DB명
			String DB_ID = "multi";	//  접속할 아이디
			String DB_PASSWORD = "abcd";	// 접속할 패스워드
			
			Class.forName("org.gjt.mm.mysql.Driver"); 
			Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);	// DB에 접속
			
			String sql = "delete from clubcomment where commentId = ?";	//SQL문 작성
			
			//PreparedStatement 생성(SQL문의 형틀을 정의)
			PreparedStatement pstmt1 = con.prepareStatement(sql);
			pstmt1.setInt(1, Integer.parseInt(commentId));
			pstmt1.executeUpdate();
			
			%>
			<script>
				location.href = "BookClubDetail.jsp?postId=<%=postId%>"
			</script>
			
		<% } catch (Exception e) {
	        out.println(e);
		}
	%>
</body>
</html>
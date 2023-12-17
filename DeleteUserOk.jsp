<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원탈퇴</title>
</head>
<body>
	<%
		String userId = (String) session.getAttribute("userId");
		String pw = request.getParameter("pw");
		try{
			
			String DB_URL = "jdbc:mysql://localhost:3306/internetproject";	//  접속할 DB명
			String DB_ID = "multi";	//  접속할 아이디
			String DB_PASSWORD = "abcd";	// 접속할 패스워드
			
			Class.forName("org.gjt.mm.mysql.Driver"); 
			Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);	// DB에 접속
			
			String sql = "select * from User where userid = ? and password = ?";	//SQL문 작성
			
			//PreparedStatement 생성(SQL문의 형틀을 정의)
			PreparedStatement pstmt1 = con.prepareStatement(sql);
			pstmt1.setString(1, userId);
			pstmt1.setString(2, pw);
			// sql문 실행
			ResultSet rs = pstmt1.executeQuery();
			
			if(rs.next()){ // 성공
				String jsql = "delete from User where userid=?";
				PreparedStatement  pstmt2 = con.prepareStatement(jsql);
				pstmt2.setString(1, userId);
				
				pstmt2.executeUpdate();
				%>
				<script>
					alert("회원탈퇴가 완료되었습니다.");
					window.location.href = "<%= request.getContextPath() %>/Logout.jsp";
				</script>
			<% }else{	// 실패 %>
				<script>
					alert("비밀번호가 틀렸습니다.");
					window.location.href = "<%= request.getContextPath() %>/DeleteUser.jsp";
				</script>
			<% }
			
		} catch (Exception e) {
	        out.println(e);
		}
	%>
</body>
</html>
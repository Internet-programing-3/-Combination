<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		request.setCharacterEncoding("UTF-8");

		String userid = request.getParameter("userid");
		String password = request.getParameter("password");
		
		try{
			
			String DB_URL = "jdbc:mysql://localhost:3306/internetproject";	//  접속할 DB명
			String DB_ID = "multi";	//  접속할 아이디
			String DB_PASSWORD = "abcd";	// 접속할 패스워드
			
			Class.forName("com.mysql.jdbc.Driver");  // JDBC 드라이버 로딩
			Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);	// DB에 접속
			

			
			    // ... 이전 코드 ...

			    if (session.getAttribute("userId") != null) {
			        // 로그인한 사용자일 경우
			        String userId = (String) session.getAttribute("userId");

			        // 사용자의 cartId를 가져와서 세션에 설정
			        String cartIdQuery = "SELECT cartId FROM Cart WHERE userId = ?";
			        try (PreparedStatement pstmtCartId = con.prepareStatement(cartIdQuery)) {
			            pstmtCartId.setString(1, userId);
			            ResultSet rsCartId = pstmtCartId.executeQuery();

			            if (rsCartId.next()) {
			                int cartId = rsCartId.getInt("cartId");
			                session.setAttribute("cartId", cartId);
			            }
			        }
			    }
			

			
			String sql = "select * from User where userId = ? and password = ?";	//SQL문 작성
			
			//PreparedStatement 생성(SQL문의 형틀을 정의)
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, password);
			// sql문 실행
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){ // 성공
			userid = rs.getString("userId");
			String name = rs.getString("name");
		
			session.setAttribute("userId", userid);
			session.setAttribute("name", name);
			response.sendRedirect(request.getContextPath() + "/Mainpage.jsp");
			} else{ // 실패 %>
				<script>
					alert("아이디 또는 비밀번호가 맞지않습니다.");
					window.location.href = "<%= request.getContextPath() %>/Login.jsp";
				</script>
			<%	}
			
		} catch (Exception e) {
	        out.println(e);
		}
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 완료</title>
</head>
<body>

</body>
</html>
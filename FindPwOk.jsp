<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 완료</title>
</head>
<body style="display: flex; justify-content: center; margin: 0px;">
<%
   request.setCharacterEncoding("UTF-8");

   String userId = request.getParameter("userId");
   String name = request.getParameter("name");
   String phone = request.getParameter("phone");
   String password = request.getParameter("password");

   try{
      
      String DB_URL = "jdbc:mysql://localhost:3306/internetproject";   //  접속할 DB명
      String DB_ID = "multi";   //  접속할 아이디
      String DB_PASSWORD = "abcd";   // 접속할 패스워드
      
      Class.forName("com.mysql.jdbc.Driver");  // JDBC 드라이버 로딩
      Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);   // DB에 접속
      
      String sql = "SELECT * FROM user WHERE userId = ? AND name = ? AND phone = ?";   //SQL문 작성
      
      //PreparedStatement 생성(SQL문의 형틀을 정의)
      PreparedStatement pstmt = con.prepareStatement(sql);
      pstmt.setString(1, userId);
      pstmt.setString(2, name);
      pstmt.setString(3, phone);
      
      // sql문 실행
      pstmt.executeQuery();
          
      String sql2 = "UPDATE user SET password = ? WHERE userId = ? AND name = ? AND phone = ?";
      PreparedStatement pstmt2 = con.prepareStatement(sql2);
      pstmt2.setString(1, password);
      pstmt2.setString(2, userId);
      pstmt2.setString(3, name);
      pstmt2.setString(4, phone);
         
      int result = pstmt2.executeUpdate();
         
      if(result == 1){ // 성공 %>
         <script>
            alert("비밀번호 재설정에 성공하였습니다.");
            window.location.href = "<%= request.getContextPath() %>/Login.jsp";
         </script>
      <%   } else{ // 실패      %>
         <script>
            alert("비밀번호 재설정에 실패하였습니다");
            window.location.href = "<%= request.getContextPath() %>/FindUser.jsp";
         </script>
      <%   }
      }catch(Exception e){
      out.println(e);
   }
%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*, java.util.Date" %>         
<html>
   <head><title>게시판 리스트 보기</title></head>      
   <body>
<%
    String DB_URL="jdbc:mysql://localhost:3306/internetproject";  
    String DB_ID="multi";  
    String DB_PASSWORD="abcd"; 
 	 
    Class.forName("com.mysql.jdbc.Driver");  
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

    request.setCharacterEncoding("UTF-8");
    
    String clubId = request.getParameter("clubId");
    String userId = (String) session.getAttribute("userId");
    String title = request.getParameter("title");              
    String name = request.getParameter("name");
    String content = request.getParameter("content");
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    String created_at = dateFormat.format(new Date());
   
    String jsql = "select MAX(postId) from clubpost";
    PreparedStatement pstmt = con.prepareStatement(jsql);
    ResultSet rs = pstmt.executeQuery();

    int no;
    if (rs == null) {  
        no = 1;
    }  else {      
        rs.next();
        no = rs.getInt(1) + 1;
    } 
    
    rs.close();    

    String jsql2 = "insert into clubpost (postId, title, content, userId, created_at, clubId) values (?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt2 = con.prepareStatement(jsql2);
    pstmt2.setInt(1, no);
    pstmt2.setString(2, title);
    pstmt2.setString(3, content);
    pstmt2.setString(4, userId);
    pstmt2.setString(5, created_at);
    pstmt2.setString(6, clubId);
      
    pstmt2.executeUpdate();
   
    response.sendRedirect("BookClub.jsp?clubId=" + clubId);
%>
  </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*, java.util.Date" %>

<html>
   <head><title>게시판 리스트 보기</title></head>
   <body>
<%
    String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver"); 
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    request.setCharacterEncoding("UTF-8");

    // 클라이언트로부터 전달된 clubId 값을 String으로 받아옴
    String clubIdString = request.getParameter("clubId");

    int clubId;

    // clubIdString이 null 또는 빈 문자열 또는 "null" 문자열인 경우에 대한 처리
    if (clubIdString == null || clubIdString.trim().isEmpty() || clubIdString.equalsIgnoreCase("null")) {
        // clubId를 항상 1로 설정
        clubId = 1;
    } else {
        // clubIdString을 int로 변환
        clubId = Integer.parseInt(clubIdString);
    }

    String userId = (String) session.getAttribute("userId");

    // userId가 null인 경우 로그인 페이지로 리다이렉트
    if (userId == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String title = request.getParameter("title");
    String name = request.getParameter("name");
    String content = request.getParameter("content");

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    String created_at = dateFormat.format(new Date());

    int no;

    // clubpost 테이블이 비어있을 경우를 고려하여 MAX(postId) 값을 가져오는 쿼리를 변경
    String jsql = "SELECT COALESCE(MAX(postId), 0) FROM clubpost";
    PreparedStatement pstmt = con.prepareStatement(jsql);
    ResultSet rs = pstmt.executeQuery();

    rs.next();
    no = rs.getInt(1) + 1;

    rs.close();

    // clubId를 가지고 있는지 확인
    String checkClubIdQuery = "SELECT clubId FROM club WHERE clubId = ?";
    PreparedStatement checkClubIdStmt = con.prepareStatement(checkClubIdQuery);
    checkClubIdStmt.setInt(1, clubId);

    ResultSet checkClubIdRs = checkClubIdStmt.executeQuery();

    // clubId가 존재하지 않으면 club 테이블에 추가
    if (!checkClubIdRs.next()) {
        // clubId를 가지고 있는 행이 없으면 추가
        String insertClubQuery = "INSERT INTO club (clubId, clubName) VALUES (?, ?)";
        PreparedStatement insertClubStmt = con.prepareStatement(insertClubQuery);
        insertClubStmt.setInt(1, clubId);
        // 여기서는 clubName을 적절히 설정해야 합니다.
        insertClubStmt.setString(2, "YourClubName");

        insertClubStmt.executeUpdate();
    }

    checkClubIdRs.close();
    checkClubIdStmt.close();

    String jsql2 = "INSERT INTO clubpost (postId, title, content, userId, created_at, clubId) VALUES (?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt2 = con.prepareStatement(jsql2);
    pstmt2.setInt(1, no);
    pstmt2.setString(2, title);
    pstmt2.setString(3, content);
    pstmt2.setString(4, userId);
    pstmt2.setString(5, created_at);

    // clubId를 int로 설정
    pstmt2.setInt(6, clubId);

    pstmt2.executeUpdate();

    response.sendRedirect("BookClub.jsp?clubId=" + clubId);
%>
  </body>
</html>

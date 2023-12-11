<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>장바구니 비우기 결과</title>
</head>
<body>
    <%
    try {
        String DB_URL = "jdbc:mysql://localhost:3306/project";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";
        Class.forName("org.gjt.mm.mysql.Driver");
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String ctNo = session.getId();
        // prdNo를 정수형으로 처리
        int prdNo = Integer.parseInt(request.getParameter("BookId"));

        String jsql = "DELETE FROM cart WHERE CartId=? AND BookId = ?";
        PreparedStatement pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, ctNo);
        pstmt.setInt(2, prdNo);
        pstmt.executeUpdate();

        response.sendRedirect("showCart.jsp");
    } catch (Exception e) {
        // 오류 발생 시 오류 메시지 출력
        out.println(e);
    }
    %>
</body>
</html>

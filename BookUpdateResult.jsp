<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>도서 수정 결과</title>
</head>
<body>
<center>
<%
    request.setCharacterEncoding("euc-kr");

    String bookCtg = request.getParameter("bookCtg");
    String bookId = request.getParameter("bookId");
    String bookName = request.getParameter("bookName");
    int price = Integer.parseInt(request.getParameter("price"));
    int bookStock = Integer.parseInt(request.getParameter("bookStock"));
    String writer = request.getParameter("writer");
    String bookContent = request.getParameter("bookContent");
    String publisher = request.getParameter("publisher");
    String bookStatus = request.getParameter("bookStatus");

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

		Class.forName("org.gjt.mm.mysql.Driver"); 
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String jsql = "UPDATE BOOK SET bookName=?, price=?, bookStock=?, ";
        jsql += "writer=?, bookContent=?, publisher=?, bookStatus=?, bookCtg=? WHERE bookId=?";
        PreparedStatement pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, bookName);
        pstmt.setInt(2, price);
        pstmt.setInt(3, bookStock);
        pstmt.setString(4, writer);
        pstmt.setString(5, bookContent);
        pstmt.setString(6, publisher);
        pstmt.setString(7, bookStatus);
        pstmt.setString(8, bookCtg);
        pstmt.setString(9, bookId);
        pstmt.executeUpdate();

        String jsql2 = "SELECT * FROM BOOK WHERE bookId=?";
        PreparedStatement pstmt2 = con.prepareStatement(jsql2);
        pstmt2.setString(1, bookId);
        ResultSet rs = pstmt2.executeQuery();
        rs.next();
%>
        <font color="blue" size='6'><b>수정된 상품정보는 다음과 같습니다.</b></font><p>
        <table border="2" cellpadding="10" style="font-size:10pt;font-family:'맑은 고딕'">

            <tr><td>카테고리분류</td><td><%=rs.getString("bookCtg")%></td></tr>

            <tr><td>도서번호</td><td><%=rs.getString("bookId")%></td></tr>

            <tr><td>도서 명</td><td><%=rs.getString("bookName")%></td></tr>

            <tr><td>도서 가격</td><td><%=rs.getInt("price")%> 원</td></tr>

            <tr><td>재고수량</td><td><%=rs.getInt("bookStock")%> 권</td></tr>

            <tr><td>저자 </td><td><%=rs.getString("writer")%></td></tr>

            <tr><td>상세설명</td><td width=300><%=rs.getString("bookContent")%></td></tr>

            <tr><td>출판사</td><td><%=rs.getString("publisher")%></td></tr>

            <tr><td>판매 상태</td><td><%=rs.getString("bookStatus")%></td></tr>

            <tr><td>책 리뷰</td><td><%=rs.getString("bookReview")%></td></tr>
        </table><p>
        <a href="BookSelect.jsp" align=center style="font-size:10pt;font-family: '맑은 고딕'">전체 등록상품 조회 </a>
<%
    } catch (Exception e) {
        out.println(e);
    }
%>
</center>
</body>
</html>

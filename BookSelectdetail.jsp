<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>도서 상세정보 조회</title>
</head>
<body>
<center>
<%
try {
    String DB_URL = "jdbc:mysql://localhost:3306/internetproject"; // DB 접속할 명
    String DB_ID = "multi"; // 접속할 아이디
    String DB_PASSWORD = "abcd"; // 접속할 패스워드

	Class.forName("org.gjt.mm.mysql.Driver"); 
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
    String key = request.getParameter("bookId");
    String jsql = "SELECT * FROM BOOK WHERE bookId = ?";
    PreparedStatement pstmt = con.prepareStatement(jsql);
    pstmt.setString(1, key);
    ResultSet rs = pstmt.executeQuery(); // SQL 문 실행
    rs.next();
    String bookId = rs.getString("bookId");
    String bookName = rs.getString("bookName");
    int price = rs.getInt("price");
    int bookStock = rs.getInt("bookStock");
    String writer = rs.getString("writer");
    String bookContent = rs.getString("bookContent");
    String publisher = rs.getString("publisher");
    String bookStatus = rs.getString("bookStatus");
    String bookCtg = rs.getString("bookCtg");
    String bookReview = rs.getString("bookReview");
%>
    <font color="blue" size='6'><b>[도서 상세정보 조회]</b></font><p>
    <table border="1" style="font-size:10pt;font-family:'맑은 고딕'">
        <tr>
            <td align=center>카테고리분류</td><td align=center><%=bookCtg%></td>
            <td rowspan="7" align=center><img src="images/<%=bookId%>.jpg" width="300" height="300"></td>
        </tr>

        <tr><td align=center>도서번호</td><td align=center><%=bookId%></td></tr>
        <tr><td align=center>도서명</td><td align=center><%=bookName%></td></tr>
        <tr><td align=center>도서가격</td><td align=center><%=price%> 원</td></tr>
        <tr><td align=center>재고수량</td><td align=center><%=bookStock%> 개</td></tr>
        <tr><td align=center>저자</td><td align=center><%=writer%></td></tr>
        <tr><td align=center>상품설명</td><td align=center width=300><%=bookContent%></td></tr>
        <tr><td align=center>출판사</td><td align=center><%=publisher%></td></tr>
        <tr><td align=center>도서 상태</td><td align=center><%=bookStatus%></td></tr>
        <tr><td align=center>책 리뷰</td><td align=center><%=bookReview%></td></tr>
    </table><p>
    <br><br>
    <img src="./images/<%=bookId%>_detail.jpg" width=700 height=700 border=0>
    <br><br><br>
    <a href="BookUpdate.jsp?bookId=<%=bookId%>" align=center style="font-size:10pt;font-family:'맑은 고딕'">수정</a>&nbsp;&nbsp;&nbsp;
    <a href="BookDelete.jsp?bookId=<%=bookId%>" align=center style="font-size:10pt;font-family:'맑은 고딕'">삭제</a>
    <br><br><br>
</center>
<%
} catch (Exception e) {
    out.println(e);
}
%>
</body>
</html>

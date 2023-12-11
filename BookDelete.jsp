<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>도서 삭제 페이지</title>
</head>
<body>
<center>
<%
try {
    String DB_URL = "jdbc:mysql://localhost:3306/internetproject"; // DB 접속할 명
    String DB_ID = "multi"; // 접속할 아이디
    String DB_PASSWORD = "abcd"; // 접속할 패스워드

    Class.forName("org.gjt.mm.mysql.Driver"); // JDBC 드라이버 로딩
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
%>
    <font color="blue" size='6'><b>[등록된 도서 삭제]</b></font><p>

    <h4>다음과 같이 등록된 도서를 삭제하시겠습니까?</h4>

    <table border="2" cellpadding="10" style="font-size:10pt;font-family:'맑은 고딕'">
        <tr>
            <td>카테고리분류</td>
            <td><%=bookCtg%></td>
            <td rowspan="7"><img src="images/<%=bookId%>.jpg" width="300" height="300"></td>
        </tr>
        <tr><td>도서 번호</td><td><%=bookId%></td></tr>

        <tr><td>도서 명</td><td><%=bookName%></td></tr>

        <tr><td>도서 가격</td><td><%=price%> 원</td></tr>

        <tr><td>재고수량</td><td><%=bookStock%> 권</td></tr>

        <tr><td>저자</td><td><%=writer%></td></tr>

        <tr><td>상세설명</td><td width="300"><%=bookContent%></td></tr>

        <tr><td>출판사</td><td><%=publisher%></td></tr>

        <tr><td>판매 상태</td><td><%=bookStatus%></td></tr>

    </table><p>
    <a href="BookDeleteResult.jsp?bookId=<%=bookId%>" style="font-size:10pt;font-family:'맑은 고딕'">삭제</a>&nbsp;&nbsp;&nbsp;
    <a href="BookSelect.jsp" style="font-size:10pt;font-family:'맑은 고딕'">취소</a>
<%
} catch (Exception e) {
    out.println(e);
}
%>
</center>
</body>
</html>

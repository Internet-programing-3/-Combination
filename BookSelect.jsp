<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>도서 조회</title>
</head>
<body>
<center>
    <font color="blue" size='6'><b>[도서 조회]</b></font><p>
    <table border="1" width="1000" style="font-size:10pt;font-family: '맑은 고딕'">
        <tr>
            <td align=center>상품사진</td>
            <td align=center>카테고리분류</td>
            <td align=center>도서 번호</td>
            <td align=center>도서 명</td>
            <td align=center>도서 가격</td>
            <td align=center>저자</td>
            <td align=center>출판사</td>
            <td align=center>판매상태</td>
            <td align=center>상세 설명</td>
            <td align=center>재고수량</td>
            <td align=center>책 리뷰</td>
            <td align=center><b><font color=blue>[도서 정보 수정]</font></b></td>
            <td align=center><b><font color=blue>[도서 정보 삭제]</font></b></td>
        </tr>
        <%
        try {
            String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
            String DB_ID = "multi";
            String DB_PASSWORD = "abcd";

    		Class.forName("org.gjt.mm.mysql.Driver"); 
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
            String jsql = "SELECT * FROM Book";
            PreparedStatement pstmt = con.prepareStatement(jsql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String bookCtg = rs.getString("bookCtg");
                int bookId = rs.getInt("bookId");
                String bookName = rs.getString("bookName");
                int price = rs.getInt("price");
                int bookStock = rs.getInt("bookStock");
                String writer = rs.getString("writer");
                String bookContent = rs.getString("bookContent");
                String publisher = rs.getString("publisher");
                String bookStatus = rs.getString("bookStatus");
                String bookReview = rs.getString("bookReview");
        %>
        <tr> 
            <td align="center"><a href="BookSelectdetail.jsp?bookId=<%=bookId%>"><img src="images/<%=bookId%>.jpg" width="100" height="100" border=0></a></td>
            <td align="center"><%=bookCtg%></td>
            <td align=center><a href="BookSelectdetail.jsp?bookId=<%=bookId%>"><%=bookId%></a></td>
            <td align=center><a href="BookSelectdetail.jsp?bookId=<%=bookId%>"><%=bookName%></a></td>
            <td align="center"><%=price%> 원</td>
            <td align="center"><%=bookStock%> 권</td>
            <td align="center"><%=writer%></td>
            <td align="center" width=300><%=bookContent%></td>
            <td align="center"><%=publisher%></td>
            <td align="center"><%=bookStatus%></td>
            <td align="center"><%=bookReview%></td>
            <td><a href="BookUpdate.jsp?bookId=<%=bookId%>"><center>수정</center></a></td>
            <td><a href="BookDelete.jsp?bookId=<%=bookId%>" ><center>삭제</center></a></td>
        </tr>
        <%
            } // while 문의 끝
        %>
    </table><p><br>
    <a href="BookCreate.jsp" align=center style="font-size:10pt;font-family: '맑은 고딕'">[신규 도서 추가 등록] </a><br><br>
    <%
        } catch (Exception e) {
            out.println(e);
        }
    %>
</center>
</body>
</html>

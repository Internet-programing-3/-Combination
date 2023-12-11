<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>

<html>
<head>
    <title>도서 정보 수정</title>
</head>
<body>

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
    String bookReview = rs.getString("bookReview");
%>
    <center>
        <font color="blue" size='6'><b>[도서 정보 수정]</b></font><p>
        <form method="post" action="BookUpdateResult.jsp">
            <table border="2" cellpadding="10" style="font-size:10pt;font-family:'맑은 고딕'">
                <tr>
                    <td>카테고리분류 :</td>
                    <td>
                        <select name="bookCtg">
                            <option value="베스트셀러" <%=bookCtg.equals("베스트셀러") ? "selected" : "" %>>베스트셀러</option>
                            <option value="신규 도서" <%=bookCtg.equals("신규 도서") ? "selected" : "" %>>신규 도서</option>
                            <option value="국내 도서" <%=bookCtg.equals("국내 도서") ? "selected" : "" %>>국내 도서</option>
                            <option value="해외 도서" <%=bookCtg.equals("해외 도서") ? "selected" : "" %>>해외 도서</option>
                        </select>
                        <p>
                    </td>
                    <td rowspan="8" align=center><img src="images/<%=bookId%>.jpg" width="300" height="300"></td>
                </tr>

                <tr>
                    <td>도서 번호 :</td>
                    <td><input type="hidden" name="bookId" value="<%=bookId%>"><%=bookId%></td>
                </tr>

                <tr>
                    <td>도서 명 :</td>
                    <td><input type="text" name="bookName" value="<%=bookName%>"></td>
                </tr>

                <tr>
                    <td>도서 가격 :</td>
                    <td><input type="text" name="price" value="<%=price%>"> 원</td>
                </tr>

                <tr>
                    <td>재고수량 :</td>
                    <td><input type="text" name="bookStock" value="<%=bookStock%>"> 개</td>
                </tr>

                <tr>
                    <td>저자 :</td>
                    <td><input type="text" name="writer" value="<%=writer%>"></td>
                </tr>

                <tr>
                    <td>상품설명 :</td>
                    <td><textarea name="bookContent" rows="5" cols="30"><%=bookContent%> </textarea></td>
                </tr>

                <tr>
                    <td>출판사 :</td>
                    <td><input type="text" name="publisher" value="<%=publisher%>"></td>
                </tr>

                <tr>
                    <td>판매 상태 :</td>
                    <td>
                        <input type="radio" name="bookStatus" value="판매 중" <%=bookStatus.equals("판매 중") ? "checked" : "" %>>판매 중
                        <input type="radio" name="bookStatus" value="품절" <%=bookStatus.equals("품절") ? "checked" : "" %>>품절
                        <input type="radio" name="bookStatus" value="재입고 중" <%=bookStatus.equals("재입고 중") ? "checked" : "" %>>재입고 중
                    </td>
                </tr>

                <!-- 추가된 항목 -->
                <tr>
                    <td>책 리뷰 :</td>
                    <td><textarea name="bookReview" rows="5" cols="30"><%=bookReview%> </textarea></td>
                </tr>
            </table>
            <p>
            <br>
            <br><br><br>
            <input type="submit" value="수정완료">
        </form>
        <br><br><br>
    </center>
<%
        
    } catch (Exception e) {
        out.println(e);
    }
%>
</body>
</html>

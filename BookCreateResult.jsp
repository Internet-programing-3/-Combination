<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>도서 등록 결과</title>
</head>
<body>
<%
    request.setCharacterEncoding("euc-kr"); // 입력폼에서 전송된 한글데이터 처리

    // String 입력폼에서 받는 데이터는 모두 문자열
    String bookCtg = request.getParameter("bookCtg");
    String bookId = request.getParameter("bookId");
    String bookName = request.getParameter("bookName");
    int price = Integer.parseInt(request.getParameter("price")); // String => int 변환
    int bookStock = Integer.parseInt(request.getParameter("bookStock")); // String => int 변환
    String writer = request.getParameter("writer");
    String bookContent = request.getParameter("bookContent");
    String publisher = request.getParameter("publisher");
    String bookStatus = request.getParameter("bookStatus");
    String bookReview = request.getParameter("bookReview");

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/internetproject"; // DB 접속할 명
        String DB_ID = "multi"; // 접속할 아이디
        String DB_PASSWORD = "abcd"; // 접속할 패스워드

        Class.forName("org.gjt.mm.mysql.Driver"); // JDBC 드라이버 로딩
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        // DB 에 접속

        // SQL : 문 작성 테이블 필드명
        String jsql = "INSERT INTO Book (bookCtg, bookId, bookName, price, bookStock, writer, bookContent, publisher, bookStatus, bookReview) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // PreparedStatement (SQL ) 생성 문의 형틀을 정의함
        PreparedStatement pstmt = con.prepareStatement(jsql);
        // SQL ? ( ) 위의 문에서 에 해당되는 곳에 다음의 값들을 하나씩 할당함 인수 전달
        // setInt() 정수형의 경우에는 를 사용함
        pstmt.setString(1, bookCtg);
        pstmt.setString(2, bookId);
        pstmt.setString(3, bookName);
        pstmt.setInt(4, price); // 정수값인 경우
        pstmt.setInt(5, bookStock); // 정수값인 경우
        pstmt.setString(6, writer);
        pstmt.setString(7, bookContent);
        pstmt.setString(8, publisher);
        pstmt.setString(9, bookStatus);
        pstmt.setString(10, bookReview);
        pstmt.executeUpdate(); // SQL 문 실행
%>
    <center>
        <font color="blue" size='6'><b>[ 등록된 도서 정보 ] </b></font><p>
        <table border="2" cellpadding="10" style="font-size:10pt;font-family:'맑은 고딕'">
            <tr><td width="100">카테고리분류</td><td width="300"><%=bookCtg%></td></tr>
            <tr><td width="100">도서 번호</td><td width="300"><%=bookId%></td></tr>
            <tr><td width="100">도서 명</td><td width="300"><%=bookName%></td></tr>
            <tr><td width="100">도서 가격</td><td width="300"><%=price%> 원</td></tr>
            <tr><td width="100">재고수량</td><td width="300"><%=bookStock%> 개</td></tr>
            <tr><td width="100">저자</td><td width="300"><%=writer%></td></tr>
            <tr><td width="100">상세 설명</td><td width="300"><%=bookContent%></td></tr>
            <tr><td width="100">출판사</td><td width="300"><%=publisher%></td></tr>
            <tr><td width="100">판매 상태</td><td width="300"><%=bookStatus%></td></tr>
            <tr><td width="100">도서 리뷰</td><td width="300"><%=bookReview%></td></tr>
        </table><p>
<%
    } catch (Exception e) {
        out.println(e);
    }
%>
        <p>
        <a href="BookSelect.jsp" style="font-size:10pt;font-family:'맑은 고딕'">전체 등록상품 조회</a><br><br>
    </center>
</body>
</html>

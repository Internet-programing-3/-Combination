<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*, java.io.*, java.util.UUID" %>
<%@ page import="java.nio.file.Paths" %>

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
    String priceParam = request.getParameter("price");
    String bookStockParam = request.getParameter("bookStock");
    int price = (priceParam != null && !priceParam.isEmpty()) ? Integer.parseInt(priceParam) : 0;
    int bookStock = (bookStockParam != null && !bookStockParam.isEmpty()) ? Integer.parseInt(bookStockParam) : 0;

    String writer = request.getParameter("writer");
    String bookContent = request.getParameter("bookContent");
    String publisher = request.getParameter("publisher");
    String bookStatus = request.getParameter("bookStatus");
    String bookReview = request.getParameter("bookReview");

    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    String fileName = "";
    Part filePart = request.getPart("bookImgFile");
    if (filePart != null && filePart.getSize() > 0) {
        fileName = UUID.randomUUID().toString() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String filePath = uploadPath + File.separator + fileName;
        try (InputStream input = filePart.getInputStream(); OutputStream output = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            while (input.read(buffer) != -1) {
                output.write(buffer);
            }
        }
    }

    try {
  
    	String DB_URL = "jdbc:mysql://localhost:3306/internetproject?serverTimezone=UTC";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 수정된 SQL 문
        String jsql = "INSERT INTO Book (bookCtg, bookId, bookName, price, bookStock, writer, bookContent, publisher, bookStatus, bookReview, bookImg) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(jsql);

        pstmt.setString(1, bookCtg);
        pstmt.setString(2, bookId);
        pstmt.setString(3, bookName);
        pstmt.setInt(4, price);
        pstmt.setInt(5, bookStock);
        pstmt.setString(6, writer);
        pstmt.setString(7, bookContent);
        pstmt.setString(8, publisher);
        pstmt.setString(9, bookStatus);
        pstmt.setString(10, bookReview);
        pstmt.setString(11, fileName);
        pstmt.executeUpdate();
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
            <tr><td width="100">도서 사진</td><td width="300"><%=fileName%></td></tr>
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

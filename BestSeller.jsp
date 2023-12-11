<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>베스트셀러</title>
</head>
<body>
    <center>
        <br><br>
        <font color="blue" size='6'><b>[ 베스트셀러 ] </b></font><p>

        <%
        try {
            String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
            String DB_ID = "multi";
            String DB_PASSWORD = "abcd";

            Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            // 베스트 셀러 목록 가져오기
            String bestSellerQuery = "SELECT b.bookId, b.bookName, b.price, b.writer, b.publisher, b.bookCtg, b.bookStatus, b.bookContent, b.bookStock, b.bookReview, b.bookImg, (b.sales + COALESCE(b.reviewCount, 0)) AS totalScore " +
                    "FROM Book b " +
                    "ORDER BY totalScore DESC " +
                    "LIMIT 10";
            PreparedStatement bestSellerStmt = con.prepareStatement(bestSellerQuery);
            ResultSet bestSellerRs = bestSellerStmt.executeQuery();

            while (bestSellerRs.next()) {
                int bookId = bestSellerRs.getInt("bookId");
                String bookName = bestSellerRs.getString("bookName");
                int price = bestSellerRs.getInt("price");
                String writer = bestSellerRs.getString("writer");
                String publisher = bestSellerRs.getString("publisher");
                String bookCtg = bestSellerRs.getString("bookCtg");
                String bookStatus = bestSellerRs.getString("bookStatus");
                String bookContent = bestSellerRs.getString("bookContent");
                int bookStock = bestSellerRs.getInt("bookStock");
                String bookReview = bestSellerRs.getString("bookReview");
                String bookImg = bestSellerRs.getString("bookImg");

                // 베스트 셀러 정보 출력
                out.println("Book ID: " + bookId + "<br>");
                out.println("Book Name: " + bookName + "<br>");
                out.println("Price: " + price + "<br>");
                out.println("Writer: " + writer + "<br>");
                out.println("Publisher: " + publisher + "<br>");
                out.println("Category: " + bookCtg + "<br>");
                out.println("Status: " + bookStatus + "<br>");
                out.println("Content: " + bookContent + "<br>");
                out.println("Stock: " + bookStock + "<br>");
                out.println("Review: " + bookReview + "<br>");
                out.println("Image: " + bookImg + "<br>");
                out.println("---------------<br>");
            }

            con.close();
        } catch (Exception e) {
            out.println(e);
        }
        %>
    </center>
</body>
</html>

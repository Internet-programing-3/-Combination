<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>신간도서</title>
</head>
<body>
    <center>
        <br><br>
        <font color="green" size='6'><b>[신간도서] </b></font><p>

        <%
        try {
            String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
            String DB_ID = "multi";
            String DB_PASSWORD = "abcd";

            Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            // 신간 도서 목록 가져오기
            String newReleaseQuery = "SELECT * FROM Book " +
                    "ORDER BY registrationDate DESC " +
                    "LIMIT 10";
            PreparedStatement newReleaseStmt = con.prepareStatement(newReleaseQuery);
            ResultSet newReleaseRs = newReleaseStmt.executeQuery();

            while (newReleaseRs.next()) {
                int bookId = newReleaseRs.getInt("bookId");
                String bookName = newReleaseRs.getString("bookName");
                int price = newReleaseRs.getInt("price");
                String writer = newReleaseRs.getString("writer");
                String publisher = newReleaseRs.getString("publisher");
                String bookCtg = newReleaseRs.getString("bookCtg");
                String bookStatus = newReleaseRs.getString("bookStatus");
                String bookContent = newReleaseRs.getString("bookContent");
                int bookStock = newReleaseRs.getInt("bookStock");
                String bookReview = newReleaseRs.getString("bookReview");
                String bookImg = newReleaseRs.getString("bookImg");

                // 신간 도서 정보 출력
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

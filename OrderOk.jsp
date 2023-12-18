<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료</title>
    <link rel="stylesheet" type="text/css" href="Main.css?v=1">
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</head>
<body>

    <%
        request.setCharacterEncoding("UTF-8");
        String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";
		Class.forName("org.gjt.mm.mysql.Driver"); 
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 오늘의 책 랜덤 선택
        int today = 0;
        Random random = new Random();
        today = random.nextInt(8) + 1;

        String todayBook = "SELECT bookId, bookName, writer, bookImg FROM Book WHERE bookId = ?";
        PreparedStatement pstmtToday = con.prepareStatement(todayBook);
        pstmtToday.setInt(1, today);
        ResultSet rsToday = pstmtToday.executeQuery();
        rsToday.next();
        int todaykId = rsToday.getInt("bookId");
        String todayName = rsToday.getString("bookName");
        String todayWriter = rsToday.getString("writer");
        String todayBookImg = rsToday.getString("bookImg");
        %>
            <%!
        // 주문 번호 생성 메서드
        int generateUniqueOrderNumber(Connection connection) throws SQLException {
            String jsql = "SELECT MAX(ordNo) + 1 FROM orderInfo"; 
            PreparedStatement pstmt = connection.prepareStatement(jsql);
            ResultSet rs = pstmt.executeQuery(); 
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return 1;
            }
        }

        // 주문 번호 중복 확인 메서드
        boolean isOrderNumberUnique(Connection connection, int orderNumber) throws SQLException {
            String jsql = "SELECT COUNT(*) FROM orderInfo WHERE ordNo = ?"; 
            PreparedStatement pstmt = connection.prepareStatement(jsql);
            pstmt.setInt(1, orderNumber);
            ResultSet rs = pstmt.executeQuery(); 
            rs.next();
            int count = rs.getInt(1);
            return count == 0;
        }
    %>
    <%

        // 주문 정보 처리
        try {
            String ctNo = session.getId();
            String myId = (String)session.getAttribute("sid");

            String oName = request.getParameter("name");
            String oTel = request.getParameter("phone");
            String oReceiver = request.getParameter("receiver");
            String oRcvAddress = request.getParameter("rcvAddress");
            String oRcvPhone = request.getParameter("rcvPhone");
            String oCardNo = request.getParameter("cardNo");
            String oCardPass = request.getParameter("cardPass");
            String oBank = request.getParameter("bank");
            String oPay = request.getParameter("pay"); 

            // 새로운 주문번호 부여
            int oNum = 0;
            boolean isUnique = false;

            while (!isUnique) {
                oNum = generateUniqueOrderNumber(con);
                isUnique = isOrderNumberUnique(con, oNum);
            }

            // 장바구니 내역 주문상품 테이블에 저장
            String jsql2 = "SELECT bookId, ctQty FROM cart WHERE ctNo = ?";
            PreparedStatement pstmt2 = con.prepareStatement(jsql2);
            pstmt2.setString(1, ctNo);
            ResultSet rs2 = pstmt2.executeQuery();

            while (rs2.next()) {
                String bookId = rs2.getString("bookId");
                int ctQty = rs2.getInt("ctQty");

                // 주문상품테이블에 주문번호, 상품번호, 주문수량 저장
                String jsql3 = "INSERT INTO orderProduct (ordNo, bookId, ordQty) VALUES (?,?,?)";
                PreparedStatement pstmt3 = con.prepareStatement(jsql3);
                pstmt3.setInt(1, oNum);
                pstmt3.setString(2, bookId);
                pstmt3.setInt(3, ctQty);
                pstmt3.executeUpdate();
            }

            // 주문정보 테이블에 저장
            String jsql4 = "INSERT INTO orderInfo (ordNo, userId, ordDate, ordReceiver, ordRcvAddress, ordRcvPhone, ordPay, ordBank, ordCardNo, ordCardPass) VALUES(?,?,?,?,?,?,?,?,?,?)";            
            java.util.Date date = new java.util.Date();
            String oDate = date.toLocaleString(); 
            PreparedStatement pstmt4 = con.prepareStatement(jsql4);
            pstmt4.setInt(1, oNum);
            pstmt4.setString(2, myId);
            pstmt4.setString(3, oDate);
            pstmt4.setString(4, oReceiver);
            pstmt4.setString(5, oRcvAddress);
            pstmt4.setString(6, oRcvPhone);
            pstmt4.setString(7, oPay);
            pstmt4.setString(8, oBank);
            pstmt4.setString(9, oCardNo);
            pstmt4.setString(10, oCardPass);
            pstmt4.executeUpdate();

            // 주문 처리 후 장바구니 비우기
            response.sendRedirect("DeleteAllCart.jsp?case=1");

        } catch(Exception e) {
            out.println(e);
        } finally {
            rsToday.close();
            pstmtToday.close();
            con.close();
        }
    %>

</body>
</html>

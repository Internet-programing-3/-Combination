<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*, java.text.*" %>
<html>
<head>
    <title>주문 처리 완료</title>
    <style type="text/css">
        a:link { text-decoration: none; color: black; } <!-- 클릭하기전의 설정은 선없고 검정색 -->
        a:visited { text-decoration: none; color: black; } <!-- 방문한뒤의 설정은 밑줄없고 검정 -->
        a:hover { text-decoration: underline; color: gray; } <!-- 마우스가 올라갈때 설정은 아랫줄있고 파랑 -->
    </style>
</head>
<body>
<%
try {
    String DB_URL = "jdbc:mysql://localhost:3306/project";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

	Class.forName("org.gjt.mm.mysql.Driver"); 
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
    request.setCharacterEncoding("euc-kr");
    String cartId = session.getId();
    String userId = (String) session.getAttribute("sid");

    // 주문자 정보를 위해 추후 필요함
    String orderName = request.getParameter("name");
    String orderTel = request.getParameter("memTel");
    String orderReceiver = request.getParameter("receiver");
    String orderRcvAddress = request.getParameter("rcvAddress");
    String orderRcvPhone = request.getParameter("rcvPhone");
    String orderCardNo = request.getParameter("cardNo");
    String orderCardPass = request.getParameter("cardPass");
    String orderBank = request.getParameter("bank");
    String orderPay = request.getParameter("pay");

    // 새로운 주문번호를 부여하기 위해 주문테이블에 있는 마지막 주문번호를 가져옴
    String jsql = "SELECT MAX(orderId) FROM CartOrder";
    PreparedStatement pstmt = con.prepareStatement(jsql);
    ResultSet rs = pstmt.executeQuery();

    int orderId;
    if (rs.next()) {
        orderId = rs.getInt(1) + 1;
    } else {
        orderId = 1;
    }

    String jsql2 = "SELECT bookId, quantity FROM CartItem WHERE cartId = ?";
    PreparedStatement pstmt2 = con.prepareStatement(jsql2);
    pstmt2.setString(1, cartId);
    ResultSet rs2 = pstmt2.executeQuery();

    while (rs2.next()) {
        int bookId = rs2.getInt("bookId");
        int quantity = rs2.getInt("quantity");
        String jsql3 = "INSERT INTO OrderItem (orderId, bookId, quantity) VALUES (?,?,?)";
        PreparedStatement pstmt3 = con.prepareStatement(jsql3);
        pstmt3.setInt(1, orderId);
        pstmt3.setInt(2, bookId);
        pstmt3.setInt(3, quantity);
        pstmt3.executeUpdate();
    }

    String jsql4 = "INSERT INTO CartOrder (orderId, orderState, cartId) VALUES(?,?,?)";
    java.util.Date date = new java.util.Date();
    String orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    PreparedStatement pstmt4 = con.prepareStatement(jsql4);
    pstmt4.setInt(1, orderId);
    pstmt4.setString(2, "주문 완료");
    pstmt4.setString(3, cartId);
    pstmt4.executeUpdate();

    String jsql5 = "INSERT INTO Payment (paymentId, paymentKind, totalPay, orderId, userId) VALUES(?,?,?,?,?)";
    PreparedStatement pstmt5 = con.prepareStatement(jsql5);
    pstmt5.setInt(1, orderId);
    pstmt5.setString(2, "카드 결제"); // 또는 다른 결제 수단에 맞게 수정
    pstmt5.setString(3, orderPay);
    pstmt5.setInt(4, orderId);
    pstmt5.setString(5, userId);
    pstmt5.executeUpdate();

    response.sendRedirect("deleteTempCart.jsp");
} catch (Exception e) {
    out.println(e);
}
%>
</body>
</html>

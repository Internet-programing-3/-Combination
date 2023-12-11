<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*, java.text.*" %>
<html>
<head>
    <title>주문 처리 완료</title>
    <style type="text/css">
        a:link { text-decoration: none; color: black; }
        a:visited { text-decoration: none; color: black; }
        a:hover { text-decoration: underline; color: gray; }
    </style>
</head>
<%
try{
    String DB_URL = "jdbc:mysql://localhost:3306/project";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
    request.setCharacterEncoding("euc-kr");
    String cartId = session.getId(); // 세션번호 장바구니번호 저장
    String userId = (String)session.getAttribute("sid"); // 접속 값을 가져와서 변수에 저장 (주문자정보를 위해 추후 필요함)

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
    String maxOrderNoQuery = "SELECT MAX(orderId) FROM CartOrder"; 
    PreparedStatement maxOrderNoStmt = con.prepareStatement(maxOrderNoQuery);
    ResultSet maxOrderNoRs = maxOrderNoStmt.executeQuery(); 
    int orderId;
    if(maxOrderNoRs.next())
        orderId = maxOrderNoRs.getInt(1) + 1;
    else 
        orderId = 1;

    // 장바구니 테이블에 있는 내역들을 읽어와서 주문상품 테이블에 주문번호, 상품번호, 주문수량을 저장
    String cartItemsQuery = "SELECT bookId, quantity FROM CartItem WHERE cartId = ?";
    PreparedStatement cartItemsStmt = con.prepareStatement(cartItemsQuery);
    cartItemsStmt.setString(1, cartId);
    ResultSet cartItemsRs = cartItemsStmt.executeQuery(); 

    while(cartItemsRs.next()) {
        int bookId = cartItemsRs.getInt("bookId");
        int quantity = cartItemsRs.getInt("quantity");

        // 주문상품테이블에 주문번호, 상품번호, 주문수량 저장
        String insertOrderItemQuery = "INSERT INTO OrderItem (orderId, bookId, quantity) VALUES (?,?,?)";
        PreparedStatement insertOrderItemStmt = con.prepareStatement(insertOrderItemQuery);
        insertOrderItemStmt.setInt(1, orderId);
        insertOrderItemStmt.setInt(2, bookId);
        insertOrderItemStmt.setInt(3, quantity);
        insertOrderItemStmt.executeUpdate();
    }

    // 주문정보 테이블에 저장시킬 필드들을 저장
    String insertOrderInfoQuery = "INSERT INTO CartOrder (orderId, orderState, cartId) VALUES(?,?,?)";
    
    // 주문일을 오늘 날짜로 테이블에 저장
    java.util.Date date = new java.util.Date();
    String orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    
    PreparedStatement insertOrderInfoStmt = con.prepareStatement(insertOrderInfoQuery);
    insertOrderInfoStmt.setInt(1, orderId);
    insertOrderInfoStmt.setString(2, "주문 완료");
    insertOrderInfoStmt.setString(3, cartId);
    insertOrderInfoStmt.executeUpdate();

    String insertPaymentQuery = "INSERT INTO Payment (paymentId, paymentKind, totalPay, orderId, userId) VALUES(?,?,?,?,?)";
    PreparedStatement insertPaymentStmt = con.prepareStatement(insertPaymentQuery);
    insertPaymentStmt.setInt(1, orderId);
    insertPaymentStmt.setString(2, "카드 결제"); // 또는 다른 결제 수단에 맞게 수정
    insertPaymentStmt.setString(3, orderPay);
    insertPaymentStmt.setInt(4, orderId);
    insertPaymentStmt.setString(5, userId);
    insertPaymentStmt.executeUpdate();

    // 주문정보와 관련된 일체의 정보들을 각각 테이블과 테이블에 저장시킨 후 장바구니 비우기를 수행함
    // i) 주문 후에 장바구니를 비우는 것과 ii) 주문없이 장바구니를 비우는 것을 각각 구분하기 위해 case 파라미터를 사용
    // case=1: 주문처리 완료 후에 장바구니를 비우는 경우
    // 그 외의 경우는 주문없이 장바구니 비우기
    response.sendRedirect("deleteAllCart.jsp?case=1"); 
} catch(Exception e) {
    out.println(e);
} 
%>

</body>
</html>

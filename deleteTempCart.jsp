<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>주문 완료</title>
</head>
<body>
    <center>
        <%
        try {
            String DB_URL = "jdbc:mysql://localhost:3306/project";
            String DB_ID = "multi";
            String DB_PASSWORD = "abcd";

            Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            String cartId = session.getId();

            // 주문 정보를 유지하기 위해 CartOrder 테이블에 추가
            String orderState = "주문 완료"; // 또는 다른 상태에 따라 변경
            String insertOrderSql = "INSERT INTO CartOrder (orderState, cartId) VALUES (?, ?)";
            PreparedStatement insertOrderStmt = con.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
            insertOrderStmt.setString(1, orderState);
            insertOrderStmt.setString(2, cartId);
            insertOrderStmt.executeUpdate();

            ResultSet generatedKeys = insertOrderStmt.getGeneratedKeys();
            int orderId = -1;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            // 주문한 상품들에 대한 정보를 OrderItem 테이블에 추가
            String deleteTempCartSql = "DELETE FROM CartItem WHERE cartId=?";
            PreparedStatement deleteTempCartStmt = con.prepareStatement(deleteTempCartSql);
            deleteTempCartStmt.setString(1, cartId);
            deleteTempCartStmt.executeUpdate();
            %>
            <br><br>
            <font size=6 color=blue><b>[ ] 상품 주문 완료 </b></font><p>
            상품 주문이 완료되었습니다.<br><br>
            주문 번호: <%= orderId %><br><br>
            주문하신 상품은 주문 완료 후 일 이내에 배송될 예정입니다.<br><br>
            남서울 멀티쇼핑몰을 이용해 주셔서 감사합니다!
            <%
        } catch (Exception e) {
            out.println(e);
        }
        %>
    </center>
</body>
</html>

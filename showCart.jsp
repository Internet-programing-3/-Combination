<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>장바구니 내역 조회</title>
</head>
<body>
    <center>
        <br><br>
        <font color="blue" size='6'><b>[장바구니 내역]</b></font><p>

        <%
        try {
            String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
            String DB_ID = "multi";
            String DB_PASSWORD = "abcd";

            Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            // 세션에서 "cartId" 속성 가져오기
            Integer cartIdAttribute = (Integer) session.getAttribute("cartId");

            // cartIdAttribute가 null인지 확인
            int cartId = (cartIdAttribute != null) ? cartIdAttribute.intValue() : -1;

            String jsql = "SELECT * FROM cart WHERE cartId = ?";
            PreparedStatement pstmt = con.prepareStatement(jsql);
            pstmt.setInt(1, cartId);
            ResultSet rs = pstmt.executeQuery();


            if (!rs.next()) {
                %>
                장바구니가 비었습니다.
                <%
            } else {
                %>
                <form action="order.jsp" method="post">
                <table border=1 style="font-size:10pt;font-family: '맑은 고딕'">
                    <tr>
                        <td bgcolor="#002C57" width=120 height="30" align="center">
                            <p align="center"><font size="2" color="#ECFAE4"><strong>상품번호</strong></font></td>
                            <td bgcolor="#002C57" width=120 height="30" align="center">
                            <p><font size="2" color="#ECFAE4"><strong>상품명</strong></font></td>
                        <td bgcolor="#002C57" width=120 height="30" align="center">
                            <p><font size="2" color="#ECFAE4"><strong>상품단가 원(₩)</strong></font></td>
                        <td bgcolor="#002C57" width=120 height="30" align="center">
                            <p><font size="2" color="#ECFAE4"><strong>주문수량 개(개)</strong></font></td>
                        <td bgcolor="#002C57" width=120 height="30" align="center">
                            <p><font size="2" color="#ECFAE4"><strong>주문액 원(₩)</strong></font></td>
                        <td bgcolor="#002C57" width=120 height="30" align="center">
                            <p><font size="2" color="red"><b>[ ] 상품삭제 </b></font></td>

                    </tr>
                    <%
                    String jsql2 = "SELECT bookId, ctQty FROM cart WHERE cartId = ?";
                    PreparedStatement pstmt2 = con.prepareStatement(jsql2);
                    pstmt2.setInt(1, cartId);
                    ResultSet rs2 = pstmt2.executeQuery();
                    int total = 0;
                    while (rs2.next()) {
                        int bookId = rs2.getInt("bookId");
                        int quantity = rs2.getInt("ctQty");
                        String jsql3 = "SELECT bookName, price FROM book WHERE bookId = ?";
                        PreparedStatement pstmt3 = con.prepareStatement(jsql3);
                        pstmt3.setInt(1, bookId);

                        ResultSet rs3 = pstmt3.executeQuery();
                        rs3.next();
                        String bookName = rs3.getString("bookName");
                        int price = rs3.getInt("price");
                        int amount = price * quantity;
                        total = total + amount;
                    %>
                        <tr>
                            <td bgcolor="#eeeede" height="30" align="center"><font size="2"><%=bookId%></font></td>
                            <td bgcolor="#eeeede" height="30" align="center"><font size="2"><%=bookName%></font></td>
                            <td bgcolor="#eeeede" height="30" align="center" align=right><font size="2"><%=price%></font></td>
                            <td bgcolor="#eeeede" height="30" align="center" align=right><font size="2"><%=quantity%></font></td>
                            <td bgcolor="#eeeede" height="30" align="right"><font size="2"><%=amount%> 원</font></td>
                            <td bgcolor="#eeeede" height="30" align="center">
                                <input type="checkbox" name="deleteItems" value="<%=bookId%>">
                            </td>

                        </tr>
                        <%
                    }
                        %>
                    <tr>
                        <td colspan=4 align=center><font size="2" color="red"><b>전체 주문총액</b></font></td>
                        <td bgcolor="#eeeede" height="30" align=right>
                            <font size="2" color="red"><b><%=total%> 원</b></font>
                        </td>
                        <td align=center>
                            <font size=2 color=green>( 선택물품 총합 )  </font>
                        </td>
                    </tr>
                </table>
                <br><br>
                <input type="submit" value="주문하기">
                <a href="deleteAllCart.jsp"><font size=2>장바구니 비우기</font></a>
                </form>
                <%
            }
        } catch (Exception e) {
            out.println(e);
        }
        %>
    </center>
</body>
</html>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>장바구니 담기</title>
    <style type="text/css">
        a:link { text-decoration: none; color: black; }
        a:visited { text-decoration: none; color: black; }
        a:hover { text-decoration: underline; color:blue; }
    </style>
</head>
<body>
<%
    String myid = (String)session.getAttribute("userId"); 
    if (myid == null) {
%>
    <center>
        <br><br><br>
        <font style="font-size:10pt;font-family: '맑은 고딕'">
            상품 주문을 위해서는 로그인이 필요합니다 ! <br><br> 
            <a href="Login.jsp" ><img src="images/logIn.png" border=0></a>
        </font>
    </center>
<%
    } else {
        try {
            String DB_URL="jdbc:mysql://localhost:3306/internetproject";
            String DB_ID="multi"; 
            String DB_PASSWORD="abcd";

            Class.forName("org.gjt.mm.mysql.Driver"); 
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

            if (session.getAttribute("userId") != null) {
                // 로그인한 사용자일 경우
                int userId = Integer.parseInt(myid);

                // 기존 세션에 저장된 cartId 확인
                String cartIdAttribute = (String) session.getAttribute("cartId");
                String cartId = (cartIdAttribute != null) ? cartIdAttribute : null;

                String cartIdQuery = "SELECT cartId FROM Cart WHERE userId = ?";
                try (PreparedStatement pstmtCartId = con.prepareStatement(cartIdQuery)) {
                    pstmtCartId.setInt(1, userId);
                    ResultSet rsCartId = pstmtCartId.executeQuery();

                    if (rsCartId.next()) {
                        cartId = rsCartId.getString("cartId");
                        session.setAttribute("cartId", cartId);
                    }
                }

                String ctNo = session.getId();
                String bookId = request.getParameter("bookId");
                int ctQty = Integer.parseInt(request.getParameter("quantity"));

                String cartCheckQuery = "SELECT * FROM Cart WHERE cartId = ? AND bookId=? ";
                try (PreparedStatement cartCheckPstmt = con.prepareStatement(cartCheckQuery)) {
                    cartCheckPstmt.setString(1, ctNo);
                    cartCheckPstmt.setString(2, bookId);
                    ResultSet cartCheckRs = cartCheckPstmt.executeQuery();

                    if (cartCheckRs.next()) {
                        // 이미 존재하는 경우: 상품 수량 갱신
                        int sum = cartCheckRs.getInt("ctQty") + ctQty;
                        String updateSql = "UPDATE cart SET ctQty=? WHERE cartId=? AND bookId=?";
                        try (PreparedStatement pstmtUpdate = con.prepareStatement(updateSql)) {
                            pstmtUpdate.setInt(1, sum);
                            pstmtUpdate.setString(2, ctNo);
                            pstmtUpdate.setString(3, bookId);
                            pstmtUpdate.executeUpdate();
                        }
                    } else {
                        // 존재하지 않는 경우: 새로운 상품 레코드 추가
                        String insertSql = "INSERT INTO cart (cartId, bookId, ctQty) VALUES (?, ?, ?)";
                        try (PreparedStatement pstmtInsert = con.prepareStatement(insertSql)) {
                            pstmtInsert.setString(1, ctNo);
                            pstmtInsert.setString(2, bookId);
                            pstmtInsert.setInt(3, ctQty);
                            pstmtInsert.executeUpdate();
                        }
                    }
                }
            }
          
            response.sendRedirect("showCart.jsp");
        } catch(Exception e) {
            out.println(e);
        }
    }
%>
</body>
</html>

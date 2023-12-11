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
    String myid = (String)session.getAttribute("sid"); 
    if (myid == null) {
%>
    <center>
        <br><br><br>
        <font style="font-size:10pt;font-family: '맑은 고딕'">
            상품 주문을 위해서는 로그인이 필요합니다 ! <br><br> 
            <a href="login.jsp" ><img src="./images/login.gif" border=0></a>
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

            String ctNo = session.getId();
            String bookId = request.getParameter("bookId");
            int ctQty = Integer.parseInt(request.getParameter("quantity"));

            // Check if the user has an existing cart
            String cartCheckQuery = "SELECT * FROM Cart WHERE userId = ?";
            PreparedStatement cartCheckPstmt = con.prepareStatement(cartCheckQuery);
            cartCheckPstmt.setString(1, myid);
            ResultSet cartCheckRs = cartCheckPstmt.executeQuery();

            int cartId;

            if (cartCheckRs.next()) {
                cartId = cartCheckRs.getInt("cartId");
            } else {
                // If the user doesn't have a cart, create one
                String createCartQuery = "INSERT INTO Cart (userId) VALUES (?)";
                PreparedStatement createCartPstmt = con.prepareStatement(createCartQuery, Statement.RETURN_GENERATED_KEYS);
                createCartPstmt.setString(1, myid);
                createCartPstmt.executeUpdate();

                ResultSet generatedKeys = createCartPstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    cartId = generatedKeys.getInt(1);
                } else {
                    // Handle error
                    throw new SQLException("Creating cart failed, no ID obtained.");
                }
            }

            // Check if the item is already in the cart
            String itemCheckQuery = "SELECT * FROM CartItem WHERE cartId = ? AND bookId = ?";
            PreparedStatement itemCheckPstmt = con.prepareStatement(itemCheckQuery);
            itemCheckPstmt.setInt(1, cartId);
            itemCheckPstmt.setString(2, bookId);
            ResultSet itemCheckRs = itemCheckPstmt.executeQuery();

            if (itemCheckRs.next()) {
                // If the item is already in the cart, update the quantity
                int existingQty = itemCheckRs.getInt("ctQty");
                int newQty = existingQty + ctQty;

                String updateItemQuery = "UPDATE CartItem SET ctQty = ? WHERE cartId = ? AND bookId = ?";
                PreparedStatement updateItemPstmt = con.prepareStatement(updateItemQuery);
                updateItemPstmt.setInt(1, newQty);
                updateItemPstmt.setInt(2, cartId);
                updateItemPstmt.setString(3, bookId);
                updateItemPstmt.executeUpdate();
            } else {
                // If the item is not in the cart, add it
                String addItemQuery = "INSERT INTO CartItem (cartId, bookId, ctQty) VALUES (?, ?, ?)";
                PreparedStatement addItemPstmt = con.prepareStatement(addItemQuery);
                addItemPstmt.setInt(1, cartId);
                addItemPstmt.setString(2, bookId);
                addItemPstmt.setInt(3, ctQty);
                addItemPstmt.executeUpdate();
            }
        } catch(Exception e) {
            out.println(e);
        }
        response.sendRedirect("showCart.jsp");
    }
%>
</body>
</html>

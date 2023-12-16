<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>��ٱ��� ���</title>
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
        <font style="font-size:10pt;font-family: '���� ���'">
            ��ǰ �ֹ��� ���ؼ��� �α����� �ʿ��մϴ� ! <br><br> 
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
                // �α����� ������� ���
                int userId = Integer.parseInt(myid);

                // ���� ���ǿ� ����� cartId Ȯ��
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
                        // �̹� �����ϴ� ���: ��ǰ ���� ����
                        int sum = cartCheckRs.getInt("ctQty") + ctQty;
                        String updateSql = "UPDATE cart SET ctQty=? WHERE cartId=? AND bookId=?";
                        try (PreparedStatement pstmtUpdate = con.prepareStatement(updateSql)) {
                            pstmtUpdate.setInt(1, sum);
                            pstmtUpdate.setString(2, ctNo);
                            pstmtUpdate.setString(3, bookId);
                            pstmtUpdate.executeUpdate();
                        }
                    } else {
                        // �������� �ʴ� ���: ���ο� ��ǰ ���ڵ� �߰�
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

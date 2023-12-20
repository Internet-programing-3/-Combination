<%@ page contentType="text/html;charset=UTF-8" %>
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
    }
    else 
    {
        try
        {
            String DB_URL="jdbc:mysql://localhost:3306/internetproject";
            String DB_ID="multi"; 
            String DB_PASSWORD="abcd";

    		Class.forName("org.gjt.mm.mysql.Driver"); 
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
            
            String ctNo=session.getId();
            
            String bookId = request.getParameter("bookId"); // 상품번호
            int ctQty = Integer.parseInt(request.getParameter("ctQty")); // ( 주문수량 장바구니에 담

            String jsql = "select * from cart where ctNo = ? and bookId = ?";
            PreparedStatement pstmt = con.prepareStatement(jsql);
            pstmt.setString(1, ctNo);
            pstmt.setString(2, bookId);
            ResultSet rs = pstmt.executeQuery(); 
             if(rs.next()) // . 동일 상품이 이미 장바구니에 존재한다면 수량만을 추가시킴
            { // , update 즉 문을 사용하여 이미 존재하는 상품데이터의 수량부분만을 갱신시
            
            int sum = rs.getInt("ctQty") + ctQty; // 이미 기존에 있는 수량에다 새로 추가시킬 수량을
            
            String jsql2 = "update cart set ctQty=? where ctNo=? and bookId=?";
            PreparedStatement pstmt2 = con.prepareStatement(jsql2);
            pstmt2.setInt(1, sum);
            pstmt2.setString(2, ctNo);
            pstmt2.setString(3, bookId);
            pstmt2.executeUpdate();
            %>
            <script>
                console.log("Update Query Executed. ctNo: <%=ctNo%>, bookId: <%=bookId%>, ctQty: <%=ctQty%>");
            </script>
            <%
            }
            else // , 동일 상품이 장바구니에 존재하지 않는다면 새로운 상품레코드를 장바구니 테이블에
            
            {
            String jsql3 = "insert into cart (ctNo, bookId, ctQty) values (?,?,?)";
            PreparedStatement pstmt3 = con.prepareStatement(jsql3);
            pstmt3.setString(1,ctNo);
            pstmt3.setString(2,bookId);
            pstmt3.setInt(3,ctQty);
            pstmt3.executeUpdate();
            %>
            <script>
                console.log("Insert Query Executed. ctNo: <%=ctNo%>, bookId: <%=bookId%>, ctQty: <%=ctQty%>");
            </script>
            <%
            } // 76 ~97 if-else 행 행 문의 끝
        } catch(Exception e) {
            %>
            <script>
                console.log("<%=e%>");
            </script>
            
            
            <%
        } // catch 문 닫기
        // , showCart.jsp 장바구니에 상품을 등록 또는 갱신시킨 후 장바구니 내역을 보여주도록 를 호
        response.sendRedirect("showCart.jsp"); // <jsp:forward page="showCart.jsp"/> 와
    } // 24~104 if-else 행 문의 끝 
%>
</body>
</html>

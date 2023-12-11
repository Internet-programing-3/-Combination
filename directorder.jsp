<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>주문하기</title>
</head>
<script language="javascript" src="js_package.js"></script>
<body>
<center>
<%
String userId = (String)session.getAttribute("userId"); 

if (userId == null) {
%>
<!-- 로그인이 안 된 경우 -->
<center>
    <br><br><br>
    <font style="font-size:10pt;font-family:'맑은 고딕'">
        상품 주문을 위해서는 로그인이 필요합니다! <br><br> <a href="login.jsp"><img src="./images/login.gif" border=0></a>
    </font>
</center>
<%
} else {
    Connection con = null;
    try {
        String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String cartIdQuery = "SELECT cartId FROM Cart WHERE userId = ?";
        PreparedStatement cartIdStmt = con.prepareStatement(cartIdQuery);
        cartIdStmt.setString(1, userId);
        ResultSet cartIdResult = cartIdStmt.executeQuery();
        cartIdResult.next();
        int cartId = cartIdResult.getInt("cartId");

        String selectCartItemSql = "SELECT b.bookId, b.bookName, b.price, ci.quantity, (b.price * ci.quantity) AS amount " +
                                  "FROM CartItem ci " +
                                  "JOIN Book b ON ci.bookId = b.bookId " +
                                  "WHERE ci.cartId = ?";
        PreparedStatement selectCartItemStmt = con.prepareStatement(selectCartItemSql);
        selectCartItemStmt.setInt(1, cartId);
        ResultSet cartItemResult = selectCartItemStmt.executeQuery();
        int total = 0; // 전체 주문 총액
%>
<!-- 상품 주문서 -->
<br><br>
<font color="blue" size='6'><b>[ 상품 주문서 ]  </b></font><p>

<!-- 주문 상품 목록 -->
<table border=1 style="font-size:10pt;font-family:'맑은 고딕'">
    <tr>
        <td bgcolor="#002C57" width=120 height="30" align="center">
            <font size="2" color="#ECFAE4"><strong>상품번호</strong></font>
        </td>
        <td bgcolor="#002C57" width=120 height="30" align="center">
            <font size="2" color="#ECFAE4"><strong>상품명</strong></font>
        </td>
        <td bgcolor="#002C57" width=120 height="30" align="center">
            <font size="2" color="#ECFAE4"><strong>상품단가 원(￦)</strong></font>
        </td>
        <td bgcolor="#002C57" width=120 height="30" align="center">
            <font size="2" color="#ECFAE4"><strong>주문수량 개(개)</strong></font>
        </td>
        <td bgcolor="#002C57" width=120 height="30" align="center">
            <font size="2" color="#ECFAE4"><strong>주문액 원(￦)</strong></font>
        </td>
        <td bgcolor="#002C57" width=114 height="30" align="center">
            <font size="2" color="red"><b>비 고</b></font>
        </td>
    </tr>
<%
        while (cartItemResult.next()) {
            int bookId = cartItemResult.getInt("bookId");
            String bookName = cartItemResult.getString("bookName");
            int price = cartItemResult.getInt("price");
            int quantity = cartItemResult.getInt("quantity");
            int amount = cartItemResult.getInt("amount");
            total += amount;
%>
    <tr>
        <td bgcolor="#eeeede" height="30" align="center">
            <font size="2"><%= bookId %></font>
        </td>
        <td bgcolor="#eeeede" height="30" align="center">
            <font size="2"><%= bookName %></font>
        </td>
        <td bgcolor="#eeeede" height="30" align="center" align="right">
            <font size="2"><%= price %></font>
        </td>
        <td bgcolor="#eeeede" height="30" align="center" align="right">
            <font size="2"><%= quantity %></font>
        </td>
        <td bgcolor="#eeeede" height="30" align="right">
            <font size="2"><%= amount %> 원</font>
        </td>
        <td bgcolor="#eeeede" height="30" align="center">
            <font size="2">즉시 구매</font>
        </td>
    </tr>
<%
        }
%>
    <tr>
        <td colspan=4 align=center>
            <font size="2" color="red"><b>전체 주문총액</b></font>
        </td>
        <td bgcolor="#eeeede" height="30" align=right>
            <font size="2" color="red"><b><%= total %> 원</b></font>
        </td>
        <td align=center>
            <font size=2 color=green>( ) 선택물품 총합 </font>
        </td>
    </tr>
</table>

<%
        // 주문자 정보 출력
        String selectMemberSql = "SELECT name, phone FROM User WHERE userId = ?";
        PreparedStatement selectMemberStmt = con.prepareStatement(selectMemberSql);
        selectMemberStmt.setString(1, userId);
        ResultSet memberResult = selectMemberStmt.executeQuery();
        memberResult.next();
        String name = memberResult.getString("name");
        String phone = memberResult.getString("phone");
%>

<form name="form" method="Post" action="directOrderOK.jsp"> 
<table border=1 style="font-size:10pt;font-family:'맑은 고딕'">
    <tr>
        <td rowspan=2 width="155" align="center" bgcolor="#002C57">
            <font size="2" color="#ECFAE4">
                <strong>주문자 정보</strong>
            </font>
        </td>
        <td align="center" width=110 bgcolor="#002C57">
            <font size="2" color="#ECFAE4">
                <strong>이 름</strong>
            </font>
        </td>
        <td width=470><%= name %></td>
    </tr>
    <tr>
        <td align="center" width=110 bgcolor="#002C57">
            <font size="2" color="#ECFAE4">
                <strong>전 화</strong>
            </font>
        </td>
        <td width=470><input type="text" name="memTel" size=40 value=<%= phone %>></td>
    </tr>
</table>

<!-- 이하 생략 -->
<table border=1 style="font-size:10pt;font-family:'맑은 고딕'">
    <tr>
        <td rowspan=2 align="center" width="155" bgcolor="#002C57">
            <font size="2" color="#ECFAE4">
                <strong>결제 방법</strong>
            </font>
        </td>
        <td align="center" width=110 bgcolor="#002C57">
            <font size="2" color="#ECFAE4">
                <strong>신용카드 번호</strong>
            </font>
        </td>
        <td width=120><input type="text" name="cardNo"></td>
        <td align="center" width=112 bgcolor="#002C57">
            <font size="2" color="#ECFAE4">
                <strong>비밀번호</strong>
            </font>
        </tr>
        <tr>
<td align="center" width=110 bgcolor="#002C57">
    <font size="2" color="#ECFAE4">
        <strong>무통장 입금</strong>
    </font>
</td>
<td colspan=3 width=474>
    <select name="bank">
        <option value="0" selected>다음 중 선택</option>
        <option value=" " 우리은행>우리은행 주 남서울멀티쇼핑몰 (324-01-123400 / ( ) )</option>
        <option value=" " 국민은행>국민은행 주 남서울멀티쇼핑몰 (011-02-300481 / ( ) )</option>
        <option value=" " 외환은행>외환은행 주 남서울멀티쇼핑몰 (327-56-333002 / ( ) )</option>
        <option value=" " 신한은행>신한은행 주 남서울멀티쇼핑몰 (987-25-202099 / ( ) )</option>
        <option value=" " 하나은행>하나은행 주 남서울멀티쇼핑몰 (698-00-222176 / ( ) )</option>
    </select>
    <font size=1 color=blue>( or !) 카드 무통장입금 중 택일 </font>
</td>
</tr>
</table>
<table border=1 style="font-size:13pt;font-family: '맑은 고딕'">
    <tr>
        <td colspan=2 align="center" width="275" bgcolor="#002C57">
            <font color="red">
                <strong>전체 주문 총액 원 ()</strong>
            </font>
        </td>
        <!-- hidden orderOK.jsp ! -->
        <td width=470 align=right>
            <input type="hidden" name="pay" value="<%=total%>">
            <font color="red"><%=total%></font>&nbsp( ) 원
        </td>
    </tr>
</table>
<br>
<table>
    <tr>
        <!-- onClick , input type "button" 이벤트가 사용되고 있고 태그의 속성값이 임에 유의할 것
        ! -->
        <!-- "js_package.js" check_val() ! -->
        <td>
            <input type=button value=" " 주문확인 OnClick="check_val()">
        </td>
        <td>
            <input type="reset" value=" " 주문취소 name="reset">
        </td>
    </tr>
</table>
</form>


<%
 } catch(Exception e) {
 out.println(e);
} 
} // if-else 문의 끝
%>



</center>
</body>
</html>



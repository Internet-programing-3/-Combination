<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>주문하기</title>
</head>
<script language="javascript" src="js_package.js">
</script>
<body>
<center>
<br><br>
<font color="blue" size='6'><b>[ 상품 주문서 ]  </b></font><p>
<%
try { // 완전히 동일한 코드임
 String DB_URL="jdbc:mysql://localhost:3306/project"; // DB project 접속 는
 String DB_ID="multi"; 
 String DB_PASSWORD="abcd";
 
Class.forName("org.gjt.mm.mysql.Driver"); 
 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

// 장바구니 정보 가져오기
String ctNo = (String)session.getAttribute("cartId");
String userId = (String)session.getAttribute("userId");

String jsql = "SELECT * FROM CartItem ci JOIN Book b ON ci.bookId = b.bookId WHERE ci.cartId = ?";
PreparedStatement pstmt = con.prepareStatement(jsql);
pstmt.setString(1, ctNo);
ResultSet rs = pstmt.executeQuery();

if(!rs.next()) {
%>
장바구니가 비었습니다.
<%
} else {
%>
<table border=1 style="font-size:10pt;font-family: '맑은 고딕'">
<tr> 
 <td bgcolor="#002C57" width = 120 height="30" align="center"><font size="2" color="#ECFAE4"><strong>상품번호</strong></font></td>
 <td bgcolor="#002C57" width = 120 height="30" align="center"><font size="2" color="#ECFAE4"><strong>상품명</strong></font></td> 
 <td bgcolor="#002C57" width = 120 height="30" align="center"><font size="2" color="#ECFAE4"><strong>상품단가 원( )</strong></font></td> 
 <td bgcolor="#002C57" width = 120 height="30" align="center"><font size="2" color="#ECFAE4"><strong>주문수량 개( )</strong></font></td> 
 <td bgcolor="#002C57" width = 120 height="30" align="center"><font size="2" color="#ECFAE4"><strong>주문액 원( )</strong></font></td> 
 <td bgcolor="#002C57" width = 120 height="30" align="center"><font size="2" color="red"><b>[ ] 상품삭제 </b></font></td>
</tr>

<%
int total = 0;
do {
    String prdNo = rs.getString("bookId");
    String prdName = rs.getString("bookName");
    int prdPrice = rs.getInt("price");
    int ctQty = rs.getInt("quantity");
    int amount = prdPrice * ctQty;
    total += amount;
%>

<tr> 
 <td bgcolor="#eeeede" height="30" align="center"><font size="2"><%=prdNo%></font></td> 
 <td bgcolor="#eeeede" height="30" align="center"><font size="2"><%=prdName%></font></td>
 <td bgcolor="#eeeede" height="30" align="right"><font size="2"><%=prdPrice%></font></td>
 <td bgcolor="#eeeede" height="30" align="right"><font size="2"><%=ctQty%></font></td>
 <td bgcolor="#eeeede" height="30" align="right"><font size="2"><%=amount%> 원</font></td> 
 <td bgcolor="#eeeede" height="30" align="center">
    <a href="deleteCart.jsp?prdNo=<%=prdNo%>"><font size="2" color=blue><b>삭제</b></font></a>
 </td>
</tr>

<%
} while (rs.next());
%>

<tr>
 <td colspan=4 align=center><font size="2" color="red"><b>전체 주문총액</b></font></td>
 <td bgcolor="#eeeede" height="30" align=right><font size="2" color="red"><b><%=total%> 원</b></font></td>
 <td align=center><font size=2 color=green>( ) 선택물품 총합</font></td>
</tr>
</table> 

<%
// (2) - 주문자 정보 출력 회원 테이블 정보 출력
String jsql2 = "SELECT * FROM User WHERE userId = ?";
PreparedStatement pstmt2 = con.prepareStatement(jsql2);
pstmt2.setString(1, userId);
ResultSet rs2 = pstmt2.executeQuery();
rs2.next();

String name = rs2.getString("name");
String tel = rs2.getString("phone");
%>

<form name="form" method="Post" action="orderOK.jsp">
<table border=1 style="font-size:10pt;font-family: '맑은 고딕'">
<tr>
<td rowspan=2 width="155" align="center" bgcolor="#002C57">
    <font size="2" color="#ECFAE4"><strong>주문자 정보</strong></font>
</td>
<td align="center" width=110 bgcolor="#002C57">
    <font size="2" color="#ECFAE4"><strong>이 름</strong></font>
</td>
<td width=470><%=name%></td>
</tr>
<tr>
<td align="center" width=110 bgcolor="#002C57">
    <font size="2" color="#ECFAE4"><strong>전 화</strong></font>
</td>
<td width=470><input type="text" name="memTel" size=40 value=<%=tel%>></td>
</tr>
</table>

<table border=1 style="font-size:10pt;font-family: " 맑은 고딕 >
<tr>
<td rowspan = 3 width="155"align="center" bgcolor="#002C57">
<font size="2" color="#ECFAE4">
<strong>수령인 정보</strong></font></td>
<td align="center" width=110 bgcolor="#002C57">
<font size="2" color="#ECFAE4">
<strong>이 름</strong></font></td>
<td width=470><input type="text" name="receiver" size=40></td>
</tr>
<tr>
<td align="center" width=110 bgcolor="#002C57">
<font size="2" color="#ECFAE4">
<strong>주 소</strong></font></td>
<td width=470><input type="text" name="rcvAddress" size=40></td>
</tr>
<tr>
<td align="center" width=110 bgcolor="#002C57">
<font size="2" color="#ECFAE4">
<strong>전 화</strong></font></td>
<td width=470><input type="text" name="rcvPhone" size=40></td>
</tr>
</table>
<table border=1 style="font-size:10pt;font-family: " 맑은 고딕 >
<tr>
<td rowspan = 2 align="center" width="155" bgcolor="#002C57">
<font size="2" color="#ECFAE4">
<strong>결제 방법</strong></font></td>
<td align="center" width=110 bgcolor="#002C57">
<font size="2" color="#ECFAE4">
<strong>신용카드 번호</td>
<td width=120><input type="text" name="cardNo"></td>
<td align="center" width=112 bgcolor="#002C57">
<font size="2" color="#ECFAE4">
<strong>비밀번호</strong></font></td>
<td width=120><input type="password" name="cardPass"></td>

</tr>
<tr>
<td align="center" width=110 bgcolor="#002C57">
<font size="2" color="#ECFAE4">
<strong>무통장 입금</strong></font></td>
<td colspan=3 width=474>
<select name="bank">
<option value="0" selected>다음 중 선택 </option>
 <option value=" " 우리은행 >우리은행 주 남서울멀티쇼핑몰 ( 324-01-123400 / ( ) )</option>
 <option value=" " 국민은행 >국민은행 주 남서울멀티쇼핑몰 ( 011-02-300481 / ( ) )</option>
 <option value=" " 외환은행 >외환은행 주 남서울멀티쇼핑몰 ( 327-56-333002 / ( ) )</option>
 <option value=" " 신한은행 >신한은행 주 남서울멀티쇼핑몰 ( 987-25-202099 / ( ) )</option>
 <option value=" " 하나은행 >하나은행 주 남서울멀티쇼핑몰 ( 698-00-222176 / ( ) )</option>
</select>
<font size=1 color=blue>( or !) 카드 무통장입금 중 택일 </font>
</td></td></tr>
</table>
<table border=1 style="font-size:13pt;font-family: " 맑은 고딕 >
<tr>
<td colspan = 2 align="center" width="275" bgcolor="#002C57">
<font color="red">
<strong>전체 주문 총액 원 ()</strong></font></td>
 <!-- hidden orderOK.jsp ! --> 왜 처리를 해야만 하는지 를 분석하면서 곰곰히 생각해 볼 것
<td width=470 align=right><input type="hidden" name="pay" value="<%=total%>" 
><font color="red"><%=total%></font>&nbsp( ) 원 </td> 
</tr>
</table>
<br>
<table>
<tr> 
<td><input type = button value = " " 주문확인 OnClick="check_val()"></td>
<td><input type="reset" value=" " 주문취소 name="reset" ></td>
</tr>
</table>
</form>

<%
} // if-else 문의 끝
} catch(Exception e) {
    out.println(e);
} 
%>

</center> 
</body>
</html>

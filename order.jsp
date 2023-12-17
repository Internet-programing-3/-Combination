<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
String ctNo = session.getId(); // ctNo 세션 번호를 장바구니 번호로서 이용하기 위해 에 저장

String jsql = "select * from cart where ctNo = ?";
PreparedStatement pstmt = con.prepareStatement(jsql);
pstmt.setString(1, ctNo);

ResultSet rs = pstmt.executeQuery();

if(!rs.next()) {
%>
장바구니가 비었습니다.
<%
} else {
%>


<%
String jsql2 = "select bookId, ctQty from cart where ctNo = ?";
PreparedStatement pstmt2 = con.prepareStatement(jsql2);
pstmt2.setString(1, ctNo);
ResultSet rs2 = pstmt2.executeQuery(); 
int total=0;
while(rs2.next()) 
 { 
String prdNo = rs2.getString("bookId"); // cart 테이블로부터 상품번호 추출
 int ctQty = rs2.getInt("ctQty"); // cart 테이블로부터 주문수량 추출
 String jsql3 = "select bookName,Price from Book where BookId = ?";
 PreparedStatement pstmt3 = con.prepareStatement(jsql3);
 pstmt3.setString(1, prdNo);
 
ResultSet rs3 = pstmt3.executeQuery(); 
rs3.next();
String prdName = rs3.getString("bookName"); // goods 테이블로부터 상품명 추출
int prdPrice = rs3.getInt("price"); // goods 테이블로부터 상품단가 추출
 int amount = prdPrice * ctQty; // 주문액 계산
total = total + amount;
%>
<%
 }
%>


<%
String myid = (String)session.getAttribute("sid"); // ( , ) 로그인했었던 주문자 정보 즉 아이디

// (2) - 주문자 정보 출력 회원 테이블 정보 출력
String jsql4 = "select name, phone from user where userId = ?";
PreparedStatement pstmt4 = con.prepareStatement(jsql4);
pstmt4.setString(1,myid);
ResultSet rs4 = pstmt4.executeQuery();
rs4.next();

String name = rs2.getString("name");
String tel = rs2.getString("phone");

} // if-else 문의 끝
} catch(Exception e) {
    out.println(e);
} 
%>

</center> 
</body>
</html>

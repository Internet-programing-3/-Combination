<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
	<link rel="stylesheet" type="text/css" href="Main.css?v=1">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
		String DB_ID = "multi";
		String DB_PASSWORD = "abcd";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
	%>

	<header>
		<a href="Mainpage.jsp">
			<img src="images/Logo.jpg" style="width: 400px; height: 150px;" alt="청년책방 로고">
		</a>
	</header>

	<nav class="navMainOne">
		<div class="todayMain">
			<a href="#">
				<%
					int today = 0;
					Random random = new Random();
					today = random.nextInt(8) + 1;

					String todayBook = "SELECT bookId, bookName, writer, bookImg FROM Book WHERE bookId = ?";
					PreparedStatement pstmtToday = con.prepareStatement(todayBook);
					pstmtToday.setInt(1, today);
					ResultSet rsToday = pstmtToday.executeQuery();
					rsToday.next();
					int todaykId = rsToday.getInt("bookId");
					String todayName = rsToday.getString("bookName");
					String todayWriter = rsToday.getString("writer");
					String todayBookImg = rsToday.getString("bookImg");
				%>
				<span>
					<img src="<%=todayBookImg%>.jpg" title="<%=todayName%>(<%=todayWriter%>)" alt="<%=todayName%>">
				</span>
				<span>
					<h3><%=todayName%></h3>
					<p><%=todayWriter%></p>
				</span>
				<%
					rsToday.close();
					pstmtToday.close();
				%>
			</a>
		</div>
		<div class="searchMain">
			<img src="images/LogoIcon.png" alt="로고아이콘">
			<input type="text">
			<button type="button" alt="검색 버튼">검색</button>
		</div>
		<div>
			<%
				if (session.getAttribute("userId") == null) {
			%>
			<a href="Login.jsp">
				<img src="images/mypage.png" style="width: 50px; height: 50px;" title="마이페이지" alt="마이페이지">
			</a>
			<a href="Login.jsp">
				<img src="images/cart.png" style="width: 50px; height: 50px; margin: 0 10px;" title="장바구니" alt="장바구니">
			</a>
			<a href="Login.jsp">
				<img src="images/logIn.png" style="width: 50px; height: 50px;" title="로그인" alt="회원가입/로그인">
			</a>
			<%
				} else {
			%>
			<a href="MyPage.jsp">
				<img src="images/mypage.png" style="width: 50px; height: 50px;" title="마이페이지" alt="마이페이지">
			</a>
			<a href="#">
				<img src="images/cart.png" style="width: 50px; height: 50px; margin: 0 10px;" title="장바구니" alt="장바구니">
			</a>
			<a href="Logout.jsp">
				<img src="images/logOut.png" style="width: 50px; height: 50px;" title="로그아웃" alt="로그아웃">
			</a>
			<%
				}
			%>
        </div>
	</nav>

	<main class="ShopMain">
		<%
		try {
			Integer cartIdAttribute = (Integer) session.getAttribute("cartId");
			int cartId = (cartIdAttribute != null) ? cartIdAttribute.intValue() : -1;

			String jsql = "SELECT * FROM cart WHERE cartId = ?";
			PreparedStatement pstmt = con.prepareStatement(jsql);
			pstmt.setInt(1, cartId);
			ResultSet rs = pstmt.executeQuery();

			if (!rs.next()) {
		%>
				<article class="shopList">
					<table>
						<tr class="shopHeader">
							<th>장바구니가 비었습니다.</th>
						</tr>
					</table>
				</article>
		<%
			} else {
		%>
				<form action="order.jsp" method="post">
					<article class="shopList">
						<table border=1 style="font-size:10pt;font-family: '맑은 고딕'">
							<tr>
								<td bgcolor="#002C57" width=120 height="30" align="center">
									<font size="2" color="#ECFAE4"><strong>상품번호</strong></font>
								</td>
								<td bgcolor="#002C57" width=120 height="30" align="center">
									<font size="2" color="#ECFAE4"><strong>상품명</strong></font>
								</td>
								<td bgcolor="#002C57" width=120 height="30" align="center">
									<font size="2" color="#ECFAE4"><strong>상품단가 원(₩)</strong></font>
								</td>
								<td bgcolor="#002C57" width=120 height="30" align="center">
									<font size="2" color="#ECFAE4"><strong>주문수량 개(개)</strong></font>
								</td>
								<td bgcolor="#002C57" width=120 height="30" align="center">
									<font size="2" color="#ECFAE4"><strong>주문액 원(₩)</strong></font>
								</td>
								<td bgcolor="#002C57" width=120 height="30" align="center">
									<font size="2" color="red"><b>[ ] 상품삭제 </b></font>
								</td>
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
									<font size=2 color=green>( 선택물품 총합 ) </font>
								</td>
							</tr>
						</table>
						<br><br>
						<input type="submit" value="주문하기">
						<a href="deleteAllCart.jsp"><font size=2>장바구니 비우기</font></a>
					</article>
				</form>
		<%
			}
		} catch (Exception e) {
			out.println(e);
		}
		%>
	</main>

	<%
		con.close();	
	%>

	<footer>
		<div class="notices">
			<ul>
				<li><h4>공지사항</h4></li>
				<li><a href="javascript:void(0);">개인정보 처리방침 변경안내</a></li>
				<li><a href="javascript:void(0);"><h4>더보기+</h4></a></li>
				<li><h4>이벤트</h4></li>
				<li><a href="javascript:void(0);">11월 북클럽 독후감대회 우승자 발표</a></li>
				<li><a href="javascript:void(0);"><h4>더보기+</h4></a></li>
			</ul>
		</div>
		<div class="footerMain">
			<img src="images/Logo.jpg">
			<div>
				<p>회사소개 | 이용약관 | 개인정보처리방침 | 청소년보호정책 | 대량주문안내 | 협력사여러분 | 채용정보 | 광고소개</p>
				<p>
					대표이사 : 서병덕 | 남서울대학교 멀티미디어학과 | 사업자등록번호 : 181-001-2002</br>
					대표전화 : 1588-0000 (발신자 부담전화) | FAX : 0000-112-505 (지역번호 공통) | 인터넷프로그래밍2 : 제 2023호
				</p>
			</div>
		</div>
	</footer>
</body>
</html>


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

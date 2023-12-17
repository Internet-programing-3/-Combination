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
		Class.forName("org.gjt.mm.mysql.Driver"); 
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
			<a href="showCart">
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
			String ctNo = session.getId(); // ctNo 세션 번호를 장바구니 번호로서 이용하기 위해 에 저장

			String jsql = "select * from cart where ctNo = ?";
			PreparedStatement pstmt = con.prepareStatement(jsql);
			pstmt.setString(1, ctNo);
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
		<article class="shopList">
    <table>
        <tr class="shopHeader">
            <th><input type="checkbox" id="selectAll" checked></th>
            <th colspan="2" align="left">전체 선택</th>
            <th colspan="2" align="right">
                <a href="javacript:void(0);"><button>선택 삭제</button></a>
            </th>
        </tr>
        <!-- 상품 목록 -->
             <%
            // 기존 코드와 함께 사용할 변수 선언
            int totalAmount = 0;
            
            String jsql2 = "select cart.bookId, ctQty, bookName, price, bookImg " +
                           "from cart " +
                           "join Book on cart.bookId = Book.bookId " +
                           "where ctNo = ?";
            PreparedStatement pstmt2 = con.prepareStatement(jsql2);
            pstmt2.setString(1, ctNo);
            ResultSet rs2 = pstmt2.executeQuery();
            while (rs2.next()) {
                String bookId = rs2.getString("bookId"); // cart 테이블로부터 상품번호 추출
                int ctQty = rs2.getInt("ctQty"); // cart 테이블로부터 주문수량 추출
                String bookName = rs2.getString("bookName");
                int price = rs2.getInt("price");
                String bookImg = rs2.getString("bookImg");
                int amount = price * ctQty;
                totalAmount += amount;
        %>
                <tr class="shopCont">
                    <td><input type="checkbox" checked></td>
                    <a href="javascript:void(0);">
                        <td><img src="<%= bookImg %>.jpg"></td>
                        <td align="left"><%= bookName %></td>
                        <td><%= ctQty %>권</td>
                        <td><%= amount %>원</td>
                    </a>
                </tr>
        <%
            }
            rs2.close();
            pstmt2.close();
        %>
    </table>
</article>

<!-- 결제정보 -->
<aside class="shopAside">
    <table>
        <tr>
            <th>총 상품 금액</th>
            <td><%= totalAmount %>원</td>
        </tr>
        <tr>
            <th>할인 금액</th>
            <td>- 0원</td>
        </tr>
        <tr class="shopEnd">
            <th>합계</th>
            <td><%= totalAmount %>원</td>
        </tr>
    </table>
    <!-- 구매 버튼 -->
    <a href="Payment.jsp">
        <button>구매하기</button>
    </a>
</aside>

								
			
							<%
							}
							%>
					
					
				
		<%
			
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

			
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인화면</title>
	<!-- 외부 CSS 적용 / 파일 경로 뒤에 ' ?v=1 ' 부분 지우지 마세요. 에러나요! -->
	<!-- 단위 수정 잘못하면 UI랑 배열 깨집니다 -->
	<link rel="stylesheet" type="text/css" href="Main.css?v=1">
	<!-- jQuery 라이브러리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</head>
<body>
	<%
		// 인코딩
		request.setCharacterEncoding("UTF-8");
		// DB 연결
		String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
		String DB_ID = "multi";
		String DB_PASSWORD = "abcd";
		Class.forName("org.gjt.mm.mysql.Driver"); 
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
	%>
	<!-- 제이쿼리용 -->
	<script type="text/javascript">
		 $(document).ready(function(){
			 $(".btnMO li").click(function () {
				var contNum = $(this).index();
				$(this).addClass("On").siblings().removeClass("On");
				$(".contMO").eq(contNum).addClass("On").siblings().removeClass("On");
			});
		 })
	</script>

	<!-- header (로고) -->
	<header>
		<a href="Mainpage.jsp">
			<img src="images/Logo.jpg" style="width: 400px; height: 150px;" alt="청년책방 로고">
		</a>
	</header>

	<!-- nav1 ( 오늘의 책, 검색창, 마이페이지, 로그인 ) -->
	<nav class="navMainOne">
		<!--오늘의 책 -->
		<div class="todayMain"><a href="#">
		<%
    int today = 0;
    Random random = new Random();
    today = random.nextInt(8) + 1;
    String todayBook = "SELECT bookId, bookName, writer, bookImg FROM Book WHERE bookId = ?";
    PreparedStatement pstmtToday = con.prepareStatement(todayBook);
    pstmtToday.setInt(1, today);
    ResultSet rsToday = pstmtToday.executeQuery();
    
    if (rsToday.next()) {
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
    } else {
        // 오늘의 책이 없는 경우 처리
%>
    <span>
        <p>오늘의 책이 없습니다.</p>
    </span>
<%
    }
    rsToday.close();
    pstmtToday.close();
%>
		
		</a></div>
		<!-- 검색바 -->
		<div class="searchMain">
			<img src="images/LogoIcon.png" alt="로고아이콘">
			<input type="text">
			<button type="button" alt="검색 버튼">검색</button>
		</div>
		<!-- 마이페이지, 장바구니, 로그인/로그아웃 버튼 -->
		<div>
			<!-- 로그인 -->
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
			<!-- 로그아웃 -->
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

	<!-- nav2 (베스트셀러, 신간도서, 국내도서 등) -->
	<nav class="navMainTwo">
		<ul>
			<li><a href="BookList.jsp?bookCtg=베스트셀러">
				<img src="images/menuButton01.png" alt="베스트셀러">
			</a></li>
			<li><a href="BookList.jsp?bookCtg=신간도서">
				<img src="images/menuButton02.png" alt="신간도서">
			</a></li>
			<li><a href="BookList.jsp?bookCtg=국내도서">
				<img src="images/menuButton03.png" alt="국내도서">
			</a></li>
			<li><a href="BookList.jsp?bookCtg=해외도서">
				<img src="images/menuButton04.png" alt="해외도서">
			</a></li>
			<li><a href="#">
				<img src="images/menuButton05.png" alt="이벤트">
			</a></li>
			<li><a href="BookClub.jsp?clubId=1">
				<img src="images/menuButton06.png" alt="북클럽">
			</a></li>
		</ul>
	</nav>

	<!-- main1 (베스트셀러 목록 ) -->
	<main class="MainOne">
		<!-- tab 버튼 -->
		<ul class="btnMO">
			<li class="On"><a href="javascript:void(0);">추천 도서</a></li>
			<li><a href="javascript:void(0);">화제의 신간</a></li>
			<li><a href="javascript:void(0);">스테디셀러</a></li>
			<li><a href="javascript:void(0);">코믹</a></li>
		</ul>
		<!-- tab1 추천 도서 -->
		<div class="contMO On">
			<table>
				<tr>
				<%
				
					String RecommendBook = "SELECT bookId, bookName, price, writer, bookImg FROM Book LIMIT 8";
					int RB = 1;
					PreparedStatement pstmtRB = con.prepareStatement(RecommendBook);
					ResultSet rsRB = pstmtRB.executeQuery(); 
					while(rsRB.next()){ 
						int bookId = rsRB.getInt("bookId"); 
						String  bookName = rsRB.getString("bookName"); 
						int bookPrice = rsRB.getInt("price");
						String  writer = rsRB.getString("writer");
						String bookImg = rsRB.getString("bookImg");
				%>
					<td><a href="BookDetail.jsp?bookId=<%=bookId%>">
						<p>
							<img src="<%=bookImg%>.jpg" title="<%=bookName%>(<%=writer%>)" alt="<%=bookName%>">
							<b><%=bookName%></b></br>
							<%=writer%></br>
							<b><%=bookPrice%>원</b>
						</a></p>
					</td>
				<%
						if(RB % 4 == 0){out.println("<tr>");}
						RB++;
					}
					out.println("</tr>");
					rsRB.close();
					pstmtRB.close();
				%>
			</table>
		</div>
		<!-- tab2 화제의 신간 -->
		<div class="contMO">
			<table>
				<tr>
				<%
					String NewBook = "SELECT bookId, bookName, price, writer, bookImg FROM Book ORDER BY bookId DESC LIMIT 8";
					int NB = 1;
					PreparedStatement pstmtNB = con.prepareStatement(NewBook);
					ResultSet rsNB = pstmtNB.executeQuery(); 
					while(rsNB.next()){ 
						int bookId = rsNB.getInt("bookId"); 
						String  bookName = rsNB.getString("bookName"); 
						int bookPrice = rsNB.getInt("price");
						String  writer = rsNB.getString("writer");
						String bookImg = rsNB.getString("bookImg");
				%>
					<td>
						<p><a href="BookDetail.jsp?bookId=<%=bookId%>">
							<img src="<%=bookImg%>.jpg" title="<%=bookName%>(<%=writer%>)" alt="<%=bookName%>">
							<b><%=bookName%></b></br>
							<%=writer%></br>
							<b><%=bookPrice%>원</b>
						</a></p>
					</td>
				<%
						if(NB % 4 == 0){out.println("<tr>");}
						NB++;
					}
					out.println("</tr>");
					rsNB.close();
					pstmtNB.close();
				%>
			</table>
		</div>
		<!-- tab3 스테디셀러 -->
		<div class="contMO">
			<table>
				<tr>
				<%
					String SteadySeller = "SELECT bookId, bookName, price, writer, bookImg FROM Book LIMIT 8";
					int SS = 1;
					PreparedStatement pstmtSS = con.prepareStatement(SteadySeller);
					ResultSet rsSS = pstmtSS.executeQuery(); 
					while(rsSS.next()){ 
						int bookId = rsSS.getInt("bookId"); 
						String  bookName = rsSS.getString("bookName"); 
						int bookPrice = rsSS.getInt("price");
						String  writer = rsSS.getString("writer");
						String bookImg = rsSS.getString("bookImg");
				%>
					<td>
						<p><a href="BookDetail.jsp?bookId=<%=bookId%>">
							<img src="<%=bookImg%>.jpg" title="<%=bookName%>(<%=writer%>)" alt="<%=bookName%>">
							<b><%=bookName%></b></br>
							<%=writer%></br>
							<b><%=bookPrice%>원</b>
						</a></p>
					</td>
				<%
						if(SS % 4 == 0){out.println("<tr>");}
						SS++;
					}
					out.println("</tr>");
					rsSS.close();
					pstmtSS.close();
				%>
			</table>
		</div>
		<!-- tab4 코믹 -->
		<div class="contMO">
			<table>
				<tr>
				<%
					String ComicBook = "SELECT bookId, bookName, price, writer, bookImg FROM Book LIMIT 8";
					int CB = 1;
					PreparedStatement pstmtCM = con.prepareStatement(ComicBook);
					ResultSet rsCM = pstmtCM.executeQuery(); 
					while(rsCM.next()){ 
						int bookId = rsCM.getInt("bookId"); 
						String  bookName = rsCM.getString("bookName"); 
						int bookPrice = rsCM.getInt("price");
						String  writer = rsCM.getString("writer");
						String bookImg = rsCM.getString("bookImg");
				%>
					<td>
						<p><a href="BookDetail.jsp?bookId=<%=bookId%>">
							<img src="<%=bookImg%>.jpg" title="<%=bookName%>(<%=writer%>)" alt="<%=bookName%>">
							<b><%=bookName%></b></br>
							<%=writer%></br>
							<b><%=bookPrice%>원</b>
						</a></p>
					</td>
				<%
						if(CB % 4 == 0){out.println("<tr>");}
						CB++;
					}
					out.println("</tr>");
					rsCM.close();
					pstmtCM.close();
				%>
			</table>
		</div>
	</main>

	<!-- main2 (주간/월간 베스트, 이벤트 도서) -->
	<main class="MainTwo">
		<h2>주간 베스트</h2>
			<table>
				<tr>
				<%
					String WeeklyBest = "SELECT bookId, bookName, price, writer, bookImg FROM Book LIMIT 5";
					PreparedStatement pstmtWB = con.prepareStatement(WeeklyBest);
					ResultSet rsWB = pstmtWB.executeQuery(); 
					while(rsWB.next()){ 
						int bookId = rsWB.getInt("bookId"); 
						String  bookName = rsWB.getString("bookName"); 
						String writer = rsWB.getString("writer");
						String bookImg = rsWB.getString("bookImg");
				%>
					<td><a href="BookDetail.jsp?bookId=<%=bookId%>">
						<img src="<%=bookImg%>.jpg" title="<%=bookName%>(<%=writer%>)" alt="<%=bookName%>">
					</a></td>
				<%
					}
					rsWB.close();
					pstmtWB.close();
				%>
			</table>
		<h2>월간 베스트</h2>
			<table>
				<tr>
				<%
					String MonthlyBest = "SELECT bookId, bookName, price, writer, bookImg FROM Book ORDER BY bookId DESC LIMIT 5";
					PreparedStatement pstmtMB = con.prepareStatement(MonthlyBest);
					ResultSet rsMB = pstmtMB.executeQuery(); 
					while(rsMB.next()){ 
						int bookId = rsMB.getInt("bookId"); 
						String  bookName = rsMB.getString("bookName"); 
						String writer = rsMB.getString("writer");
						String bookImg = rsMB.getString("bookImg");
				%>
					<td><a href="BookDetail.jsp?bookId=<%=bookId%>">
						<img src="<%=bookImg%>.jpg" title="<%=bookName%>(<%=writer%>)" alt="<%=bookName%>">
					</a></td>
				<%
					}
					rsMB.close();
					pstmtMB.close();
				%>
			</table>
		<h2>이벤트 도서</h2>
			<table class="event">
				<tr>
				<%
					String EventBook = "SELECT bookId, bookName, price, writer, bookImg FROM Book LIMIT 5";
					PreparedStatement pstmtEB = con.prepareStatement(EventBook);
					ResultSet rsEB = pstmtEB.executeQuery(); 
					while(rsEB.next()){ 
						int bookId = rsEB.getInt("bookId"); 
						String  bookName = rsEB.getString("bookName"); 
						String writer = rsEB.getString("writer");
						String bookImg = rsEB.getString("bookImg");
				%>
					<td><a href="BookDetail.jsp?bookId=<%=bookId%>">
						<img src="<%=bookImg%>.jpg" title="<%=bookName%>(<%=writer%>)" alt="<%=bookName%>">
					</a></td>
				<%
					}
					rsEB.close();
					pstmtEB.close();
				%>
			</table>
	</main>

	<!-- main3 (북클럽 Pick) -->
	<main class="MainThree">
	
		<%
			String BclubPick = "SELECT bookId, bookName, price, writer, publisher, bookContent, bookImg FROM Book WHERE bookId = 3";
			PreparedStatement pstmtBP = con.prepareStatement(BclubPick);
			ResultSet rsBP = pstmtBP.executeQuery(); 
			
			if(rsBP.next()){
			
			int bookId = rsBP.getInt("bookId"); 
			String  bookName = rsBP.getString("bookName"); 
			int price = rsBP.getInt("price");
			String writer = rsBP.getString("writer");
			String publisher = rsBP.getString("publisher");
			String bookContent =  rsBP.getString("bookContent");
			String bookImg = rsBP.getString("bookImg");
		%>
		<div class="contMTh-01">
			<h1>북클럽 Pick</h1>
			<h4>청년책방 독자가 직접 선정한 이달의 도서</h4>
			<a href="#"><button>
				북클럽 Pick 도서 구매하기
			</button></a>
			<a href="#"><button>
				추천 도서 전체보기
			</button></a>
		</div>
		<img src="<%=bookImg%>.jpg" title="<%=bookName%>(<%=writer%>)" alt="<%=bookName%>">
		<div class="contMTh-02">
			<h1><%=bookName%></h1>
			<p><%=writer%> | <%=publisher%></p>
			<p><b><%=price%>원</b></p>
			<h3><%=bookContent%></h3>
		</div>
		<%
    } else {
        // 오류 처리: 결과가 없는 경우
%>
    <div class="contMTh-01">
        <p>북클럽 Pick 도서를 찾을 수 없습니다.</p>
    </div>
		<%
    }
			rsBP.close();
			pstmtBP.close();
			con.close();
		%>
	</main>

	<!-- footer -->
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
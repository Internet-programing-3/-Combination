<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도서 목록</title>
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

		String bookCtg = request.getParameter("bookCtg");
		String ListLoad = "SELECT * FROM Book WHERE bookCtg = ?";
        PreparedStatement pstmtLL = con.prepareStatement(ListLoad);
        pstmtLL.setString(1, bookCtg);
        ResultSet rsLL = pstmtLL.executeQuery();
	%>
	<!-- 제이쿼리용 -->
	<script type="text/javascript">
		 $(document).ready(function(){
			$(".ListMain aside li").click(function () {
				var contNum = $(this).index();
				$(this).addClass("On").siblings().removeClass("On");
			});

			 $(".tabLM p").click(function () {
				var contNum = $(this).index();
				$(this).addClass("On").siblings().removeClass("On");
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
            // 변수들을 if 문 내부에서 선언
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
                // 결과가 없을 때 처리하는 부분을 여기에 추가합니다.
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
			<a href="showCart.jsp">
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

	<main class="ListMain">
		<!-- 사이드바 -->
		<aside>
			<div>
				<h2><%=bookCtg%></h2>
				<ul>
					<li class="On"><a href="javascript:void(0);">전체 도서 보기</a></li>
					<li><a href="javascript:void(0);">주간 베스트</a></li>
					<li><a href="javascript:void(0);">월간 베스트</a></li>
					<li><a href="javascript:void(0);">신간</a></li>
					<li><a href="javascript:void(0);">이벤트 도서</a></li>
				</ul>
			</div>
		</aside>
		<!-- 도서 목록 -->
		<section>
			<article class="tabLM">
				<p class="On">인기순</p>
				<p>등록일순</p>
				<p>상품명순</p>
				<p>저가격순</p>
				<p>고가격순</p>
			</article>
			<%
			 while (rsLL.next()) {
                 int bookId = rsLL.getInt("bookId");
                 String bookName = rsLL.getString("bookName");
                 int price = rsLL.getInt("price");
                 int bookStock = rsLL.getInt("bookStock");
                 String writer = rsLL.getString("writer");
                 String bookContent = rsLL.getString("bookContent");
                 String publisher = rsLL.getString("publisher");
                 String bookImg = rsLL.getString("bookImg");
			%>
			<article class="contLM">
				<a href="BookDetail.jsp?bookId=<%=bookId%>">
					<img src="<%=bookImg%>.jpg" title="<%=bookName%>(<%=writer%>)" alt="<%=bookName%>">
				</a>
				<div class="infoLM">
					<a href="BookDetail.jsp?bookId=<%=bookId%>">
						<h3><%=bookName%></h3>
					</a>
					<h5><a href="javascript:void(0);"><%=writer%></a> | <a href="javascript:void(0);"><%=publisher%></a></h5>
					<h4>
						<%=price%>원
						<%if(bookStock <= 10){ out.print("<span class='stock'>(남은 재고: " + bookStock + "권)</span>"); }%>
					</h4>
					<p><%=bookContent%></p>
				</div>
				<form>
            <label for="qty_<%=bookId%>">수량:</label>
            <input type="number" id="qty_<%=bookId%>" name="quantity" min="1" max="<%=bookStock%>">
        </form>

        <div class="addLM">
            <a href="inCart.jsp" onClick="inCart('<%=bookId%>', $('#qty_<%=bookId%>').val())">
                <button class="cart">장바구니 담기</button>
            </a>

					<a href="#"><button class="buy">바로 구매</button></a>
				
				</div>
			</article>
			<%
				}
				rsLL.close();
				pstmtLL.close();
			%>
		</section>
	</main>

	<%
		con.close();
	%>
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


	<script>
		function inCart(bookId, ctQty) {
		    // AJAX 요청
		    $.ajax({
		        type: 'POST',
		        url: 'inCart.jsp',
		        data: { bookId: bookId, ctQty: ctQty },
		        success: function(response) {
		            // 요청이 성공한 경우 처리
		            alert('장바구니에 담겼습니다.');
		        },
		        error: function(error) {
		            // 요청이 실패한 경우 처리
		            alert('오류가 발생했습니다.');
		        }
		    });
		}

	</script>

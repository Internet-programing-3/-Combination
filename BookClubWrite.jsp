<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북클럽 게시판 글쓰기</title>
	<!-- 외부 CSS 적용 / 파일 경로 뒤에 ' ?v=1 ' 부분 지우지 마세요. 에러나요! -->
	<!-- 단위 수정 잘못하면 UI랑 배열 깨집니다 -->
	<link rel="stylesheet" type="text/css" href="Main.css?v=1">
	<!-- jQuery 라이브러리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script language="javascript">
		function in_check(){
			let inp = document.input;
			let clubId = inp.clubId;
			let title = inp.title;
			let name = inp.name;
			let content = inp.content;

			if (title.value == "") {
				alert("제목을 입력하세요!");
				return;
			}

			if (content.value == "") {
				alert("본문의 내용을 입력하세요!");
				return;
			}

			document.input.submit();
		}
	</script>
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

		String group_index;
		int list_index;

		String clubId = request.getParameter("clubId");
		String userId = (String) session.getAttribute("userId");
	%>

	<!-- header (로고) 북클럽 Ver. -->
	<header>
		<p><a href="Mainpage.jsp">&lt; 청년책방 페이지로 돌아가기</a></p>
		<a href="BookClub.jsp?clubId=1">
			<img src="images/LogoBC.jpg" style="width: 300px; height: 150px;" alt="북클럽 로고">
		</a>
	</header>

	<!-- nav1 ( 오늘의 책, 검색창, 마이페이지, 로그인 ) 북클럽 Ver. -->
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
		</a></div>
		<!-- 검색바 -->
		<div class="searchMain" style="border-color: #FF8787;">
			<img src="images/LogoIconBC.png" alt="로고아이콘">
			<input type="text">
			<button type="button" style="border-color: #FF8787; background-color: #FF8787;" alt="검색 버튼">검색</button>
		</div>
		<!-- 마이페이지, 장바구니, 로그인/로그아웃 버튼 -->
		<div>
			<!-- 로그인 -->
			<%
				if (session.getAttribute("userId") == null) {
			%>
			<a href="Login.jsp">
				<img src="images/mypageBC.png" style="width: 50px; height: 50px; margin-right: 3px;" title="마이페이지" alt="마이페이지">
			</a>
			<a href="Login.jsp">
				<img src="images/edit.png" style="width: 50px; height: 53px; margin: 0 10px;" title="글쓰기" alt="글쓰기">
			</a>
			<a href="Login.jsp">
				<img src="images/logInBC.png" style="width: 50px; height: 50px;" title="로그인" alt="회원가입/로그인">
			</a>
			<!-- 로그아웃 -->
			<%
				} else {
			%>
			<a href="MyPage.jsp">
				<img src="images/mypageBC.png" style="width: 50px; height: 50px;" title="마이페이지" alt="마이페이지">
			</a>
			<a href="BookClubWrite.jsp">
				<img src="images/edit.png" style="width: 50px; height: 53px; margin: 0 10px;" title="글쓰기" alt="글쓰기">
			</a>
			<a href="Logout.jsp">
				<img src="images/logOutBC.png" style="width: 50px; height: 50px;" title="로그아웃" alt="로그아웃">
			</a>
			<%
				}
			%>
        </div>
	</nav>

	<main class="writeBCMain">
		<form method="post" action="BookClubWriteOk.jsp" name="input">
			<input name="clubId" type="hidden" value="<%=clubId%>">
			<table>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" Maxlength="30" placeholder="제목을 입력하세요"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><input type="hidden" name="name" Maxlength="20" value="<%=userId%>"><%=userId%></td>
				</tr>
				<tr>
					<th>본문</th>
					<td><textarea rows="15" cols="80" name="content"></textarea></td>
				</tr>
			</table>
			<button onclick="check()">등록</button>
			<button class="Back"><a href="BookClub.jsp?clubId=<%=clubId%>">취소</a></button>
		</form>
	</main>

	<%
		con.close();
	%>

	<!-- footer 북클럽 Ver. -->
	<footer>
		<div class="notices" style="border-color: #FF8787;">
			<ul>
				<li><h4>공지사항</h4></li>
				<li><a href="javascript:void(0);">개인정보 처리방침 변경안내</a></li>
				<li><a href="javascript:void(0);"><h4>더보기+</h4></a></li>
				<li><h4>이벤트</h4></li>
				<li><a href="javascript:void(0);">11월 북클럽 독후감대회 우승자 발표</a></li>
				<li><a href="javascript:void(0);"><h4>더보기+</h4></a></li>
			</ul>
		</div>
		<div class="footerMain" style="margin-top: 10px;">
			<img src="images/LogoBC.jpg" style="height: 150px;" alt="북클럽 로고">
			<div style="margin-top: 35px;">
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

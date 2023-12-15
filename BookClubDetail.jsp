<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북클럽 게시판 상세보기</title>
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
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
	%>
	<!-- 자바스크립트 -->
	<script type="text/javascript">
		 $(document).ready(function(){
			 //제이쿼리용
			 $(".btnBCM li").click(function () {
				var contNum = $(this).index();
				$(this).addClass("On").siblings().removeClass("On");
			});
			 $(".contBCM li").click(function () {
				var contNum = $(this).index();
				$(this).addClass("On").siblings().removeClass("On");
			});

			function in_check(){
				let inp = document.input;
				let content = inp.content;
				let postId = inp.postId;
				let userId = inp.userId;

				if (content.value == ""){
					alert("댓글 내용을 입력하세요!");
					return;
				}
				document.input.submit();
			}
			function check(){
				let del = document.del;
				let postId = del.postId;
				let commentId = del.commentId;
				   
				document.del.submit();
			}
		})
	</script>

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
   		
	<main class="DetailBCMain">
		<aside class="asideBCM">	
			<!--- 유저 프로필 -->
			<div class="userBCM">
				<img src="images/mypageBC.png" title="북클럽 프로필" alt="북클럽 프로필">
				<h5>닉네임</h5>
			</div>
			<!-- 내가 쓴 글, 댓글 관리 -->
			<table>
				<tr>
					<th>내가 작성한 글</th>
					<td>00개</td>
				</tr>
				<tr>
					<th>내가 단 댓글</th>
					<td>00개</td>
				</tr>
			</table>
			<!-- 북클럽 설정, 글 작성 버튼 -->
			<a href="BookClubWrite.jsp"><button class="Write">글쓰기</button></a>
			<a href="javascript:void(0);"><button class="Option">북클럽 설정</button></a>
			<!-- 북클럽 내비게이션 -->
			<ul class="btnBCM">
				<h4>북클럽 소식</h4>
				<li><a href="javacript:void(0);">공지</a></li>
				<li><a href="javacript:void(0);">이벤트</a></li>
				<li><a href="javacript:void(0);">이달의 도서</a></li>
				<h4>북클럽 게시판</h4>
				<li class="On"><a href="javacript:void(0);">추천해요 책</a></li>
				<li><a href="javacript:void(0);">추천해줘요 책</a></li>
				<li><a href="javacript:void(0);">독서 토론</a></li>
			</ul>
		</aside>
		<section class="contDBCM">
			<!-- 목록으로 돌아가기, 글 수정, 삭제 -->
			<article class="contDBCM-01">
				<a href="BookClub.jsp"><h3>&lt; 목록</h3></a>
				<ul>
					<li><a href="BookClubModify.jsp">수정</a></li>
					<li><a href="BookClubDelete.jsp">삭제</a></li>
				</ul>
			</article>
			<!-- 게시글 -->
			<article class="contDBCM-02">
				<!-- 제목, 작성자, 조회수 -->
				<div class="Header">
					<h1>위대하지않은 게츠비</h1>
					<img src="images/mypageBC.png">
					<span>
						<p class="Writer"><a href="javacript:void(0);">작성자</a></p>
						<p class="Date">2023.10.23 | 조회수 10</p>
					</span>
				</div>
				<!-- 내용 -->
				<div class="Content">
					내용 상세
				</div>
			</article>
			<!-- 댓글 -->
			<article class="contDBCM-03">
				<h4>댓글 ( 0 )</h4>
				<!-- 댓글 목록-->
				<ul>
					<li><img src="images/mypageBC.png"></li>
					<li class="Content">
						<p>작성자</p>
						<div>댓글 내용</div>
						<button>수정</button>
						<button OnClick="check()">삭제</button>
					</li>
				</ul>
				<!--댓글 작성 -->
				<div class="Comment">
					<form method="post" action="BookClubDetailOk.jsp" name="input">
						<input type="hidden" name="postId" value="<%//=postId%>">
						<input type = "hidden" name="userId" value="<%//= userid %>">작성자
						<input type="text" name="content" placeholder="댓글을 남겨보세요">
						<input type="button" OnClick="in_check()" value="댓글 등록">
						</form>
				</div>
			</article>
		</section>
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

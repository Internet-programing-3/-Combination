<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북클럽 게시판 리스트</title>
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

		String group_index;
		int list_index;

		String clubId = request.getParameter("clubId");
		group_index = request.getParameter("group_index");
		//첫 페이지는 group_index 값이 0

		if(group_index != null){
			list_index = Integer.parseInt(group_index);
		}
		else{
			list_index = 0;     //현재 페이지 수
		}


		// clubId 값이 null이 아닐 때만 쿼리 수행
 ResultSet cntRs = null; // cntRs 변수를 선언하고 초기화

    if (clubId != null) {
        String jsql = "select count(*) from ClubPost where clubId =? ";
        PreparedStatement pstmt1 = con.prepareStatement(jsql);
        pstmt1.setString(1, clubId);
        cntRs = pstmt1.executeQuery(); // cntRs를 초기화
    }

    try {
        if (cntRs != null && cntRs.next()) { // cntRs가 null이 아니고 결과가 있을 때만 처리
            int cnt = cntRs.getInt(1);//글의 총 개수

		    //한 페이지에 10개의 글 출력하기 위해
		    //글의 개수를 10으로 나누어 페이지 계산
		    int cntList = cnt/10; // 페이지 수 계산하기 위한 변수 
		    int remainder = cnt%10; //나머지
		    int cntList_1;//총페이지 수

		    //1(11, 21, 31, 41, ...)번째 글이 올라올 때 총 페이지 수 1 증가
		    if (cntList != 0){ //글이 10개이상이면
		        if (remainder == 0){    //10으로 나눈 나머지가 없으면        
		            cntList_1 = cntList;  //몫이 페이지 수
		        }
		        else {                   //나머지가 있으면
		               cntList_1 = cntList + 1; //몫에 1 더한 값이 총페이지 수
		        }
		    } 
		    else{
		        cntList_1 = cntList + 1; //총페이지 수
		    }

        }
    } catch (Exception e) {
        e.printStackTrace(); // 예외를 출력
    } finally {
        if (cntRs != null) {
            cntRs.close(); // 반드시 ResultSet을 닫아야 합니다.
        }
    }
	    // DB 연결 및 데이터 조회 등의 작업 수행

	    String clubName = ""; // 변수를 미리 선언하고 초기화
	    String description = "";

	    String jsql2 = "select * from Club where clubId=?";
	    PreparedStatement pstmt2 = con.prepareStatement(jsql2);
	    pstmt2.setString(1, clubId);
	    ResultSet rs = pstmt2.executeQuery();

	    // clubName 및 description 변수 초기화
	    if (rs.next()) {
	        clubName = rs.getString("clubName");
	        description = rs.getString("description");
	    }
	%>

	<!-- 제이쿼리용 -->
	<script type="text/javascript">
		 $(document).ready(function(){
			 $(".btnBCM li").click(function () {
				var contNum = $(this).index();
				$(this).addClass("On").siblings().removeClass("On");
			});
			 $(".contBCM li").click(function () {
				var contNum = $(this).index();
				$(this).addClass("On").siblings().removeClass("On");
			});
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
				}
				
			%>
			<a href="MyPage.jsp">
				<img src="images/mypageBC.png" style="width: 50px; height: 50px;" title="마이페이지" alt="마이페이지">
			</a>
			<a href="BookClubWrite.jsp">
				<img src="images/edit.png" style="width: 50px; height: 53px; margin: 0 10px;" title="글쓰기" alt="글쓰기">
			</a>
			<a href="Logout.jsp">
				<img src="images/logoutBC.png" style="width: 50px; height: 50px;" title="로그아웃" alt="로그아웃">
			</a>
			
				
			
        </div>
	</nav>

	<main class="BookClubMain">
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
		<section class="contBCM">
			<!-- 게시판 이름 -->
<article class="headerBCM">
    <h1><%= (clubName != null && !clubName.isEmpty()) ? clubName : "게시판 이름 없음" %></h1>
    <h6><%= (description != null && !description.isEmpty()) ? description : "게시판 설명 없음" %></h6>
</article>

			<!-- 게시판 제목, 정렬 -->
			<article class="contBCM-01">
				<h1>전체글보기</h1>
			
				<ul>
					<li class="On"><a href="javascript:void(0)">최신순</a></li>
					<li><a href="javascript:void(0)">오래된순</a></li>
					<li><a href="javascript:void(0)">조회순</a></li>
					<li><a href="javascript:void(0)">인기순</a></li>
				</ul>
			</article>
			<!-- 게시글 목록 -->
			<article class="contBCM-02">
				<table>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>
					<%
						String jsql3 = "select * from ClubPost where clubId=? order by postId desc, created_at";
						PreparedStatement pstmt3 = con.prepareStatement(jsql3);
						pstmt3.setString(1, clubId);
						ResultSet rs2 = pstmt3.executeQuery();

						if (!rs2.wasNull()){
							for(int i = 0; i < list_index * 20; i++) { rs2.next(); }
						}

						int cursor = 0;
						while (rs2.next()){
							int postId = rs2.getInt("postId");
							String title = rs2.getString("title");
							String userId = rs2.getString("userId");
							String created_at = rs2.getString("created_at");
							int hits = rs2.getInt("hits");
					%>
					<tr>
						<td class="Num"><%=postId%></td>
						<td class="Title" title="제목"><a href="BookClubDetail.jsp?postId=<%=postId%>"><%=title%></a></td>
						<td class="Writer"><a href="javascript:void(0);"><%=userId%></a></td>
						<td class="Date"><%=created_at%></td>
						<td class="View"><%=hits%></td>
					</tr>
					<%
							
  					  			cursor++;
						   		 if (cursor >= 10) 
						        break;
						}
						
					%>
				</table>
			</article>
			<!-- 글쓰기 버튼, 페이지 번호 -->
			<article class="contBCM-03">
				<a href="BookClubWrite.jsp"><div class="btnWrite">
					<p>글쓰기</p>
					<img src="images/edit_white.png">
				</div></a>
				<div class="Page">
					<!-- 첫 페이지 이동 -->
					<a href="BookClub.jsp?group_index=0"><p>&lt;&lt;</p></a>
					<!-- 이전 페이지 이동 -->
					<a href="javascript:void(0);"><p>&lt;</p></a>
					<!-- 현재 페이지 / 전체 페이지 -->
					<p> 1 / 100 </p>
					<!-- 다음 페이지 이동 -->
					<a href="javascript:void(0);"><p>&gt;</p></a>
					<!-- 마지막 페이지 이동 -->
					<a href="javascript:void(0);"><p>&gt;&gt;</p></a>
				</div>
			</article>
		</section>
	</main>

	<%
	rs2.close();
	pstmt3.close();
		rs.close();
		pstmt2.close();
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

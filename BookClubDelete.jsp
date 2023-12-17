<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북클럽 게시글 삭제</title>
	<!-- 외부 CSS 적용 / 파일 경로 뒤에 ' ?v=1 ' 부분 지우지 마세요. 에러나요! -->
	<!-- 단위 수정 잘못하면 UI랑 배열 깨집니다 -->
	<link rel="stylesheet" type="text/css" href="Main.css?v=1">
	<!-- jQuery 라이브러리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script type="text/javascript">
		function check(){
			let frm = document.myform;
			let postId = frm.postId;
			let pw = frm.pw;
			
			/* 비밀번호 유효성 검사 */
			if(pw.value == ""){
				alert("비밀번호를 입력해주세요.");
				myform.pw.focus();
				return false;
			}
			
			else{
				frm.submit();
			}
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

		String postId = request.getParameter("postId");
	%>

	<!-- header (로고) 북클럽 Ver. -->
	<header>
		<a href="BookClub.jsp?clubId=1">
			<img src="images/LogoBC.jpg" style="width: 300px; height: 150px;" alt="북클럽 로고">
		</a>
	</header>

	<main class="deleteBCMain">
		<form method="post" name="myform" action="BookClubDeleteOk.jsp">
			<h3>게시글 삭제 확인</h3>
			<p color="#000000">게시글의 삭제를 위해 정보를 입력해주세요.</p>
			<div>
				<input name = "postId" type="hidden" value=<%= postId %>>
				<input type="password" name="pw" maxlength="20" placeholder="비밀번호 입력 (필수)" required autofocus>
			</div>
			<button type="submit" onclick="check()" title="삭제" alt="삭제 버튼">삭제</button>
		</form>
		<a href="BookClubDetail.jsp?postId=<%=postId%>"><button type="button" title="삭제 취소" alt="삭제 취소 버튼">취소</button></a>
	</main>

	<%
		con.close();
	%>

</body>
</html>

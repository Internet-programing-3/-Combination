<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
	<!-- 외부 CSS 적용 / 파일 경로 뒤에 ' ?v=1 ' 부분 지우지 마세요. 에러나요! -->
	<!-- 단위 수정 잘못하면 UI랑 배열 깨집니다 -->
	<link rel="stylesheet" type="text/css" href="Main.css?v=1">
	<!-- jQuery 라이브러리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</head>
<body>
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

		String name = (String) session.getAttribute("name");
    	String userId = (String) session.getAttribute("userId");
	%>
	<!-- 비밀번호 유효성 검사 -->
	<script type="text/javascript">
		function check(){
			let frm = document.myform;
			let pw = frm.pw;
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

	<!-- header (로고) -->
	<header>
		<a href="Mainpage.jsp">
			<img src="images/Logo.jpg" style="width: 400px; height: 150px;" alt="청년책방 로고">
		</a>
	</header>

	<main class="DeleteMain">
		<form method="post" name="myform" action="DeleteUserOk.jsp">
			<h3>회원 탈퇴</h3>
			<p>
				※ 탈퇴 시 계정이 영구 삭제됩니다(복구 불가능).</br>
				※ 탈퇴를 계속하시려면 비밀번호를 입력해주세요.
			</p>
			<h4><%= name %> 님의 아이디 : <%= userId %></h4>
			<div>
				<input type="password" name="pw" maxlength="20" placeholder="비밀번호 입력 (필수)" required autofocus>
			</div>
			<button type="submit" onclick="check()" title="회원 탈퇴" alt="회원 탈퇴 버튼">회원 탈퇴</button>
		</form>
		<a href="MyPage.jsp"><button type="button" title="수정 취소" alt="입력정보 초기화 버튼">취소</button></a>
	</main>

</body>
</html>

<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 수정</title>
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

		String id = (String)session.getAttribute("userId"); 
	%>
	<script type="text/javascript">
		function check(){
			let frm = document.myform;
			let id = frm.id;
			let pw = frm.pw;
			let name = frm.name;
			let hp1 = frm.hp1;
			let hp2 = frm.hp2;
			let hp3 = frm.hp3;
			let email1 = frm.email1;
			let email2 = frm.email2;
			let birth = frm.birth;
			let sex = frm.sex;
			
			/* 아이디 유효성 검사 */
			if(id.value == ""){
				alert("아이디를 입력해주세요.");
				myform.id.focus();
				return false;
			}
			
			/* 비밀번호 유효성 검사 */
			if(pw.value == ""){
				alert("비밀번호를 입력해주세요.");
				myform.pw.focus();
				return false;
			}
			
			/* 이름 유효성 검사 */
			if(name.value == ""){
				alert("이름을 입력해주세요.");
				myform.name.focus();
				return false;
			}
			
			/* 휴대폰번호 유효성 검사 */
			if(hp2.value == ""){
				alert("전화번호를 입력해주세요.");
				myform.hp2.focus(); 
				return false;
			}
			if(hp3.value == ""){
				alert("전화번호를 입력해주세요.");
				myform.hp3.focus(); 
				return false;
			}
				
			/* 이메일 유효성 검사 */
			if(email1.value == ""){
				alert("이메일을 입력해주세요.");
				myform.email1.focus();
				return false;
			}
			if(email2.value == ""){
				alert("이메일을 입력해주세요.");
				myform.email2.focus();
				return false;
			}
			
			/* 성별 유효성 검사 */
			if(sex.value == ""){
				alert("성별을 선택해주세요.");
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

	<!-- 회원 정보 수정 폼 -->
	<div class="UpdateMain">
		<form name="myform" method="post" action="UpdateUserOk.jsp">
			<h3>회원 정보 수정</h3>
			<p>회원 정보 수정을 위한 정보를 입력해주세요.</p>
			<div class="contUM">
				<!-- 아이디 -->
				<div class="contUM-01">
					<h4>아이디</h4>
					<input type="hidden" name ="id" value="<%=id%>"><h4><%=id%> <b>(수정 불가)</b></h4>
				</div>
				<p>숫자만 입력 가능, 최대 11자리</p>
				<!-- 비밀번호 입력 -->
				<div class="contUM-01">
					<h4>비밀번호</h4>
					<input type="password" name="pw" maxlength="20" placeholder="비밀번호를 입력하세요 (필수)" required>
				</div>
				<p>영문과 숫자 혼합 가능, 최대 20자리</p>
				<!-- 이름 입력 -->
				<div class="contUM-01">
					<h4>이름</h4>
					<input type="text" name="name" maxlength="20" placeholder="이름을 입력하세요 (필수)" required>
				</div>
				<p>최대 20자(한글 10자)까지 가능</p>
				<!-- 핸드폰 번호 입력 -->
				<div class="contUM-02">
					<h4>연락처</h4>
					<select name="hp1">
						<option value="010" selected>010
						<option value="011">011
						<option value="016">016
						<option value="017">017
						<option value="018">018
						<option value="019">019
					</select> - 
					<input type="text" name="hp2" maxlength="4" required> - 
					<input type="text" name="hp3" maxlength="4" required>
				</div>
				<!-- 이메일 입력 -->
				<div class="contUM-03">
					<h4>이메일</h4>
					<input type="text" name="email1" placeholder="이메일 아이디" required> @ 
					<input type="text" name="email2" placeholder="이메일 주소" required>
				</div>
				<!-- 생일 입력 -->
				<div class="contUM-04">
					<h4>생년월일</h4>
					<input type="date" name="birth" required>
				</div>
				<!-- 성별 입력 -->
				<div class="contUM-05">
					<h4>성별</h4>
					<div>
						<input type="radio" name="sex" value="M" required>남성
						<input type="radio" name="sex" value="W" required>여성
					</div>
				</div>
            </div>
			<button type="submit" onclick="check()" title="회원 정보 수정" alt="회원 정보 수정 버튼">회원 정보 수정</button>
		</form>
		<a href="MyPage.jsp"><button type="button" title="수정 취소" alt="입력정보 초기화 버튼">취소</button></a>
    </div>

</body>
</html>
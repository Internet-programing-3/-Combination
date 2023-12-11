<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
	<!-- 외부 CSS 적용 / 파일 경로 뒤에 ' ?v=1 ' 부분 지우지 마세요. 에러나요! -->
	<!-- 단위 수정 잘못하면 UI랑 배열 깨집니다 -->
	<link rel="stylesheet" type="text/css" href="Main.css?v=1">
	<!-- jQuery 라이브러리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</head>
<body>
	<!-- 제이쿼리용 -->
	<script type="text/javascript">
		 $(document).ready(function(){
			 $(".btnLogin li").click(function () {
				var contNum = $(this).index();
				$(this).addClass("On").siblings().removeClass("On");
				$(".contLO").eq(contNum).addClass("On").siblings().removeClass("On");
			});
		 })
	</script>
	<!-- header (로고) -->
	<header>
		<a href="Mainpage.jsp">
			<img src="images/Logo.jpg" style="width: 400px; height: 150px;" alt="청년책방 로고">
		</a>
	</header>

	<!-- 로그인 탭 -->
	<main class="LoginOne">
		<ul class="btnLogin">
			<li class="On"><a href="javascript:void(0);">회원 로그인</a></li>
			<li><a href="javascript:void(0);">비회원 로그인</a></li>
		</ul>
			<!-- 회원 로그인 -->
			<div class="contLO On">
				<form method="post" action="LoginOk.jsp">
					<div class="mainLO">
						<input type="text" style="border-radius: 5px 5px 0 0;" name="userid" title="아이디 입력" placeholder="아이디를 입력하세요">
						<input type="password" style="border-radius: 0 0 5px 5px;" name="password" title="비밀번호 입력" placeholder="비밀번호를 입력하세요">
						<button type="submit" title="로그인" alt="로그인 버튼">로그인</button>
					</div>
					<div class="optLO">
						<input type="checkbox" id="saveID" title="아이디 저장" checked>
						<label id="saveID">아이디 저장하기</label>
					</div>
					<div class="subLO">
						<button type="button" title="아이디/비밀번호 찾기" alt="아이디/비밀번호 찾기 버튼">아이디/비밀번호 찾기</button>
						<a href="SignUp.jsp"><button type="button" title="회원가입" alt="회원가입 버튼">회원가입</button></a>
					</div>
				</form>
			</div>
			<!-- 비회원 로그인 -->
			<div class="contLO">
				<div class="inputLO">
					<div class="mainLO">
					<input type="text" style="border-radius: 5px 5px 0 0;" name="userid" title="주문번호 입력" placeholder="주문번호를 입력하세요">
					<input type="password" style="border-radius: 0 0 5px 5px;" name="password" title="비밀번호 입력" placeholder="비밀번호를 입력하세요">
					<button type="submit" title="주문조회" alt="주문조회 버튼">조회</button>
				</div>
				<div class="optLO">
					<input type="checkbox" id="saveID" title="주문번호 저장" checked>
					<label id="saveID">주문번호 저장하기</label>
				</div>
				<div class="subLO">
					<button type="button" title="주문번호 찾기" alt="주문번호 찾기 버튼">주문번호 찾기</button>
					<a href="SignUp.jsp"><button type="button" title="회원가입" alt="회원가입 버튼">회원가입</button></a>
				</div>
			</div>
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
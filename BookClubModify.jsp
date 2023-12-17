	<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
	<%@page import="java.sql.*"%>
	<%@page import="java.util.*"%>
	<!DOCTYPE html>
	<html lang="ko">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>북클럽 게시판 수정</title>
		<!-- 외부 CSS 적용 / 파일 경로 뒤에 ' ?v=1 ' 부분 지우지 마세요. 에러나요! -->
		<!-- 단위 수정 잘못하면 UI랑 배열 깨집니다 -->
		<link rel="stylesheet" type="text/css" href="Main.css?v=1">
		<!-- jQuery 라이브러리 연결 -->
		<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
		<script type="text/javascript">
        function check() {
            let frm = document.myform;
            let postId = frm.postId;
            let title = frm.title;
            let content = frm.content;

            if (title.value == "") {
                alert("제목을 입력하세요");
                myform.title.focus();
                return false;
            }

            if (content.value == "") {
                alert("내용을 입력하세요");
                myform.content.focus();
                return false;
            } else {
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
	
			String jsql = "select * from clubpost where postId = ?";
	
			PreparedStatement pstmt = con.prepareStatement(jsql);
			pstmt.setInt(1, Integer.parseInt(postId));
			ResultSet rs = pstmt.executeQuery();
	
			if(!rs.wasNull()) {
				rs.next();
				String title = rs.getString("title");
				String content = rs.getString("content").trim();
		%>
	
		<!-- header (로고) 북클럽 Ver. -->
		<header>
			<a href="BookClub.jsp?clubId=1">
				<img src="images/LogoBC.jpg" style="width: 300px; height: 150px;" alt="북클럽 로고">
			</a>
		</header>
	
		<main class="modifyBCMain">
			<form method="post" action="BookClubModifyOk.jsp" name="myform">
				<input type="hidden" name="postId" value="<%=postId%>">
				<table>
					<tr>
						<th>제목</th>
						<td><input type="text" name="title"  value="<%=title%>" Maxlength="30" placeholder="제목을 입력하세요"></td>
					</tr>
					<tr>
						<th>본문</th>
						<td><textarea rows="15" cols="80" name="content"><%=content%></textarea></td>
					</tr>
				</table>
				<button onclick="check()">수정</button>
				<button class="Back"><a href="BookClubDetail.jsp?postId=<%=postId%>">취소</a></button>
			</form>
		</main>
	
		<%
			}
			rs.close();
			pstmt.close();
			con.close();
		%>
	
	</body>
	</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북클럽 게시글 삭제</title>
    
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
<body style="display: flex; justify-content: center;">

    <!-- 기본 틀 80% -->
    <div style="width: 80vw; display: flex; flex-direction: column; align-items: center; margin-top: 30px;">
	
			<%
    			String postId = request.getParameter("postId");
			%>
			
			<!-- 로고 -->
		    <header style="display: flex; align-items: center; margin-top: 30px;">
		    	<a href="Mainpage.jsp">
		        	<img src="logo.jpg" alt="로고" style="width: 10vw;">
		        </a>
		    </header>
			<form method="post" action="BookClubDeleteOk.jsp" name="myform"
			style="display: flex; flex-direction: column; align-items: center; border: solid 1px; padding: 50px; margin-top: 100px;">
				<div style="margin-bottom: 25px;">게시글의 삭제를 위해 정보를 입력해주세요</div>
				<input name = "postId" type="hidden" value=<%= postId %>>
                <div style="border-bottom: solid 1px; margin-bottom: 25px;">
                	<input type="password" name="pw" style="width: 25vw; height: 5.7vh; border: none; outline: none;" placeholder="회원님의 비밀번호를 입력하세요">
                </div>
                <div>
                    <button style="border: solid 1px; background-color: white; cursor: pointer;" type="button" onclick="check()">삭제</button>
                    <button type="button" style="border: solid 1px; background-color: white;" type="button">
						<a href="BookClubDetail.jsp?postId=<%=postId%>" style="text-decoration: none; color: black; cursor: pointer;">취소</a>
					</button>
                </div>
			</form>
    </div>
</body>
</html>

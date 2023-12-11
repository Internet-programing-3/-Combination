<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북클럽 게시판 글쓰기</title>
</head>
<body style="width: 98vw; display: flex; flex-direction: column; margin: 0px; align-items: center;">

	<%
		String clubId = request.getParameter("clubId");
		String userId = (String) session.getAttribute("userId");		
	%>
	<script language="javascript">
      function in_check()
	  {
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

    <div style="width: 70vw;">

        <!-- 로고 부분 -->
        <header style="display: flex; justify-content: center;">
            <a href='Mainpage.jsp'><img src="logo.jpg" alt="로고"></a>
        </header>

        <!-- 첫번째 메뉴들 ( 오늘의 책, 검색창, 마이페이지, 로그인 ) -->
        <main style="display: flex; justify-content: space-around; align-items: center;">
            <div style="border: solid 2px; text-align: center; padding: 20px;">오늘의 책</div>
            <div style="display: flex; border: solid 1px; width: 25vw; height: 6.3vh;">
                <div style="border: solid 1px; padding: 10px; width: 20vw; height: 3.65vh;">
                    <input type="text" style="width: 20vw; height: 4vh; border: none; outline: none;">
                </div>
                <button style="width: 10vw; background-color: white; border: solid 1px;">검색</button>
            </div>
            <div style="display: flex; flex-direction: column;">
                <a href='MyPage.jsp' style="border: solid 2px; margin: 10px; background-color: white; padding: 5px; color:black; text-decoration: none;">
                마이페이지</a>
                <a href='Logout.jsp' style="border: solid 2px; margin: 10px; background-color: white; padding: 5px; color:black; text-decoration: none;">
				    로그아웃</a>
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">장바구니</button>
            </div>
        </main>

        <!-- 두번째 메뉴들 ( 베스트셀러, 신간도서, 국내도서 등등 ) -->
        <main style="display: flex; justify-content: space-around; margin-top: 5vh;">
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">베스트셀러</div>
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">신간도서</div>
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">국내도서</div>
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">해외도서</div>
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">이벤트</div>
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">
            	<a href='BookClub.jsp?clubId=1' style="padding: 25px; color:black; text-decoration: none;">북클럽</a></div>
        </main>
        
        <%	if(userId == null){ %>
				<script>
					window.location.href = "<%= request.getContextPath() %>/Login.jsp";
				</script>
        <%	}else{ %>
        <!-- 세번째 메뉴들 ( 북클럽 글쓰기 ) -->
        <main style="display: flex; flex-direction: column; justify-content: space-around; align-items: center;
        margin-top: 10vh; padding: 20px;">
        	<form method="post" action="BookClubWriteOk.jsp" name="input">
		       <div align="center">
		       	<input name = "clubId" type="hidden" value=<%= clubId %>>
		        <table width="550" border="0" cellspacing="2" cellpadding="3">
			 	   <tr>
			 	      <td bgcolor='cccccc' width="150">
			 	         <div align="center"><font size=2><b> 제  목 </b></font></div>
			 	      </td>
			 	      <td width="400">
			 	         <input type="text" size="60" name="title" Maxlength="30">
			 	      </td>
			 	   </tr>
			 	   <tr>
			 	      <td bgcolor='cccccc' width="150">
			 	         <div align="center" style="width:100px;"><font size=2><b>작성자 아이디</b></font></div>
			 	      </td>
			 	      <td width="400"><input type="hidden" size="30" name="name" Maxlength="20" value=<%= userId %>><%= userId %></td>
			 	    </tr>
			 	   <tr>
			 	      <td bgcolor='cccccc' width="150">
			 	         <div align="center"><font size=2><b> 본  문</b></font></div>
			 	      </td>
			 	      <td><textarea rows="15" cols="60" name="content"></textarea></td>
			 	    </tr>
			 	  <tr>    
		          	<td colspan="2"> 
		              <div align="center"> 
		                    <input type="button" value="등   록" OnClick="in_check()">
		          	     	<a href="BookClub.jsp?clubId=<%=clubId%>" style="border: solid 1px; text-decoration: none; color: black; cursor: pointer;">취소</a>
		        	  </div>
		           	</td>
		          </tr>
		         </table>
		       </div>  
		      </form>
        </main>
        <% } %>

        <!-- 이용약관, 고객센터, 1:1문의, FAQ -->
        <footer style="display: flex; justify-content: space-around; margin-top: 5vh;">
            <button style="display: flex; justify-content: center; align-items: center; background-color: white; border: solid 1px; width: 5vw;">이용약관</button>
            <button style="display: flex; justify-content: center; align-items: center; background-color: white; border: solid 1px; width: 5vw;">고객센터</button>
            <button style="display: flex; justify-content: center; align-items: center; background-color: white; border: solid 1px; width: 5vw;">1:1문의</button>
            <button style="display: flex; justify-content: center; align-items: center; background-color: white; border: solid 1px; width: 5vw;">FAQ</button>
        </footer>
    </div>
</body>
</html>

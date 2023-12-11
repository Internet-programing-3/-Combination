<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북클럽 게시판 상세보기</title>
</head>
	<% String userid = (String)session.getAttribute("userId"); %>

	<script language="javascript">
      function in_check()
	  {
    	  let inp = document.input;
	      let content = inp.content;
	      let postId = inp.postId;
	      let userId = inp.userId;

		  if (content.value == "") {
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
     </script>	

<body style="width: 98vw; display: flex; flex-direction: column; margin: 0px; align-items: center;">
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
              	<%              	
				if (userid == null) {
				%>
				    <a href='Login.jsp' style="border: solid 2px; margin: 10px; background-color: white; padding: 5px; color:black; text-decoration: none;">
				    로그인</a>
				<%
				} else {
				%>
				    <a href='Logout.jsp' style="border: solid 2px; margin: 10px; background-color: white; padding: 5px; color:black; text-decoration: none;">
				    로그아웃</a>
				<%
				}
				%>
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
        
        <!-- 세번째 메뉴들 ( 북클럽 카테고리 ) -->
        <main style="display: flex; justify-content: space-around; margin-top: 10vh;">
        	<div style="display: flex; justify-content: center; align-items: center; border: solid 1px; width: 10vw; height: 8vh;">
        		<a href='BookClub.jsp?clubId=1' style="padding: 20px; color:black; text-decoration: none;">추천해요 책</a>
        	</div>
        	<div style="display: flex; justify-content: center; align-items: center; border: solid 1px; width: 10vw; height: 8vh;">
        		<a href='BookClub.jsp?clubId=2' style="padding: 20px; color:black; text-decoration: none;">추천해줘요 책</a>
        	</div>
	        <div style="display: flex; justify-content: center; align-items: center; border: solid 1px; width: 10vw; height: 8vh;">
	        	<a href='BookClub.jsp?clubId=3' style="padding: 20px; color:black; text-decoration: none;">얘기해요 책</a>
	        </div>
        </main>
      
       <%
	       String DB_URL="jdbc:mysql://localhost:3306/internetproject";  
	       String DB_ID="multi";  
	       String DB_PASSWORD="abcd"; 
	 	 
		   Class.forName("com.mysql.jdbc.Driver");  
	 	   Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
	
		   String postId = request.getParameter("postId");              
		   String  jsql = "select * from clubpost where postId = ?";
	       PreparedStatement pstmt = con.prepareStatement(jsql);
	       pstmt.setInt(1, Integer.parseInt(postId));
	       ResultSet rs = pstmt.executeQuery();
		
	       String clubId = "";
	       String title = "";
	       String content = "";
	       String created_at = "";
	       String userId = "";
	       int hits = 0;
	       
	       if(!rs.wasNull()) {
	           rs.next();
	           clubId = rs.getString("clubId");
	           title = rs.getString("title").trim();
	           content = rs.getString("content").trim();
	           created_at = rs.getString("created_at").trim();
	           userId = rs.getString("userId").trim();
	           hits = rs.getInt("hits");
	           hits ++;
	       }
   		%> 
   		
   		<!-- 네번째 메뉴들 ( 목록 , 수정 , 삭제 ) -->
   		<%	if(userId.equals(userid)){%>
   		    <main style="margin-top: 5vh; display: flex; justify-content: flex-end;">
   				<a href="BookClub.jsp?clubId=<%=clubId%>" style="margin-right: 2vw; color:black; text-decoration: none;">목록</a>
   	            <a href="BookClubModify.jsp?postId=<%=postId%>" style="margin-right: 2vw; color:black; text-decoration: none;">수정</a>
   	            <a href="BookClubDelete.jsp?postId=<%=postId%>" style="color:black; text-decoration: none;">삭제</a>
   	        </main>
   		<%	}else{ %>
   			<main style="margin-top: 5vh; display: flex; justify-content: flex-end;">
   				<a href="BookClub.jsp?clubId=<%=clubId%>" style="margin-right: 2vw; color:black; text-decoration: none;">목록</a>
   			</main>
   		<% } %>
        
        <!-- 다섯번째 메뉴들 ( 북클럽 상세보기 ) -->
        <main style="display: flex; flex-direction: column; justify-content: space-around; 
        margin-top: 2vh; border-top: solid 1px; border-bottom: solid 1px; padding: 20px;">
        	<div style="display: flex; justify-content: space-between;">
        		<div><%= title %></div>
        		<div><%= hits %></div>
        	</div>
        	<div style="margin-top: 3vh;"><%= userId %></div>
        	<div style="margin-top: 3vh;"><%= created_at %></div>
        	<div style="padding: 10px; margin-top: 3vh; border: solid 1px; height: 70vh; margin-bottom: 2vh;"><%= content %></div>
        	댓글 목록
        </main>
        
        <%
        	String jsql2 = "select * from clubcomment order by commentId";
        	PreparedStatement pstmt2 = con.prepareStatement(jsql2);
        	ResultSet rs2 = pstmt2.executeQuery();
        	while (rs2.next()) 
 		   {
        		  String commentId = rs2.getString("commentId");
 	              String comment_content = rs2.getString("content");
 				  String comment_userId = rs2.getString("userId");
 	              String comment_created_at = rs2.getString("created_at");
        %>
        
        <!-- 네번째 메뉴들 ( 상세보기 댓글 ) -->
        <main style="display: flex; justify-content: space-between; border-bottom: solid 1px; padding: 15px;">
        	<div style="display: flex;">
        		<div><%= commentId %></div>
        		<div style="margin-left: 1vw;"><%= comment_userId %></div>
        		<div style="margin-left: 5vw;"><%= comment_content %></div>
        	</div>
        	<div style="display: flex;">
	        	<div><%= comment_created_at %></div>
	        	<% if(comment_userId.equals(userid)){ %>
        		<div style="margin-left: 2vw;">
        			<form method="post" action="CommentDelete.jsp" name="del">
        				<input type = "hidden" name="commentId" value="<%= commentId %>">
        				<input type = "hidden" name="postId" value="<%= postId %>">
	        			<input type = "button" style="border: solid 1px; cursor: pointer;" value="삭제" OnClick="check()">
	        		</form>
	        	</div>
	        	<% } %>
        	</div>
        </main>
        <%	} %>
        <div style="margin-top: 3vh;">
	        <form method="post" action="BookClubDetailOk.jsp" name="input"
	        style="display: flex; justify-content: space-between; margin-top: 1vh;">
	        	<input type = "hidden" name="postId" value="<%= postId %>">
	        	<input type = "hidden" name="userId" value="<%= userid %>">
	        	<input type = "text" style="width: 60vw; height: 3vh;" name="content">
	        	<input type = "button" style="background-color: white; border: solid 1px; cursor: pointer;" value="댓글 달기" OnClick="in_check()">
	        </form>
        </div>

		<%   
		    rs.close();
			pstmt.close();
	
	        String jsql3 = "update clubpost set hits = ? where postId = ?";
	        PreparedStatement up_hits_Pstmt = con.prepareStatement(jsql3);
	        up_hits_Pstmt.setInt(1, hits);
	        up_hits_Pstmt.setInt(2, Integer.parseInt(postId));
	        up_hits_Pstmt.executeUpdate();
	        
			up_hits_Pstmt.close();  
			con.close();
  		%> 

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

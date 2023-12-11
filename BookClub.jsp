<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북클럽 게시판 리스트</title>
</head>

       <%
       String DB_URL="jdbc:mysql://localhost:3306/internetproject";  
       String DB_ID="multi";  
       String DB_PASSWORD="abcd"; 
 	 
	   Class.forName("com.mysql.jdbc.Driver");  
	   Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

		request.setCharacterEncoding("euc-kr");

		String group_index;
		int list_index;

		String clubId = request.getParameter("clubId");
		group_index = request.getParameter("group_index");
		//첫 페이지는 group_index 값이 0
		   
		if (group_index != null) 	
				list_index = Integer.parseInt(group_index);  
		else 
				list_index = 0;     //현재 페이지 수 

		//board 테이블에 있는 총 자료의 수(글의 개수) 알아 오기
		String jsql = "select count(*) from ClubPost where clubId";
		PreparedStatement pstmt1 = con.prepareStatement(jsql);
		ResultSet cntRs = pstmt1.executeQuery();

		cntRs.next();
		int cnt = cntRs.getInt(1);//글의 총 개수

		//한 페이지에 10개의 글 출력하기 위해
		//글의 개수를 10으로 나누어 페이지 계산
		int cntList = cnt/10; // 페이지 수 계산하기 위한 변수 
		int remainder = cnt%10; //나머지
		int cntList_1;//총페이지 수
			
		//1(11, 21, 31, 41, ...)번째 글이 올라올 때 총 페이지 수 1 증가
		if (cntList != 0) //글이 10개이상이면
		{
			   if (remainder == 0)	 //10으로 나눈 나머지가 없으면		
				  cntList_1 = cntList;  //몫이 페이지 수          
			   else                    //나머지가 있으면
				   cntList_1 = cntList + 1; //몫에 1 더한 값이 총페이지 수		  
		 } 
		 else 		 
			  cntList_1 = cntList + 1; //총페이지 수		
			   
		cntRs.close();
			
		String jsql2 = "select * from Club where clubId=?";
		PreparedStatement pstmt2 = con.prepareStatement(jsql2);
		pstmt2.setString(1, clubId);
		ResultSet rs = pstmt2.executeQuery();
   %>

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
				if (session.getAttribute("userId") == null) {
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
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">
            	<a href='BookClub.jsp?clubId=1' style="padding: 25px; color:black; text-decoration: none;">북클럽</a></div>
            	<!-- 두번째 메뉴들 ( 베스트셀러, 신간도서, 국내도서 등등 ) -->

            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">
               <a href='BookList.jsp?bookCtg=베스트셀러' style="padding: 25px; color:black; text-decoration: none;">베스트셀러</a></div>
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">
               <a href='BookList.jsp?bookCtg=신간도서' style="padding: 25px; color:black; text-decoration: none;">신간도서</a></div>
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">
               <a href='BookList.jsp?bookCtg=국내도서' style="padding: 25px; color:black; text-decoration: none;">국내도서</a></div>
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">
               <a href='BookList.jsp?bookCtg=해외도서' style="padding: 25px; color:black; text-decoration: none;">해외도서</a></div>
            <div style="display: flex; justify-content: center; align-items: center; border: solid 2px; border-radius: 100px; width: 7.5vw; height: 15vh;">
            이벤트</div>
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
        String clubName = "";
        String description = "";
        
        while (rs.next()) {
            clubName = rs.getString("clubName");
            description = rs.getString("description");
        }
        %>
        
        <!-- 네번째 메뉴들 ( 북클럽 게시글 목록 ) -->
	     <div align="center">
	        <br><br>
	        <table width="800" border="0" cellspacing="0" cellpadding="5" >
	          <tr>
	             <td colspan="5">        
	                <div align="center"><font size=6><<%=clubName%>></font></div>
	                <div align="center"><font size=3><%=description %></font></div>
	              </td>
	           </tr>
	           <tr>
	              <td colspan="5">
	                 <div align="right"><font size=2 color=red>현재 페이지 / 총 페이지 &nbsp(<%= list_index + 1 %> / <%= cntList_1 %>)</font></div>
	              </td>
	           </tr>
			   </table>
	
	   	<table border='0' width='800' cellpadding='0' cellspacing='0'>
		<tr>
			<td><hr size='1'>
			</td>
	 	</tr>
	   </table>  
	
	      <table width="800" border="0" cellspacing="2" cellpadding="3">
	 	   <tr  bgcolor='cccccc'>
	 	      <td width="50" height="20">
	 	         <div align="center"><font size=2><b>번 호</b></font></div>
	 	      </td>
	 	      <td width="420" height="20">
	 	         <div align="center"><font size=2><b>제 목</b></font></div>
	 	      </td> 	      
	 	      <td width="100" height="20">
	 	         <div align="center"><font size=2><b>글쓴이 아이디</b></font></div>
	 	      </td>
	 	      <td width="180" height="20">
	 	         <div align="center"><font size=2><b>날 짜</b></font></div>
	 	      </td>
	 	      <td width="50" height="20">
	 	         <div align="center"><font size=2><b>조회수</b></font></div>
	 	      </td>
	 	   </tr>
	 	   
	    <%
	    
		String jsql3 = "select * from ClubPost where clubId=? order by postId desc, created_at";
		PreparedStatement pstmt3 = con.prepareStatement(jsql3);
		pstmt3.setString(1, clubId);
		ResultSet rs2 = pstmt3.executeQuery();
	    
		if (!rs2.wasNull()) 
		{
		   for(int i = 0; i < list_index * 20; i++) 
		      rs2.next();
	
	       int cursor = 0;
	       while (rs2.next()) 
		   {
	              int postId = rs2.getInt("postId");
	              String title = rs2.getString("title");
				  String userId = rs2.getString("userId");
	              String created_at = rs2.getString("created_at");
	              int hits = rs2.getInt("hits");
	    %> 	   
	   
	 	   <tr bgcolor='ededed'>
	 	      <td>
	 	         <div align="center"><font size=2><%=postId%></font></div>
	 	      </td>
	 	      <td>
	 	         <a href="BookClubDetail.jsp?postId=<%=postId%>"><font size=2><%=title%></font></a>
	 	      </td> 	      
	 	      <td>
	 	         <div align="center"><font size=2><%=userId%></font></a></div>
	 	      </td>
	
	 	      <td>
	 	         <div align="center"><font size="2"><%=created_at%></font></div>
	 	      </td> 	      
	 	      <td>
	 	         <div align="center"><font size=2><%=hits%></font></div>
	 	      </td>
	 	   </tr>  	   
	
	   <%
		   //while 문이 반복 수행될 때마다 cursor를 1씩 증가
			 cursor ++;
	         if (cursor >= 10) break; 
	        }   // while문의 끝
	    }  //  if문의 끝
	   %>
	   
	   	<table border='0' width='800' cellpadding='0' cellspacing='0'>
		<tr>
			<td><hr size='1'>
			</td>
	 	</tr>
	</table>  
	
	
	     <div align="center">
	        <table width="700" border="0" cellspacing="0" cellpadding="5">
	          <tr>&nbsp;</tr><tr>
	             <td colspan="5">        
	                <div align="center">
			<%
				//첫페이지 (group_index 값이 0)로 이동할 수 있게끔 링크
			%>
	        <%= "["%><a href="BookClub.jsp?group_index=0"><font size=2>처음</font></a><%="]" %>
	        &nbsp;&nbsp;&nbsp;
	                
	   <% 
	   //페이지 번호를 출력 및 링크시키기 위한 변수들을 선언
	       int startpage=1;
	       int maxpage = cntList_1;
	       int endpage = startpage + maxpage -1;
	
		//보여줄 페이지가 속한 그룹의 첫번째 페이지부터 마지막 페이지까지의 링크를 추가
	       for (int j=startpage; j<=endpage; j++) 
		   {
	           if(j == list_index+1) 
			   {
	   %>
	               <%= j %>
	   <%
	            } 
	            else 
				{
	   %>
	        <a href="BookClub.jsp?group_index=<%= j - 1 %>"><%= j %></a>
	   <%
	            }
	       }
	   %>
	    
	      &nbsp;&nbsp;&nbsp;
		  <%
				//마지막 페이지로 이동할 수 있게끔 링크
		   %>
	      <%= "["%><a href="BookClub.jsp?group_index=<%= cntList_1 - 1 %>"><font size=2>끝</font></a><%="]" %>
	    
	             </td>
	          </tr>                
	          <tr>
	             <td colspan="5">
	                <div align="center">  
	        <center>
	        <a href="BookClubWrite.jsp?clubId=<%=clubId%>">글쓰기</a>
			<br><br>
	        </center> 
		 </div>
	        </td>
	      </tr>
	    </table>
	
	   </div>
	</form>


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

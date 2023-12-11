<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*" %> 
<html>
   <head><title>게시판 내용 수정</title></head>     
   
   <script type="text/javascript">
    function check(){
    	let frm = document.myform;
    	let postId = frm.postId;
    	let title = frm.title;
    	let content = frm.content;
		
		if(title.value == ""){
			alert("제목을 입력하세요");
			myform.title.focus();
			return false;
		}
		
		if(content.value == ""){
			alert("내용을 입력하세요");
			myform.content.focus();
			return false;
		}
		
		else{
			frm.submit();
		}
    }
    </script>
   
   <%
       String DB_URL="jdbc:mysql://localhost:3306/internetproject";  
       String DB_ID="multi";
       String DB_PASSWORD="abcd";
 	 
	   Class.forName("com.mysql.jdbc.Driver");  
 	   Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

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
   
<body>
<br><br>
  <center><font size=6 color=blue><게시글 수정></font></center>
  <center>
  <form method="post" action="BookClubModifyOk.jsp" name="myform">
    <table width="550" border="0" cellspacing="2" cellpadding="3">
      <tr>&nbsp;</tr>
      <tr>
	     <td align="center">
	        <input type="hidden" name="postId" value="<%= postId %>">
         </td>
      </tr>   
 	  <tr>
 	     <td bgcolor='cccccc' width="100" align="center"> <font size=2><b>제  목</b></font></td>
 	     <td width="400">
			  <input type="text" size="60" name="title"  value="<%= title %>" Maxlength="30">
 	     </td>
 	   </tr>   
 	  <tr>
 	     <td bgcolor='cccccc' width="100" height="100" align="center"><font size=2><b>본  문</b></font></td>
 	      <td><textarea rows="15" cols="60" name="content"><%= content %></textarea></td>
 	  </tr>
 	   
<% 
        }
       rs.close();
       con.close();
%>
 	</table>
  </form>
  		<button style="border: solid 1px; background-color: white; cursor: pointer;" type="button" onclick="check()">수정</button>
			  <button style="border: solid 1px; background-color: white; cursor: pointer;" type="button">
			   	  <a href="BookClubDetail.jsp?postId=<%=postId%>" style="text-decoration: none; color: black; cursor: pointer;">취소</a>
			  </button>
 </body>
</html>
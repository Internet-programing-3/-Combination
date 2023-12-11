<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>���� ��� ���</title>
</head>
<body>
<%
    request.setCharacterEncoding("euc-kr"); // �Է������� ���۵� �ѱ۵����� ó��

    // String �Է������� �޴� �����ʹ� ��� ���ڿ�
    String bookCtg = request.getParameter("bookCtg");
    String bookId = request.getParameter("bookId");
    String bookName = request.getParameter("bookName");
    int price = Integer.parseInt(request.getParameter("price")); // String => int ��ȯ
    int bookStock = Integer.parseInt(request.getParameter("bookStock")); // String => int ��ȯ
    String writer = request.getParameter("writer");
    String bookContent = request.getParameter("bookContent");
    String publisher = request.getParameter("publisher");
    String bookStatus = request.getParameter("bookStatus");
    String bookReview = request.getParameter("bookReview");

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/internetproject"; // DB ������ ��
        String DB_ID = "multi"; // ������ ���̵�
        String DB_PASSWORD = "abcd"; // ������ �н�����

        Class.forName("org.gjt.mm.mysql.Driver"); // JDBC ����̹� �ε�
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        // DB �� ����

        // SQL : �� �ۼ� ���̺� �ʵ��
        String jsql = "INSERT INTO Book (bookCtg, bookId, bookName, price, bookStock, writer, bookContent, publisher, bookStatus, bookReview) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // PreparedStatement (SQL ) ���� ���� ��Ʋ�� ������
        PreparedStatement pstmt = con.prepareStatement(jsql);
        // SQL ? ( ) ���� ������ �� �ش�Ǵ� ���� ������ ������ �ϳ��� �Ҵ��� �μ� ����
        // setInt() �������� ��쿡�� �� �����
        pstmt.setString(1, bookCtg);
        pstmt.setString(2, bookId);
        pstmt.setString(3, bookName);
        pstmt.setInt(4, price); // �������� ���
        pstmt.setInt(5, bookStock); // �������� ���
        pstmt.setString(6, writer);
        pstmt.setString(7, bookContent);
        pstmt.setString(8, publisher);
        pstmt.setString(9, bookStatus);
        pstmt.setString(10, bookReview);
        pstmt.executeUpdate(); // SQL �� ����
%>
    <center>
        <font color="blue" size='6'><b>[ ��ϵ� ���� ���� ] </b></font><p>
        <table border="2" cellpadding="10" style="font-size:10pt;font-family:'���� ���'">
            <tr><td width="100">ī�װ��з�</td><td width="300"><%=bookCtg%></td></tr>
            <tr><td width="100">���� ��ȣ</td><td width="300"><%=bookId%></td></tr>
            <tr><td width="100">���� ��</td><td width="300"><%=bookName%></td></tr>
            <tr><td width="100">���� ����</td><td width="300"><%=price%> ��</td></tr>
            <tr><td width="100">������</td><td width="300"><%=bookStock%> ��</td></tr>
            <tr><td width="100">����</td><td width="300"><%=writer%></td></tr>
            <tr><td width="100">�� ����</td><td width="300"><%=bookContent%></td></tr>
            <tr><td width="100">���ǻ�</td><td width="300"><%=publisher%></td></tr>
            <tr><td width="100">�Ǹ� ����</td><td width="300"><%=bookStatus%></td></tr>
            <tr><td width="100">���� ����</td><td width="300"><%=bookReview%></td></tr>
        </table><p>
<%
    } catch (Exception e) {
        out.println(e);
    }
%>
        <p>
        <a href="BookSelect.jsp" style="font-size:10pt;font-family:'���� ���'">��ü ��ϻ�ǰ ��ȸ</a><br><br>
    </center>
</body>
</html>

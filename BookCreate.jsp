<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.io.*, java.util.UUID" %>

<html>
<head>
    <title>도서 등록</title>
</head>
<body>
    <center>
        <font color="blue" size="6"><b>[도서 등록]</b></font>
        <form method="post" action="BookCreateResult.jsp" enctype="multipart/form-data">
            <table border="2" cellpadding="10" style="font-size:10pt;font-family:맑은 고딕">
                <tr>
                    <td>도서 이미지 업로드 :</td>
                    <td><input type="file" name="bookImgFile"></td>
                </tr>
                <tr>
                    <td>카테고리분류 :</td>
                    <td>
                        <select name="bookCtg">
                            <option value="베스트셀러">베스트셀러</option>
                            <option value="신규 도서">신규 도서</option>
                            <option value="국내 도서">국내 도서</option>
                            <option value="해외 도서">해외 도서</option>
                        </select>
                        <p>
                    </td>
                </tr>
                <tr>
                    <td>도서 번호 :</td>
                    <td><input type="text" name="bookId"></td>
                </tr>
                <tr>
                    <td>도서 명 :</td>
                    <td><input type="text" name="bookName"></td>
                </tr>
                <tr>
                    <td>도서 가격 :</td>
                    <td><input type="text" name="price"> 원</td>
                </tr>
                <tr>
                    <td>저자 :</td>
                    <td><input type="text" name="writer"> 지음</td>
                </tr>
                <tr>
                    <td>출판사 :</td>
                    <td><input type="text" name="publisher"> </td>
                </tr>
                <tr>
                    <td>판매 상태 :</td>
                    <td>
                        <input type="radio" name="bookStatus" value="판매 중">판매 중
                        <input type="radio" name="bookStatus" value="품절">품절
                        <input type="radio" name="bookStatus" value="재입고 중">재입고 중
                    </td>
                </tr>
                <tr>
                    <td>상세 설명 :</td>
                    <td><textarea name="bookContent" rows="5" cols="30"></textarea></td>
                </tr>
                <tr>
                    <td>재고수량:</td>
                    <td><input type="text" name="bookStock"> 권</td>
                </tr>
                <!-- 추가된 항목 -->
                <tr>
                    <td>도서 리뷰:</td>
                    <td><textarea name="bookReview" rows="5" cols="30"></textarea></td>
                </tr>
            </table>
            <p>
            <input type="submit" value="[도서 등록]">
            <input type="reset" value="취 소">
        </form>
    </center>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>주문 완료</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }

        .ellipse-title {
            width: 100%;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-top: 10px;
        }

        main {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 5vh;
        }
    </style>
</head>
<body style="width: 98vw; display: flex; flex-direction: column; margin: 0px; align-items: center;">
    <div style="width: 70vw;">

        <!-- 로고 부분 -->
        <header style="display: flex; justify-content: flex-start;">
            <img src="logo.jpg" alt="로고">
        </header>

        <!-- 첫번째 메뉴들 ( 마이페이지, 로그인 ) -->
        <main>
            <!-- 마이페이지, 로그인 -->
            <div style="display: flex; flex-direction: row; align-items: center;">
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">마이페이지</button>
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">로그인</button>
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">장바구니</button>
            </div>

            <!-- 장바구니 내역 창 -->
                        <!-- 장바구니 내역 창 -->
            <div style="border: solid 1px; height: 80vh; text-align: center; width: 60%;">
                <div style="border-bottom: solid 1px; width: 100%; height: 8vh; display: flex; align-items: center; justify-content: space-between;">
                    <div>
                        <input type="checkbox" id="selectAll"> 전체 선택
                    </div>
                    <div>
                        <span style="cursor: pointer; color: blue; text-decoration: underline;">구매 목록 삭제</span>
                    </div>
                </div>
                <div style="width: 100%; padding: 5px;">
                    <!-- 책 A -->
                    <div style="display: flex; align-items: center; justify-content: space-between; border-bottom: solid 1px; width: 100%; height: 10vh;">
                        <!--책 이미지 -->
                        <input type="checkbox" id="selectA">
                        <img src="book_a.jpg" alt="Book A" style="width: 50px; height: 70px; margin-right: 10px;">

                        <!-- 책 정보 -->
                        <div style="flex-grow: 1; text-align: left;">
                            <div>책 A 제목</div>
                            <div>수량: 1</div>
                            <div>가격: 30,000원</div>
                        </div>
                    </div>
                    <!-- 책 B -->
                    <div style="display: flex; align-items: center; justify-content: space-between; border-bottom: solid 1px; width: 100%; height: 10vh;">
                        <!-- 책 이미지 -->
                        <input type="checkbox" id="selectB"> 
                        <img src="book_b.jpg" alt="Book B" style="width: 50px; height: 70px; margin-right: 10px;">

                        <!-- Book Information -->
                        <div style="flex-grow: 1; text-align: left;">
                            <div>책 B 제목</div>
                            <div>수량: 2</div>
                            <div>가격: 40,000원</div>
                        </div>
                    </div>
                    <!-- 책 C -->
                    <div style="display: flex; align-items: center; justify-content: space-between; width: 100%; height: 10vh;">
                        <!-- 책 이미지 -->
                        <input type="checkbox" id="selectC">
                        <img src="book_c.jpg" alt="Book C" style="width: 50px; height: 70px; margin-right: 10px;">

                        <!-- 책 정보 -->
                        <div style="flex-grow: 1; text-align: left;">
                            <div>책 C 제목</div>
                            <div>수량: 1</div>
                            <div>가격: 30,000원</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 주문자 정보 테이블 -->
            <table>
                <tr>
                    <th colspan="2">주문 정보</th>
                </tr>
                <tr>
                    <td>이름</td>
                    <td>홍길동</td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td>서울시 강남구</td>
                </tr>
                <tr>
                    <td>연락처</td>
                    <td>010-1234-5678</td>
                </tr>

                <tr>
                    <td>주문 번호</td>
                    <td>123456789</td>
                </tr>
                <tr>
                    <td>주문 일자</td>
                    <td>2023-11-12</td>
                </tr>
            </table>

            <!-- 총 가격 테이블 -->
            <table>
                <tr>
                    <th colspan="2">총 가격</th>
                </tr>
                <tr>
                    <td>상품 가격</td>
                    <td>100,000원</td>
                </tr>
                <tr>
                    <td>배송비</td>
                    <td>0원</td>
                </tr>
                <tr>
                    <td>총 결제 금액</td>
                    <td>100,000원</td>
                </tr>
            </table>


        </main>

        <footer style="display: flex; justify-content: space-around; margin-top: 5vh;">
            <textarea style="width: 20vw; height: 10vh; resize: none; border: solid 1px; padding: 10px;"></textarea>
        </footer>

    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
</head>
<body style="width: 98vw; display: flex; flex-direction: column; margin: 0px; align-items: center;">
    <div style="width: 70vw;">

        <!-- 로고 부분 -->
        <header style="display: flex; justify-content: flex-start;">
            <img src="logo.jpg" alt="로고">
        </header>

        <!-- 첫번째 메뉴들 ( 마이페이지, 로그인 ) -->
        <main style="display: flex; justify-content: flex-end; align-items: center;">
            <!-- 마이페이지, 로그인 -->
            <div style="display: flex; flex-direction: row; align-items: center;">
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">마이페이지</button>
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">로그인</button>
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">장바구니</button>
            </div>
        </main>

        <main style="display: flex; justify-content: space-around; margin-top: 5vh;">
            <!-- 장바구니 내역 창 -->
            <div style="border: solid 1px; text-align: center; width: 60%;">
                <div style="border-bottom: solid 1px; width: 100%; height: 8vh; display: flex; align-items: center; justify-content: space-between;">
                    <div>
                        <input type="checkbox" id="selectAll"> 전체 선택
                    </div>
                    <div>
                        <span style="margin-right: 10px; cursor: pointer; color: blue; text-decoration: underline;">목록 삭제</span>
                    </div>
                </div>
                <div style="width: 100%;">
                    <!-- 책 A -->
                    
                    <div style="display: flex; align-items: center; justify-content: space-between; border-bottom: solid 1px; width: 97%; height: 10vh; padding: 10px;">
                        <!--책 이미지 -->
                        <input type="checkbox">
                        <img src="book_a.jpg" alt="Book A" style="width: 50px; height: 70px; margin-right: 10px;">

                        <!-- 책 정보 -->
                        <div>책 A 제목</div>
                        <div>수량: 1</div>
                        <div>가격: 30,000원</div>
                    </div>
                </div>
            </div>

            <!-- 결제 정보 창 -->
            <div style="border: solid 1px; height: 70vh; text-align: center; width: 30%;">
                <div style="width: 100%; padding: 5px;">결제 정보</div>
                <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%;">
                    <div style="border-bottom: solid 1px; width: 100%; height: 8vh;">결제 금액: 100,000원</div>
                    <div style="width: 100%; height: 8vh;">
                        <!-- 결제 정보 내용 -->
                        <!-- 예시: -->
                        결제 수단: 신용카드
                    </div>
                    <button style="height: 5vh; margin-top: 10px; background-color: #4CAF50; color: white; border: none; padding: 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 14px;">
                        주문하기
                    </button>
                </div>
            </div>
        </main>

    </div>
</body>
</html>

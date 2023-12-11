<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 내역 정보</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }

        .flex-container {
            display: flex;
            justify-content: space-around;
            margin-top: 5vh;
        }

        .flex-item {
            width: 50vw; /* 조정한 부분 */
        }

        .payment-info-container {
            border: solid 1px;
            height: 70vh;
            text-align: center;
            width: 30%;
        }

        .info-container {
            display: flex;
            width: 100%;
            justify-content: space-between;
            border: 1px solid black; /* 추가된 부분 */
            padding: 10px; /* 추가된 부분 */
        }

        /* Added this style to remove borders between records */
        .no-border {
            border: none;
        }

        /* Added this style to create horizontal lines */
        .horizontal-line {
            border: solid 1px;
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
        <main style="display: flex; justify-content: flex-end; align-items: center;">
            <!-- 마이페이지, 로그인 -->
            <div style="display: flex; flex-direction: row; align-items: center;">
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">마이페이지</button>
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">로그인</button>
                <button style="border: solid 2px; margin: 10px; background-color: white; padding: 5px;">장바구니</button>
            </div>
        </main>

<main>
        <div class="flex-container">

            <!-- 배송지 정보, 주문 상품, 결제 수단 테이블 -->
            <div class="info-container">
                <table class="flex-item">
                    <!-- 배송지 정보 테이블 -->
                    <tr>
                        <th class="no-border">배송지 정보</th>
                    </tr>
                    <tr>
                        <td class="no-border">수령인: 홍길동</td>
                    </tr>
                    <tr>
                        <td class="no-border">주소: 서울시 강남구</td>
                    </tr>
                    <tr>
                        <td>연락처: 010-1234-5678</td>
                    </tr>

                    <!-- 주문 상품 테이블 -->
                    <tr>
                        <th class="no-border">주문 상품</th>
                    </tr>
                    <tr>
                        <td class="no-border">상품명: 추천해요 책</td>
                    </tr>
                    <tr>
                        <td class="horizontal-line">가격: 30,000원</td>
                    </tr>

                    <!-- 다른 상품 정보들도 추가 -->
                    <tr>
                        <th class="no-border">결제 수단 선택</th>
                    </tr>
                    <tr>
                        <td class="no-border">신용카드 계좌이체</td>
                    </tr>
                </table>
            </div>

            <!-- 결제 정보 창 -->
            <div class="payment-info-container">
                <table style="width: 100%; height: 100%;">
                    <tr>
                        <th colspan="2">결제 정보</th>
                    </tr>
                    <tr>
                        <td colspan="2" class="horizontal-line" style="height: 8vh;">결제 금액: 100,000원</td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 8vh;">
                            <!-- 결제 정보 내용 -->
                            <!-- 예시: -->
                            결제 수단: 신용카드
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 5vh; margin-top: 10px; background-color: #4CAF50; color: white; border: none; padding: 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 14px;">
                            주문하기
                        </td>
                    </tr>
                </table>
            </div>
            
        </div>
</main>


        <footer style="display: flex; justify-content: space-around; margin-top: 5vh;">
            <textarea style="width: 20vw; height: 10vh; resize: none; border: solid 1px; padding: 10px;"></textarea>
        </footer>

    </div>
</body>
</html>

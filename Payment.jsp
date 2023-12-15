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
        
        i{
        	font-size: large; font-weight: bold; margin-right: 20px;
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
            <div>
	            <div style="width: 40vw; height: 30vh; border: solid 1px black; margin-bottom: 20px;">
					<div style="border-bottom: solid 1px; padding: 10px;">배송지 정보</div>
					<div style="height: 77%; display: flex; flex-direction: column; justify-content: space-around; padding: 10px;">
						<div><i>주소</i> **도 **시 **동 **아파트 ***동 ****호</div>
						<div><i>수령인</i> ***</div>
						<div><i>연락처</i> 010-1234-5678</div>
					</div>
	            </div>
	            
	            <div style="width: 40vw;border: solid 1px black; margin-bottom: 20px;">
					<div style="border-bottom: solid 1px; padding: 10px;">주문상품 : 총 n개</div>
					<div style="display: flex; align-items: center; justify-content: space-around; padding: 10px; border-bottom: solid 1px;">
                        <!--책 이미지 -->
                        <img src="book_a.jpg" alt="Book A" style="width: 50px; height: 70px; margin-right: 10px;">

                        <!-- 책 정보 -->
                        <div>책 A 제목</div>
                        <div>수량: 1</div>
                        <div>가격: 30,000원</div>
					</div>
	            </div>
	            
	            <div style="width: 40vw;border: solid 1px black; margin-bottom: 20px;">
	            	<div style="border-bottom: solid 1px; padding: 10px;">결제 수단</div>
	            	<div style="display: flex; justify-content: space-around; padding: 30px;">
	            		<div>
	            			<input type="radio" name="payment">카드
	            		</div>
	            		<div>
	            			<input type="radio" name="payment">계좌
	            		</div>
	            		<div>
	            			<input type="radio" name="payment">카카오
	            		</div>
	            		<div>
	            			<input type="radio" name="payment">네이버
	            		</div>
	            	</div>
	            </div>
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

    </div>
</body>
</html>

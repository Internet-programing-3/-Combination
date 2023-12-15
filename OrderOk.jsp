<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문완료</title>
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

        <main style="display: flex; flex-direction:column; align-items: center; justify-content: space-around; margin-top: 5vh;">
            <p style="border: solid 1px; padding: 20px 50px 20px 50px; border-radius: 20px; margin-bottom: 20px;">주문이 완료되었습니다!</p>
            
            <div style="display: flex; flex-direction: column; width: 40vw; border: solid 1px black; margin-bottom: 20px;">
            	<p style="border-bottom: solid 1px; padding: 0px 10px 20px 30px;">주문번호 : *******</p>
            	<div style="display: flex; align-items: center; justify-content: space-between; border-bottom: solid 1px; width: 97%; height: 10vh; padding: 10px;">
                        <!--책 이미지 -->
                        <img src="book_a.jpg" alt="Book A" style="width: 50px; height: 70px; margin-right: 10px;">

                        <!-- 책 정보 -->
                        <div>책 A 제목</div>
                        <div>수량: 1</div>
                        <div>가격: 30,000원</div>
                </div>
			</div>
			
			<div style="width: 40vw; height: 30vh; border: solid 1px black; margin-bottom: 20px;">
					<div style="border-bottom: solid 1px; padding: 10px;">주문자 정보</div>
					<div style="height: 77%; display: flex; flex-direction: column; justify-content: space-around; padding: 10px;">
						<div><i>배송지</i> **도 **시 **동 **아파트 ***동 ****호</div>
						<div><i>수령인</i> ***</div>
						<div><i>연락처</i> 010-1234-5678</div>
					</div>
	        </div>
	        
	        <div style="width: 37.5vw; display: flex; justify-content: space-between; border: solid 1px; padding: 20px; margin-bottom: 20px;">
	        	<p>결제 금액</p>
	        	<p>*** 원</p>
	        </div>
			
        </main>

    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비회원 로그인</title>
</head>
<body style="width: 100vw; display: flex; flex-direction: column; margin: 0px; align-items: center;">
    <div style="width: 70vw;">

        <!-- 로고 부분 -->
        <header style="display: flex; justify-content: center;">
            <a href='Mainpage.jsp'><img src="logo.jpg" alt="로고"></a>
        </header>

        <!-- 첫번째 메뉴들 ( 회원 로그인, 비회원 로그인 ) -->
        <main style="display: flex; justify-content: space-around; align-items: center;">
            <a href='Login.jsp' style="color:black; text-decoration: none;">
            <div style="text-align: center; padding: 20px;">회원로그인</div></a>
            <a href='Login2.jsp' style="color: black; text-decoration: none;">
            <div style="border-bottom: solid 2px; text-align: center; padding: 20px;">비회원로그인</div></a>
        </main>

        <!-- 두번째 메뉴들 ( 아이디, 비밀번호 ) -->
        <main style="display: flex; flex-direction: column; align-items: center; margin-top: 5vh;">
            <div style="display: flex; border: solid 1px; width: 40vw; height: 6vh; margin-bottom: 15px;">
                <input type="text" style="width: 40vw; height: 5.7vh; border: none;" placeholder="주문번호를 입력하세요">
            </div>
            <div style="display: flex; border: solid 1px; width: 40vw; height: 6vh;">
                <input type="text" style="width: 40vw; height: 5.7vh; border: none;" placeholder="비밀번호를 입력하세요">
            </div>
        </main>

        <!-- 세번째 메뉴들 ( 로그인, 아이디/비밀번호 찾기, 회원가입 ) -->
        <main style="display: flex; flex-direction: column; align-items: center; margin-top: 5vh;">
            <button style="display: flex; border: solid 1px; justify-content: center; align-items: center; width: 8vw; height: 5vh; background-color: white; margin-bottom: 20px;">
                조회
            </button>
            <div style="display: flex;">
                <button style="display: flex; border: solid 1px; justify-content: center; align-items: center; width: 10vw; height: 5vh; background-color: white; margin-right: 10px;">
                    아이디/비밀번호 찾기
                </button>
                <button style="display: flex; border: solid 1px; justify-content: center; align-items: center; width: 8vw; height: 5vh; background-color: white; margin-left: 10px;">회원가입</button>
            </div>
        </main>

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

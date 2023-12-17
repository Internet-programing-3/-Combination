<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료</title>
    <!-- 외부 CSS 적용 / 파일 경로 뒤에 ' ?v=1 ' 부분 지우지 마세요. 에러나요! -->
    <!-- 단위 수정 잘못하면 UI랑 배열 깨집니다 -->
    <link rel="stylesheet" type="text/css" href="Main.css?v=1">
    <!-- jQuery 라이브러리 연결 -->
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</head>
<body>
    <%
        // 인코딩
        request.setCharacterEncoding("UTF-8");
        // DB 연결
        String DB_URL = "jdbc:mysql://localhost:3306/internetproject";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";
		Class.forName("org.gjt.mm.mysql.Driver"); 
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 오늘의 책 랜덤 선택
        int today = 0;
        Random random = new Random();
        today = random.nextInt(8) + 1;

        String todayBook = "SELECT bookId, bookName, writer, bookImg FROM Book WHERE bookId = ?";
        PreparedStatement pstmtToday = con.prepareStatement(todayBook);
        pstmtToday.setInt(1, today);
        ResultSet rsToday = pstmtToday.executeQuery();
        rsToday.next();
        int todaykId = rsToday.getInt("bookId");
        String todayName = rsToday.getString("bookName");
        String todayWriter = rsToday.getString("writer");
        String todayBookImg = rsToday.getString("bookImg");

        // 주문 정보 처리
        try {
            String cartId = session.getId();
            String userId = (String)session.getAttribute("sid");

            String orderName = request.getParameter("name");
            String orderTel = request.getParameter("memTel");
            String orderReceiver = request.getParameter("receiver");
            String orderRcvAddress = request.getParameter("rcvAddress");
            String orderRcvPhone = request.getParameter("rcvPhone");
            String orderCardNo = request.getParameter("cardNo");
            String orderCardPass = request.getParameter("cardPass");
            String orderBank = request.getParameter("bank");
            String orderPay = request.getParameter("pay");

            // 새로운 주문번호 부여
            String maxOrderNoQuery = "SELECT MAX(orderId) FROM CartOrder";
            PreparedStatement maxOrderNoStmt = con.prepareStatement(maxOrderNoQuery);
            ResultSet maxOrderNoRs = maxOrderNoStmt.executeQuery();
            int orderId;
            if(maxOrderNoRs.next())
                orderId = maxOrderNoRs.getInt(1) + 1;
            else 
                orderId = 1;

            // 장바구니 내역 주문상품 테이블에 저장
            String cartItemsQuery = "SELECT bookId, quantity FROM CartItem WHERE cartId = ?";
            PreparedStatement cartItemsStmt = con.prepareStatement(cartItemsQuery);
            cartItemsStmt.setString(1, cartId);
            ResultSet cartItemsRs = cartItemsStmt.executeQuery();

            while(cartItemsRs.next()) {
                int bookId = cartItemsRs.getInt("bookId");
                int quantity = cartItemsRs.getInt("quantity");

                // 주문상품테이블에 주문번호, 상품번호, 주문수량 저장
                String insertOrderItemQuery = "INSERT INTO OrderItem (orderId, bookId, quantity) VALUES (?,?,?)";
                PreparedStatement insertOrderItemStmt = con.prepareStatement(insertOrderItemQuery);
                insertOrderItemStmt.setInt(1, orderId);
                insertOrderItemStmt.setInt(2, bookId);
                insertOrderItemStmt.setInt(3, quantity);
                insertOrderItemStmt.executeUpdate();
            }

            // 주문정보 테이블에 저장
            String insertOrderInfoQuery = "INSERT INTO CartOrder (orderId, orderState, cartId) VALUES(?,?,?)";
            java.util.Date date = new java.util.Date();
            String orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);

            PreparedStatement insertOrderInfoStmt = con.prepareStatement(insertOrderInfoQuery);
            insertOrderInfoStmt.setInt(1, orderId);
            insertOrderInfoStmt.setString(2, "주문 완료");
            insertOrderInfoStmt.setString(3, cartId);
            insertOrderInfoStmt.executeUpdate();

            // 결제 정보 저장
            String insertPaymentQuery = "INSERT INTO Payment (paymentId, paymentKind, totalPay, orderId, userId) VALUES(?,?,?,?,?)";
            PreparedStatement insertPaymentStmt = con.prepareStatement(insertPaymentQuery);
            insertPaymentStmt.setInt(1, orderId);
            insertPaymentStmt.setString(2, "카드 결제");
            insertPaymentStmt.setString(3, orderPay);
            insertPaymentStmt.setInt(4, orderId);
            insertPaymentStmt.setString(5, userId);
            insertPaymentStmt.executeUpdate();

            // 주문 처리 후 장바구니 비우기
            response.sendRedirect("deleteAllCart.jsp?case=1");
        } catch(Exception e) {
            out.println(e);
        } finally {
            rsToday.close();
            pstmtToday.close();
            con.close();
        }
    %>

    <!-- header (로고) -->
    <header>
        <a href="Mainpage.jsp">
            <img src="images/Logo.jpg" style="width: 400px; height: 150px;" alt="청년책방 로고">
        </a>
    </header>

    <!-- nav1 ( 오늘의 책, 검색창, 마이페이지, 로그인 ) -->
    <nav class="navMainOne">
        <!-- 오늘의 책 -->
        <div class="todayMain"><a href="#">
            <span>
                <img src="<%=todayBookImg%>.jpg" title="<%=todayName%>(<%=todayWriter%>)" alt="<%=todayName%>">
            </span>
            <span>
                <h3><%=todayName%></h3>
                <p><%=todayWriter%></p>
            </span>
        </a></div>
        <!-- 검색바 -->
        <div class="searchMain">
            <img src="images/LogoIcon.png" alt="로고아이콘">
            <input type="text">
            <button type="button" alt="검색 버튼">검색</button>
        </div>
        <!-- 마이페이지, 장바구니, 로그인/로그아웃 버튼 -->
        <div>
            <!-- 로그인 -->
            <%
                if (session.getAttribute("userId") == null) {
            %>
            <a href="Login.jsp">
                <img src="images/mypage.png" style="width: 50px; height: 50px;" title="마이페이지" alt="마이페이지">
            </a>
            <a href="Login.jsp">
                <img src="images/cart.png" style="width: 50px; height: 50px; margin: 0 10px;" title="장바구니" alt="장바구니">
            </a>
            <a href="Login.jsp">
                <img src="images/logIn.png" style="width: 50px; height: 50px;" title="로그인" alt="회원가입/로그인">
            </a>
            <!-- 로그아웃 -->
            <%
                } else {
            %>
            <a href="MyPage.jsp">
                <img src="images/mypage.png" style="width: 50px; height: 50px;" title="마이페이지" alt="마이페이지">
            </a>
            <a href="#">
                <img src="images/cart.png" style="width: 50px; height: 50px; margin: 0 10px;" title="장바구니" alt="장바구니">
            </a>
            <a href="Logout.jsp">
                <img src="images/logOut.png" style="width: 50px; height: 50px;" title="로그아웃" alt="로그아웃">
            </a>
            <%
                }
            %>
        </div>
    </nav>

    <main class="orderMain">
        <!-- 주문 처리 완료 내용 -->
        <div class="orderHeader">
            <p>주문이 완료되었습니다!</p>
        </div>
        <!-- 상품 목록 -->
        <article class="shopList">
            <table>
                <tr class="cartHeader">
                    <th colspan="4">주문 번호 : **** *** *****</th>
                </tr>
                <tr class="shopCont">
                    <a href="javascript:void(0);">
                        <td><img src="images/b008.jpg"></td>
                        <td align="left">설자은, 금성으로 돌아오다</td>
                        <td>1권</td>
                        <td>16800원</td>
                    </a>
                </tr>
            </table>
        </article>
        <!-- 주문자 정보 -->
        <article class="shopList">
            <table>
                <tr class="cartHeader">
                    <th colspan="4">주문자 정보</th>
                </tr>
                <tr class="cartCont">
                    <th>주소</th>
                    <td>남서울대학교 멀티미디어학과</td>
                </tr>
                <tr class="cartCont">
                    <th>수령인</th>
                    <td>홍길동</td>
                </tr>
                <tr class="cartCont">
                    <th>연락처</th>
                    <td>010-0000-0000</td>
                </tr>
            </table>
        </article>
        <!-- 결제 금액 -->
        <div class="orderEnd">
            <p class="EndOne">총 결제 금액</p>
            <p class="EndTwo">18600 원</p>
        </div>
        <!-- 페이지 이동 -->
        <div class="pageMove">
            <p><a href="MyPage.jsp">&lt; 메인으로 돌아가기</a></p>
            <p><a href="MyPage.jsp">마이페이지로 이동하기 &gt;</a></p>
        </div>
    </main>

    <!-- footer -->
    <footer>
        <div class="notices">
            <ul>
                <li><h4>공지사항</h4></li>
                <li><a href="javascript:void(0);">개인정보 처리방침 변경안내</a></li>
                <li><a href="javascript:void(0);"><h4>더보기+</h4></a></li>
                <li><h4>이벤트</h4></li>
                <li><a href="javascript:void(0);">11월 북클럽 독후감대회 우승자 발표</a></li>
                <li><a href="javascript:void(0);"><h4>더보기+</h4></a></li>
            </ul>
        </div>
        <div class="footerMain">
            <img src="images/Logo.jpg">
            <div>
                <p>회사소개 | 이용약관 | 개인정보처리방침 | 청소년보호정책 | 대량주문안내 | 협력사여러분 | 채용정보 | 광고소개</p>
                <p>
                    대표이사 : 서병덕 | 남서울대학교 멀티미디어학과 | 사업자등록번호 : 181-001-2002</br>
                    대표전화 : 1588-0000 (발신자 부담전화) | FAX : 0000-112-505 (지역번호 공통) | 인터넷프로그래밍2 : 제 2023호
                </p>
            </div>
        </div>
    </footer>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
      }
      .login-container {
        width: 350px;
        margin: 100px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
      }
      h2 {
        text-align: center;
        margin-bottom: 20px;
      }
      input[type=text], input[type=password] {
        width: 100%;
        padding: 10px;
        margin: 8px 0 16px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
      }
      input[type=submit] {
        width: 100%;
        padding: 10px;
        background-color: #4285f4;
        border: none;
        color: #fff;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
      }
      input[type=submit]:hover {
        background-color: #3367d6;
      }
      .error-msg {
        color: red;
        text-align: center;
        margin-bottom: 10px;
      }
    </style>
</head>
<body>

<div class="login-container">
    <h2>로그인</h2>

    <!-- 로그인 실패 시 메시지 -->
    <c:if test="${not empty errorMessage}">
        <div class="error-msg">${errorMessage}</div>
    </c:if>

    <!-- 로그인 폼 -->
    <form action="${pageContext.request.contextPath}/auth/login" method="post">
        <label for="user_id">아이디</label>
        <input type="text" id="user_id" name="user_id" placeholder="아이디 입력" required>

        <label for="user_pw">비밀번호</label>
        <input type="password" id="user_pw" name="user_pw" placeholder="비밀번호 입력" required>

        <input type="submit" value="로그인">
    </form>
</div>

</body>
</html>
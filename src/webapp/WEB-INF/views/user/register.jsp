<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>注册 - 宠物领养</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body style="display: flex; align-items: center; justify-content: center; min-height: 100vh;">

<div class="container">
    <div class="login-box">
        <h2>创建账号</h2>
        <p style="color: var(--zen-gray); margin-bottom: 40px;">开启领养之旅</p>

        <c:if test="${not empty errorMsg}">
            <div class="error-msg">${errorMsg}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/user/register" method="post">
            <div class="form-group">
                <input type="text" name="username" required placeholder="设定账号" style="text-align: center;">
            </div>
            <div class="form-group">
                <input type="password" name="password" required placeholder="设定密码" style="text-align: center;">
            </div>

            <div style="margin-top: 40px; display: flex; flex-direction: column; gap: 15px;">
                <button type="submit" class="primary-solid" style="width: 100%; padding: 12px;">立即注册</button>
                <a href="${pageContext.request.contextPath}/user/toLogin" class="btn" style="border: none; color: var(--zen-gray);">返回登录</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>登录 - 宠物领养</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body class="login-page">

<div class="container">
    <div class="login-box refined-login">

        <h2 class="login-title">宠物领养</h2>
        <p class="login-sub-title">欢迎登录系统</p>

        <div id="error-container" class="error-msg" style="display: ${not empty errorMsg ? 'block' : 'none'};">
            ${errorMsg}
        </div>

        <c:if test="${not empty successMsg}">
            <div class="success-msg">${successMsg}</div>
        </c:if>

        <form id="loginForm" action="${pageContext.request.contextPath}/user/login" method="post">

            <!-- 账号 -->
            <div class="form-group refined-form">
                <label for="username" class="input-label">账号</label>
                <input type="text" id="username" name="username" placeholder="请输入账号" autocomplete="off">
            </div>

            <!-- 密码 -->
            <div class="form-group refined-form">
                <label for="password" class="input-label">密码</label>
                <input type="password" id="password" name="password" placeholder="请输入密码">
            </div>

            <div class="login-action-area">
                <button type="submit" class="primary-solid full-width-btn">进入系统</button>
            </div>

            <div class="login-extra-links">
                <a href="${pageContext.request.contextPath}/user/toRegister" class="link-primary">注册新账号</a>
                <a href="${pageContext.request.contextPath}/user/toAdminLogin" class="link-muted">管理员入口</a>
            </div>
        </form>
    </div>
</div>

<script>
    document.getElementById('loginForm').addEventListener('submit', function(event) {
        var username = document.getElementById('username').value.trim();
        var password = document.getElementById('password').value.trim();
        var errorContainer = document.getElementById('error-container');

        if (!username || !password) {
            event.preventDefault();
            errorContainer.innerText = "账号或密码不能为空";
            errorContainer.style.display = 'block';
        } else {
            errorContainer.style.display = 'none';
        }
    });
</script>

</body>
</html>

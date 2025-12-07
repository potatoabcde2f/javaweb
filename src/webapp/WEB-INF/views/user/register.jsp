<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>宠物领养系统 - 注册</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container">
    <div class="login-box">
        <h2>用户注册</h2>
        <form action="/user/register" method="post">
            <div class="form-group">
                <label>账号：</label>
                <input type="text" name="username" required placeholder="请设置账号">
            </div>
            <div class="form-group">
                <label>密码：</label>
                <input type="password" name="password" required placeholder="请设置密码">
            </div>
            <div class="error-msg">${errorMsg}</div>
            <div class="btn-group">
                <button type="submit">注册</button>
                <a href="/WEB-INF/views/user/login.jsp">返回登录</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>